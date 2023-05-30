import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/features/videos/widgets/video_button.dart';
import 'package:tiktok/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class VideoPost extends StatefulWidget {
  final int index;

  const VideoPost({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/video3.mp4');

  final Duration _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;
  bool _isPaused = false;
  bool isExpanded = false;
  String text = '준석이 좀 보세요 준석이 좀 보세요!!! 준석이 좀 보세요 준석이 좀 보세요!!!';

  // 동영상이 끝나는 조건
  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {}
    }
  }

  // 동영상 플레이어 초기화
  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();

    // 동영상 루프돌게
    await _videoPlayerController.setLooping(true);

    // 동영상이 끝나면 페이지 이동 읽어줌
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _initAnimationController();
  }

  // 애니메이션 컨트롤러 정의
  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    // 1번 방법
    /*_animationController.addListener(() {
      // build 하도록 체크 -> 변경값 계속 찍음
      setState(() {});
    });*/
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  // 다른 페이지 이동시 완전히 이동되면 info.visibleFraction 의 값이 1이 되고 재생
  // 이동중 다음 페이지 동영상 재생 안되도록
  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    // 다른 탭으로 이동 시 재생중이면 멈춤
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _videoPlayerController.pause();
    }
  }

  // 정지시 재생아이콘 없앰
  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      // 애니메이션 컨트롤러 up -> low
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      // 애니메이션 컨트롤러 low -> up
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onExpandedTap() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  // 댓글 버튼 누르면 댓글창 뜨게
  void _onCommentTap() async {
    // await 끝나는 시점은 댓글창이 닫히는 시점 (VideoComments)
    await showModalBottomSheet(
      // 사이즈 변경 가능하도록 변경
      isScrollControlled: true,
      // 투명색
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const VideoComments(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 15,
            child: SizedBox(
              width: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '@준석',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v10,
                  GestureDetector(
                    onTap: _onExpandedTap,
                    child: Text(
                      text,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      maxLines: isExpanded ? null : 1,
                      style: const TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 15,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/92096204?v=4'),
                  child: Text('준석'),
                ),
                Gaps.v24,
                const VideoButton(
                  text: '2.9M',
                  icon: FontAwesomeIcons.solidHeart,
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onCommentTap,
                  child: const VideoButton(
                    text: '33K',
                    icon: FontAwesomeIcons.solidComment,
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  text: 'Share',
                  icon: FontAwesomeIcons.share,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
