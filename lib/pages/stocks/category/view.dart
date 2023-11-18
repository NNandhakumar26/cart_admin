import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/pages/stocks/controller.dart';
import 'package:unicons/unicons.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class AddEditCategory extends GetView<StocksListController> {
  const AddEditCategory({super.key});

  @override
  Widget build(BuildContext context) {
    fun(BuildContext context, List<AssetEntity> assets) {
      return AssetPicker.pickAssets(
        context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 2,
          //selectedAssets: assets,
          requestType: RequestType.image,
        ),
      );
    }

    Future<AssetEntity?> _pickFromCamera(BuildContext c) {
      return CameraPicker.pickFromCamera(c,
          pickerConfig: const CameraPickerConfig(enableRecording: false),
          locale: const Locale('en', 'US'));
    }

    var body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: controller.formkey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: controller.categoryName,
                    maxLength: 50,
                    maxLines: 3,
                    minLines: 1,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: ColorConst.black),
                    //autofocus: true,

                    validator: (s) {
                      s = s ?? '';
                      if (s.trim().isEmpty) {
                        return 'Please Enter Category Name';
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                        isDense: true,
                        prefix: const SizedBox(
                          width: 8,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 8, top: 14, right: 14, bottom: 14),
                        hintText: 'Category Name',
                        labelText: 'Category Name *',
                        helperStyle: const TextStyle(
                          color: ColorConst.grey3,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
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
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorConst.black),
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
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      checkColor: ColorConst.white,
                      fillColor: MaterialStateProperty.all(
                        ColorConst.primary,
                      ),
                      value: controller.isEnabled.value,
                      onChanged: (v) {
                        controller.isEnabled.value = v ?? false;
                        controller.update();
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Wrap(
                        children: [
                          Text(
                            "Is Active?",
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
              // Obx(
              //   () => !controller.showImage.value
              //       ? TextButton(
              //           onPressed: () async {
              //             const AssetPickerTextDelegate textDelegate =
              //                 AssetPickerTextDelegate();
              //             controller.selImage = await AssetPicker.pickAssets(
              //               context,
              //               pickerConfig: AssetPickerConfig(
              //                 maxAssets: 1,
              //                 gridCount: 4,
              //                 pageSize: 120,
              //                 //selectedAssets: assets,
              //                 requestType: RequestType.image,
              //                 specialItemPosition: SpecialItemPosition.prepend,
              //                 textDelegate:
              //                     const EnglishAssetPickerTextDelegate(),

              //                 specialItemBuilder: (
              //                   BuildContext context,
              //                   AssetPathEntity? path,
              //                   int length,
              //                 ) {
              //                   if (path?.isAll != true) {
              //                     return null;
              //                   }
              //                   return Semantics(
              //                     label: textDelegate.sActionUseCameraHint,
              //                     button: true,
              //                     onTapHint: textDelegate.sActionUseCameraHint,
              //                     child: GestureDetector(
              //                       behavior: HitTestBehavior.opaque,
              //                       onTap: () async {
              //                         final AssetEntity? result =
              //                             await _pickFromCamera(context);
              //                         if (result == null) {
              //                           return;
              //                         }
              //                         final AssetPicker<AssetEntity,
              //                                 AssetPathEntity> picker =
              //                             context
              //                                 .findAncestorWidgetOfExactType()!;
              //                         final DefaultAssetPickerBuilderDelegate
              //                             builder = picker.builder
              //                                 as DefaultAssetPickerBuilderDelegate;
              //                         final DefaultAssetPickerProvider p =
              //                             builder.provider;
              //                         await p.switchPath(
              //                           PathWrapper<AssetPathEntity>(
              //                             path: await p.currentPath!.path
              //                                 .obtainForNewProperties(),
              //                           ),
              //                         );
              //                         p.selectAsset(result);
              //                       },
              //                       child: const Center(
              //                         child: Icon(Icons.camera_alt_rounded,
              //                             size: 32.0),
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               ),
              //             );
              //             //print(controller.selImage);
              //             if (controller.selImage == null) return;
              //             var bytes = (await controller.selImage![0]
              //                 .thumbnailDataWithSize(
              //                     const ThumbnailSize(500, 500),
              //                     quality: 100))!;

              //             controller.path = await Get.to<String>(
              //                 () => CropImage(bytes, circleOnly: true));
              //             if (controller.path == null) return;
              //             // controller.path =
              //             //     await compressImage(controller.path!, max: 256);
              //             controller.showImage.value = true;
              //           },
              //           child: const Text('Upload Image'))
              //       : TextButton(
              //           onPressed: () async {
              //             controller.selImage = null;
              //             controller.path = '';
              //             controller.update();
              //             controller.showImage.value = false;
              //           },
              //           child: const Text('Try another image'),
              //         ),
              // ),
              const SizedBox(
                height: 15,
              ),
              // Obx(() => controller.showImage.value
              //     ? CircleAvatar(
              //         radius: 96,
              //         child:
              //             ClipOval(child: Image.file(File(controller.path!))))
              //     : const SizedBox.shrink()),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 20.0, right: 10.0, bottom: 5.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConst.primary,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: Text(
                      controller.flag ? 'Update' : 'Add',
                      style: const TextStyle(
                          fontSize: 18,
                          color: ColorConst.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      controller.flag
                          ? controller.updatCategories()
                          : controller.addCategories();
                    }),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: ColorConst.background,
      //drawer:
      appBar: AppBar(
        backgroundColor: ColorConst.primary,
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            // When the user taps the button, show a snackbar.
            onTap: () {
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
        title: Text(controller.flag ? 'Edit Category' : 'Add Category'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: body,
          ),
        ),
      ),
    );
  }
}
