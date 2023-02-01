import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foode_app/model/banner_model.dart';
import 'package:foode_app/model/category_model.dart';
import 'package:foode_app/model/product_model.dart';

class HomeController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<BannerModel> listOfBanners = [];
  List<ProductModel> listOfProduct = [];
  List<CategoryModel> listOfCategory = [];
  List listOfCategoryDocId = [];
  bool _isLoading = true;
  bool setFilter = false;
  bool _isCategoryLoading = true;
  bool _isProductLoading = true;
  int selectIndex = -1;

  changeIndex(int index) async {
    if (selectIndex == index) {
      selectIndex = -1;
    } else {
      selectIndex = index;
     var res = await firestore
          .collection("products")
          .where("category", isEqualTo: listOfCategoryDocId[selectIndex])
          .get();
      listOfProduct.clear();
      for (var element in res.docs) {
        listOfProduct.add(ProductModel.fromJson(element.data()));
      }
    }
    notifyListeners();
  }

  setFilterChange() {
    setFilter = !setFilter;
    notifyListeners();
  }

  getBanners() async {
    _isLoading = true;
    notifyListeners();
    var res = await firestore.collection("banner").get();
    listOfBanners.clear();
    for (var element in res.docs) {
      String docId = element.data()["productId"];
      var res = await firestore
          .collection("products")
          .doc(docId.replaceAll(" ", ""))
          .get();
      listOfBanners.add(
          BannerModel.fromJson(data: element.data(), dataProduct: res.data()));
    }
    _isLoading = false;
    notifyListeners();
  }

  getCategory({bool isLimit = true}) async {
    _isCategoryLoading = true;
    notifyListeners();
    dynamic res;
    if (isLimit) {
      res = await firestore.collection("category").limit(5).get();
    } else {
      res = await firestore.collection("category").get();
    }
    listOfCategory.clear();
    listOfCategoryDocId.clear();
    for (var element in res.docs) {
      listOfCategory.add(CategoryModel.fromJson(element.data()));
      listOfCategoryDocId.add(element.id);
    }
    _isCategoryLoading = false;
    notifyListeners();
  }

  searchCategory(String name) async {
    var res = await firestore.collection("category").orderBy("name").startAt(
        [name.toLowerCase()]).endAt(["${name.toLowerCase()}\uf8ff"]).get();
    listOfCategory.clear();
    listOfCategoryDocId.clear();
    for (var element in res.docs) {
      listOfCategory.add(CategoryModel.fromJson(element.data()));
      listOfCategoryDocId.add(element.id);
    }
    notifyListeners();
  }

  getProduct({bool isLimit = true}) async {
    _isProductLoading = true;
    notifyListeners();
    var res;
    if (isLimit) {
      res = await firestore.collection("products").limit(5).get();
    } else {
      res = await firestore.collection("products").get();
    }
    listOfProduct.clear();
    for (var element in res.docs) {
      listOfProduct.add(ProductModel.fromJson(element.data()));
    }
    _isProductLoading = false;
    notifyListeners();
  }

  bool get isTotalLoading =>
      _isLoading || _isCategoryLoading || _isProductLoading;
}
