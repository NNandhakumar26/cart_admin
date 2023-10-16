import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/global/widgets/botton_navigation/botton_navigation.dart';
import 'package:toyskart_admin/pages/orders/hotel_orders/view.dart';

import 'controller.dart';

class AllOrderTabView extends StatefulWidget {
  const AllOrderTabView({
    Key? key,
  }) : super(key: key);

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
                    child: Badge(
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
                        'New',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorConst.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Badge(
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
                        'Accepted',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorConst.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                      child: Badge(
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
                      'Shipped',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConst.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )),
                  Tab(
                    child: Badge(
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
                        'Deliverd',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorConst.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
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
