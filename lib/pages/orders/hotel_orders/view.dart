import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toyskart_admin/global/app_service.dart';
import 'package:toyskart_admin/global/style.dart';

import '../../../core/constants/colors.dart';
import 'controller.dart';

class AllOrderList extends GetView<AllOrderListListController> {
  const AllOrderList({super.key, required this.type, required this.nextState});
  final String type;
  final String nextState;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<AllOrderListListController>(initState: (state) async {
        await controller.getOrders(type);
      }, builder: (ctrl) {
        if (controller.allOrders.isEmpty) {
          return Obx((() => Center(
                child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(top: 0, left: 0, bottom: 0),
                    child: AppService.to.inRequest()
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                  child: JumpingDotsProgressIndicator(
                                numberOfDots: 4,
                                fontSize: 60.0,
                                color: ColorConst.primary,
                              )),
                            ),
                          )
                        : Text(
                            'No Orders Found',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffB3B3BF)),
                          )),
              )));
        }
        return RefreshIndicator(
            onRefresh: () async {
              controller.getOrders(type);
            },

            // height: 400,
            child: ListView.builder(
                itemCount: controller.allOrders.length,
                itemBuilder: (context, index) {
                  var item = controller.allOrders[index];
                  return InkWell(
                    onTap: () {
                      if (controller.exandingId == item.id) {
                        controller.exandingId = null;
                      } else {
                        controller.exandingId = item.id;
                      }
                      controller.update();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: 25, left: 20, top: 10, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(blurRadius: 10, color: ColorConst.grey3)
                        ],
                        color: ColorConst.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   child: PrimaryText(
                                    //       text:
                                    //           'Orde ID: ${item.id}',
                                    //       size: 14,
                                    //       color: ColorConst.black,
                                    //       fontWeight:
                                    //           FontWeight.w700),
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: PrimaryText(
                                              height: 1.5,
                                              text:
                                                  'Ordered Time: ${controller.dateAsReadable(item.orderDate, format: 'dd-MM-yyyy @ hh:mm a')}',
                                              size: 14,
                                              color: ColorConst.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            controller.exandingId == item.id
                                                ? Icons.arrow_right_outlined
                                                : Icons
                                                    .arrow_drop_down_outlined,
                                            color: ColorConst.primary,
                                          ),
                                        )
                                      ],
                                    ),
                                    // SizedBox(
                                    //   child: PrimaryText(
                                    //       height: 1.5,
                                    //       text:
                                    //           'Delivered Time: ${controller.dateAsReadable(item.orderedTime, format: 'dd-MM-yyyy @ hh:mm a')}',
                                    //       size: 14,
                                    //       color: ColorConst.black,
                                    //       fontWeight:
                                    //           FontWeight.w700),
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: PrimaryText(
                                              height: 1.5,
                                              text:
                                                  'Status: ${item.productStatusUpdate()}',
                                              size: 14,
                                              color: ColorConst.green,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextButton(
                                              onPressed: () =>
                                                  controller.updatStatus(
                                                      item.id, nextState),
                                              child: Text(nextState)),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 5,
                                    ),
                                    for (var a in item.productsName)
                                      Container(
                                        // height: 50,
                                        width: screenWidth * .75,
                                        margin: const EdgeInsets.all(2),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          minVerticalPadding: 0,
                                          title: Text(
                                            a.name,
                                            style: const TextStyle(
                                                color: ColorConst.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                            "\u{20B9}${a.actualAmount} X ${a.itemCount}",
                                            style: const TextStyle(
                                                color: ColorConst.primary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          trailing: Text(
                                            "\u{20B9}${a.itemCount * a.actualAmount}",
                                            style: const TextStyle(
                                                color: ColorConst.primary,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          if (controller.exandingId == item.id) ...[
                            InkWell(
                              child: Container(
                                //alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                // decoration: BoxDecoration(
                                //     border: Border.symmetric(
                                //       vertical: BorderSide.none,
                                //       horizontal: BorderSide.lerp(
                                //           1.0, 1, 1),
                                //       //  color: ColorConst.primary,
                                //     ),
                                //     borderRadius:
                                //         const BorderRadius
                                //                 .horizontal(
                                //             left: Radius.zero,
                                //             right: Radius.zero)),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(
                                        color: ColorConst.primary,
                                        thickness: 1),
                                    SizedBox(
                                      width: 300,
                                      height: 40,
                                      child: ListTile(
                                        title: const Text(
                                          " Ordered Amount :",
                                          style: TextStyle(
                                              color: ColorConst.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        trailing: Text(
                                          " \u{20B9}${item.orderAmount}",
                                          style: const TextStyle(
                                              color: ColorConst.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 40,
                                      child: ListTile(
                                        title: const Text(
                                          " GST : 18%",
                                          style: TextStyle(
                                              color: ColorConst.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        trailing: Text(
                                          " ${(item.gstAmount).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              color: ColorConst.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 40,
                                      child: ListTile(
                                        title: const Text(
                                          "Delivery Charge :",
                                          style: TextStyle(
                                              color: ColorConst.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        trailing: Text(
                                          " \u{20B9}${item.deliveryCharge}",
                                          style: const TextStyle(
                                              color: ColorConst.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                        color: ColorConst.primary,
                                        thickness: 1),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    ElevatedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: ColorConst.white,
                                        // backgroundColor:
                                        //     const Color.fromRGBO(
                                        //         230, 169, 25, 1),
                                        minimumSize: const Size.fromHeight(32),
                                        textStyle:
                                            const TextStyle(fontSize: 14),
                                      ),
                                      child: const Text('View Receipt'),
                                      onPressed: () {
                                        controller.createReceipt(item);
                                      },
                                    ),
                                    //   width: 300,
                                    //   height: 40,
                                    //   child: ListTile(
                                    //     title: const Text(
                                    //       "Grand Total :",
                                    //       style: TextStyle(
                                    //           color: ColorConst.black,
                                    //           fontSize: 18,
                                    //           fontWeight:
                                    //               FontWeight.w600),
                                    //     ),
                                    //     trailing: Text(
                                    //       " \u{20B9}${item.totalAmount}",
                                    //       style: const TextStyle(
                                    //           color: ColorConst.black,
                                    //           fontSize: 18,
                                    //           fontWeight:
                                    //               FontWeight.w600),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          Row(
                            children: [
                              // Expanded(
                              //     flex: 1,
                              //     child: TextButton(
                              //         onPressed: () {},
                              //         child: const Text(
                              //           'REORDER',
                              //           style: TextStyle(
                              //             color: ColorConst.primary,
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.w600,
                              //           ),
                              //         ))),
                              //Spacer(),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    //alignment: Alignment.bottomRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorConst.primary,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        )),
                                    child: Column(
                                      children: [
                                        Text(
                                          " Total : \u{20B9}${item.totalAmount}",
                                          style: const TextStyle(
                                              color: ColorConst.primary,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }));
      }),
    );
  }
}
