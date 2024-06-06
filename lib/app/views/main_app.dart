import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_gender/app/views/widget/drawer.dart';
import 'package:my_gender/bot/view/bot_chat_screen.dart';
import 'package:my_gender/tips/controllers/tips_controller.dart';
import 'package:my_gender/tips/views/tips_view.dart';
import 'package:my_gender/users/backend/user_profle.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    TipsView(),
    BotChatView(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyGender',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontFamily: "DS",
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      drawer: const MainViewDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates_rounded),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bots),
            label: 'MyGender Bot',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.outline,
        onTap: _onItemTapped,
      ),
    );
  }
}
