import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_ct/home_page.dart';
import 'package:stock_ct/toolbox.dart';
import 'package:device_information/device_information.dart';

class LoginPage extends StatefulWidget {
  final String token;
  const LoginPage({Key? key, required this.token}) : super(key: key);
  static const String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int changePageNumber = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget getLoginPagination(int index) {
    List<Widget> loginContainerList = [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: MyColor.homePageLinear),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child:
                    Text('承通證券投資顧問', style: MyText.myTextStyle(fontSize: 24)),
              ),
              Expanded(
                flex: 5,
                child: Text('股份有限公司', style: MyText.myTextStyle(fontSize: 24)),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('已加入會員',
                          style: MyText.myTextStyle(fontSize: 11)),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () async {
                          await MyDialog.showAccountDialog(
                              context: context, token: widget.token);
                        },
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width * (202 / 375),
                          height:
                              MediaQuery.of(context).size.height * (48 / 667),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: MyColor.buttonYellow,
                          ),
                          child: Center(
                            child: Text(
                              '登入',
                              style: MyText.myTextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('尚未成為會員',
                          style: MyText.myTextStyle(fontSize: 11)),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width * (202 / 375),
                          height:
                              MediaQuery.of(context).size.height * (48 / 667),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: MyColor.buttonBlue,
                          ),
                          child: Center(
                            child: Text(
                              '註冊',
                              style: MyText.myTextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
              ),
              const Expanded(flex: 4, child: SizedBox()),
              Expanded(
                flex: 2,
                child: Text('正派經營．誠信為本．績效為根',
                    style: MyText.myTextStyle(fontSize: 16)),
              ),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
      ),
    ];
    return loginContainerList[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(flex: 3, child: SizedBox()),
          Expanded(
              flex: 24,
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                      flex: 7, child: getLoginPagination(changePageNumber)),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              )),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 2,
            child: Text(
              'CHENG-TUNG Security Investment Consultant CO. Ltd.',
              style: MyText.myTextStyle(fontSize: 12, weight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
