import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:platform_converter_app/controller/get_controller.dart';
import 'package:platform_converter_app/controller/platform_controller.dart';

import 'components/home_components.dart';

HomeGetController homeGetController = Get.put(HomeGetController());
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PlatformController platformController = Get.put(PlatformController());
    return Obx(
      () => (platformController.platformControlling.value == false)
          ? DefaultTabController(
              length: 4,
              child: platformAndroidScaffold(
                  platformController, homeGetController,context),
            )
          : CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_add)),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.chat_bubble_2),
                      label: "Chats".toUpperCase()),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.phone),
                      label: "Calls".toUpperCase()),
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
                    child:
                    iosPageList[indexSet],
                  ),
                ),
              ),
            ),
    );
  }
}

List<Widget> iosPageList = [
  firstPageColumn(),
  Container(),
  Container(),
  fourPageSettingColumn()
];
// -----------------------------------------------------------------------------------------
// todo ios page  -> 4
Widget fourPageSettingColumn() {
  return Obx(
    () =>  Column(
      children: [
        SizedBox(height: 80,),
        iosSettingSetListTile(
          textSet: "Profile",
          valueTextSet: "Update Profile Data",
          iconSet: Icon(CupertinoIcons.person,color: CupertinoColors.activeBlue,),
          setValueBool: homeGetController.profileSettingBool.value,
          onChanged: (value) {
            homeGetController
                .settingMethod(homeGetController.profileSettingBool);
          },).paddingSymmetric(horizontal: 10),
        if (homeGetController.profileSettingBool.value)
          ...List.generate(
            iosSettingWidgetList.length, (index) {
            return iosSettingWidgetList[index];
          },
          )
        else
          Container(),
        Divider(color: CupertinoColors.systemGrey4,).paddingSymmetric(horizontal: 20),
        iosSettingSetListTile(
          textSet: "Theme",
          valueTextSet: "Change Theme",
          iconSet: Icon(CupertinoIcons.sun_min,color: CupertinoColors.activeBlue,),
          setValueBool: homeGetController.themeSetting.value,
          onChanged: (value) { homeGetController
              .settingMethod(homeGetController.themeSetting);
          },).paddingSymmetric(horizontal: 10),
      ],
    ),
  );
}
//------------------------------------------------------------------------------------------
// todo ios page  -> 1
Widget firstPageColumn() {
  return Column(
    children: [
      SizedBox(
        height: 90,
        width: double.infinity,
      ),
      CircleAvatar(
        radius: 65,
        backgroundColor: CupertinoColors.systemBlue,
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.camera,
              color: CupertinoColors.white,
            )),
      ),
      SizedBox(
        height: 25,
      ),
      createCupertinoTextFormFieldRow(
          textFind: "Full Name",
          iconSetFind: Icon(
            CupertinoIcons.person,
            color: Colors.blue,
          ).paddingOnly(right: 3))
          .paddingSymmetric(horizontal: 0),
      createCupertinoTextFormFieldRow(
          textFind: "Phone Number",
          iconSetFind: Icon(
            CupertinoIcons.phone,
            color: Colors.blue,
          ).paddingOnly(right: 3))
          .paddingSymmetric(horizontal: 0),
      createCupertinoTextFormFieldRow(
          textFind: "Chat Conversation",
          iconSetFind: Icon(
            CupertinoIcons.chat_bubble_text,
            color: Colors.blue,
          ).paddingOnly(right: 3))
          .paddingSymmetric(horizontal: 0),
      Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.calendar,
                color: Colors.blue,
              )),
          Text(
            "Pick Date",
            style: TextStyle(fontSize: 17),
          )
        ],
      ).paddingSymmetric(horizontal: 10),
      Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.time,
                color: Colors.blue,
              )),
          Text(
            "Pick Time",
            style: TextStyle(fontSize: 17),
          )
        ],
      ).paddingSymmetric(horizontal: 10),
      CupertinoButton(
        color: CupertinoColors.activeBlue,
        child: Text(
          "Save",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {

        },
      )
    ],
  );
}

//------------------------------------------------------------------------------------------
CupertinoTextFormFieldRow createCupertinoTextFormFieldRow(
    {required String textFind, required iconSetFind}) {
  return CupertinoTextFormFieldRow(
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
