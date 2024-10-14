import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/main.dart';

import '../../../controller/get_controller.dart';
import '../../../controller/platform_controller.dart';

//todo Scaffold android all Methods...
Scaffold platformAndroidScaffold(PlatformController platformController,
    HomeGetController homeGetController, BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Platform Converter"),
      actions: [
        Switch(
          value: platformController.platformControlling.value,
          onChanged: (value) {
            platformController
                .platformMethod(platformController.platformControlling);
          },
        ).paddingSymmetric(horizontal: 10),
      ],
      bottom: TabBar(tabs: [
        Tab(
          icon: Icon(Icons.person_add_rounded),
        ),
        Tab(
          child: Container(
            child: Text("Chats".toUpperCase()),
          ),
        ),
        Tab(
          child: Container(
            child: Text("Calls".toUpperCase()),
          ),
        ),
        Tab(
          child: Container(
            child: Text("Settings".toUpperCase()),
          ),
        ),
      ]),
    ),
    body: TabBarView(
      children: [
        saveContactSingleChildScrollView(context),
        Container(),
        Container(),
        SizedBox(
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  settingSetListTile(
                    textSet: "Profile",
                    iconSet: const Icon(
                      Icons.person,
                      size: 30,
                    ),
                    setValueBool: homeGetController.profileSettingBool.value,
                    onChanged: (value) {
                      homeGetController
                          .settingMethod(homeGetController.profileSettingBool);
                    },
                    valueTextSet: 'Update Profile Data',
                  ).paddingSymmetric(vertical: 15, horizontal: 15),
                  if (homeGetController.profileSettingBool.value)
                    ...List.generate(
                      settingWidgetList.length,
                      (index) {
                        return settingWidgetList[index];
                      },
                    )
                  else
                    Container(),
                  const Divider().paddingSymmetric(horizontal: 18),
                  settingSetListTile(
                    textSet: "Theme",
                    iconSet: const Icon(
                      Icons.wb_sunny_outlined,
                      size: 30,
                    ),
                    setValueBool: homeGetController.themeSetting.value,
                    onChanged: (value) {
                      homeGetController
                          .settingMethod(homeGetController.themeSetting);
                    },
                    valueTextSet: 'Change Theme',
                  ).paddingSymmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

ListTile settingSetListTile(
    {required String valueTextSet,
    required String textSet,
    required iconSet,
    required bool setValueBool,
    required ValueChanged onChanged}) {
  return ListTile(
    title: Text(
      textSet,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    leading: iconSet,
    subtitle: Text(valueTextSet),
    trailing: Switch(value: setValueBool, onChanged: onChanged),
  );
}

CircleAvatar settingCircleAvatar() {
  return CircleAvatar(
    radius: 70,
    child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.add_a_photo_outlined,
          size: 30,
        )),
  );
}

CircleAvatar iosSettingCircleAvatar() {
  return CircleAvatar(
    radius: 70,
    backgroundColor: CupertinoColors.activeBlue,
    child: IconButton(
        onPressed: () {},
        icon: Icon(
          CupertinoIcons.camera,
          size: 30,
          color: Colors.white,
        )),
  );
}

List<Widget> iosSettingWidgetList = [
  iosSettingCircleAvatar(),
  TextFormField(
    textInputAction: TextInputAction.next,
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      hintText: "Enter your name...",
      border: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
    ),
  ),
  TextFormField(
    textInputAction: TextInputAction.done,
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.grey.shade600),
    decoration: InputDecoration(
      hintText: "Enter your bio...",
      border: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
    ),
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(onPressed: () {}, child: Text("Save".toUpperCase())),
      TextButton(onPressed: () {}, child: Text("Clear".toUpperCase()))
    ],
  )
];
List<Widget> settingWidgetList = [
  settingCircleAvatar(),
  TextFormField(
    textInputAction: TextInputAction.next,
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      hintText: "Enter your name...",
      border: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
    ),
  ),
  TextFormField(
    textInputAction: TextInputAction.done,
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.grey.shade600),
    decoration: InputDecoration(
      hintText: "Enter your bio...",
      border: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.transparent,
      )),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
    ),
  ),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(onPressed: () {}, child: Text("Save".toUpperCase())),
      TextButton(onPressed: () {}, child: Text("Clear".toUpperCase()))
    ],
  )
];
//todo ----------------------------------------------------------------------------------------------
TextFormField userContactAddingTextFormField(
    {required TextInputType textType,
    required String textLabel,
    required Icon iconSet,
    required TextEditingController textController}) {
  return TextFormField(
      controller: textController,
      keyboardType: textType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: Text(textLabel),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        prefixIcon: iconSet,
      ));
}

