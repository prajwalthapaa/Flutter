import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';


class CategoryRepository {
  CollectionReference<CategoryModel> categoryRef = FirebaseService.db.collection("categories").withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) {
      return CategoryModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );

  Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;

      if (!hasData) {
        // Clear existing categories (if any)
        await clearExistingCategories();

        // Get the new list of categories
        List<CategoryModel> newCategories = makeNewCategory();

        // Add the new categories to Firestore
        newCategories.forEach((element) async {
          await categoryRef.add(element);
        });
      }

      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> clearExistingCategories() async {
    var snapshot = await categoryRef.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }


  Future<DocumentSnapshot<CategoryModel>>  getCategory(String categoryId) async {
      try{
        print(categoryId);
        final response = await categoryRef.doc(categoryId).get();
        return response;
      }catch(e){
        rethrow;
      }
  }

  // List<CategoryModel> makeCategory(){
  //     return [
  //       CategoryModel(categoryName: "Mobile Phones and Accessories", status: "active", imageUrl: "https://reviews.com.np/uploads/article/top-10-phones-under-30k-in-nepal-2020/top-10-phones-under-30k-in-nepal-2020.jpeg"),
  //       CategoryModel(categoryName: "Automobile", status: "active", imageUrl: "https://i2-prod.dailyrecord.co.uk/incoming/article25217715.ece/ALTERNATES/s615/0_Daily-Record-Road-Record.jpg"),
  //       CategoryModel(categoryName: "Apparel", status: "active", imageUrl: "https://www.techprevue.com/wp-content/uploads/2016/05/online-apparel-business.jpg"),
  //       CategoryModel(categoryName: "Computers and Peripherals", status: "active", imageUrl: "https://i2.wp.com/d3d2ir91ztzaym.cloudfront.net/uploads/2020/07/computer-peripherals.jpeg"),
  //       CategoryModel(categoryName: "Music Instruments", status: "active", imageUrl: "https://img.texasmonthly.com/2013/04/ESSENTIALS_680X382.jpg"),
  //     ];
  // }

  List<CategoryModel> makeNewCategory(){
    return [
      CategoryModel(categoryName: "Cakes", status: "active", imageUrl: "https://images.pexels.com/photos/1793037/pexels-photo-1793037.jpeg?auto=compress&cs=tinysrgb&w=400"),
      CategoryModel(categoryName: "Cupcakes", status: "active", imageUrl: "https://images.pexels.com/photos/14105/pexels-photo-14105.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
      CategoryModel(categoryName: "Donuts", status: "active", imageUrl: "https://images.unsplash.com/photo-1551024601-bec78aea704b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGNha2VzfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"),
      CategoryModel(categoryName: "Pinata Cakes", status: "active", imageUrl: "https://images.unsplash.com/photo-1593198976133-ce0c3006974f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8UGluYXRhJTIwY2FrZXN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60"),
      CategoryModel(categoryName: "Bento Cakes", status: "active", imageUrl: "https://media.istockphoto.com/id/1467525229/photo/bento-cake-a-cute-little-dessert-cake-for-a-gift-korean-style-cakes-in-a-box-for-one-person.webp?b=1&s=170667a&w=0&k=20&c=CTLxSfJR0bE4yokkSDQkAMafdV4F55nS0ZSytfv-HBk="),
      CategoryModel(categoryName: "Cakesickles", status: "active", imageUrl: "https://images.unsplash.com/photo-1501014882647-fa3cef30d47d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBvcHNpY2xlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"),
    ];
  }



}