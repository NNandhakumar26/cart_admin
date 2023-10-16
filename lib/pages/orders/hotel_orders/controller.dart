import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toyskart_admin/core/constants/api.dart';
import 'package:toyskart_admin/core/services/api/data_api.dart';
import 'package:toyskart_admin/core/utils/misc.dart';
import 'package:toyskart_admin/pages/checkout/model.dart';
import 'package:toyskart_admin/pages/orders/date_time_model.dart';

import '../../../core/utils/loader.dart';

class AllOrderListListController extends GetxController {
  RxList<OrderListModel> allOrders = <OrderListModel>[].obs;
  RxList<OrderListModel> forCount = <OrderListModel>[].obs;
  String status = 'New';
  String singleOrderStatus = 'New';
  List<DateTimeModel> filteredDate = [];
  DateTimeModel? filteredDate2;
  int newCount = 0;
  int acceptedCount = 0;
  int wayCount = 0;
  int deliveredCount = 0;
  String? exandingId;
  String htmlString = "";
  RxBool isLoading = false.obs;
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

  // AddressModel checkoutItems = {};
  List checkoutList = [];

  getOrdersCount() async {
    var db = FirebaseFirestore.instance.collection('orders');
    await db.get().then((event) {
      forCount.clear();

      for (var doc in event.docs) {
        forCount.add(OrderListModel.fromJson(doc.data()));
      }
    });

    update();
  }

  int lastPage = -1;
  String prevType = '';
  getOrders(orderStatus) async {
    prevType = orderStatus;
    await delay(200);
    allOrders.clear();
    update();
// if(){
//     int currentCount = allOrders.length;
//     int offset = currentCount ~/ 10;
//     if (lastPage == offset) return;
//     lastPage = offset;

    var api = DataApiService<List>(
      '${ApiConst.orders}/list',
      dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: false,
      errorToast: false,
    );
    var status = 1;
    if (orderStatus == 'New') {
      status = 1;
    } else if (orderStatus == 'Accepted') {
      status = 2;
    } else if (orderStatus == 'outOfDelivery') {
      status = 3;
    } else if (orderStatus == 'Delivered') {
      status = 4;
    }

    Map<String, String> params = {
      //"userId": AppService.to.loggedUser[0].id,
      "offset": '0',
      "limit": "30",
      "productStatus": '$status',
      //"orderStatus":'',//  default: 0, // 0.pending 1.Success 2.Failure 3.Cancel 4.Refund
      // "status":
      //     '$status', //default: 0, // 0.pending 1.New 2.Accepted 3.outOfDelivery 4.Delivered
    };

    if (!await api.gets(params)) {
      isLoading.value = true;

      return;
    }

    var details = api.data[0]['paginatedResults'];
    for (var doc in details) {
      allOrders.add(OrderListModel.fromJson(doc));
    }
    isLoading.value = true;

    update();
  }

  updatStatus(orderId, orderStatus) async {
    var type = "2";
    // var status = "";
    var api = DataApiService(
      '${ApiConst.orders}/status-update',
      // dataKey: "detail",
      msgToast: false,
      appJson: true,
      showLoader: true,
      errorToast: false,
    );

    // if (orderStatus == 2) {
    //   status = '2';
    // } else if (orderStatus == 3) {
    //   status = '3';
    // } else if (orderStatus == 4) {
    //   status = '4';
    // } else if (orderStatus == 1) {
    //   status = '1';
    //   type = '1';
    // }

    var status = 1;
    if (orderStatus == 'New') {
      status = 1;
      // type = '1';
    } else if (orderStatus == 'Accepted') {
      status = 2;
    } else if (orderStatus == 'outOfDelivery') {
      status = 3;
    } else if (orderStatus == 'Delivered') {
      status = 4;
    }
    Map<String, String> params = {
      "orderId": orderId,
      "type": type,
      "statusUpdate": '$status'
    };

    if (!await api.put(params, {})) return;
    allOrders.removeWhere((element) => element.id == orderId);
    // getOrders(orderStatus);

    update();
  }

