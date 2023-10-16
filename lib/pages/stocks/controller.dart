import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:toyskart_admin/core/constants/api.dart';
import 'package:toyskart_admin/core/constants/routes.dart';
import 'package:toyskart_admin/core/services/api/data_api.dart';
import 'package:toyskart_admin/core/utils/alerts.dart';
import 'package:toyskart_admin/core/utils/image_compress.dart';
import 'package:toyskart_admin/core/utils/loader.dart';
import 'package:toyskart_admin/core/utils/misc.dart';
import 'package:toyskart_admin/global/app_service.dart';
import 'package:toyskart_admin/global/functions/category_popup_view.dart';
import 'package:toyskart_admin/global/functions/global_functions.dart';
import 'package:toyskart_admin/pages/checkout/model.dart';
import 'package:toyskart_admin/pages/orders/date_time_model.dart';
import 'package:toyskart_admin/pages/stocks/category/model.dart';
import 'package:toyskart_admin/pages/stocks/category/view.dart';
import 'package:toyskart_admin/pages/stocks/food_list_model.dart';

class StocksListController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ItemList> foodItemList = <ItemList>[].obs;
  RxList<OrderListModel> forCount = <OrderListModel>[].obs;
  String status = 'New';
  String singleOrderStatus = 'New';
  List<DateTimeModel> filteredDate = [];
  DateTimeModel? filteredDate2;
  int newCount = 0;
  int acceptedCount = 0;
  int wayCount = 0;
  int deliveredCount = 0;
  XFile? pickedImageFile;
  List<AssetEntity>? selImage;
  List<String?> path = [];
  RxBool showImage = false.obs;
  final imageViewPageController = PageController();
// categiry fields
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  RxBool isEnabled = false.obs;
  String cid = "";
  bool flag = false;
