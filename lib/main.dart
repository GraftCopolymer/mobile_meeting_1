import 'package:flutter/material.dart';
import 'package:flutter_example_play/custom_bottom_bar.dart';
import 'package:flutter_example_play/custom_button.dart';
import 'package:flutter_example_play/image_page.dart';
import 'package:flutter_example_play/network_page.dart';
import 'package:flutter_example_play/upload_image_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _enableButton = true;
  final List<Widget> _pages = [
    NetWorkPage(),
    ImagePage(),
    UploadImagePage()
  ];
  int _curIndex = 0;

  void _buildTabs(){

  }

  @override
  void initState() {
    super.initState();
    // 初始化_pages页面
    _pages.add(
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(value: _enableButton, onChanged: (value){ setState(() {_enableButton = !_enableButton;}); print("Changed");}),
            Text("啊嘞, 怎么这个开关点不动啊??"),
            CustomButton(child: const Text("Click Me"), onPressed: _enableButton ? (){
              print("Hello World");
            } : null),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_curIndex],
      bottomNavigationBar: CustomBottomBar(
        children: [
          CustomBarItem(child: Icon(Icons.home)),
          CustomBarItem(child: Icon(Icons.account_balance_wallet)),
          CustomBarItem(child: Icon(Icons.ice_skating))
        ],
        onSelected: (p0) {
          setState(() {
            _curIndex = p0;
          });
        },
      ),
    );
  }
}