  String dateAsReadable(DateTime? dateTime,
      {String format = "dd-MMM-yyyy HH:MM ss", String ifNull = " - "}) {
    if (dateTime == null) return ifNull;

    DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime.toLocal());
  }

  Future<void> createReceipt(OrderListModel item) async {
    Directory appDocDir = await getTemporaryDirectory();
    final targetPath = appDocDir.path;

    showLoader();
    var localString =
        "<div style='width:100%; align-items:center; display:flex; justify-content:center;'><p style='font-weight:600; font-size:28px; color:#1C4587;'>Your Receipt</p></div><p style='padding:0px;'>Thank you for your purchase on Mercury Toys and for your support .</p>'<br><p style='padding:3px 3px 3px 0px; margin:3px 3px 3px 0px;'><b>Order ID:</b> ${item.orderId}</p><br><p style='padding:0px 3px 0px 0px; margin:0px 3px 0px 0px;'><b>Date:</b> ${dateAsReadable(item.orderDate, format: 'dd-MM-yyyy @ hh:mm a')}</p><br><p style='padding:0px 3px 0px 0px; margin:0px 3px 0px 0px;'><b>Shipping Address:</b> ${item.address.fullName}, ${item.address.address1},${item.address.city}, - ${item.address.pincode}, Mobile: ${item.address.phoneNo}</p> ";
    localString +=
        "<table style='width:100% ;border: 1px solid black; border-collapse:collapse; padding:3px 3px 3px 0px; margin:20px 3px 3px 0px;'><tr style='border: 1px solid black; '>   <th style='height:35px; border: 1px solid black;text-align:center;'> <p style='margin-left:8px;'>Product Description</p></th>  <th style='border: 1px solid black;text-align:center; width:25%; '><p style='margin-left:8px;'>Qty * Unit Price</p></th>  <th style='border: 1px solid black;text-align:left; width:15%; '><p style='margin-left:8px;'>Amount</p></th>	</tr>";

    for (var a in item.productsName) {
      localString +=
          "<tr style='border: 1px solid black; height:35px;'> <td style='border: 1px solid black; text-align:left;'><p style='margin-left:8px;' >${a.name}</p></td><td style='border: 1px solid black; text-align:right; width:15%;'><p style='margin-right:12px;'>${a.itemCount} X \u{20B9}${a.actualAmount}</p></td><td style='border: 1px solid black; text-align:right;  width:15%;'><p style='margin-right:8px;'>\u{20B9}${a.itemCount * a.actualAmount}</p></td>";
    }
    localString +=
        "<tr style='border: 1px solid black; height:35px;'> <td colspan='2' style='border: 1px solid black; text-align:right;'><p style='margin-right:12px;' >GST %</p></td><td  style='border: 1px solid black; text-align:right;  width:15%;'><p style='margin-right:8px;'>${item.gstAmount}%</p></td>";
    localString +=
        "<tr style='border: 1px solid black; height:35px;'> <td colspan='2' style='border: 1px solid black; text-align:right;'><p style='margin-right:12px;' >Delivey Charge</p></td><td  style='border: 1px solid black; text-align:right;  width:15%;'><p style='margin-right:8px;'>\u{20B9}${item.deliveryCharge}</p></td>";
    localString +=
        "<tr style='border: 1px solid black; height:35px;'> <td colspan='2' style='border: 1px solid black; text-align:right;'><p style='margin-right:12px;font-size:20px; font-weight:bold;' >Total</p></td><td  style='border: 1px solid black; text-align:right;  width:15%;'><p style='margin-right:8px; font-size:20px; font-weight:bold;'>\u{20B9}${item.totalAmount}</p></td>";
    localString += "</table>";

    update();
    try {
      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          localString, targetPath, "Receipt");
      OpenFile.open(generatedPdfFile.path);
    } catch (e) {
      dPrint(e);
    }

    hideLoader();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getOrdersCount();
    addtime();
    getOrders('New');
    // Timer.periodic(const Duration(minutes: 1), (timer) {
    //   getOrders('New');
    // });
    super.onReady();
  }
//   String dat (){

// DateTime dt = (map['timestamp'] as Timestamp).toDate()
//   }
}
