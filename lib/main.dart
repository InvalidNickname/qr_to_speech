import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'Qr Scanner'),
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;

  MainPage({Key key, this.title}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String qrText = "";
  FlutterTts ttsModule;
  var options = ScanOptions(strings: {
    'cancel': 'отменить',
    'flash_on': 'вспышка',
    'flash_off': 'без_вспышки'
  });

  _MainPageState() {
    ttsModule = FlutterTts();
  }

  Future<void> readQr() async {
    var result = await BarcodeScanner.scan(options: options);

    if (result.type == ResultType.Barcode) {
      setState(() {
        qrText = result.rawContent;
        speak(qrText);
      });
    }
  }

  void speak(String text) async {
    await ttsModule.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$qrText'),
            RaisedButton(
              onPressed: readQr,
              child: Text('Считать QR'),
            ),
          ],
        ),
      ),
    );
  }
}
