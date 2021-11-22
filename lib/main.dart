import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_ct_web/toolbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  Future<DocumentSnapshot>? getDeviceTokenList;
  Map<String, String> groupList = {};
  TextEditingController testController = TextEditingController();
  String? inputText;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getDeviceTokenList = firestore.collection('DeviceToken').doc('token').get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appThemeBackground,
      appBar: AppBar(
        backgroundColor: MyColor.appThemeBackground,
        elevation: 0,
        title: Center(
            child: Text(
          '承通投顧',
          style: MyText.myTextStyle(fontSize: 23, fontColor: MyColor.textWhite),
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: FutureBuilder<DocumentSnapshot>(
              future: getDeviceTokenList,
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> deviceList =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '裝置列表',
                                style: MyText.myTextStyle(
                                    fontSize: 22, fontColor: MyColor.textWhite),
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: ListView.builder(
                                itemCount: deviceList.length,
                                shrinkWrap: true,
                                itemBuilder: (ctx, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            deviceList.keys.toList()[i],
                                            style: MyText.myTextStyle(
                                                fontSize: 22,
                                                fontColor: MyColor.textWhite),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            deviceList[
                                                deviceList.keys.toList()[i]],
                                            style: MyText.myTextStyle(
                                              fontSize: 22,
                                              fontColor: MyColor.textWhite,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                groupList[deviceList.keys
                                                        .toList()[i]] =
                                                    deviceList[deviceList.keys
                                                        .toList()[i]];
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '群組',
                                style: MyText.myTextStyle(
                                    fontSize: 22, fontColor: MyColor.textWhite),
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: ListView.builder(
                                  itemCount: groupList.length,
                                  itemBuilder: (ctx, i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            groupList.keys.toList()[i],
                                            style: MyText.myTextStyle(
                                                fontSize: 22,
                                                fontColor: MyColor.textWhite),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '請輸入測試推播訊息:',
                    style: MyText.myTextStyle(
                        fontSize: 22, fontColor: MyColor.textWhite),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: testController,
                    style: MyText.myTextStyle(
                        fontSize: 22, fontColor: MyColor.textWhite),
                    onChanged: (newValue) {
                      inputText = newValue;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      await MyDIO.fcmSend(
                          title: '測試訊息',
                          body: testController.text,
                          target: groupList.values.toList());
                    },
                    child: const Text(
                      '發送',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
