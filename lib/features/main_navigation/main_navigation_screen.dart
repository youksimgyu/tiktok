import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/features/discover/discover_screen.dart';
import 'package:tiktok/features/inbox/inbox_screen.dart';
import 'package:tiktok/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok/features/profiles/user_profile_screen.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 4;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Record video',
              ),
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  // 가운데 아이콘 버튼 꾹 누를 때 애니메이션 부분
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
    return SafeArea(
      child: Scaffold(
        // 키보드 열었을 때 화면이 위로 올라가는 것을 방지
        resizeToAvoidBottomInset: false,
        backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
        body: Stack(
          children: [
            Offstage(
              offstage: _selectedIndex != 0,
              child: const VideoTimelineScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 1,
              child: const DiscoverScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 3,
              child: const InboxScreen(),
            ),
            Offstage(
              offstage: _selectedIndex != 4,
              child: const UserProfileScreen(),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: _selectedIndex == 0 ? Colors.black : Colors.white,
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
                  selectIndex: _selectedIndex,
                ),
                NavTab(
                  text: 'Discover',
                  icon: FontAwesomeIcons.compass,
                  selectedIcon: FontAwesomeIcons.solidCompass,
                  isSelected: _selectedIndex == 1,
                  onTap: () => _onTap(1),
                  selectIndex: _selectedIndex,
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
                    child: PostVideoButton(
                      inverted: _selectedIndex != 0,
                    ),
                  ),
                ),
                Gaps.h24,
                NavTab(
                  text: 'Inbox',
                  icon: FontAwesomeIcons.message,
                  selectedIcon: FontAwesomeIcons.solidMessage,
                  isSelected: _selectedIndex == 3,
                  onTap: () => _onTap(3),
                  selectIndex: _selectedIndex,
                ),
                NavTab(
                  text: 'Profile',
                  icon: FontAwesomeIcons.user,
                  selectedIcon: FontAwesomeIcons.solidUser,
                  isSelected: _selectedIndex == 4,
                  onTap: () => _onTap(4),
                  selectIndex: _selectedIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
