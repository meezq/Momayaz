
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:momayaz/core/utils/safe_print.dart';
part 'collection_copy_state.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;
String userId = MyShared.getString(key: MySharedKeys.userid);



class CollectionCopyCubit extends Cubit<CollectionCopyState> {
  CollectionCopyCubit() : super(CollectionCopyInitial());

  Future<void> copyNestedSubcollection(
      String srcCollection, String srcDoc, String srcSubcollection, String destCollection) async {
    // Reference to the source subcollection
    var sourceRef = FirebaseFirestore.instance
        .collection(srcCollection)
        .doc(srcDoc)
        .collection(srcSubcollection);

    // Get all documents from the source subcollection
    var querySnapshot = await sourceRef.get();

    // Check if the source collection is empty
    if (querySnapshot.docs.isEmpty) {
      safePrint('No documents found in source subcollection.');
      return;
    }


    // Transaction to perform batch write
    await firestore.runTransaction((transaction) async {
      for (var doc in querySnapshot.docs) {
        var destRef = firestore.collection(destCollection).doc(doc.id);
        transaction.set(destRef, doc.data());
      }
    }).then((value) {
      safePrint('All documents copied successfully!');
    }).catchError((error) {
      safePrint('Error copying documents: $error');
    });

  }
  void copyCollection() {
    copyNestedSubcollection('categories', '9', '9', 'products');
  }

}
