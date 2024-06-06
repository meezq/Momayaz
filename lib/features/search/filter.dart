import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterFirestore extends StatefulWidget{
  const FilterFirestore({super.key});

  @override
  State <FilterFirestore> createState() => _FilterFirestoreState();


}

class _FilterFirestoreState extends State<FilterFirestore> {

  List<QueryDocumentSnapshot> data = [];

  initialData() async{
    CollectionReference products = FirebaseFirestore.instance.collection("products");
    QuerySnapshot productsdata = await products.get();
    productsdata.docs.forEach((element) {
    });
    setState(() {

    });
  }

  @override
  void initState(){
    initialData();
    super.initState();
  }
@override
  Widget build(BuildContext context){
    return scaffold(
      appBar: AppBar(
        title: const Text('Filter'),

      ),
      body: container(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i){
              return Card(
                child: ListTile(
                  subtitle: Text("price : ${data[i]['price']}"),
                  title: Text(
                    data[i]['title'],
                    style: TextStyle(fontSize: 30),
                  )),
              );
            }))
    );
}



  container({required ListView child}) {}

   scaffold({required AppBar appBar, required body}) {}

 

}
