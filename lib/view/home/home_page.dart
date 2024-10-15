import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/controller/get_controller.dart';
import 'package:platform_converter_app/controller/platform_controller.dart';

import 'components/home_components.dart';

HomeGetController homeGetController = Get.put(HomeGetController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    contexts = context;
    PlatformController platformController = Get.put(PlatformController());
    return Obx(
      () => (platformController.platformControlling.value == false)
          ? DefaultTabController(
              length: 4,
              child: platformAndroidScaffold(
                  platformController, homeGetController, context),
            )
          : CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_add)),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.chat_bubble_2),
                      label: "Chats".toUpperCase(),
                      activeIcon: IconButton(onPressed: () {
                        homeGetController.methodUpdate();
                      }, icon: Icon(CupertinoIcons.chat_bubble_2))
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.phone),
                      label: "Calls".toUpperCase(),
                      activeIcon: IconButton(onPressed: () {
                        homeGetController.methodUpdate();
                      }, icon: Icon(CupertinoIcons.phone))
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings),
                    label: "Settings".toUpperCase(),
                  ),
                ],
              ),
              tabBuilder: (BuildContext context, indexSet) => Scaffold(
                backgroundColor: CupertinoColors.white,
                body: CupertinoTabView(
                  builder: (BuildContext context) => CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      trailing: CupertinoSwitch(
                        value: platformController.platformControlling.value,
                        onChanged: (value) {
                          platformController.platformMethod(
                              platformController.platformControlling);
                        },
                      ),
                      middle: const Text("Platform Converter"),
                    ),
                    child: iosPageList[indexSet],
                  ),
                ),
              ),
            ),
    );
  }
}

