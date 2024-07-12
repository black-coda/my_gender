import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_gender/app/views/widget/drawer.dart';
import 'package:my_gender/auth/controllers/firebase_base_provider.dart';
import 'package:my_gender/bot/view/bot_chat_screen.dart';
import 'package:my_gender/tips/views/tips_view.dart';
import 'package:my_gender/tracker/views/dashboard_view.dart';
import 'package:my_gender/users/views/edit_profile_view.dart';
import 'package:my_gender/users/views/user_profle.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
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
    final photoUrl = ref.read(firebaseProvider).currentUser?.photoURL;
    final updatedPhotoUrl = ref.watch(photoUrlProvider.notifier).state;
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
            icon: updatedPhotoUrl == null
                ? CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      photoUrl ??
                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                    ),
                  )
                : CircleAvatar(
                    radius: 15,
                    backgroundImage: MemoryImage(
                      updatedPhotoUrl,
                    ),
                  ),
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
            icon: Icon(Icons.person_rounded),
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
