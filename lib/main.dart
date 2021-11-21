import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_ct_web/toolbox.dart';


void main()async {
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController testController = TextEditingController();
  String? inputText;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('承通投顧')),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '請輸入測試推播訊息:',
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: testController,
              onChanged: (newValue){
                inputText=newValue;
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async {
              await MyDIO.fcmSend(title: '測試訊息',body: testController.text);

            }, child: const Text(
              '發送',
              style: TextStyle(fontSize: 18),
            ),),
          ],
        ),
      ),
    );
  }
}
