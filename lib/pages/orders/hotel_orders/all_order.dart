import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/global/widgets/badge.dart';
import 'package:toyskart_admin/global/widgets/botton_navigation/botton_navigation.dart';
import 'package:toyskart_admin/pages/orders/hotel_orders/view.dart';

import 'controller.dart';

class AllOrderTabView extends StatefulWidget {
  const AllOrderTabView({
    super.key,
  });

  @override
  State<AllOrderTabView> createState() => _AllOrderTabViewState();
}

class _AllOrderTabViewState extends State<AllOrderTabView>
    with SingleTickerProviderStateMixin {
  final RxBool showTitle = false.obs;

  late final TabController tabController =
      TabController(length: 4, vsync: this);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String displayName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.primary,
      appBar: AppBar(
        backgroundColor: ColorConst.primary,
        title: const Text(
          'All Orders',
          style: TextStyle(
            fontSize: 18,
            color: ColorConst.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavCustom(indexValue: 1),
      ),
      body: GetBuilder<AllOrderListListController>(
        init: AllOrderListListController(),
        builder: (_) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TabBar(
                controller: tabController,
                indicatorColor: ColorConst.primary,
                // indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
                tabs: [
                  Tab(
                    child: CustomTabbarBadge(
                      showBadge: _.newCount != 0,
                      titleText: 'New',
                      badgeText: _.newCount.toString(),
                    ),
                  ),
                  Tab(
                    child: CustomTabbarBadge(
                      showBadge: _.acceptedCount != 0,
                      titleText: 'Accepted',
                      badgeText: _.acceptedCount.toString(),
                    ),
                  ),
                  Tab(
                    child: CustomTabbarBadge(
                      showBadge: _.wayCount != 0,
                      titleText: 'Shipped',
                      badgeText: _.wayCount.toString(),
                    ),
                  ),
                  Tab(
                    child: CustomTabbarBadge(
                      showBadge: _.deliveredCount != 0,
                      titleText: 'Deliverd',
                      badgeText: _.deliveredCount.toString(),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    AllOrderList(type: "New", nextState: 'Accepted'),
                    AllOrderList(type: 'Accepted', nextState: 'outOfDelivery'),
                    AllOrderList(type: 'outOfDelivery', nextState: 'Delivered'),
                    AllOrderList(type: 'Delivered', nextState: 'Done'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
