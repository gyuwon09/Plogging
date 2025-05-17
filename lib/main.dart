import 'package:flutter/material.dart'; // 여기의 백슬래시 제거

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plogging',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomeWithBottomNav(),
    );
  }
}

class HomeWithBottomNav extends StatefulWidget {
  const HomeWithBottomNav({super.key});

  @override
  _HomeWithBottomNavState createState() => _HomeWithBottomNavState(); // 여기의 백슬래시 제거
}

class _HomeWithBottomNavState extends State<HomeWithBottomNav> { // 여기의 백슬래시 제거
  int _currentIndex = 0; // 여기의 백슬래시 제거

  final _tabs = <Map<String, Widget>>[ // 여기의 백슬래시 제거
    {
      'appBar': AppBar(
        leading: const Icon(Icons.public),
        title: const Text('신갈고등학교'),
        centerTitle: true,
      ),
      'body': Container(color: Colors.blue),
    },
    {
      'appBar': AppBar(title: const Text('상점')),
      'body': const Center(child: Text('상점 화면')),
    },
    {
      'appBar': AppBar(title: const Text('프로필')),
      'body': const Center(child: Text('프로필 화면')),
    },
    {
      'appBar': AppBar(title: const Text('설정')),
      'body': const SettingPage(), // 여기서 SettingPage는 아래에 정의된 Simple SettingPage 사용
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _tabs[_currentIndex]['appBar'], // 여기의 백슬래시 제거
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: child,
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _tabs[_currentIndex]['body'], // 여기의 백슬래시 제거
        transitionBuilder: (child, anim) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        // 선택된 항목의 색상 (아이콘과 라벨 모두에 적용)
        selectedItemColor: Colors.grey,
        // 선택되지 않은 항목의 색상 (아이콘과 라벨 모두에 적용)
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: '상점'),
          BottomNavigationBarItem(icon: Icon(Icons.circle_outlined), label: '프로필'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: '설정'),
        ],
        // backgroundColor: Colors.grey[200], // BottomNavigationBar 배경색 (참고)
      ),

    );
  }
}

// SettingPage 위젯 정의 (제공해주신 코드에 맞춰 간단하게 Center 위젯만 포함)
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('설정 페이지'),
    );
  }
}
