
import 'dart:io';

import 'package:fh/core/constants/local_storage_constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/movie_model.dart';



class AppHive {


  static Future<void> init() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Hive
      ..init(tempPath)
      ..registerAdapter(MovieModelAdapter());
        await Hive.openBox(HiveKeyConstants.moviesBox); // Open a Hive box
  }



}
