import 'package:flutter/material.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/global/widgets/badge.dart';
import 'package:toyskart_admin/pages/stocks/controller.dart';
import 'package:toyskart_admin/pages/stocks/items/items.dart';

class StocksTabView2 extends StatefulWidget {
  const StocksTabView2({
    super.key,
  });

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
                    title: CustomTabbarBadge(
                      showBadge: _.wayCount != 0,
                      titleText: 'Available',
                      badgeText: _.wayCount.toString(),
                    ),
                  ),
                  TabItem(
                    color: Colors.red,
                    title: CustomTabbarBadge(
                      showBadge: _.deliveredCount != 0,
                      titleText: 'Out Of Stock',
                      badgeText: _.deliveredCount.toString(),
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
