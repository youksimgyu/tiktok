import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/features/onboarding/widgets/tutorial_column.dart';

import '../../constants/sizes.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showInPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx < 0) {
      setState(() {
        _direction = Direction.left;
      });
    } else {
      setState(() {
        _direction = Direction.right;
      });
    }
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left) {
      setState(() {
        _showInPage = Page.second;
      });
    } else {
      setState(() {
        _showInPage = Page.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: SafeArea(
            child: AnimatedCrossFade(
              crossFadeState: _showInPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
              firstChild: const TutorialColumn(
                title: 'Watch cool videos!',
                text:
                    'Videos are personalized for you based on what you watch, like, and share.',
              ),
              secondChild: const TutorialColumn(
                  title: 'Follow the rules',
                  text: 'Take care of one another! Plis!'),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size24,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showInPage == Page.first ? 0 : 1,
              child: CupertinoButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: const Text('Enter the app!'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
