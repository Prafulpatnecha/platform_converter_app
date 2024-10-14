import 'package:get/get.dart';
PlatformController platformController = Get.put(PlatformController());
class PlatformController extends GetxController {
  RxBool platformControlling = false.obs;
  RxBool isDark = false.obs;

  //testing
  // {
        RxInt adding = 0.obs;

        void addingMethod() {
          // adding.value++;
          String value = "Name Name_PhoneNo_Chat_Date_Time_image";
          print(value.split("_").sublist(0,1).join(" "));
        }
//   }
  void platformMethod(RxBool value)
  {
    value.value = !value.value;
  }
}