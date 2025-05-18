import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animations/animations.dart';

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
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.black,
        ),
      ),
      home: const HomeWithBottomNav(),
    );
  }
}

class HomeWithBottomNav extends StatefulWidget {
  const HomeWithBottomNav({super.key});

  @override
  State<HomeWithBottomNav> createState() => _HomeWithBottomNavState();
}

class _HomeWithBottomNavState extends State<HomeWithBottomNav> {
  int _currentIndex = 0;
  int _previousIndex = 0;
  final List<Map<String, Widget>> _tabs = [];

  @override
  void initState() {
    super.initState();
    _tabs.addAll([
      {
        'appBar': AppBar(
          leading: const Icon(Icons.public),
          title: const Text('신갈고등학교'),
          centerTitle: true,
        ),
        'body': Container(color: Colors.white),
      },
      {
        'appBar': AppBar(
          title: const Text('상점'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  '포인트: 1,000P',
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        'body': const ShopPage(),
      },
      {
        'appBar': const SizedBox.shrink(),
        'body': Stack(
          children: [
            Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 80, 50, 50),
              child: Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                      child: Column(
                        children: const [
                          Icon(Icons.circle_outlined, size: 50, color: Colors.white),
                          Text(
                            '사용자 이름',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '11번째 사용자입니다',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    flex: 7,
                    child: Opacity(
                      opacity: 0.75,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      },
      {
        'appBar': AppBar(title: const Text('설정')),
        'body': LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth > 600 ? 64.0 : 16.0;
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 24,
              ),
              child: ListView.separated(
                itemCount: _settingsItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, idx) {
                  final item = _settingsItems[idx];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 24,
                      ),
                      backgroundColor: Colors.grey.shade200,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(item.icon, color: Colors.black54),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final bool reverse = _currentIndex < _previousIndex;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _currentIndex == 2
          ? null
          : PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: reverse,
          transitionBuilder: (child, animation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
              child: child,
            );
          },
          child: _tabs[_currentIndex]['appBar']!,
        ),
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        reverse: reverse,
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: _tabs[_currentIndex]['body']!,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _previousIndex = _currentIndex;
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: '상점'),
          BottomNavigationBarItem(icon: Icon(Icons.circle_outlined), label: '프로필'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: '설정'),
        ],
      ),
    );
  }
}

class ShopItemData {
  final String name;
  final String description;
  final int price;
  final int count;

  ShopItemData({
    required this.name,
    required this.description,
    required this.price,
    this.count = 0,
  });
}

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _selectedTab = 0;
  final List<String> _tabTitles = ['상품', '쿠폰', '내 아이템'];

  final List<ShopItemData> products = [
    ShopItemData(name: '햇빛 모자', description: '햇빛을 가려주는 멋진 모자', price: 500),
    ShopItemData(name: '물병', description: '가벼운 플라스틱 물병', price: 300),
  ];

  final List<ShopItemData> coupons = [
    ShopItemData(name: '쿠폰 1', description: '10% 할인 쿠폰', price: 0, count: 1),
    ShopItemData(name: '쿠폰 2', description: '무료 배송 쿠폰', price: 0, count: 2),
  ];

  final List<ShopItemData> inventory = [
    ShopItemData(name: '아이템 1', description: '내 아이템 설명 1', price: 0, count: 3),
    ShopItemData(name: '아이템 2', description: '내 아이템 설명 2', price: 0, count: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ToggleButtons(
                isSelected: List.generate(
                    _tabTitles.length, (i) => i == _selectedTab),
                borderRadius: BorderRadius.circular(8),
                selectedBorderColor: Colors.black,
                selectedColor: Colors.white,
                fillColor: Colors.black,
                color: Colors.black,
                constraints:
                const BoxConstraints(minHeight: 40, minWidth: 100),
                onPressed: (index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
                children: _tabTitles
                    .map((title) => Text(title,
                    style:
                    const TextStyle(fontWeight: FontWeight.bold)))
                    .toList(),
              ),
            ),
            Expanded(
              child: _selectedTab == 0
                  ? _buildGrid(products)
                  : _selectedTab == 1
                  ? _buildList(coupons)
                  : _buildList(inventory),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              // 새로고침 로직
              setState(() {
                // 데이터 새로고침 예시
              });
            },
            backgroundColor: Colors.black,
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(List<ShopItemData> items) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, idx) {
        final item = items[idx];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(Icons.shopping_bag,
                      size: 48, color: Colors.blueGrey),
                  const SizedBox(height: 4),
                  Text(item.name,
                      style:
                      const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(item.description,
                      style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 2),
                  Text('가격: \${item.price}원',
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // 구매 로직
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('구매',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(List<ShopItemData> items) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, idx) {
        final item = items[idx];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style:
                      const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(item.description,
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
              if (_selectedTab == 2)
                Text('x\${item.count}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))
              else
                ElevatedButton(
                  onPressed: () {
                    // 쿠폰 로직
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    _selectedTab == 1 ? '다운로드' : '사용',
                    style:
                    const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String title;
  const _SettingItem(this.icon, this.title);
}

const _settingsItems = [
  _SettingItem(Icons.image_outlined, '배경사진 바꾸기'),
  _SettingItem(Icons.help_outline, '사용 설명서'),
  _SettingItem(Icons.privacy_tip_outlined, '개인정보 처리방침'),
  _SettingItem(Icons.language_outlined, '언어 선택'),
  _SettingItem(Icons.emoji_events_outlined, '도전과제'),
];