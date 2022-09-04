import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter arun',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const DefaultTabController(
          length: 2, child: HomePage(title: 'Flutter Arun Home Page')),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _currentBottomNavigationBarIndex = 0;
  int _counter = 10;

  var pages = [
    TabBarView(children: [
      const Icon(Icons.explore_outlined),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('头条：'),
            // Text(
            //   '$_counter',
            // style: const TextStyle(fontSize: 50),
            // style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
    ]),
    TabBarView(children: [
      const Icon(Icons.collections),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('收藏：'),
          ],
        ),
      ),
    ]),
    TabBarView(children: [
      const Icon(Icons.person),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('我：'),
          ],
        ),
      ),
    ]),
  ];

  void _onTabBottomNavigationBar(int index) {
    setState(() {
      _currentBottomNavigationBarIndex = index;
    });
  }

  void _incrementCounter() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('成功！'),
        duration: const Duration(seconds: 15),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  dynamic showAppBar() {
    return _currentBottomNavigationBarIndex == 0
        ? AppBar(
            leading: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => {
                _scaffoldKey.currentState!.openDrawer(),
              },
            ),
            title: Image.asset(
              getIcon('avatar.png'),
              width: 40,
            ),
            actions: [
              IconButton(
                  onPressed: _resetCounter, icon: const Icon(Icons.refresh)),
            ],
            bottom: const TabBar(tabs: [
              Tab(text: '人文'),
              Tab(text: '科技'),
            ]),
          )
        : null;
  }

  dynamic showBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _currentBottomNavigationBarIndex,
        onTap: _onTabBottomNavigationBar,
        items: const [
          BottomNavigationBarItem(
              label: '头条', icon: Icon(Icons.explore_outlined)),
          BottomNavigationBarItem(label: '收藏', icon: Icon(Icons.collections)),
          BottomNavigationBarItem(label: '我', icon: Icon(Icons.person)),
        ]);
  }

  dynamic showFloatingActionButton() {
    return _currentBottomNavigationBarIndex == 0
        ? FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black87,
            child: const Icon(Icons.add_a_photo),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: showAppBar(),
      body: pages[_currentBottomNavigationBarIndex],
      drawer: const Drawer(child: Center(child: Text('text'))),
      bottomNavigationBar: showBottomNavigationBar(),
      floatingActionButton: showFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

/// 获取图片全路径
String getImg(String name) {
  return 'assets/images/$name';
}

/// 获取 icon 全路径
String getIcon(String name) {
  return 'assets/icons/$name';
}
