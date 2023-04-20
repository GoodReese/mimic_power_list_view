import 'package:flutter/material.dart';
import 'package:mimic_power_list_view/mimic_power_list_view.dart';
import 'package:mimic_power_list_view/utils/novel_heler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white,
      body: _testView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _testView() {
    List<Widget> pageList = [];
    List<String> contentList = [
      '''1 Android，另一个软件包用于网络，另一个软件包用于汽车（作为物联网设备的例子）。除其他好处外，这种方法允许域专家扩展现有插件，以为他们最熟悉的平台工作。

联合插件需要以下软件包：

面向应用程序的软件包
插件用户依赖使用插件的软件包。此软件包指定了Flutter应用程序使用的API。
平台包
一个或多个包含特定平台实现代码的软件包。面向应用程序的软件包调用这些软件包——它们不包含在应用程序中，除非它们包含最终用户可访问的特定平台功能。
平台接口包
将面向应用程序的包装粘在平台包装上的包装。此软件包声明了任何平台软件包必须实现的接口，以支持面向应用程序的软件包。拥有定义此接口的单个软件包可确保所有平台软件包以统一的方式实现相同的功能。
''',
      '''2 理想情况下，在向联合插件添加平台实现时，您将与软件包作者协调以包括您的实现。通过这种方式，原作者认可您的实施。

例如，假设您为（想象中的）foobar插件编写foobar_windows实现。在认可的插件中，原始foobar作者将您的Windows实现添加为面向应用程序的软件包的pubspec中的依赖项。然后，当开发人员在其Flutter应用程序中包含foobar插件时，Windows实现以及其他认可的实现将自动提供给该应用程序。

非认可的联合插件
如果您出于任何原因无法让原始插件作者添加您的实现，那么您的插件不会被认可。开发人员仍然可以使用您的实现，但必须手动将插件添加到应用程序的pubspec文件中。因此，开发人员必须同时包含foobar依赖项和foobar_windows依赖项，以实现全部功能。

有关联合插件的更多信息，为什么它们有用，以及如何实现它们，请参阅Harry Terkelsen的Medium文章，如何编写Flutter Web插件，第2部分。

''',
      '''3 Android，另一个软件包用于网络，另一个软件包用于汽车（作为物联网设备的例子）。除其他好处外，这种方法允许域专家扩展现有插件，以为他们最熟悉的平台工作。

联合插件需要以下软件包：

面向应用程序的软件包
插件用户依赖使用插件的软件包。此软件包指定了Flutter应用程序使用的API。
平台包
一个或多个包含特定平台实现代码的软件包。面向应用程序的软件包调用这些软件包——它们不包含在应用程序中，除非它们包含最终用户可访问的特定平台功能。
平台接口包
将面向应用程序的包装粘在平台包装上的包装。此软件包声明了任何平台软件包必须实现的接口，以支持面向应用程序的软件包。拥有定义此接口的单个软件包可确保所有平台软件包以统一的方式实现相同的功能3。
''',
      '''4 理想情况下，在向联合插件添加平台实现时，您将与软件包作者协调以包括您的实现。通过这种方式，原作者认可您的实施。

例如，假设您为（想象中的）foobar插件编写foobar_windows实现。在认可的插件中，原始foobar作者将您的Windows实现添加为面向应用程序的软件包的pubspec中的依赖项。然后，当开发人员在其Flutter应用程序中包含foobar插件时，Windows实现以及其他认可的实现将自动提供给该应用程序。

非认可的联合插件
如果您出于任何原因无法让原始插件作者添加您的实现，那么您的插件不会被认可。开发人员仍然可以使用您的实现，但必须手动将插件添加到应用程序的pubspec文件中。因此，开发人员必须同时包含foobar依赖项和foobar_windows依赖项，以实现全部功能。

有关联合插件的更多信息，为什么它们有用，以及如何实现它们，请参阅Harry Terkelsen的Medium文章，如何编写Flutter Web插件，第4部分。

''',
    ];
    for (String content in contentList) {
      pageList.add(Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        color: Colors.white,
        child: Text(
          content,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ));
    }
    return MimicPowerListView.builder(
      key: ValueKey("hor"),
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
      semanticChildCount: pageList.length,
      addRepaintBoundaries: false,
      controller: buildNovelScrollController(ReaderTurnPageMode.simulationMode),
      layoutManager: buildNovelLayoutManager(
          ReaderTurnPageMode.simulationMode, Colors.white),
      itemBuilder: (context, index) {
        return pageList[index];
      },
      itemCount: pageList.length,
      debugTag: "MimicList",
    );
  }
}
