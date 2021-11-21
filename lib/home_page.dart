import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'toolbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int segmentValue=0;
  Map<int,Widget> segments= <int,Widget>{
    0:Text('推播通知',style: MyText.myTextStyle(fontSize: 16),),
    1:Text('研究日刊',style: MyText.myTextStyle(fontSize: 16),),
    2:Text('今日訊息',style: MyText.myTextStyle(fontSize: 16),),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appThemeBackground,
      appBar: AppBar(
        actions:const [Icon(Icons.settings_outlined,size: 25,)],
        backgroundColor: MyColor.appThemeBackground,
        elevation: 0,
        title: Center(child: Text('承通投顧',style: MyText.myTextStyle(fontSize: 16),)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex:2,
                    child: CupertinoSlidingSegmentedControl<int>(
                        backgroundColor: MyColor.blockBackground,
                        thumbColor: MyColor.segmentWhite,
                        groupValue: segmentValue,
                        children: segments,
                        onValueChanged: (selectedTab){
                          if(selectedTab!=null){
                            setState(() {
                              segmentValue=selectedTab;
                            });
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: ListView(
              children: const [],
            ),
          ),
        ],
      ),
    );
  }
}
