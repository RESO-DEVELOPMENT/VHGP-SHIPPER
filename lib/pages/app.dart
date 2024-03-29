// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/appProvider.dart';
import '../widgets/bottom_navbar.dart';
import 'contact_page.dart';
import 'history_page.dart';
import 'home_page.dart';
import 'list_order_aceept_page.dart';
import 'transaction_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  var _currentTab = TabItem.home;

  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.order: GlobalKey<NavigatorState>(),
    TabItem.history: GlobalKey<NavigatorState>(),
    TabItem.transaction: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  //AppBar appBar = Null;

  // void registerNotification() async {
  //   await Firebase.initializeApp();
  //   messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(alert: true, badge: true, provisional: false, sound: true);
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     fcmListener = FirebaseMessaging.onMessage.asBroadcastStream().listen((RemoteMessage message) {
  //       print("on app");
  //       PushNotificationModel notification =
  //           PushNotificationModel(title: message.notification!.title, body: message.notification!.body, dataTitle: message.data['title'], dataBody: message.data['body']);

  //       setState(() {
  //         _notificationInfo = notification;
  //       });
  //       print("body: ${notification.body}");
  //       print("title: ${notification.title}");
  //       _showNotification(_notificationInfo.title!, _notificationInfo.body!);
  //     });
  //   } else {
  //     print("not permission");
  //   }
  // }

  // Future<void> _showNotification(String title, String content) async {
  //   final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('your channel id', 'your channel name',
  //       channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, icon: '@drawable/logoicon', tag: "Cộng Đồng Chung Cư", ticker: 'ticker');

  //   final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(0, title, content, platformChannelSpecifics, payload: 'item x');
  // }

  @override
  void initState() {
    // var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettingsIOS = DarwinInitializationSettings();
    // var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (value) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => RootApp()));
    // });

    // registerNotification();
    // checkForInitialMessage();
    super.initState();
    print("init");
  }

  // checkForInitialMessage() async {
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => RootApp()));
  //     });
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<AppProvider>(builder: (context, provider, child) {
    return WillPopScope(onWillPop: () async {
      // if (provider.getIsLogin == true) {
      final isFirstRouteInCurrentTab =
          !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
      if (isFirstRouteInCurrentTab) {
        // if not on the 'main' tab
        if (_currentTab != TabItem.home) {
          // select 'main' tab
          _selectTab(TabItem.home);
          // back button handled by app
          return false;
        }
      }
      // let system handle back button if we're on the first route
      return isFirstRouteInCurrentTab;
    },
        // },
        child: Consumer<AppProvider>(builder: (context, provider, child) {
      var storeId = context.read<AppProvider>().getUserId ?? "";
      List<Widget> widgetOptions = <Widget>[
        HomePage(),
        ListOrderAceeptPage(),
        HistoryPage(),
        TransactionPage(),
        ContactPage(),
      ];
      return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: widgetOptions.elementAt(_currentTab.index),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              primaryColor: Colors.red,
            ),
            child: BottomNavbar(
              currentTab: _currentTab,
              onSelectTab: _selectTab,
            ),
          ));
    }));
    // });
  }
}
