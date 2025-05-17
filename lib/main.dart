import 'package:flutter/material.dart';

void main() {
  //앱 구동부( 메인 페이지 구동 )
  runApp(const MainPage());
}

//메인 페이지
class MainPage extends StatelessWidget {
  //필수 설정부
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    //실질적 코딩 하는 곳( 앱 디자인 )
    //MaterialApp()은 구글이 제공하는 Material design을 쉽게 활용할 수 있게 해주는 위젯( 구글 스타일이 아니더라도 커스터마이즈가 유용 )
    return MaterialApp(
      //Text('안녕!!')
      //Image.asset('assets/logo.png')
      //Container(width: 50,height: 50,color: Colors.blue) -단위는 lp  //container 대용으로 SizedBox가 존재
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

      //가로로 여러줄 표기
      //body: Row(
      // mainAxisAlignment: MainAxisAlignment.center, //가로측 중앙 정렬
      //crossAxisAlignment: CrossAxisAlignment.center, //세로축 중앙 정렬(컨테이너로 싸매야함)
      // children: [
      //  Icon(Icons.star),
      //  Text("Plogging")
      //]),

      //body: Container(
      //  width: 50,
      //  height: 50,
      //  color: Colors.blue,
      //  margin: EdgeInsets.all(20), //Container 마진 입히기 // 내부에 여백을 주려면 padding: EdgeInsets.all(20),
      //  margin: EdgeInsets.fromLTRB(10, 20, 10, 20), //개별 부분 마진
      //  이 외 찌끄레기 설정들은
      //decoration: BoxDecoration(
      //    border: Border.all(color: Colors.red)
      //),
      //)


      //세로는 Column 위젯
      //Column에서는 mainAxisAlignment: MainAxisAlignment.spaceEvenly, 넣어서 세로 정렬

      //home: Scaffold(
      //  appBar: AppBar(title: Text("Plogging"),),
      //  body: Align(
      //    alignment: Alignment.centerLeft,
      //    child: Container(
      //      width: double.infinity,
      //      height: 50,
      //      color: Colors.blue,
      //      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
      //    ),
      //  )
      //)

      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.public,),
          title: Text("신갈고등학교",style:TextStyle(
            fontSize: 20,
            //backgroundColor: Colors.brown

          ),),
        ),
        body: Container(color: Colors.blue,),
        bottomNavigationBar:SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child:Container(
                //color: Colors.red,
                padding: EdgeInsets.all(0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.home_outlined,size: 30,color: Colors.black,)
                ),
                //child: Container(
                //  color: Colors.pink,
                //  child: Icon(Icons.home,size: 40,),
                //),
              ),flex: 5,),
              Flexible(child:Container(
                //color: Colors.red,
                padding: EdgeInsets.all(0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.shopping_basket_outlined,size: 30,color: Colors.black,)
                ),
                //child: Container(
                //  color: Colors.pink,
                //  child: Icon(Icons.home,size: 40,),
                //),
              ),flex: 5,),
              Flexible(child:Container(
                //color: Colors.red,
                padding: EdgeInsets.all(0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.circle_outlined,size: 30,color: Colors.black,)
                ),
                //child: Container(
                //  color: Colors.pink,
                //  child: Icon(Icons.home,size: 40,),
                //),
              ),flex: 5,),
              Flexible(child:Container(
                //color: Colors.red,
                padding: EdgeInsets.all(0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.settings_outlined,size: 30,color: Colors.black,)
                ),
                //child: Container(
                //  color: Colors.pink,
                //  child: Icon(Icons.home,size: 40,),
                //),
              ),flex: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
