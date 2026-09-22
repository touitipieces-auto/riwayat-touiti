import 'package:flutter/material.dart';

void main() => runApp(const RiwayatTouitiApp());

class RiwayatTouitiApp extends StatelessWidget {
  const RiwayatTouitiApp({super.key});

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFE2A93B);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'روايات التويتي',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090A0F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
        fontFamily: 'sans-serif',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNav = 0;
  final categories = ['الكل', 'رعب', 'غموض', 'رومانسية', 'دراما', 'خيال'];
  int selectedCategory = 0;

  final books = const [
    Book('ظل في داخلي', 'أحمد العتيبي', 'رعب', '4.8'),
    Book('بقايا حلم', 'سارة خالد', 'رومانسية', '4.6'),
    Book('المدينة المظلمة', 'كريم يوسف', 'غموض', '4.7'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _topBar()),
              SliverToBoxAdapter(child: _hero()),
              SliverToBoxAdapter(child: _sectionTitle('الروايات الجديدة', 'المزيد')),
              SliverToBoxAdapter(child: _newBooks()),
              SliverToBoxAdapter(child: _sectionTitle('الأكثر قراءة', 'المزيد')),
              SliverToBoxAdapter(child: _popularBooks()),
              const SliverToBoxAdapter(child: SizedBox(height: 110)),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNav(),
      ),
    );
  }

  Widget _topBar() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
    child: Row(
      children: [
        const Text(
          'روايات التويتي',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: Color(0xFFE6B04A)),
        ),
        const Spacer(),
        _roundIcon(Icons.search_rounded),
        const SizedBox(width: 8),
        _roundIcon(Icons.notifications_none_rounded),
      ],
    ),
  );

  Widget _hero() => Container(
    margin: const EdgeInsets.fromLTRB(18, 8, 18, 25),
    height: 205,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: const LinearGradient(
        colors: [Color(0xFF3A211A), Color(0xFF17121A), Color(0xFF101116)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      border: Border.all(color: Color(0xFF2B2932)),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 18, top: 18,
          child: Container(
            width: 125, height: 165,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFF0D1118), Color(0xFF70471B)],
                begin: Alignment.bottomLeft, end: Alignment.topRight,
              ),
            ),
            child: const Center(
              child: Text('رواية\nجديدة', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ),
        const Positioned(
          right: 22, top: 26,
          child: Text('اختيار اليوم', style: TextStyle(color: Color(0xFFE8B34D), fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const Positioned(
          right: 22, top: 56,
          child: SizedBox(
            width: 230,
            child: Text('اكتشف عوالم\nجديدة', textAlign: TextAlign.right,
              style: TextStyle(fontSize: 31, height: 1.05, fontWeight: FontWeight.w800)),
          ),
        ),
        Positioned(
          right: 22, bottom: 22,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE2A93B),
              foregroundColor: const Color(0xFF17120A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            child: const Text('تصفح الآن', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    ),
  );

  Widget _sectionTitle(String title, String action) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 7, 20, 14),
    child: Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const Spacer(),
        Text(action, style: const TextStyle(color: Color(0xFFE2A93B), fontSize: 12)),
      ],
    ),
  );

  Widget _newBooks() => SizedBox(
    height: 218,
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, i) => _bookCard(books[i]),
    ),
  );

  Widget _bookCard(Book b) => SizedBox(
    width: 145,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 155, width: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            gradient: LinearGradient(
              colors: b.category == 'رعب'
                  ? const [Color(0xFF26313E), Color(0xFF111318)]
                  : b.category == 'رومانسية'
                  ? const [Color(0xFF7B3B33), Color(0xFF181116)]
                  : const [Color(0xFF33474A), Color(0xFF111518)],
              begin: Alignment.topRight, end: Alignment.bottomLeft,
            ),
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(b.title, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          )),
        ),
        const SizedBox(height: 8),
        Text(b.title, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(b.author, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xFF99959F), fontSize: 11)),
      ],
    ),
  );

  Widget _popularBooks() => ListView.separated(
    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    itemCount: books.length,
    separatorBuilder: (_, __) => const SizedBox(height: 10),
    itemBuilder: (_, i) => Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFF12131A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF24252D)),
      ),
      child: Row(
        children: [
          Container(
            width: 58, height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: const LinearGradient(colors: [Color(0xFF584021), Color(0xFF19141A)]),
            ),
            child: const Icon(Icons.menu_book_rounded, color: Color(0xFFE2A93B)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(books[i].title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Text(books[i].author, style: const TextStyle(color: Color(0xFF99959F), fontSize: 11)),
              const SizedBox(height: 7),
              Row(children: [
                const Icon(Icons.star_rounded, size: 15, color: Color(0xFFE2A93B)),
                const SizedBox(width: 3),
                Text(books[i].rating, style: const TextStyle(fontSize: 11)),
                const SizedBox(width: 10),
                Text(books[i].category, style: const TextStyle(color: Color(0xFF99959F), fontSize: 11)),
              ]),
            ],
          )),
          const Icon(Icons.chevron_left_rounded, color: Color(0xFF77737D)),
        ],
      ),
    ),
  );

  Widget _roundIcon(IconData icon) => Container(
    width: 42, height: 42,
    decoration: BoxDecoration(
      color: const Color(0xFF12131A),
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: const Color(0xFF282932)),
    ),
    child: IconButton(onPressed: () {}, icon: Icon(icon, size: 21)),
  );

  Widget _bottomNav() => BottomNavigationBar(
    currentIndex: selectedNav,
    onTap: (i) => setState(() => selectedNav = i),
    backgroundColor: const Color(0xFF0F1016),
    selectedItemColor: const Color(0xFFE2A93B),
    unselectedItemColor: const Color(0xFF77737D),
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'الرئيسية'),
      BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'المكتبة'),
      BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'التصنيفات'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: 'المفضلة'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'حسابي'),
    ],
  );
}

class Book {
  final String title, author, category, rating;
  const Book(this.title, this.author, this.category, this.rating);
}
