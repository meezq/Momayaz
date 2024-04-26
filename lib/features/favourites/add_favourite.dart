import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = MyShared.getString(key: MySharedKeys.userid);
void addFav({
  required String catId,
  required String id,
}) {
firestore
        .collection("categories")
        .doc(catId)
        .collection(catId)
        .doc(id)
        .collection("likes")
        .doc(userId)
        .set({
      "liked_by": userId,
      "liked_on": FieldValue.serverTimestamp(), // to record the time of the like
    });
  firestore
      .collection("categories")
      .doc(catId)
      .collection(catId)
      .doc(id)
      .get()
      .then((value) {
    firestore
        .collection("users")
        .doc(userId)
        .collection("fav")
        .doc(id)
        .set({
      "id": id,
      "category": catId,
      
    });
  });
}

Future<bool> isLiked(String catId, String id) async {
  // Attempt to fetch the document
  DocumentSnapshot snapshot = await 
  firestore
        .collection("categories")
        .doc(catId)
        .collection(catId)
        .doc(id)
        .collection("likes")
        .doc(userId)
        .get();
  // Return true if the document exists, false otherwise
  return snapshot.exists;
}