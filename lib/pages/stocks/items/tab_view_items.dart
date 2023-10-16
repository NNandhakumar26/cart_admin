import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/pages/stocks/controller.dart';
import 'package:toyskart_admin/pages/stocks/items/items.dart';

class StocksTabView2 extends StatefulWidget {
  const StocksTabView2({
    Key? key,
  }) : super(key: key);

  @override
  State<StocksTabView2> createState() => _StocksTabView2State();
}

class _StocksTabView2State extends State<StocksTabView2>
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
                height: 5,
              ),
              ColorfulTabBar(
                indicatorHeight: 0,
                tabs: [
                  TabItem(
                    color: Colors.green,
                    title: Badge(
                      padding: const EdgeInsets.all(8.0),
                      badgeColor: ColorConst.primary,
                      showBadge: _.wayCount != 0,
                      badgeContent: Text(
                        _.wayCount.toString(),
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
                    ),
                  ),
                  TabItem(
                    color: Colors.red,
                    title: Badge(
                      padding: const EdgeInsets.all(8.0),
                      badgeColor: ColorConst.primary,
                      showBadge: _.deliveredCount != 0,
                      badgeContent: Text(
                        _.deliveredCount.toString(),
                        style: const TextStyle(
                            color: ColorConst.background, fontSize: 14),
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

              const SizedBox(height: 2),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    StocksList2(
                      type: '3',
                    ),
                    StocksList2(
                      type: '4',
                    ),
                  ],
                ),
              ),
              //const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}