// item fields
  GlobalKey<FormState> formkeyItem = GlobalKey<FormState>();
  final toyName = TextEditingController();
  final toyDescription = TextEditingController();
  final price = TextEditingController();
  final units = TextEditingController();
  final totalQuantity = TextEditingController();
  final toyId = TextEditingController();
  CategoryModel? categoryController;
  bool itemFlag = false;

  RxBool isAvail = false.obs;
  String type = '1';
  String dt = 'Veg';

  addtime() {
    var time = [
      {"Time": "Today", "Date": DateTime.now().toString()},
      {
        "Time": "Yesterday",
        "Date": DateTime.now().add(const Duration(days: 1)).toString()
      },
      {
        "Time": "Last 7 days",
        "Date": DateTime.now().subtract(const Duration(days: 7)).toString()
      },
      {
        "Time": "Last 14 days",
        "Date": DateTime.now().subtract(const Duration(days: 14)).toString()
      },
      {
        "Time": "Last 30 days",
        "Date": DateTime.now().subtract(const Duration(days: 30)).toString()
      },
      {
        "Time": "Last 60 days",
        "Date": DateTime.now().subtract(const Duration(days: 60)).toString()
      },
      {
        "Time": "Last 6 months ",
        "Date": DateTime.now().subtract(const Duration(days: 180)).toString()
      },
      {
        "Time": "Last 1 year ",
        "Date": DateTime.now().subtract(const Duration(days: 365)).toString()
      }
    ];
    for (var item in time) {
      filteredDate.add(DateTimeModel.fromJson(item));
    }
    update();
  }

  List checkoutList = [];

  updateItemStatus(bool orderStatus, ItemList item) async {
    showLoader();

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json, image/*',
        'Authorization': 'Bearer ${await AppService.to.idToken()}',
      };
      var firstUrl = '${ApiConst.apiHost}${ApiConst.middlePath}';
      var url = '$firstUrl${ApiConst.item}/${item.id}?tenantId=admin';
      var dio = d.Dio(
        d.BaseOptions(
          baseUrl: firstUrl,
          headers: headers,
        ),
      );

      var response = await dio.put(
        url,
        data: d.FormData.fromMap({
          //'image': img,
          "id": item.id,
          "name": item.name,
          "description": item.description,

          "availableType": 1,
          "price": item.price,
          "stockCount": item.stockCount,
          "category": [item.category],
          "includeGst": true,
          "enable": orderStatus.toString(),
          "updatedBy": AppService.to.loggedUser[0].id
        }),
      );

      var va = response.data!;
      dPrint(va);
      selImage = null;
      toyId.text = "";
      path = [];
      showImage.value = false;
      toyName.text = "";
      toyDescription.text = "";
      price.text = "";
      isEnabled.value = false;
      categoryController = null;
      update();

      // getItems(3);
      toast('Toy updated successfully.');
      Get.back();
    } on d.DioError catch (e) {
      dPrint(e.response?.data ?? '');
    } finally {
      hideLoader();
    }
  }

  String dateAsReadable(DateTime? dateTime,
      {String format = "dd-MMM-yyyy", String ifNull = " - "}) {
    if (dateTime == null) return ifNull;

    DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  getCategoriesLocal(type) async {
    categories.clear();
    update();
    await delay(100);

    var userDetails = AppService.to.loggedUser[0];
    var api = DataApiService<List>(
      ApiConst.getCategories,
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    Map<String, String> params = {
      "limit": '10',
      "enable": type == "1" ? "true" : "false",
      "offset": '0',
    };
    if (!await api.gets(params)) return;
    List details = api.data;
    categories.clear();

    for (var doc in details) {
      categories.add(CategoryModel.fromJson(doc));
    }

    //AppService.to.globalCategoriesList = categories;
    update();
  }

  updatCategoriesflag(CategoryModel item, bool flag) async {
    var userDetails = AppService.to.fireUser!;

    var api = DataApiService<List>(
      '${ApiConst.categories}/${item.id}',
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    Map<String, String> params = {
      "name": item.name,
      "value": item.name.replaceAll(" ", "_").toLowerCase(),
      "enable": flag.toString(),
      //"parentCategoryId": "",
      "categoryType": "1",
      "status": flag ? '1' : '2',
      "updatedBy": AppService.to.loggedUser[0].id
    };
    print(params);

    if (!await api.put(params, {})) return;

    toast("Category updated successfully");
    await getCategoriesLocal(flag == true ? "2" : "1");
    getCategory();
    update();
  }

  updatCategories() async {
    var userDetails = AppService.to.fireUser!;

    if (formkey.currentState!.validate()) {
      // var db = FirebaseFirestore.instance.collection('address').doc();
      var api = DataApiService<List>(
        '${ApiConst.categories}/$cid',
        dataKey: "detail",
        msgToast: false,
        appJson: true,
        showLoader: false,
        errorToast: false,
      );
      Map<String, String> params = {
        "name": categoryName.text,
        "value": categoryName.text.replaceAll(" ", "_").toLowerCase(),
        "enable": isEnabled.value.toString(),
        //"parentCategoryId": "",
        "categoryType": "1",
        "status": isEnabled.value ? '1' : '2',
        "updatedBy": AppService.to.loggedUser[0].id
      };
      print(params);

      if (!await api.put(params, {})) return;
      await getCategoriesLocal(flag == true ? "2" : "1");
      categoryName.text = "";
      isEnabled.value = false;

      toast("Category updated successfully");
      // Get.offNamed(RouteConst.categoryList);
      Get.back();
      // }
      update();
    }
  }

  addCategories() async {
    if (formkey.currentState!.validate()) {
      // if (path == null) {
      //   toast('Please upload image to procced');
      //   return;
      // }
      showLoader();

      try {
        Map<String, String> headers = {
          'Content-Type': 'application/json, image/*',
          'Authorization': 'Bearer ${await AppService.to.idToken()}',
        };
        //path = await compressImage(path!, max: 256);

        var dio = d.Dio(
          d.BaseOptions(
            baseUrl: ApiConst.apiHost + ApiConst.middlePath,
            headers: headers,
          ),
        );

        var response = await dio.post(
          '${ApiConst.categories}?tenantId=admin',
          data: d.FormData.fromMap({
            // 'image': await d.MultipartFile.fromFile(
            //   path!,
            //   filename: path!.split('/').last,
            //   contentType: MediaType('image', path!.split('.').last),
            // ),
            "name": categoryName.text,
            "value": categoryName.text.replaceAll(" ", "_").toLowerCase(),
            "enable": isEnabled.value.toString(),
            "parentCategoryId": "",
            "categoryType": "1",
            "status": isEnabled.value ? '1' : '2',

            "createdBy": AppService.to.loggedUser[0].id
          }),
        );

        var va = response.data!;
        dPrint(va);

        await getCategoriesLocal(flag == true ? "2" : "1");
        selImage = null;
        path = [];
        showImage.value = false;
        categoryName.text = "";
        isEnabled.value = false;
        update();
        toast('Category added successfully.');
        Get.back();
      } on d.DioError catch (e) {
        dPrint(e.response?.data ?? '');
      } finally {
        getCategory();
        hideLoader();
      }
    }
  }

  getCategoryById(CategoryModel item) async {
    cid = item.id;
    flag = true;
    categoryName.text = item.name;

    cid = item.id;
    isEnabled.value = item.isActive;
    update();
    Get.to(
      () => const AddEditCategory(),
    );
  }

  getItems(type) async {
    foodItemList.clear();
    //foodsListFiltered.clear();
    update();
    await delay(100);

    var api = DataApiService<List>(
      ApiConst.menuList,
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    Map<String, String> params = {
      "userId": AppService.to.loggedUser[0].id,
      "enable": type == "3" ? "true" : "false",
    };

    if (!await api.gets(params)) return;

    var details = api.data[0]['paginatedResults'];
    for (var doc in details) {
      foodItemList.add(ItemList.fromJson(doc));
    }

    update();
  }

  void openCategoryPicker() async {
    CategoryModel? zone = await Get.dialog<CategoryModel?>(
      AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: CategoryPickerViewBody()),
      // barrierColor: ColorConst.primary,
      barrierDismissible: true,
    );
    if (zone == null) return;
    if (categoryController != null && zone == categoryController) return;

    if (categoryController == null) {
      categoryController = zone;
      update();
      return;
    }

    categoryController = zone;

    //print(categoryController!.name);

    update();
  }

  addItem() async {
    if (formkeyItem.currentState!.validate()) {
      if (path == null) {
        toast('Please upload image to procced');
        return;
      }
      showLoader();

      try {
        Map<String, String> headers = {
          'Content-Type': 'application/json, image/*',
          'Authorization': 'Bearer ${await AppService.to.idToken()}',
        };
        var img = [];
        for (var i = 0; i < path.length; i++) {
          path[i] = await compressImage(path[i]!, max: 256);
          img.add(await d.MultipartFile.fromFile(
            path[i]!,
            filename: path[i]!.split('/').last,
            contentType: MediaType('image', path[i]!.split('.').last),
          ));
        }

        var dio = d.Dio(
          d.BaseOptions(
            baseUrl: ApiConst.apiHost + ApiConst.middlePath,
            headers: headers,
          ),
        );

        var response = await dio.post(
          '${ApiConst.item}?tenantId=admin',
          data: d.FormData.fromMap({
            // 'image': await d.MultipartFile.fromFile(
            //   path,
            //   filename: path.split('/').last,
            //   contentType: MediaType('image', path.split('.').last),
            // ),
            'image': img,
            "name": toyName.text,
            "description": toyDescription.text,

            "availableType": 1,
            "price": price.text,
            "stockCount": units.text,
            "category": categoryController?.id,
            "includeGst": true,
            "enable": isEnabled.value.toString(),
            "createdBy": AppService.to.loggedUser[0].id
          }),
        );

        var va = response.data!;
        dPrint(va);
        selImage = null;
        path = [];
        showImage.value = false;
        toyName.text = "";
        toyDescription.text = "";
        price.text = "";
        isEnabled.value = false;
        categoryController = null;
        update();

        // getItems(3);
        toast('Toy added successfully.');
        Get.back();
      } on d.DioError catch (e) {
        dPrint(e.response?.data ?? '');
      } finally {
        hideLoader();
      }
    }
  }

  updateItem({flag = true}) async {
    if (formkeyItem.currentState!.validate()) {
      if (path == null) {
        toast('Please upload image to procced');
        return;
      }
      showLoader();

      try {
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await AppService.to.idToken()}',
        };
        // var img = [];
        // for (var i = 0; i < path.length; i++) {
        //   path[i] = await compressImage(path[i]!, max: 256);
        //   img.add(await d.MultipartFile.fromFile(
        //     path[i]!,
        //     filename: path[i]!.split('/').last,
        //     contentType: MediaType('image', path[i]!.split('.').last),
        //   ));
        // }
        var firstUrl = '${ApiConst.apiHost}${ApiConst.middlePath}';
        var url = '$firstUrl${ApiConst.item}/${toyId.text}?tenantId=admin';
        var dio = d.Dio(
          d.BaseOptions(
            baseUrl: firstUrl,
            headers: headers,
          ),
        );
        var params = {
          //'image': img,
          "id": toyId.text,
          "name": toyName.text,
          "description": toyDescription.text,

          "availableType": 1,
          "price": price.text,
          "stockCount": units.text,
          "category": categoryController?.id,
          "includeGst": true,
          "enable": isEnabled.value.toString(),
          "updatedBy": AppService.to.loggedUser[0].id
        };
        print(params);
        var response = await dio.put(
          url,
          data: d.FormData.fromMap(params),
        );

        var va = response.data!;
        dPrint(va);
        selImage = null;
        toyId.text = "";
        path = [];
        showImage.value = false;
        toyName.text = "";
        toyDescription.text = "";
        price.text = "";
        isEnabled.value = false;
        categoryController = null;
        update();

        // getItems(3);
        toast('Toy updated successfully.');
        Get.back();
      } on d.DioError catch (e) {
        dPrint(e.response?.data ?? '');
      } finally {
        hideLoader();
      }
    }
  }

  setItem(ItemList? item) {
    Get.toNamed(RouteConst.add, arguments: item);

    if (Get.arguments != null) {
      ItemList fm = Get.arguments;
      itemFlag = true;

      toyName.text = fm.name;
      price.text = fm.price.toString();
      isAvail.value = fm.enable;
      toyDescription.text = fm.description;
      units.text = fm.stockCount.toString();
      toyId.text = fm.id;
      isEnabled.value = fm.enable;
      path = fm.image;
      showImage.value = true;
      Get.toNamed(RouteConst.add, arguments: item);
      update();
      print('arg');
    } else {
      print('no arg');
    }
  }

  load(type) async {
    if (type == "1" || type == "2") {
      await getCategoriesLocal(type);
    } else if (type == "3" || type == "4") {
      await getItems(type);
    }
  }

  check() async {}

  @override
  void onReady() {
    // TODO: implement onReady
    load("1");
    addtime();
    check();

    // Timer.periodic(const Duration(minutes: 1), (timer) {
    //
    // });
    super.onReady();
  }
//   String dat (){

// DateTime dt = (map['timestamp'] as Timestamp).toDate()
//   }
}
