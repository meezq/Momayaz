import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/core/utils/snack_bar.dart';
import 'package:momayaz/core/widgets/app_button.dart';
import 'package:momayaz/core/widgets/app_text_field.dart';
import 'package:momayaz/features/favourites/manager/add_favourite.dart';
import 'package:momayaz/features/login/view/screens/login_screen.dart';
import 'package:momayaz/features/main/view/screens/main_screen.dart';
import 'package:momayaz/features/register/manager/register_cubit.dart';
import 'package:momayaz/features/register/model/register_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool obscureText = true;

  final TextEditingController nameEditingController = TextEditingController();

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController mobileEditingController = TextEditingController();


  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  String imageUrl = '';

  final cubit = RegisterCubit();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // create: (context) => cubit,
      child: Form(
        key: _formKey,
        child: Scaffold(
            backgroundColor: AppColors.second,
            body: Container(
              margin: EdgeInsets.all(15.sp),
              child: LayoutBuilder(
                builder: (context, constrains) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constrains.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "User Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.offWhite,
                              fontSize: 30.sp,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        if(imageUrl.isEmpty)
                          InkWell(
                          onTap: ()=>pickImage(),

                          child: const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person,size: 45),
                          )
                          )
                        else
                          Stack(
                            alignment: Alignment.center,
                            children: [
                          InkWell(
                          onTap: ()=>pickImage(),
                          child:  CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(imageUrl),
                            ),
                            ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          AppTextField(
                              hint: "Your Name",
                              keyboardType: TextInputType.name,
                              icon: Icons.person_outline_rounded,
                              controller: nameEditingController,
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              title: "Name"),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppTextField(

                            
                              hint: "Your Mobile Number",
                              keyboardType: TextInputType.number,
                              icon: Icons.phone_android_outlined,
                              controller: mobileEditingController,
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              title: "Mobile Number"),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppTextField(
                              enabled: false,
                              hint: "example@email.com",
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.email_outlined,
                              controller: emailEditingController,
                              isPassword: false,
                              textInputAction: TextInputAction.next,
                              title: "Email"),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppButton(
                              margin: const EdgeInsets.all(0),
                              padding: EdgeInsets.all(12.sp),
                              bgColor: AppColors.primary,
                              borderRadius: BorderRadius.circular(12.sp),
                              onPressed: () {
                                saveUserData();
                                pop(context);
                              },
                              label: "Update"),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  void getUserData() {
    final user = auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      firestore.collection('users').doc(userId).get().then((value) {
        safePrint("======> ${value.data()}");
        updateUi(value.data()!);
      }).catchError((error) {
        safePrint("======> $error");
      });
    } else {
      safePrint("No user currently logged in.");
      // Handle the case where no user is logged in
    }
  }

  void saveUserData() {
    final userId = auth.currentUser!.uid;
    firestore.collection("users").doc(userId).update({
      "name": nameEditingController.text,
      "phone": mobileEditingController.text,
      "image": imageUrl,
    }).then((value) {
      safePrint("======> User data saved successfully.");
      MyShared.putString(
          key: MySharedKeys.userImage, value: imageUrl);
      MyShared.putString(
          key: MySharedKeys.username, value: nameEditingController.text);
      MyShared.putString(
          key: MySharedKeys.phone, value: mobileEditingController.text);
    
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();

  }

  void updateUi(Map<String, dynamic> map) {
    nameEditingController.text = map['name'];
    mobileEditingController.text = map['phone'];
    emailEditingController.text = map['email'];
    imageUrl = map['image'];

    // setState(() {
    //   imageUrl = map['imageUrl'];
    // });
  }

  void pickImage() async{
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? file = await picker.pickImage(
        source: ImageSource.gallery);
    final image = File(file!.path);

    uploadImage(image);
    setState((){

    }
    );
  }

  void uploadImage(File image){
    setState(() {

    });
    final userId = auth.currentUser!.uid;
    storage.ref('profileImage/$userId').putFile(image)
        .then((value){
          safePrint('uploadImage => SUCCESS');
          getImage();
          safePrint('imageUrl get => SUCCESS');
  })
        .catchError((error){
      setState(() {

      });
          safePrint('uploadImage => $error');
    });
    }




  void getImage(){
    final userId = auth.currentUser!.uid;
    storage.ref('profileImage/$userId')
    .getDownloadURL()
        .then((imageUrl){
          safePrint('getImage=> SUCCESS');
          safePrint(imageUrl);
          setState(() {
            this.imageUrl = imageUrl;

          });

         // saveImageUrl(imageUrl);
    })
        .catchError((error){
          safePrint('Get Image error===> $error');
    });

  }

  void saveImageUrl(String imageUrl){
    final userId = auth.currentUser!.uid;

    firestore.collection('users').doc(userId).update({'image' : imageUrl, });
    safePrint('saveImageUrl => SUCCESS');
  }



}
