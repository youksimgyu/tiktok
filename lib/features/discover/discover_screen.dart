import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

final tabs = [
  "Top",
  "User",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late TabController _tabController;
  String _search = '';
  bool _isWriting = false;

  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {
    if (_search != "") {
      // 검색 결과 페이지로 이동
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _search = _textEditingController.text;
      });
    });
  }

  void _onTextFiledPressed() {
    setState(() {
      _isWriting = true;
    });
  }

  void _onClearTap() {
    _textEditingController.clear();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onTabBar(int index) {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: _onScaffoldTap,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: Sizes.size20,
                ),
                Gaps.h20,
                Expanded(
                  child: TextField(
                    onTap: _onTextFiledPressed,
                    controller: _textEditingController,
                    onChanged: _onSearchChanged,
                    onSubmitted: _onSearchSubmitted,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(Sizes.size5),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size10,
                      ),
                      prefixIcon: Container(
                        width: Sizes.size20,
                        alignment: Alignment.center,
                        child: const FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.black,
                          size: Sizes.size20,
                        ),
                      ),
                      suffixIcon: _isWriting
                          ? GestureDetector(
                              onTap: _onClearTap,
                              child: Container(
                                width: Sizes.size20,
                                alignment: Alignment.center,
                                child: const FaIcon(
                                  FontAwesomeIcons.solidCircleXmark,
                                  color: Colors.black38,
                                  size: Sizes.size20 + Sizes.size2,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                Gaps.h20,
                // 슬라이드 부분
                const FaIcon(
                  FontAwesomeIcons.sliders,
                  size: Sizes.size24,
                ),
              ],
            ),
            bottom: TabBar(
              // TacBarView 연동
              onTap: _onTabBar,
              // 호버같은 역할 없앰
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              indicatorColor: Colors.black,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.builder(
                // 스크롤시 키보드 내려감
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(
                  Sizes.size6,
                ),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 19.2,
                ),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4)),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          placeholderFit: BoxFit.cover,
                          fit: BoxFit.cover,
                          placeholder: "assets/images/placeholder.png",
                          image:
                              "https://blog.kakaocdn.net/dn/OspVI/btqJG96yRGN/qOU3e4h2mDICEmMhJPBif0/img.jpg",
                        ),
                      ),
                    ),
                    Gaps.v8,
                    const Text(
                      "그림에 대한 내용 깁니다 그림에 대한 내용 깁니다 그림에 대한 내용 깁니다 그림에 대한 내용 깁니다",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Sizes.size12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v3,
                    DefaultTextStyle(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size4,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/92096204?v=4",
                              ),
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                "내 아바타 이름이 깁니다",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Sizes.size12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            const Text(
                              "2.9M",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
