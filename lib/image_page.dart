import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example_play/utils/http_utils.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String _imageUrl = "${HttpUtils.BASE_URL}/image/getRandomImage";
  Key _imageKey = UniqueKey();

  Future<bool> evictImage(String imageURL, Map<String, String> headers) async {
    final NetworkImage provider = NetworkImage(imageURL, headers: headers);
    return await provider.evict();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async{
                print("$_imageKey");
                await evictImage(_imageUrl, {});
                setState(() {
                  _imageKey = UniqueKey();
                });
              }, 
              child: Text("随机获取图片")
            ),
            Image.network(_imageUrl,key: _imageKey,)
          ],
        ),
      ),
    );
  }
}