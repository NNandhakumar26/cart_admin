import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toyskart_admin/core/constants/colors.dart';
import 'package:toyskart_admin/global/app_service.dart';
import 'package:toyskart_admin/global/widgets/botton_navigation/botton_navigation.dart';
import 'package:toyskart_admin/pages/admin_info/controller.dart';
//import 'package:toyskart_admin/global/app_drawer.dart';

class AdminInfo extends GetView<AdminInfoController> {
  const AdminInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavCustom(indexValue: 2),
      ),
      appBar: AppBar(
        backgroundColor: ColorConst.primary,
        centerTitle: true,
        title: const Text(
          'Admin Info',
          style: TextStyle(
            fontSize: 18,
            color: ColorConst.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: GetBuilder<AdminInfoController>(
        builder: (_) {
          if (_.adminData.isEmpty) {
            return Obx(() => Center(
                  child: Container(
                      height: 100,
                      margin: const EdgeInsets.only(top: 0, left: 0, bottom: 0),
                      child: AppService.to.inRequest()
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                  child: JumpingDotsProgressIndicator(
                                numberOfDots: 4,
                                fontSize: 60.0,
                                color: ColorConst.primary,
                              )),
                            )
                          : Text(
                              'Loading..',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffB3B3BF)),
                            )),
                ));
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: SafeArea(
                child: Column(
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
                                controller: controller.shopName,
                                maxLength: 15,

                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) =>
                                    input!.isEmpty ? 'Please Shop Name' : null,

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
                                    hintText: 'Shop Name',
                                    labelText: 'Shop Name *',
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
                                controller: controller.address1,
                                maxLength: 15,

                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) =>
                                    input!.isEmpty ? 'Please Address 1' : null,

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
                                    hintText: 'Address 1',
                                    labelText: 'Address 1 *',
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
                                controller: controller.address2,
                                maxLength: 15,

                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) =>
                                    input!.isEmpty ? 'Please Address 2' : null,

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
                                    hintText: 'Address 2',
                                    labelText: 'Address 2 *',
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
                              )),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: controller.email,

                                style: const TextStyle(color: ColorConst.black),
                                keyboardType: TextInputType.emailAddress,
                                // autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (s) {
                                  s ??= "";
                                  if (s.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  if (!s.isEmail) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },

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
                                    hintText: 'Email',
                                    labelText: 'Email *',
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
                                controller: controller.phoneNumber1,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: ColorConst.black),
                                //autofocus: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (s) {
                                  s = s ?? '';
                                  if (s.trim().isEmpty) {
                                    return 'Please Enter Mobile Number 1';
                                  }
                                  if (!s.contains(RegExp(r'^\+*[0-9]+$'))) {
                                    return 'Please Vaild Enter Mobile Number 1';
                                  }
                                  return null;
                                },

                                decoration: InputDecoration(
                                    isDense: true,
                                    prefix: const SizedBox(
                                      width: 15,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 14, right: 14, bottom: 14),
                                    hintText: 'Mobile Number 1',
                                    labelText: 'Mobile Number 1 *',
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
                                controller: controller.phoneNumber2,
                                maxLength: 10,

                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: ColorConst.black),
                                //autofocus: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (s) {
                                  s = s ?? '';
                                  if (s.trim().isEmpty) {
                                    return 'Please Enter Mobile Number 2';
                                  }
                                  if (!s.contains(RegExp(r'^\+*[0-9]+$'))) {
                                    return 'Please Vaild Enter Mobile Number 2';
                                  }
                                  return null;
                                },

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
                                    hintText: 'Mobile Number 2',
                                    labelText: 'Mobile Number 2 *',
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
                                controller: controller.openingTime,
                                maxLength: 15,

                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) =>
                                    input!.isEmpty ? 'Please Open Time' : null,

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
                                    hintText: 'Open Time',
                                    labelText: 'Open Time *',
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
                                controller: controller.closingTime,
                                maxLength: 15,

                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) => input!.isEmpty
                                    ? 'Please Closing Time'
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
                                    hintText: 'Closing Time',
                                    labelText: 'Closing Time *',
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
                                controller: controller.defaultGst,
                                maxLength: 4,

                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) => input!.isEmpty
                                    ? 'Please Enter GST %'
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
                                    hintText: 'GST %',
                                    labelText: 'GST %',
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
                                controller: controller.insideChennai,
                                maxLength: 15,

                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) => input!.isEmpty
                                    ? 'Please Enter Inside Chennai charge'
                                    : null,

                                decoration: InputDecoration(
                                    // isDense: true,
                                    prefix: const SizedBox(
                                      width: 8,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 8,
                                        top: 14,
                                        right: 14,
                                        bottom: 14),
                                    hintText: 'Inside Chennai charge',
                                    alignLabelWithHint: true,
                                    labelText: 'Inside Chennai charge *',

                                    //  isDense: true,
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
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
                                controller: controller.outsideChennai,
                                maxLength: 15,

                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: ColorConst.black),
                                // autofocus: true,
                                validator: (input) => input!.isEmpty
                                    ? 'Please Enter Outside Chennai charge'
                                    : null,

                                decoration: InputDecoration(
                                    //isDense: true,
                                    prefix: const SizedBox(
                                      width: 8,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 8,
                                        top: 14,
                                        right: 14,
                                        bottom: 14),
                                    hintText: 'Outside Chennai charge',
                                    labelText: 'Outside Chennai charge *',
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
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  top: 20.0,
                                  right: 10.0,
                                  bottom: 5.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConst.primary,
                                    elevation: 0,
                                    minimumSize:
                                        const Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConst.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    controller.updateAdminInfo();
                                  }))
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
