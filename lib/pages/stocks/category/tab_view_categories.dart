import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/pages/stocks/category/category.dart';
import 'package:toyskart_admin/pages/stocks/controller.dart';

class StocksTabView1 extends StatefulWidget {
  const StocksTabView1({
    Key? key,
  }) : super(key: key);

  @override
  State<StocksTabView1> createState() => _StocksTabView1State();
}

class _StocksTabView1State extends State<StocksTabView1>
    with SingleTickerProviderStateMixin {
  final RxBool showTitle = false.obs;

  late final TabController tabController =
      TabController(length: 2, vsync: this);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String displayName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: GetBuilder<StocksListController>(
        init: StocksListController(),
        builder: (_) {
          return Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              ColorfulTabBar(
                indicatorHeight: 0,
                tabs: [
                  TabItem(
                      color: Colors.green,
                      title: Badge(
                        padding: const EdgeInsets.all(8.0),
                        badgeColor: ColorConst.primary,
                        showBadge: _.newCount != 0,
                        badgeContent: Text(
                          _.newCount.toString(),
                          style: const TextStyle(
                              color: ColorConst.background, fontSize: 12),
                        ),
                        animationType: BadgeAnimationType.fade,
                        position: BadgePosition.topEnd(
                          top: -22,
                        ),
                        child: const Text(
                          'Available',
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorConst.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )),
                  TabItem(
                    color: Colors.red,
                    title: Badge(
                      padding: const EdgeInsets.all(8.0),
                      badgeColor: ColorConst.primary,
                      showBadge: _.acceptedCount != 0,
                      badgeContent: Text(
                        _.acceptedCount.toString(),
                        style: const TextStyle(
                            color: ColorConst.background, fontSize: 12),
                      ),
                      animationType: BadgeAnimationType.fade,
                      position: BadgePosition.topEnd(
                        top: -22,
                      ),
                      child: const Text(
                        'Out Of Stock',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorConst.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
                controller: tabController,
              ),
              // TabBar(
              //   controller: tabController,
              //   indicatorColor: ColorConst.primary,
              //   indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
              //   tabs: [
              //     Tab(
              //       child: Badge(
              //         padding: const EdgeInsets.all(8.0),
              //         badgeColor: ColorConst.primary,
              //         showBadge: _.newCount != 0,
              //         badgeContent: Text(
              //           _.newCount.toString(),
              //           style: const TextStyle(
              //               color: ColorConst.background, fontSize: 12),
              //         ),
              //         animationType: BadgeAnimationType.fade,
              //         position: BadgePosition.topEnd(
              //           top: -22,
              //         ),
              //         child: const Text(
              //           'Categories',
              //           style: TextStyle(
              //             fontSize: 12,
              //             color: ColorConst.black,
              //             fontWeight: FontWeight.w800,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Tab(
              //       child: Badge(
              //         padding: const EdgeInsets.all(8.0),
              //         badgeColor: ColorConst.primary,
              //         showBadge: _.acceptedCount != 0,
              //         badgeContent: Text(
              //           _.acceptedCount.toString(),
              //           style: const TextStyle(
              //               color: ColorConst.background, fontSize: 12),
              //         ),
              //         animationType: BadgeAnimationType.fade,
              //         position: BadgePosition.topEnd(
              //           top: -22,
              //         ),
              //         child: const Text(
              //           'Categories OS',
              //           style: TextStyle(
              //             fontSize: 12,
              //             color: ColorConst.black,
              //             fontWeight: FontWeight.w800,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Tab(
              //         child: Badge(
              //       padding: const EdgeInsets.all(8.0),
              //       badgeColor: ColorConst.primary,
              //       showBadge: _.wayCount != 0,
              //       badgeContent: Text(
              //         _.wayCount.toString(),
              //         style: const TextStyle(
              //             color: ColorConst.background, fontSize: 12),
              //       ),
              //       animationType: BadgeAnimationType.fade,
              //       position: BadgePosition.topEnd(
              //         top: -22,
              //       ),
              //       child: const Text(
              //         'Items',
              //         style: TextStyle(
              //           fontSize: 12,
              //           color: ColorConst.black,
              //           fontWeight: FontWeight.w800,
              //         ),
              //       ),
              //     )),
              //     Tab(
              //       child: Badge(
              //         padding: const EdgeInsets.all(8.0),
              //         badgeColor: ColorConst.primary,
              //         showBadge: _.deliveredCount != 0,
              //         badgeContent: Text(
              //           _.deliveredCount.toString(),
              //           style: const TextStyle(
              //               color: ColorConst.background, fontSize: 14),
              //         ),
              //         animationType: BadgeAnimationType.fade,
              //         position: BadgePosition.topEnd(
              //           top: -22,
              //         ),
              //         child: const Text(
              //           'Items OS',
              //           style: TextStyle(
              //             fontSize: 12,
              //             color: ColorConst.black,
              //             fontWeight: FontWeight.w800,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 2),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    StocksList1(
                      type: "1",
                    ),
                    StocksList1(
                      type: '2',
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}
