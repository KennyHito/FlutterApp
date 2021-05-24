import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _pwdEditController;
  TextEditingController _userNameEditController;

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();
  String userName = '';
  String password = '';

  @override
  void initState() {
    super.initState();

    _pwdEditController = TextEditingController();
    _userNameEditController = TextEditingController();

    _pwdEditController.addListener(() => setState(() => {}));
    _userNameEditController.addListener(() => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); // 触摸收起键盘
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTopWidget(context),
              SizedBox(height: 80),
              buildEditWidget(context),
              buildLoginButton(context)
            ],
          ),
        ),
      ),
    );
  }

  /// 头部
  Widget buildTopWidget(BuildContext context) {
    double height = 100.0;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Stack(
        overflow: Overflow.visible, // 超出部分显示
        children: <Widget>[
          Positioned(
            left: (width - 90) / 2.0,
            top: height - 45,
            child: Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                ///阴影
                boxShadow: [
                  BoxShadow(color: Theme.of(context).cardColor, blurRadius: 4.0)
                ],

                ///形状
                shape: BoxShape.circle,

                ///图片
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://t7.baidu.com/it/u=2168645659,3174029352&fm=193&f=GIF'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 输入框
  Widget buildEditWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          buildLoginNameTextField(),
          SizedBox(height: 20.0),
          buildPwdTextField(),
        ],
      ),
    );
  }

  /// 用户名
  Widget buildLoginNameTextField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16,
            top: 11,
            width: 18,
            height: 18,
            child: Image.asset('images/login_user.png'),
          ),
          Positioned(
            left: 45,
            top: 10,
            bottom: 10,
            width: 1,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          Positioned(
            left: 55,
            right: 10,
            top: 10,
            height: 30,
            child: TextField(
              controller: _userNameEditController,
              focusNode: _userNameFocusNode,
              decoration: InputDecoration(
                hintText: "请输入用户名",
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 14),
              onChanged: (text) {
                userName = text;
              },
            ),
          )
        ],
      ),
    );
  }

  /// 密码
  Widget buildPwdTextField() {
    return Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 16,
              top: 11,
              width: 18,
              height: 18,
              child: Image.asset('images/login_pwd.png'),
            ),
            Positioned(
              left: 45,
              top: 10,
              bottom: 10,
              width: 1,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Positioned(
              left: 55,
              right: 10,
              top: 10,
              height: 30,
              child: TextField(
                controller: _pwdEditController,
                focusNode: _pwdFocusNode,
                decoration: InputDecoration(
                  hintText: "请输入密码",
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 14),
                obscureText: true, //加密显示,对外显示*
                onChanged: (text) {
                  password = text;
                },

                /// 设置密码
              ),
            )
          ],
        ));
  }

  /// 登录按钮
  Widget buildLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 10, right: 10),
      padding: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width - 20,
      height: 40,
      child: RaisedButton(
        onPressed: () {
          _getNativeMessage(context);
        },
        child: Text("登录"),
        color: Colors.blue[400],
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }

  void _getNativeMessage(BuildContext context) async {
    //  对应OC中的FlutterMethodChannel
    const platform = const MethodChannel('com.allen.test.call');
    String message = 'null message';
    String result;
    try {
      if (userName.isEmpty) {
        Toast.show("用户名不能为空", context, gravity: Toast.CENTER);
        return;
      }
      if (password.isEmpty) {
        Toast.show("密码不能为空", context, gravity: Toast.CENTER);
        return;
      }
      var map = {"userName": userName, "pwd": password};
      // OC回调中对应的”约定” : getFlutterMessage,[1,2,3]:传递参数
      result = await platform.invokeMethod('getFlutterMessage', map);
    } on PlatformException catch (e) {
      result = "error message $e";
    }
    setState(() {
      message = result;
    });
    print(message);
  }

  bool checkInput() {
    if (_userNameEditController.text.length == 0) {
      return false;
    } else if (_pwdEditController.text.length == 0) {
      return false;
    }
    return true;
  }
}
