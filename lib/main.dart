import 'package:flutter/material.dart';

void main() {
  //앱 구동부( 메인 페이지 구동 )
  runApp(const MyApp());
}

//메인 페이지
class MyApp extends StatelessWidget {
  //필수 설정부
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    //실질적 코딩 하는 곳( 앱 디자인 )
    //MaterialApp()은 구글이 제공하는 Material design을 쉽게 활용할 수 있게 해주는 위젯( 구글 스타일이 아니더라도 커스터마이즈가 유용 )
    return MaterialApp(
      //Text('안녕!!')
      //Image.asset('assets/logo.png')
      //Container(width: 50,height: 50,color: Colors.blue) -단위는 lp
      //Center() 내 자식 위젯의 기준점을 중앙으로 둠
      //Icon(Icons.star)
      //home: Center(
      //  child:Container(width: 50,height: 50,color: Colors.blue),
      //)

      //Scaffold() : 앱을 상단, 중단, 하단으로 나눠줌.
      //home: Scaffold(
      //  appBar: AppBar(),
      //  body: Container(),
      //  bottomNavigationBar: BottomAppBar(),
      //)

      home: Scaffold(
        appBar: AppBar(),
        body: Container(child: Text("안녕"),),
        bottomNavigationBar: BottomAppBar(),
      )
    );
  }
}
