import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter{
  //생성자 {} 옵션값, 필수를 명하기 위해서는 @required 어노테이션 추가
  LoginBackground({@required this.isJoin});

  final bool isJoin;

  //실제로 그림을 그리는 영역
  @override
  void paint(Canvas canvas, Size size) {
    // .. = 전체를 한가지 값으로
    Paint paint = Paint()..color = isJoin?Colors.red:Colors.blue;
    canvas.drawCircle(Offset(size.width * 0.5 ,size.height * 0.2 ), size.height * 0.5 , paint);
  }

//뒷 프레임이 변경되는지 묻는 메소드
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}