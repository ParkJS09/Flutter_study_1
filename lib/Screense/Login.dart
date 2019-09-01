import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auths/Helper/login_background.dart';
import 'package:firebase_auths/data/join_or_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Context : 현재구동되는 앱의 상황
    //final : 생성시점의 값을 변경 할 수 없음.
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        CustomPaint(
          size: size,
          painter:
              LoginBackground(isJoin: Provider.of<JoinOrLogin>(context).isJoin),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _setLogoImage(),
            Stack(
              children: <Widget>[
                _setCard(size),
                Positioned(
                  left: size.width * 0.15,
                  right: size.width * 0.15,
                  bottom: 0,
                  child: _setLoginBtn(),
                ),
              ],
            ),
            Container(
              height: size.height * 0.1,
            ),
            Consumer<JoinOrLogin>(
                builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      value.toggle();
                    },
                    child: Text(
                      value.isJoin
                          ? 'Already have an acoount? Sign In'
                          : 'Dont have an acoount? create one',
                      style: TextStyle(
                          color: value.isJoin ? Colors.red : Colors.blue),
                    ))),
            Container(
              height: size.height * 0.05,
            )
          ],
        )
      ],
    ));
  }

  Widget _setCard(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        //formkey를 활용하여 TextForm의 상태를 가져올 수 있음
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 12.0, bottom: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_circle), labelText: 'email'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return '아이디를 입력해주세요';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  //Password input type
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key), labelText: 'password'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return '암호를 입력해주세요';
                    }
                    return null;
                  },
                ),
                Container(
                  height: 16,
                ),
                Consumer<JoinOrLogin>(
                  //Opacity 투명
                  builder: (context, value, child) => Opacity(
                      opacity: value.isJoin ? 0 : 1,
                      child: Text('Forgot Paswword?')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _setLoginBtn() {
    return SizedBox(
      height: 50,
      child: Consumer<JoinOrLogin>(
        builder: (context, value, child) => RaisedButton(
          child: Text(
            value.isJoin?'JOIN':'LOGIN',
            style: TextStyle(color: Colors.white),
          ),
          color: value.isJoin?Colors.red:Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          onPressed: () {
            //formKey를 활용하여 currnetState를 가져와 validate()를 호
            if (_formKey.currentState.validate()) {
              value.isJoin?_register(context):_login(context);
            }
          },
        ),
      ),
    );
  }

  Widget _setLogoImage() {
    //https://media.giphy.com/media/lqut5VxPEhP9zCJdUT/giphy.gif
    //Expanded Row나 Column의 기준을 꽉 채움
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 40, left: 24, right: 24),
        child: FittedBox(
          fit: BoxFit.contain,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://media.giphy.com/media/lqut5VxPEhP9zCJdUT/giphy.gif'),
          ),
        ),
      ),
    );
  }

  /**
   * 회원가입 메소드
   */
  void _register(BuildContext context) async {
    final AuthResult reuslt = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
    );

    final FirebaseUser user = reuslt.user;

    if(user == null){
      final snackBar = SnackBar(content: Text('에러났져!'),);
      Scaffold.of(context).showSnackBar(snackBar);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage(email:user.email)));
  }

  /**
   * 로그 메소드
   */
  void _login(BuildContext context) async {
    final AuthResult reuslt = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
    );
    final FirebaseUser user = reuslt.user;
    if(user == null){
      final snackBar = SnackBar(content: Text('Please try again later'),);
      Scaffold.of(context).showSnackBar(snackBar);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage(email:user.email)));
  }
}
