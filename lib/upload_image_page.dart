import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_play/utils/http_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {

  void _uploadImage() async {
    ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if(imageFile == null){
      Fluttertoast.showToast(msg: "图片选取失败");
      return;
    }
    File file = File(imageFile.path);
    Response res = await HttpUtils.uploadImage(file);
    if(res.data != null && res.data['code'] == 0){
      Fluttertoast.showToast(msg: "上传成功");
    }
    else{
      Fluttertoast.showToast(msg: "上传失败: ${res.data['msg']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                _uploadImage();
              }, 
              child: Text("上传图片")
            )
          ],
        ),
      ),
    );
  }
}