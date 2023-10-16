import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/core/services/api/data_api.dart';
import 'package:toyskart_admin/core/utils/loader.dart';
import 'package:toyskart_admin/core/utils/misc.dart';
import 'package:toyskart_admin/global/app_service.dart';
import 'package:toyskart_admin/global/toast.dart';
import 'package:toyskart_admin/pages/admin_info/model.dart';

class AdminInfoController extends GetxController {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var id = TextEditingController();
  var shopName = TextEditingController();
  var address1 = TextEditingController();
  var address2 = TextEditingController();
  var phoneNumber1 = TextEditingController();
  var phoneNumber2 = TextEditingController();
  var openingTime = TextEditingController();
  var closingTime = TextEditingController();
  var email = TextEditingController();
  var defaultGst = TextEditingController();
  var insideChennai = TextEditingController();
  var outsideChennai = TextEditingController();

  List<AdminModel> adminData = [];

  getAdminInfo() async {
    var api = DataApiService<List>(
      'app-admin-info',
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );

    Map<String, String> params = {};

    if (!await api.gets(params)) {
      return;
    }

    var details = api.data[0];
    // for (var doc in details) {
    adminData.add(AdminModel.fromJson(details));
    // }
    id.text = adminData[0].id;
    shopName.text = adminData[0].name;
    address1.text = adminData[0].address1;
    address2.text = adminData[0].address2;
    phoneNumber1.text = adminData[0].phoneNumber1;
    phoneNumber2.text = adminData[0].phoneNumber2;
    openingTime.text = adminData[0].openingTime;
    closingTime.text = adminData[0].closingTime;
    email.text = adminData[0].email;
    defaultGst.text = adminData[0].defaultGst.toString();
    insideChennai.text = adminData[0].dcChennai.toString();
    outsideChennai.text = adminData[0].dcOuterChennai.toString();
    update();
  }

  updateAdminInfo() async {
    var userDetails = AppService.to.fireUser!;

    if (formkey.currentState!.validate()) {
      showLoader();
      var api = DataApiService<List>(
        'app-admin-info/${id.text}',
        dataKey: "detail",
        msgToast: false,
        appJson: true,
        showLoader: false,
        errorToast: false,
      );
      Map<String, String> params = {
        "defaultGst": defaultGst.text,
        "_id": id.text,
        "email": email.text,
        "name": shopName.text,

        "phoneNumber1": phoneNumber1.text,
        "phoneNumber2": phoneNumber2.text,
        // "photoUrl": "profile-uploads/99xehdpgl9qfpp86.jpg",
        "address1": address1.text,
        "address2": address2.text,
        "openingTime": openingTime.text,
        "closingTime": closingTime.text,
        //"gelocation": "",
        "active": 'true',
        // "gallery": [
        //   "profile-uploads/99xehdpgl9qfpp88.jpg",
        //   "profile-uploads/99xehdpgl9qfpp8a.jpg",
        //   "profile-uploads/99xehdpgl9qfpp8b.jpg"
        // ],
        "updatedAt": DateTime.now().toLocal().toUtc().toString(),
        "createdAt": DateTime.now().toLocal().toUtc().toString(),
        "dc_chennai": insideChennai.text,
        "dc_outerChennai": outsideChennai.text
      };
      dPrint(params);

      if (!await api.put(params, {})) {
        hideLoader();
        return;
      }

      toast("updated successfully");
      hideLoader();
      update();
    }
  }

  @override
  void onInit() {
    getAdminInfo();
    super.onInit();
  }
}
