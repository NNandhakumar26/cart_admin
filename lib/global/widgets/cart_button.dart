import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/core/constants/routes.dart';
import 'package:toyskart_admin/core/utils/alerts.dart';
import 'package:toyskart_admin/global/app_service.dart';
import 'package:toyskart_admin/global/app_service.dart';
import 'package:unicons/unicons.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key, this.onPressed}) : super(key: key);
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    // if (!Navigator.of(context).canPop() && onPressed == null) {
    //   return const SizedBox.shrink();
    // }
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Obx(
        () => AppService.to.globalCartCount > 0
            ? FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                heroTag: null,
                mini: true,
                onPressed: () {
                  debugPrint('att');
                  Get.toNamed(RouteConst.checkout, arguments: []);
                },
                child: Badge(
                  badgeContent: Text(
                    "${AppService.to.globalCartCount}",
                    style: const TextStyle(
                        color: ColorConst.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  padding: const EdgeInsets.all(6),
                  badgeColor: ColorConst.white,
                  child: const Icon(UniconsLine.shopping_bag,
                      color: ColorConst.white),
                ),
              )
            : FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                heroTag: null,
                mini: true,
                onPressed: () {
                  toast("No Items in Cart");
                },
                child: const Icon(UniconsLine.shopping_bag,
                    color: ColorConst.white),
              ),
      ),
    );
  }
}
