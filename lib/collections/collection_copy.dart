import 'package:flutter/material.dart';
import 'package:momayaz/collections/manager/collection_copy_cubit.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/core/widgets/app_button.dart';

class CollectionCopier extends StatelessWidget {
   CollectionCopier({super.key});
 final cubit = CollectionCopyCubit();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(

        padding: const EdgeInsets.all(50.0),
        child: AppButton(onPressed: ()
        {
          cubit.copyCollection();
        safePrint('copied');
        },
          label: 'copy collections',),
      )

    );
  }
}
