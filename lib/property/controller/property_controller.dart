import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:practical_softieons/local_storage/user_database.dart';
import '../../admin_login/model/user_model.dart';
import '../../local_storage/database_storage.dart';
import '../model/book_model.dart';
import '../model/property_model.dart';

class PropertyController extends GetxController {
  Rx<TextEditingController> propertyNameController =
      TextEditingController().obs;
  Rx<TextEditingController> propertyNormalPrice = TextEditingController().obs;
  Rx<TextEditingController> propertyDate = TextEditingController().obs;
  Rx<TextEditingController> propertyWeekendPrice = TextEditingController().obs;
  Rx<TextEditingController> propertyCancellationChargeController =
      TextEditingController().obs;
  RxString image = ''.obs;
  RxString status = ''.obs;
  RxString name = ''.obs;
  RxString type = ''.obs;
  RxBool isDataLoad = false.obs;
  RxBool alreadyData = false.obs;
  RxBool alreadyBooked = false.obs;
  List<Property> properties = [];
  List<BookingModel> bookModelList = [];
  UserRepository userRepository = UserRepository();
  List<BookingModel>? bookingModel;
  List<User>? allUsers;

  @override
  void onInit() {
    super.onInit();
    getAllProperties();
  }

  dateFormat(DateTime element) {
    DateFormat propertyTime = DateFormat('yyyy-MM-dd');
    String formattedDate = propertyTime.format(element);
    return formattedDate;
  }

  getPropertyData(id) async {
    var propertyData = await userRepository.getPropertyById(id);
    bookingModel = bookingModelFromJson(jsonEncode(propertyData));
    print('propertyData==>$bookingModel');
    update();
  }

  fetchUserName(userId) async {
    name.value = await userRepository.fetchUserData(userId);
  }

  clearData() {
    propertyNameController.value.clear();
    propertyNormalPrice.value.clear();
    propertyWeekendPrice.value.clear();
    image.value = '';
  }

  setData(
      {required String name,
      required String normalPrice,
      required String weeklyPrice,
      required String propertyStatus,
      required String imageValue}) {
    propertyNameController.value.text = name;
    propertyNormalPrice.value.text = normalPrice;
    propertyWeekendPrice.value.text = weeklyPrice;
    status.value = propertyStatus;
    image.value = imageValue;
  }

  void getAllProperties() async {
    isDataLoad.value = true;
    final DatabaseHelper dbHelper = DatabaseHelper();
    properties = await dbHelper.getAllProperties();
    isDataLoad.value = false;
    update();
  }

  Future<void> getAllBookingData() async {
    isDataLoad.value = true;
    final DatabaseHelper dbHelper = DatabaseHelper();
    bookModelList = await dbHelper.getAllBooking();
    isDataLoad.value = false;
    update();
  }

  final _picker = ImagePicker();

  Future<String> updatePictures(bool isCamera) async {
    if (isCamera) {
      final catchImage =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (catchImage != null) {
        image.value = XFile(catchImage.path).path;
      }
      return image.value;
    } else {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (pickedImage != null) {
        image.value = XFile(pickedImage.path).path;
      }
      update();
      return image.value;
    }
  }

//weekday find
  String getDayType(DateTime date) {
    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      return 'Weekend';
    } else {
      return 'Normal Day';
    }
  }

  //selected date
  DateTime selectedDate = DateTime.now(); // Initial date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    type.value = getDayType(selectedDate);
    propertyDate.value.text = dateFormat(selectedDate);
    update();
  }
}
