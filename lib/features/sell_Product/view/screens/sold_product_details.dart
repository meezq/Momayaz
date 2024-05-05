import 'dart:io';

import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/core/utils/snack_bar.dart';
import 'package:momayaz/core/widgets/app_button.dart';
import 'package:momayaz/core/widgets/congrats_screen.dart';
import 'package:momayaz/features/sell_Product/category.dart';
import 'package:momayaz/features/sell_Product/manager/sell_product__cubit.dart';
import 'package:momayaz/features/sell_Product/model/shipping_model.dart';
import 'package:momayaz/features/sell_Product/model/car_service_model.dart';
import 'package:momayaz/features/sell_Product/model/sell_base_model.dart';
import 'package:momayaz/features/sell_Product/model/sell_part.dart';
import 'package:momayaz/features/sell_Product/model/vehicles_model.dart';
import 'package:momayaz/features/sell_Product/view/widgets/add_photos_widget.dart';
import 'package:momayaz/features/sell_Product/view/widgets/shipping_sell.dart';
import 'package:momayaz/features/sell_Product/view/widgets/main_sold_details_item.dart';
import 'package:momayaz/features/sell_Product/view/widgets/car_service_sell_item.dart';
import 'package:momayaz/features/sell_Product/view/widgets/part_sold_item.dart';
import 'package:momayaz/features/sell_Product/view/widgets/vehicles_sell_item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class SoldProductDetailsScreen extends StatefulWidget {
  const SoldProductDetailsScreen(
      {super.key, required this.category,
      });
final Category category;

  @override
  State<SoldProductDetailsScreen> createState() => _SoldProductDetailsScreenState();
}

class _SoldProductDetailsScreenState extends State<SoldProductDetailsScreen> {
  List<String> downloadUrls = [];
  List<XFile> imageFileList = [];
  final cubit = SellProductCubit();

  Future<List<String>> uploadImages(List<XFile> imageFileList) async {
    showLoading(context);
    for (XFile image in imageFileList) {
      File file = File(image.path);
      String fileName = file.path.split('/').last;

      try {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('images/$fileName');
        UploadTask uploadTask = storageReference.putFile(file);

        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

        // Get download URL
        String downloadUrl = await snapshot.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);

        safePrint('Image uploaded: $downloadUrl');
      } catch (e) {
        safePrint('Error uploading image: $e');
      }
    }
    safePrint(downloadUrls);
    setState(() {});
    // ignore: use_build_context_synchronously
    pop(context);
    return downloadUrls;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        bottomNavigationBar: BlocConsumer<SellProductCubit, SellProductState>(
          listener: (context, state) {
            if (state is SellProductSuccess) {
              pushReplacement(
                context,
                const AppCongrats(
                  title: "Product published!",
                  icon: "done.png",
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SellProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return AppButton(
                bgColor: AppColors.primary,
                padding: EdgeInsets.all(10.sp),
                margin: EdgeInsets.all(15.sp),
                borderRadius: BorderRadius.circular(13.sp),
                onPressed: () {
                  if (context
                      .read<SellProductCubit>()
                      .mainFormKey
                      .currentState!
                      .validate()) {
                    safePrint(imageFileList);

                    if (imageFileList.isNotEmpty) {
                      uploadImages(imageFileList).then((value) {
                        DateTime currentDate = DateTime.now();

                        cubit.sellProduct(
                          catId: widget.category.categoryId,
                          vehiclesModel: VehiclesModel(
                            context
                                .read<SellProductCubit>()
                                .vehiclesNameEditingController
                                .text,
                            context
                                .read<SellProductCubit>()
                                .vehiclesModelEditingController
                                .text,
                            context
                                .read<SellProductCubit>()
                                .vehiclesColorEditingController
                                .text,
                            context
                                .read<SellProductCubit>()
                                .vehiclesTypeEditingController
                                .text,
                          ),
                          sellBaseModel: SellBaseModel(
                              context
                                  .read<SellProductCubit>()
                                  .titleEditingController
                                  .text,
                              widget.category.categoryName,
                              context
                                  .read<SellProductCubit>()
                                  .priceEditingController
                                  .text,
                              context
                                  .read<SellProductCubit>()
                                  .descriptionEditingController
                                  .text,
                              context
                                  .read<SellProductCubit>()
                                  .location
                                  .dropDownValue!
                                  .value,
                              downloadUrls,
                              MyShared.getString(
                                key: MySharedKeys.userid,
                              ),
                              MyShared.getString(
                                key: MySharedKeys.username,
                              ),
                              MyShared.getString(key: MySharedKeys.userImage),
                              widget.category.categoryId,
                              currentDate.toString()),
                          propertyModel: PartModel(
                            context
                                .read<SellProductCubit>()
                                .dimensionsEditingController
                                .text,
                            context
                                    .read<SellProductCubit>()
                                    .partType
                                    .dropDownValue
                                    ?.value ??
                                "",
                          ),
                          mobilesModel: CarServiceModel(
                            context
                                .read<SellProductCubit>()
                                .carServiceTypeEditingController
                                .text,
                          ),
                          appliancesModel: ShippingModel(
                            context
                                .read<SellProductCubit>()
                                .shippingTypeEditingController
                                .text,
                          ), carCategoryImage: widget.category.carCategoryImage, carCategoryId: widget.category.carCategoryId, carCategoryName: widget.category.carCategoryId,
                        );
                      });
                    } else {
                      snackBar(context, "Please choose at least 1 image",
                          Colors.red);
                    }
                  }
                },
                label: 'Confirm',
              );
            }
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          toolbarHeight: 0,
        ),
        backgroundColor: AppColors.second,
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: cubit.mainFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey[900],
                        padding: EdgeInsets.all(13.sp),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColors.offWhite,
                                )),
                            Text(
                              "Include some details",
                              style: TextStyle(
                                  color: AppColors.offWhite,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      AddPhotosWidgets(
                        imageFileList: imageFileList,
                      ),
                      MainSoldDetailsItem(
                        image: widget.category.categoryImage,
                        id: widget.category.categoryId,
                        category: widget.category.categoryName,
                      ),
                      widget.category.categoryId == '1'
                          ? const VehiclesSellItem()
                          : widget.category.categoryId == '2'
                              ? const PropertySoldItem()
                              : widget.category.categoryId == "3"
                                  ? const MobileSellItem()
                                  : widget.category.categoryId == "4"
                                      ? const AppliancesFashionSell()
                                      : widget.category.categoryId== "5"
                                          ? const AppliancesFashionSell()
                                          : const AppliancesFashionSell()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showLoading(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const Stack(
        alignment: AlignmentDirectional.center,
        children: [CircularProgressIndicator()],
      ),
    );
  }
}
