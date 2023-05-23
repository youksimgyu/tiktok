import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  String submitChat = "";

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        submitChat = _textEditingController.text;
      });
    });
  }

  void _onChatSubmitted() {
    if (submitChat != "") {
      _textEditingController.clear();
      _onStopChat();
    }
  }

  void _onStopChat() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: Sizes.size20,
                foregroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                ),
                child: Text('준석'),
              ),
              Positioned(
                bottom: -1,
                right: -2,
                child: Container(
                  width: Sizes.size14,
                  height: Sizes.size14,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: const Text(
            '준석',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _onStopChat,
        child: Stack(
          children: [
            ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: Sizes.size14,
                  bottom: Sizes.size80,
                  right: Sizes.size14,
                  left: Sizes.size14,
                ),
                itemBuilder: (context, index) {
                  final isMine = index % 2 == 0;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isMine
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(Sizes.size14),
                        decoration: BoxDecoration(
                          color: isMine
                              ? Colors.blue
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(Sizes.size20),
                            topRight: const Radius.circular(Sizes.size20),
                            bottomLeft: isMine
                                ? const Radius.circular(Sizes.size20)
                                : const Radius.circular(Sizes.size5),
                            bottomRight: isMine
                                ? const Radius.circular(Sizes.size5)
                                : const Radius.circular(Sizes.size20),
                          ),
                        ),
                        child: const Text(
                          'this is a message!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 10),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                    vertical: Sizes.size10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) => _onChatSubmitted(),
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Sizes.size20),
                                bottomLeft: Radius.circular(Sizes.size20),
                                topRight: Radius.circular(Sizes.size20),
                              ),
                            ),
                            hintText: 'Send a message...',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size20,
                              vertical: Sizes.size10,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            // 아이콘 가운데로 위치하게 하기
                            suffixIcon: Container(
                              width: Sizes.size20,
                              alignment: Alignment.center,
                              child: const FaIcon(
                                FontAwesomeIcons.faceSmile,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.h14,
                      GestureDetector(
                        onTap: _onChatSubmitted,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: Sizes.size10,
                                color: submitChat.isNotEmpty
                                    ? Colors.black
                                    : Colors.grey.shade300,
                              ),
                              shape: BoxShape.circle,
                              color: submitChat.isNotEmpty
                                  ? Colors.black
                                  : Colors.grey.shade300),
                          child: FaIcon(
                            submitChat.isNotEmpty
                                ? FontAwesomeIcons.paperPlane
                                : FontAwesomeIcons.solidPaperPlane,
                            color: Colors.white,
                            size: Sizes.size20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
