import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/core/utils/loader.dart';

class CropImage extends StatefulWidget {
  const CropImage(this.bytes, {Key? key, this.circleOnly = false})
      : super(key: key);
  final bool circleOnly;
  final Uint8List bytes;
  @override
  State<CropImage> createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  final controller = CropController();

  double _aspectRatio = 1;

  @override
  void initState() {
    super.initState();
    showLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  leading: const AppBackButton(),
        title: const Text('Crop Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              showLoader();
              controller.crop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Crop(
          image: widget.bytes,
          controller: controller,
          onCropped: (image) async {
            var tempDir = await getTemporaryDirectory();
            File file = await File(
                    '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png')
                .writeAsBytes(image);
            hideLoader();
            Get.back(result: file.path);
          },
          aspectRatio: _aspectRatio,
          withCircleUi: widget.circleOnly,
          baseColor: Colors.transparent.withOpacity(0.5),
          maskColor: Colors.white.withAlpha(100),
          radius: 16,
          onMoved: (newRect) {
            // do something with current cropping area.
          },
          onStatusChanged: (status) {
            if (status != CropStatus.cropping) {
              hideLoader();
            }
          },
          cornerDotBuilder: (size, edgeAlignment) =>
              const DotControl(color: ColorConst.primary),
          interactive: false,
        ),
      ),
      bottomNavigationBar: widget.circleOnly
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.crop_16_9),
                  color: _aspectRatio == 16 / 9 ? ColorConst.primary : null,
                  onPressed: () {
                    setState(() {
                      controller.aspectRatio = 16 / 9;
                      _aspectRatio = 16 / 9;
                    });
                  },
                ),
                const SizedBox(width: 8),
                RotatedBox(
                  quarterTurns: 1,
                  child: IconButton(
                    icon: const Icon(Icons.crop_16_9),
                    color: _aspectRatio == 9 / 16 ? ColorConst.primary : null,
                    onPressed: () {
                      setState(() {
                        controller.aspectRatio = 9 / 16;
                        _aspectRatio = 9 / 16;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.crop_square),
                  color: _aspectRatio == 1 ? ColorConst.primary : null,
                  onPressed: () {
                    setState(() {
                      controller.aspectRatio = 1;
                      _aspectRatio = 1;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
