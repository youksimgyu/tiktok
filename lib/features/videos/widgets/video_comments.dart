import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({Key? key}) : super(key: key);

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isLiked = false;

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  // 버튼 누르면 하트 색 바뀌게 빨간색 채워진 하트
  void _onLikePressed() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        // borderRadius 상단만 적용
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Sizes.size28),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text('22796 comments'),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
            vertical: Sizes.size10,
          ),
          separatorBuilder: (context, index) => Gaps.v20,
          itemCount: 10,
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                child: Text('A'),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Gaps.v3,
                    const Text(
                      'Comment text Comment text Comment text Comment text Comment text',
                    ),
                  ],
                ),
              ),
              Gaps.h10,
              GestureDetector(
                onTap: _onLikePressed,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _isLiked
                        ? FaIcon(
                            // 누르면 빨간색 하트
                            FontAwesomeIcons.solidHeart,
                            size: Sizes.size20,
                            color: Theme.of(context).primaryColor,
                          )
                        : FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                            color: Colors.grey.shade500,
                          ),
                    Gaps.v3,
                    Text(
                      '52.2K',
                      style: TextStyle(
                        fontSize: Sizes.size12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade500,
                foregroundColor: Colors.white,
                child: const Text('A'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