List<Widget> iosPageList = [
  firstPageColumn(),
  GetBuilder<HomeGetController>(
    builder: (context) {
      return (homeGetController.shareList.isNotEmpty)
          ? ListView.builder(
              //todo chats
              itemCount: homeGetController.shareList.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  showCupertinoModalPopup(context: context, builder: (context) {
                    return SafeArea(
                      child: Container(
                        height: 350,
                        child: Scaffold(
                          body: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                backgroundImage: FileImage(File(homeGetController
                                    .shareList[index]
                                    .split("!")
                                    .sublist(5, 6)
                                    .join(' '))),
                                radius: 70,
                              ),
                              Text(
                                homeGetController.shareList[index]
                                    .split("!")
                                    .sublist(0, 1)
                                    .join(' '),
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                              ),
                              Text(homeGetController.shareList[index]
                                  .split("!")
                                  .sublist(2, 3)
                                  .join(' ')),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: CupertinoColors.systemBlue,)),
                                  IconButton(
                                      onPressed: () {
                                        homeGetController.shareList.removeAt(index);
                                        homeGetController.removeShareListMethod();
                                        homeGetController.methodUpdate();
                                        Get.back();
                                      },
                                      icon: const Icon(Icons.delete,color: CupertinoColors.systemBlue)),
                                ],
                              ),
                              CupertinoButton(
                                  color: CupertinoColors.systemGrey2,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Cancel"))
                            ],
                          ),
                        ),
                      ),
                    );
                  },);
                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) => ,
                  // );
                },
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(homeGetController.shareList[index]
                      .split("!")
                      .sublist(5, 6)
                      .join(' '))),
                  radius: 40,
                ),
                title: Text(
                  homeGetController.shareList[index]
                      .split("!")
                      .sublist(0, 1)
                      .join(' '),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(homeGetController.shareList[index]
                    .split("!")
                    .sublist(2, 3)
                    .join(' ')),
                trailing: Text(
                  homeGetController.shareList[index]
                          .split("!")
                          .sublist(4, 5)
                          .join(' ') +
                      "," +
                      homeGetController.shareList[index]
                          .split("!")
                          .sublist(3, 4)
                          .join(' '),
                  style: const TextStyle(fontSize: 15,),
                ),
              ).paddingSymmetric(vertical: 10),
            )
          : Center(
              child: Text("No any chats yet..."),
            );
    }
  ),
  GetBuilder<HomeGetController>(
    builder: (context) {
      return (homeGetController.shareList.isNotEmpty)
          ? ListView.builder(
              itemCount: homeGetController.shareList.length,
              itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(homeGetController
                        .shareList[index]
                        .split("!")
                        .sublist(5, 6)
                        .join(' '))),
                    radius: 40,
                  ),
                  title: Text(
                    homeGetController.shareList[index]
                        .split("!")
                        .sublist(0, 1)
                        .join(' '),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(homeGetController.shareList[index]
                      .split("!")
                      .sublist(2, 3)
                      .join(' ')),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.phone_fill,
                        color: Colors.green,
                      ))).paddingSymmetric(vertical: 10),
            )
          : Center(
              child: Text("No any calls yet..."),
            );
    }
  ),
  fourPageSettingColumn()
];
// -----------------------------------------------------------------------------------------
// todo ios page  -> 4
Widget fourPageSettingColumn() {
  return Obx(
    () => Column(
      children: [
        SizedBox(
          height: 80,
        ),
        iosSettingSetListTile(
          textSet: "Profile",
          valueTextSet: "Update Profile Data",
          iconSet: const Icon(
            CupertinoIcons.person,
            color: CupertinoColors.activeBlue,
          ),
          setValueBool: homeGetController.profileSettingBool.value,
          onChanged: (value) {
            homeGetController
                .settingMethod(homeGetController.profileSettingBool);
          },
        ).paddingSymmetric(horizontal: 10),
        if (homeGetController.profileSettingBool.value)
          ...List.generate(
            iosSettingWidgetList.length,
            (index) {
              return iosSettingWidgetList[index];
            },
          )
        else
          Container(),
        Divider(
          color: CupertinoColors.systemGrey4,
        ).paddingSymmetric(horizontal: 20),
        iosSettingSetListTile(
          textSet: "Theme",
          valueTextSet: "Change Theme",
          iconSet: Icon(
            CupertinoIcons.sun_min,
            color: CupertinoColors.activeBlue,
          ),
          setValueBool: homeGetController.themeSetting.value,
          onChanged: (value) {
            homeGetController.settingMethod(homeGetController.themeSetting);
          },
        ).paddingSymmetric(horizontal: 10),
      ],
    ),
  );
}