SingleChildScrollView saveContactSingleChildScrollView(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        GetBuilder<HomeGetController>(builder: (controller) {
          return (homeGetController.fileImage == null)
              ? CircleAvatar(
                  radius: 70,
                  child: Center(
                    child: IconButton(
                        onPressed: () async {
                          try {
                            ImagePicker imagePick = ImagePicker();
                            XFile? xFileImage = await imagePick.pickImage(
                                source: ImageSource.gallery);
                            homeGetController.fileImage =
                                File(xFileImage!.path);
                            homeGetController.methodUpdate();
                          } catch (e) {
                            Get.log("Image Done Not");
                          }
                        },
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          size: 30,
                        )),
                  ),
                )
              : CircleAvatar(
                  radius: 70,
                  backgroundImage: (homeGetController.fileImage == null)
                      ? null
                      : FileImage(homeGetController.fileImage!.absolute),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        ImagePicker imagePick = ImagePicker();
                        XFile? xFileImage = await imagePick.pickImage(
                            source: ImageSource.gallery);
                        homeGetController.fileImage = File(xFileImage!.path);
                        homeGetController.methodUpdate();
                      } catch (e) {
                        Get.log("Image Done Not");
                      }
                    },
                    // child: const Icon(
                    //   Icons.add_a_photo_outlined,
                    //   size: 30,
                    // )),
                  ),
                );
        }),
        const SizedBox(
          height: 15,
        ),
        userContactAddingTextFormField(
                textType: TextInputType.text,
                textLabel: 'Full Name',
                iconSet: const Icon(
                  Icons.person_outline,
                  size: 30,
                ),
                textController: homeGetController.textName)
            .paddingSymmetric(vertical: 6, horizontal: 12),
        userContactAddingTextFormField(
                textType: TextInputType.number,
                textLabel: 'Phone Number',
                iconSet: const Icon(
                  Icons.call,
                  size: 30,
                ),
                textController: homeGetController.textNumber)
            .paddingSymmetric(vertical: 6, horizontal: 12),
        userContactAddingTextFormField(
                textType: TextInputType.text,
                textLabel: 'Chat Conversation',
                iconSet: const Icon(
                  Icons.message_outlined,
                  size: 30,
                ),
                textController: homeGetController.textChat)
            .paddingSymmetric(vertical: 6, horizontal: 12),
        Row(
          children: [
            IconButton(
                onPressed: () async {
                  try {
                    homeGetController.date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    print(homeGetController.date);
                  } catch (e) {
                    log("Date Is Not Pick");
                  }
                },
                icon: const Icon(Icons.calendar_month)),
            const Text(
              "Pick Date",
              style: TextStyle(),
            )
          ],
        ).paddingSymmetric(vertical: 3, horizontal: 12),
        Row(
          children: [
            IconButton(
                onPressed: () async {
                  try {
                    Future<TimeOfDay?> time = showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    homeGetController.timeOfDay = await time;
                    print(homeGetController.timeOfDay!.hour);
                  } catch (e) {
                    log("Time Is Not Pick");
                  }
                },
                icon: const Icon(Icons.access_time_outlined)),
            const Text(
              "Pick Time",
              style: TextStyle(),
            )
          ],
        ).paddingSymmetric(horizontal: 12),
        TextButton(
          style: const ButtonStyle(
            side: WidgetStatePropertyAll(
              BorderSide(color: Colors.black),
            ),
          ),
          onPressed: () {
            if (homeGetController.textChat.text.isNotEmpty &&
                homeGetController.textNumber.text.isNotEmpty &&
                homeGetController.textName.text.isNotEmpty &&
                homeGetController.date != null &&
                homeGetController.timeOfDay != null &&
                homeGetController.fileImage != null) {
              homeGetController.shareLocalStorage();
            } else {
              Get.snackbar("Contact", "Field Must Be Required");
            }
            // platformController.addingMethod();
          },
          child: Text(
            "Save".toUpperCase(),
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
