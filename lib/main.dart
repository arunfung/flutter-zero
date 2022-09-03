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
  int _counter = 10;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => {},
        ),
        title: Image.asset(
          getIcon('avatar.png'),
          width: 40,
        ),
        actions: [
          IconButton(onPressed: _resetCounter, icon: const Icon(Icons.refresh)),
        ],
        bottom: const TabBar(tabs: [
          Tab(text: '人文'),
          Tab(text: '科技'),
        ]),
      ),
      body: TabBarView(children: [
        const Icon(Icons.book),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('你点击的次数：'),
              Text(
                '$_counter',
                // style: const TextStyle(fontSize: 50),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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
