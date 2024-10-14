import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeGetController extends GetxController {
  HomeGetController()
  {
    shareGetLocalMethod();
  }
  RxBool profileSettingBool = false.obs;
  RxBool themeSetting = false.obs;
  RxList<String> shareList = <String>[].obs;
  TextEditingController textName = TextEditingController();
  TextEditingController textNumber = TextEditingController();
  TextEditingController textChat = TextEditingController();
  DateTime? date;
  TimeOfDay? timeOfDay;
  File? fileImage;
  void settingMethod(RxBool value)
  {
    value.value = !value.value;
  }
  Future<void> shareLocalStorage()
  async {
    // ${}
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String valueSet = "${textName.text}!${textNumber.text}!${textChat.text}!${timeOfDay!.hour}:${timeOfDay!.minute}!${date!.day}:${date!.month}:${date!.year}!${fileImage!.path}";
    print(valueSet);
    shareList.add(valueSet);
    await sharedPreferences.setStringList('contact', shareList);
  }

  Future<void> shareGetLocalMethod()
  async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    shareList.value = sharedPreferences.getStringList('contact') ?? [];
    print("----------------------------------->$shareList");
    // addList = sharedPreferences.getStringList('bookMark') ?? [];
  }
  void methodUpdate()
  {
    update();
  }
}
// String value = "Name Name_PhoneNo_Chat_Date_Time";
// print(value.split("!").sublist(0,1).join(" "));