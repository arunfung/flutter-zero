import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero/providers/user.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
        ChangeNotifierProvider(create: (context) => User()),
      ],
      child: const App(),
    ));

class Counter extends ChangeNotifier {
  int number = 0;

  increment() {
    number++;
    notifyListeners();
  }
}

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

  void _incrementCounter() async {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: const Text('成功！'),
    //     duration: const Duration(seconds: 15),
    //     action: SnackBarAction(
    //       label: 'Close',
    //       onPressed: () {},
    //     ),
    //     behavior: SnackBarBehavior.floating,
    //   ),
    // );
    // final result = await showAppDialog(context);
    // print(result);

    // BottomSheet 区域显示隐藏
    _showModalBottomSheet(context);
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
              // IconButton(
              //     onPressed: _resetCounter, icon: const Icon(Icons.refresh)),
              PopupMenuButton(
                icon: const Icon(Icons.more_horiz),
                offset: const Offset(-10, 50),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'login',
                    child: Text('登录'),
                  ),
                  const PopupMenuItem(
                    value: 'regist',
                    child: Text('注册'),
                  ),
                ],
                onCanceled: () {},
                onSelected: (value) {
                  // print(value);
                },
              )
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

  Future<bool?> showAppDialog(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除'),
        content: const Text('确定要删除吗？'),
        actions: [
          TextButton(
            child: const Text('确定'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          TextButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          )
        ],
      ),
    );
  }

  dynamic _showModalBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
                const Text('你好'),
              ],
            ),
          );
        });
  }

  dynamic showDrawer() {
    final counter = Provider.of<Counter>(context);
    final user = Provider.of<User>(context);
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(children: <Widget>[
              const Text('Drawer Header'),
              Text(user.name),
            ]),
          ),
          ListTile(
            title: const Text('您点击的次数:'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(counter.number.toString()),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: const Icon(
              Icons.add,
              size: 10,
            ),
            iconSize: 10,
            onPressed: () => {
              counter.increment(),
              user.login(),
            },
          ),
        ],
      ),
      //     Center(
      //         child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     const Text('您点击的次数'),
      //     Consumer<Counter>(builder: (context, data, child) {
      //       return Text(
      //         data.number.toString(),
      //         style: Theme.of(context).textTheme.headline4,
      //       );
      //     }),
      //     IconButton(
      //       icon: const Icon(Icons.add),
      //       onPressed: () => {
      //         counter.increment(),
      //       },
      //     ),
      //   ],
      // ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: showAppBar(),
      body: pages[_currentBottomNavigationBarIndex],
      drawer: showDrawer(),
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
