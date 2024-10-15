import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeGetController extends GetxController {
  HomeGetController() {
    shareGetLocalMethod();
    shareProfileGetLocalMethod();
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

  void settingMethod(RxBool value) {
    value.value = !value.value;
  }

  Future<void> shareLocalStorage() async {
    // ${}
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String hourMinute = "${timeOfDay?.hour}:${timeOfDay?.minute}";
    String dateTime = "${date?.day}/${date?.month}/${date?.year}";
    String image = fileImage!.path.toString();
    String valueSet =
        "${textName.text}!${textNumber.text}!${textChat.text}!$hourMinute!$dateTime!$image";
    shareList.add(valueSet);
    // shareList.clear();
    print(shareList);
    await sharedPreferences.setStringList('contact', shareList);
    textChat.clear();
    textName.clear();
    textNumber.clear();
    date=null;
    timeOfDay=null;
    fileImage=null;
    update();
  }

  Future<void> removeShareListMethod() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setStringList('contact', shareList);
  }

  Future<void> shareGetLocalMethod() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    shareList.value = sharedPreferences.getStringList('contact') ?? [];
    print("----------------------------------->$shareList");
    // addList = sharedPreferences.getStringList('bookMark') ?? [];
  }

  void methodUpdate() {
    update();
  }

  TextEditingController textUserName = TextEditingController();
  TextEditingController textUserBio = TextEditingController();
  File? profileFileImage;
  RxList shareProfileList = [].obs;

  Future<void> shareProfileLocalStorage() async {
    // ${}
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String valueString = '';
    try {
      valueString = profileFileImage!.path.toString();
    } catch (e) {
      valueString = '';
    }
    await sharedPreferences.setStringList('profile', <String>[
      textUserName.text ?? "",
      textUserBio.text ?? "",
      valueString ?? ""
    ]);
  }

  Future<void> removeShareProfileListMethod() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setStringList('profile', ["","",""]);
    textUserName.clear();
    textUserBio.clear();
    profileFileImage =null;
    update();
  }

  Future<void> shareProfileGetLocalMethod() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    shareProfileList.value = sharedPreferences.getStringList('profile') ?? [];
    print("----------------------------------->$shareProfileList");
      textUserName.text = shareProfileList[0].toString();
      textUserBio.text = shareProfileList[1].toString();
      try {
        profileFileImage = (shareProfileList[2]!="")?File(shareProfileList[2]):shareProfileList[2];
      } catch (e) {
        print("image");
      }
    if (shareProfileList[0]!="" || shareProfileList[1]!="" || shareProfileList[2]!="") {
        profileSettingBool = true.obs;
    }
    print("-------------------------------------------");
    print(shareProfileList);
    print("-------------------------------------------");
    // addList = sharedPreferences.getStringList('bookMark') ?? [];
  }
}
// String value = "Name Name_PhoneNo_Chat_Date_Time";
// print(value.split("!").sublist(0,1).join(" "));
