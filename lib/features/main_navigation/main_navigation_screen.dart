import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok/features/main_navigation/widgets/post_video_button.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final screens = [
    const Center(
      child: Text(
        'Home',
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        'Discover',
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    Container(),
    const Center(
      child: Text(
        'Inbox',
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'Record video',
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = Tween<double>(begin: 1, end: 1.4).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: screens.elementAt(_selectedIndex),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: screens.elementAt(_selectedIndex),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: screens.elementAt(_selectedIndex),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: screens.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: 'Home',
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: 'Discover',
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              Transform.scale(
                scale: _animation.value,
                child: GestureDetector(
                  onTapDown: (_) {
                    _controller.forward();
                  },
                  onTapUp: (_) {
                    _controller.reverse();
                  },
                  onTapCancel: () {
                    _controller.reverse();
                  },
                  onTap: _onPostVideoButton,
                  child: const PostVideoButton(),
                ),
              ),
              Gaps.h24,
              NavTab(
                text: 'Inbox',
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: 'Profile',
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 4,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
