import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/utils/routes/routes.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: "/medication",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes,
  ));
}
