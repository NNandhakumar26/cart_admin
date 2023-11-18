import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toyskart_admin/core/utils/misc.dart';
import 'package:toyskart_admin/global/app_service.dart';
import 'package:toyskart_admin/global/style.dart';
import 'package:toyskart_admin/pages/stocks/controller.dart';

import '../../../core/constants/colors.dart';

class StocksList2 extends GetView<StocksListController> {
  const StocksList2({
    super.key,
    required this.type,
  });
  final String type;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: GetBuilder<StocksListController>(initState: (state) async {
      await delay(100);
      await controller.load(type);
    }, builder: (ctrl) {
      if (controller.foodItemList.isEmpty) {
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
                          'No Items Found',
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffB3B3BF)),
                        )),
            )));
      }
      return Container(
        color: ColorConst.background,

        // height: 400,
        child: SizedBox(
          height: screenHeight * .8,
          child: ListView.builder(
              itemCount: controller.foodItemList.length,
              itemBuilder: (context, index) {
                var item = controller.foodItemList[index];
                return Column(
                  children: [
                    if (index == 0)
                      const SizedBox(
                        height: 25,
                      ),
                    Container(
                      margin:
                          const EdgeInsets.only(right: 25, left: 20, top: 0),
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
                                    const EdgeInsets.only(top: 25, left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 20),
                                      child: SizedBox(
                                        // width:
                                        //     MediaQuery.of(context)
                                        //             .size
                                        //             .width /
                                        //         2.2,
                                        child: PrimaryText(
                                            text: item.name,
                                            size: 16,
                                            color: ColorConst.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                controller.setItem(item);
                                              },
                                              child: const Text(
                                                'Edit',
                                                style: TextStyle(
                                                  color: ColorConst.primary,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                          // TextButton(
                                          //     onPressed: () {
                                          //       // controller.deletePopUp(
                                          //       //     context, item.id);
                                          //     },
                                          //     child: const Text(
                                          //       'Delete',
                                          //       style: TextStyle(
                                          //         color: ColorConst
                                          //             .primary,
                                          //         fontSize: 14,
                                          //         fontWeight:
                                          //             FontWeight.w600,
                                          //       ),
                                          //     )),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              child: Container(
                                                //alignment: Alignment.bottomRight,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 0),

                                                child: SwitchListTile(
                                                  value: item.enable,
                                                  // title: const Text(
                                                  //   'Status',
                                                  //   style: TextStyle(
                                                  //     color: ColorConst
                                                  //         .primary,
                                                  //     fontSize: 14,
                                                  //     fontWeight:
                                                  //         FontWeight.w600,
                                                  //   ),
                                                  // ),
                                                  activeColor: Colors.green,
                                                  activeTrackColor:
                                                      Colors.green[200],
                                                  inactiveThumbColor:
                                                      Colors.orange,
                                                  inactiveTrackColor:
                                                      Colors.orange[200],
                                                  onChanged: (e) {
                                                    item.enable = e;
                                                    controller.isEnabled.value =
                                                        e;
                                                    controller.toyId.text =
                                                        item.id;
                                                    controller.update();
                                                    controller.updateItemStatus(
                                                        e, item);
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                );
              }),
        ),
      );
    }));
  }
}
