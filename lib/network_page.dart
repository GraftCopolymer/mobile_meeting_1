import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_play/utils/http_utils.dart';

class NetWorkPage extends StatefulWidget {
  const NetWorkPage({super.key});

  @override
  State<NetWorkPage> createState() => _NetWorkPageState();
}

class _NetWorkPageState extends State<NetWorkPage> {
  String _displayText = "点击按钮随机获取句子";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_displayText),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () async {
                // 获取随机文本
                Response res = await HttpUtils.getRandomComment();
                Map<String, dynamic>? data = res.data;
                if(data != null && data['code'] == 0){
                  _displayText = data['data']['content'];
                } else{
                  _displayText = "获取失败";
                }
                setState(() {});
              }, 
              child: Text("随机获取句子")
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _controller,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if(_controller.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("内容不能为空")
                    )
                  );
                  return;
                }
                Response res = await HttpUtils.uploadComment(_controller.text);
                if(res.data != null && res.data['code'] == 0){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("提交成功")
                    )
                  );
                  // 清空原来的内容
                  _controller.text = "";
                }
                
              }, 
              child: Icon(Icons.cloud_upload_sharp)
            ),
          ],
        ),
      ),
    );
  }
}