late BuildContext contexts;
//------------------------------------------------------------------------------------------
// todo ios page  -> 1
Widget firstPageColumn() {
  return Column(
    children: [
      SizedBox(
        height: 90,
        width: double.infinity,
      ),
      GetBuilder<HomeGetController>(builder: (context) {
        return (homeGetController.fileImage == null)
            ? CircleAvatar(
                radius: 65,
                backgroundColor: CupertinoColors.systemBlue,
                child: IconButton(
                    onPressed: () async {
                      try {
                        ImagePicker imagePick = ImagePicker();
                        XFile? xFileImage = await imagePick.pickImage(
                            source: ImageSource.camera);
                        homeGetController.fileImage = File(xFileImage!.path);
                        homeGetController.methodUpdate();
                      } catch (e) {
                        Get.log("Image Done Not");
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.camera,
                      color: CupertinoColors.white,
                    )),
              )
            : CircleAvatar(
                radius: 65,
                backgroundColor: CupertinoColors.systemBlue,
                backgroundImage:
                    FileImage(homeGetController.fileImage!.absolute),
                child: GestureDetector(
                  onTap: () async {
                    try {
                      ImagePicker imagePick = ImagePicker();
                      XFile? xFileImage =
                          await imagePick.pickImage(source: ImageSource.camera);
                      homeGetController.profileFileImage =
                          File(xFileImage!.path);
                      homeGetController.methodUpdate();
                    } catch (e) {
                      Get.log("Image Done Not");
                    }
                  },
                ),
              );
      }),
      SizedBox(
        height: 25,
      ),
      createCupertinoTextFormFieldRow(
              textFind: "Full Name",
              iconSetFind: Icon(
                CupertinoIcons.person,
                color: Colors.blue,
              ).paddingOnly(right: 3),
              textFindController: homeGetController.textName)
          .paddingSymmetric(horizontal: 0),
      createCupertinoTextFormFieldRow(
              textFind: "Phone Number",
              iconSetFind: Icon(
                CupertinoIcons.phone,
                color: Colors.blue,
              ).paddingOnly(right: 3),
              textFindController: homeGetController.textNumber)
          .paddingSymmetric(horizontal: 0),
      createCupertinoTextFormFieldRow(
              textFind: "Chat Conversation",
              iconSetFind: Icon(
                CupertinoIcons.chat_bubble_text,
                color: Colors.blue,
              ).paddingOnly(right: 3),
              textFindController: homeGetController.textChat)
          .paddingSymmetric(horizontal: 0),
      Row(
        children: [
          IconButton(
              onPressed: () async {
                try {
                  homeGetController.date = await showDatePicker(
                    context: contexts,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );
                  print(homeGetController.date);
                } catch (e) {
                  log("Date Is Not Pick");
                }
                homeGetController.methodUpdate();
              },
              icon: Icon(
                CupertinoIcons.calendar,
                color: Colors.blue,
              )),
          GetBuilder<HomeGetController>(builder: (context) {
            return Text(
              (homeGetController.date == null)
                  ? "Pick Date"
                  : "${homeGetController.date!.day}/${homeGetController.date!.month}/${homeGetController.date!.year}",
              style: TextStyle(fontSize: 17),
            );
          })
        ],
      ).paddingSymmetric(horizontal: 10),
      Row(
        children: [
          IconButton(
              onPressed: () async {
                try {
                  Future<TimeOfDay?> time = showTimePicker(
                    context: contexts,
                    initialTime: TimeOfDay.now(),
                  );
                  homeGetController.timeOfDay = await time;
                  print(homeGetController.timeOfDay!.hour);
                } catch (e) {
                  log("Time Is Not Pick");
                }
                homeGetController.methodUpdate();
                print(homeGetController.timeOfDay);
              },
              icon: Icon(
                CupertinoIcons.time,
                color: Colors.blue,
              )),
          GetBuilder<HomeGetController>(builder: (context) {
            return Text(
              (homeGetController.timeOfDay == null)
                  ? "Pick Time"
                  : "${homeGetController.timeOfDay!.hour}:${homeGetController.timeOfDay!.minute}",
              style: const TextStyle(fontSize: 17),
            );
          }),
        ],
      ).paddingSymmetric(horizontal: 10),
      CupertinoButton(
        color: CupertinoColors.activeBlue,
        child: Text(
          "Save",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (homeGetController.textChat.text.isNotEmpty &&
              homeGetController.textNumber.text.isNotEmpty &&
              homeGetController.textName.text.isNotEmpty &&
              homeGetController.date != null &&
              homeGetController.timeOfDay != null &&
              homeGetController.fileImage != null) {
            homeGetController.shareLocalStorage();
            homeGetController.methodUpdate();
          } else {
            Get.snackbar("Contact", "Field Must Be Required");
          }
          // platformController.addingMethod();
        },
      ),
    ],
  );
}

//------------------------------------------------------------------------------------------
CupertinoTextFormFieldRow createCupertinoTextFormFieldRow(
    {required String textFind,
    required iconSetFind,
    required TextEditingController textFindController}) {
  return CupertinoTextFormFieldRow(
    controller: textFindController,
    prefix: iconSetFind,
    placeholder: textFind,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: CupertinoColors.systemGrey2)),
  );
}

//-------------------------------------------------------------------------------------------
ListTile iosSettingSetListTile(
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
    trailing: CupertinoSwitch(value: setValueBool, onChanged: onChanged),
  );
}
