import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/core/utils/crop_image.dart';
import 'package:toyskart_admin/global/functions/photo_url.dart';
//import 'package:toyskart_admin/global/app_drawer.dart';
import 'package:toyskart_admin/pages/stocks/controller.dart';
import 'package:toyskart_admin/pages/stocks/food_list_model.dart';
import 'package:unicons/unicons.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class AddEditItem extends GetView<StocksListController> {
  AddEditItem({Key? key, this.item}) : super(key: key);
  ItemList? item;
  Future<AssetEntity?> _pickFromCamera(BuildContext c) {
    return CameraPicker.pickFromCamera(c,
        pickerConfig: const CameraPickerConfig(enableRecording: false),
        locale: const Locale('en', 'US'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConst.primary,
      // drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: ColorConst.primary,
        centerTitle: true,
        title: Text(
          controller.itemFlag ? 'Edit Item' : 'Add Item',
          style: const TextStyle(
            fontSize: 18,
            color: ColorConst.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            // When the user taps the button, show a snackbar.
            onTap: () {
              // var address = Get.find<ManageFoodListController>();
              // address.getItems();
              // Navigator.of(context).pop();
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 2, left: 0, right: 1, bottom: 1),
              child: Icon(
                UniconsLine.angle_left,
                color: ColorConst.white,
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder<StocksListController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: controller.formkeyItem,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: controller.toyName,
                                maxLength: 15,

                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) =>
                                    input!.isEmpty ? 'Please Toy Name' : null,

                                decoration: InputDecoration(
                                    isDense: true,
                                    prefix: const SizedBox(
                                      width: 8,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 8,
                                        top: 14,
                                        right: 14,
                                        bottom: 14),
                                    hintText: 'Toy Name',
                                    labelText: 'Toy Name *',
                                    labelStyle: const TextStyle(
                                      leadingDistribution:
                                          TextLeadingDistribution.proportional,
                                      color: ColorConst.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    // labelText: 'Toy Name *',
                                    // labelStyle: const TextStyle(
                                    //   letterSpacing: 1,
                                    //   color: ColorConst.primary,
                                    //   fontSize: 16,
                                    //   fontWeight: FontWeight.w400,
                                    // ),
                                    helperStyle: const TextStyle(
                                      color: ColorConst.grey3,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintStyle: const TextStyle(
                                      color: ColorConst.grey3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    //alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    fillColor: Colors.transparent,
                                    filled: true),
                                // onChanged: (value) {
                                //   // setState(() {
                                //   controller.oldPassword = value.trim();
                                //   // });
                                // },
                              )),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: controller.toyDescription,
                                maxLength: 150,
                                minLines: 1,
                                maxLines: 4,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: ColorConst.black),
                                //autofocus: true,
                                validator: (input) => input!.isEmpty
                                    ? 'Please Enter Toy Description'
                                    : null,

                                decoration: InputDecoration(
                                    isDense: true,
                                    prefix: const SizedBox(
                                      width: 8,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 8,
                                        top: 14,
                                        right: 14,
                                        bottom: 14),
                                    hintText: 'Toy Desription',
                                    labelText: 'Toy Desription *',
                                    labelStyle: const TextStyle(
                                      leadingDistribution:
                                          TextLeadingDistribution.proportional,
                                      color: ColorConst.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    helperStyle: const TextStyle(
                                      color: ColorConst.grey3,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintStyle: const TextStyle(
                                      color: ColorConst.grey3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    //alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    fillColor: Colors.transparent,
                                    filled: true),
                                // onChanged: (value) {
                                //   // setState(() {
                                //   controller.oldPassword = value.trim();
                                //   // });
                                // },
                              )),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: controller.units,

                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: ColorConst.black),
                                //autofocus: true,
                                validator: (input) => input!.isEmpty
                                    ? 'Please Available Units'
                                    : null,
                                decoration: InputDecoration(
                                    isDense: true,
                                    prefix: const SizedBox(
                                      width: 8,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 8,
                                        top: 14,
                                        right: 14,
                                        bottom: 14),
                                    hintText: 'Available Units',
                                    labelText: 'Available Units *',
                                    labelStyle: const TextStyle(
                                      leadingDistribution:
                                          TextLeadingDistribution.proportional,
                                      color: ColorConst.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintStyle: const TextStyle(
                                      color: ColorConst.grey3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    //alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    fillColor: Colors.transparent,
                                    filled: true),
                                // onChanged: (value) {
                                //   // setState(() {
                                //   controller.newPassword = value.trim();
                                //   // });
                                // },
                              )),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: controller.price,

                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: ColorConst.black),
                                //autofocus: true,
                                validator: (input) => input!.isEmpty
                                    ? 'Please enter toy price'
                                    : null,
                                decoration: InputDecoration(
                                    isDense: true,
                                    prefix: const SizedBox(
                                      width: 8,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 8,
                                        top: 14,
                                        right: 14,
                                        bottom: 14),
                                    hintText: 'Price',
                                    labelText: 'Price *',
                                    labelStyle: const TextStyle(
                                      leadingDistribution:
                                          TextLeadingDistribution.proportional,
                                      color: ColorConst.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintStyle: const TextStyle(
                                      color: ColorConst.grey3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    //alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConst.black),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    fillColor: Colors.transparent,
                                    filled: true),
                              )),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const Text(
                                  //   'Category *',
                                  //   textAlign: TextAlign.left,
                                  //   style: TextStyle(
                                  //       color: Colors.white, fontSize: 14),
                                  // ),
                                  // const SizedBox(
                                  //   height: 12,
                                  // ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xff424756),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4))),
                                    child: ListTile(
                                      minLeadingWidth: 0,
                                      onTap: controller.openCategoryPicker,
                                      title: controller.categoryController ==
                                              null
                                          ? const Text(
                                              'Select category *',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: ColorConst.primary),
                                            )
                                          : Text(
                                              controller
                                                  .categoryController!.name,
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      trailing: const Icon(
                                        Icons.chevron_right,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          //const SizedBox(height: 4),
                          // Padding(
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: DropdownButtonFormField(
                          //     decoration: InputDecoration(
                          //         isDense: true,
                          //         prefix: const SizedBox(
                          //           width: 15,
                          //         ),
                          //         contentPadding: const EdgeInsets.only(
                          //             top: 14, right: 14, bottom: 14),
                          //         hintText: 'Type',
                          //         hintStyle: const TextStyle(
                          //           color: ColorConst.grey3,
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //         //alignLabelWithHint: true,
                          //         border: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: ColorConst.black),
                          //           borderRadius: BorderRadius.circular(4.0),
                          //         ),
                          //         errorBorder: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //             color: Colors.red,
                          //           ),
                          //           borderRadius: BorderRadius.circular(4.0),
                          //         ),
                          //         focusedBorder: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: ColorConst.black),
                          //           borderRadius: BorderRadius.circular(4.0),
                          //         ),
                          //         enabledBorder: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: ColorConst.black),
                          //           borderRadius: BorderRadius.circular(4.0),
                          //         ),
                          //         fillColor: Colors.transparent,
                          //         filled: true),
                          //     value: controller.dt,
                          //     elevation: 0,
                          //     dropdownColor: ColorConst.background,
                          //     style: const TextStyle(color: Colors.white),
                          //     onChanged: (String? newValue) {
                          //       if (newValue == 'Veg') {
                          //         controller.type = "1";
                          //         controller.dt = 'Veg';
                          //       } else if (newValue == 'Non-Veg') {
                          //         controller.type = "2";
                          //         controller.dt = 'Non-Veg';
                          //       } else if (newValue == 'Egg') {
                          //         controller.type = "3";
                          //         controller.dt = 'Egg';
                          //       }
                          //       controller.update();
                          //     },
                          //     items: <String>[
                          //       'Veg',
                          //       'Non-Veg',
                          //       'Egg'
                          //     ].map<DropdownMenuItem<String>>((String value) {
                          //       return DropdownMenuItem<String>(
                          //         value: value,
                          //         child: Center(
                          //           child: Text(
                          //             value,
                          //             style: const TextStyle(
                          //                 color: ColorConst.black),
                          //           ),
                          //         ),
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),

                          Obx(
                            () => Row(
                              children: [
                                Checkbox(
                                  checkColor: ColorConst.white,
                                  fillColor: MaterialStateProperty.all(
                                    ColorConst.primary.withOpacity(1),
                                  ),
                                  value: controller.isEnabled.value,
                                  onChanged: (v) {
                                    controller.isEnabled.value = v ?? false;
                                    //controller.update();
                                  },
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Wrap(
                                    children: const [
                                      Text(
                                        "Available now for order",
                                        style: TextStyle(
                                          color: ColorConst.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (controller.itemFlag == false) ...[
                            Obx(
                              () => !controller.showImage.value
                                  ? TextButton(
                                      onPressed: () async {
                                        const AssetPickerTextDelegate
                                            textDelegate =
                                            AssetPickerTextDelegate();
                                        controller.selImage =
                                            await AssetPicker.pickAssets(
                                          context,
                                          pickerConfig: AssetPickerConfig(
                                            maxAssets: 3,
                                            gridCount: 4,
                                            pageSize: 120,
                                            //selectedAssets: assets,
                                            requestType: RequestType.image,
                                            specialItemPosition:
                                                SpecialItemPosition.prepend,
                                            textDelegate:
                                                const EnglishAssetPickerTextDelegate(),

                                            specialItemBuilder: (
                                              BuildContext context,
                                              AssetPathEntity? path,
                                              int length,
                                            ) {
                                              if (path?.isAll != true) {
                                                return null;
                                              }
                                              return Semantics(
                                                label: textDelegate
                                                    .sActionUseCameraHint,
                                                button: true,
                                                onTapHint: textDelegate
                                                    .sActionUseCameraHint,
                                                child: GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () async {
                                                    final AssetEntity? result =
                                                        await _pickFromCamera(
                                                            context);
                                                    if (result == null) {
                                                      return;
                                                    }
                                                    final AssetPicker<
                                                            AssetEntity,
                                                            AssetPathEntity>
                                                        picker = context
                                                            .findAncestorWidgetOfExactType()!;
                                                    final DefaultAssetPickerBuilderDelegate
                                                        builder = picker.builder
                                                            as DefaultAssetPickerBuilderDelegate;
                                                    final DefaultAssetPickerProvider
                                                        p = builder.provider;
                                                    await p.switchPath(
                                                      PathWrapper<
                                                          AssetPathEntity>(
                                                        path: await p
                                                            .currentPath!.path
                                                            .obtainForNewProperties(),
                                                      ),
                                                    );
                                                    p.selectAsset(result);
                                                  },
                                                  child: const Center(
                                                    child: Icon(
                                                        Icons
                                                            .camera_alt_rounded,
                                                        size: 32.0),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                        //print(controller.selImage);
                                        if (controller.selImage == null) return;
                                        // for (var img in controller.selImage!) {
                                        for (var i = 0;
                                            i < controller.selImage!.length;
                                            i++) {
                                          var bytes = (await controller
                                              .selImage![i]
                                              .thumbnailDataWithSize(
                                                  const ThumbnailSize(500, 500),
                                                  quality: 100))!;

                                          controller.path.add(
                                              await Get.to<String>(() =>
                                                  CropImage(bytes,
                                                      circleOnly: true)));
                                        }

                                        if (controller.path == null) return;
                                        // controller.path =
                                        //     await compressImage(controller.path!, max: 256);
                                        controller.showImage.value = true;
                                      },
                                      child: const Text('Upload Image'))
                                  : TextButton(
                                      onPressed: () async {
                                        controller.selImage = null;
                                        controller.path = [];
                                        controller.update();
                                        controller.showImage.value = false;
                                      },
                                      child: const Text('Try another image'),
                                    ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                          Obx(() => controller.showImage.value
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: PageView.builder(
                                        allowImplicitScrolling: true,
                                        controller:
                                            controller.imageViewPageController,
                                        padEnds: false,
                                        itemCount: controller.path.length,
                                        itemBuilder: (c, i) {
                                          var m = controller.path[i];

                                          return controller.itemFlag
                                              ? AspectRatio(
                                                  aspectRatio: 4 / 2,
                                                  child: Image.network(
                                                      (formatImageUrl(m!))))
                                              : AspectRatio(
                                                  aspectRatio: 4 / 2,
                                                  child: Image.file(File(m!)));
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: SmoothPageIndicator(
                                        controller:
                                            controller.imageViewPageController,
                                        count: controller.path.length,
                                        effect: const ScrollingDotsEffect(
                                          activeDotColor: ColorConst.primary,
                                          activeStrokeWidth: 2.6,
                                          maxVisibleDots: 9,
                                          radius: 8,
                                          dotHeight: 6,
                                          dotWidth: 6,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              // CircleAvatar(
                              //     radius: 96,
                              //     child: ClipOval(
                              //         child: Image.file(File(controller.path))))
                              : const SizedBox.shrink()),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20.0,
                                right: 10.0,
                                bottom: 5.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConst.primary,
                                  elevation: 0,
                                  minimumSize: const Size(double.infinity, 55),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                                child: Text(
                                  controller.itemFlag ? 'Update' : 'Add',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: ColorConst.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  controller.itemFlag
                                      ? controller.updateItem()
                                      : controller.addItem();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
