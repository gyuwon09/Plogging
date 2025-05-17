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
    return MaterialApp(
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
              ),flex: 5,),
              Flexible(child:Container(
                //color: Colors.red,
                padding: EdgeInsets.all(0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.shopping_basket_outlined,size: 30,color: Colors.black,)
                ),
              ),flex: 5,),
              Flexible(child:Container(
                //color: Colors.red,
                padding: EdgeInsets.all(0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.circle_outlined,size: 30,color: Colors.black,)
                ),
              ),flex: 5,),
              Flexible(child:Container(
                //color: Colors.red,
                padding: EdgeInsets.all(0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.settings_outlined,size: 30,color: Colors.black,)
                ),
              ),flex: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
