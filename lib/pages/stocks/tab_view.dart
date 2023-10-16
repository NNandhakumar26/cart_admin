import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/global/widgets/botton_navigation/botton_navigation.dart';
//import 'package:toyskart_admin/global/app_drawer.dart';
import 'package:toyskart_admin/pages/stocks/category/tab_view_categories.dart';
import 'package:toyskart_admin/pages/stocks/category/view.dart';
import 'package:toyskart_admin/pages/stocks/items/tab_view_items.dart';
import 'package:toyskart_admin/pages/stocks/items/view.dart';

import 'controller.dart';

class TabView extends StatefulWidget {
  const TabView({
    Key? key,
  }) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  final RxBool showTitle = false.obs;

  late final TabController tabController =
      TabController(length: 2, vsync: this);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String displayName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   extendBody: true,
      backgroundColor: ColorConst.primary,
      //drawer: const AppDrawer(),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavCustom(indexValue: 0),
      ),
      appBar: AppBar(
        backgroundColor: ColorConst.primary,
        title: const Text(
          'Manage Stocks',
          style: TextStyle(
            fontSize: 18,
            color: ColorConst.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: SpeedDial(
        //Speed dial menu
        //margin bottom
        direction: SpeedDialDirection.down,
        icon: Icons.add, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: ColorConst.white, //background color of button
        foregroundColor: ColorConst.primary, //font color, icon color in button
        activeBackgroundColor:
            Colors.red, //background color when menu is expanded
        activeForegroundColor: Colors.white,
        buttonSize: const Size(40.0, 40.0), //button size
        childrenButtonSize: const Size(40.0, 40.0), //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        spaceBetweenChildren: 12,
        overlayOpacity: 0.3,

        elevation: 8.0, //shadow elevation of button
        shape: const CircleBorder(), //shape of button

        children: [
          SpeedDialChild(
              //speed dial child
              child: const Icon(Icons.add),
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
              label: 'Add new category',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () {
                var isReg = Get.isRegistered<StocksListController>();
                if (isReg) {
                  var slc = Get.find<StocksListController>();
                  slc.cid = "";
                  slc.flag = false;
                  slc.isEnabled.value = false;
                  slc.categoryName.text = "";
                  slc.update();
                }

                Get.to(
                  () => const AddEditCategory(),
                );
              }),

          SpeedDialChild(
            child: const Icon(Icons.add),
            backgroundColor: ColorConst.primary,
            foregroundColor: Colors.white,
            label: 'Add new item',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              Get.to(
                () => AddEditItem(),
              );
            },
          ),

          //add more menu item childs here
        ],
      ),
      body: GetBuilder<StocksListController>(
        init: StocksListController(),
        builder: (_) {
          return Column(
            children: [
              ColorfulTabBar(
                alignment: TabAxisAlignment.start,
                indicatorHeight: 0.1,
                tabShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0))),
                tabs: [
                  TabItem(
                      color: Colors.brown,
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
                          'Categories',
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorConst.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )),
                  TabItem(
                    color: Colors.orange,
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
                        'Items',
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
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    StocksTabView1(),
                    StocksTabView2()
                    // StocksList(
                    //   type: "1",
                    // ),
                    // StocksList(
                    //   type: '2',
                    // ),
                    // StocksList(
                    //   type: '3',
                    // ),
                    // StocksList(
                    //   type: '4',
                    // ),
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
