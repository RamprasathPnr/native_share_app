import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.native_share/share');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShareDemo(),
    );
  }

  Future<void> shareText(String text) async {
    try {
      await platform.invokeMethod('shareText', {'text': text});
    } on PlatformException catch (e) {
      print("Failed to share text: ${e.message}");
    }
  }

}

class ShareDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Share Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            MyApp().shareText('Today is difficult tomorrow is more difficult but the day after tomorrow is beautiful');
          },
          child: const Text('Share Text'),
        ),
      ),
    );
  }
}
