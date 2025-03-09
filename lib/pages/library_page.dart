import 'package:flutter/material.dart';
import 'package:flutter_playlist_animation/utils/animation_manager.dart';
import 'package:flutter_playlist_animation/utils/library_data.dart';
import 'package:flutter_playlist_animation/widgets/featured_library_items.dart';
import 'package:flutter_playlist_animation/widgets/image_wrapper.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: AnimationManager.pageElementsAnimationDuration,
    );
    offsetAnimation = Tween(
      begin: const Offset(0, 0),
      end: const Offset(0, 1),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _customAppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: FeaturedLibraryItems(animationController: animationController),),
            Expanded(child: SlideTransition(position: offsetAnimation,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecentlyText(),
                ScrollList()
              ],
            ),
            ))
        ],
      ),
     
    );
  }
































  AppBar _customAppBar() {
    return AppBar(
      title: const Text('Sabir Bugti'),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.filter_list),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}

class ScrollList extends StatelessWidget {
  const ScrollList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).padding.bottom + 20,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: LibraryData.playlistImages.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ImageWrapper(
            image: LibraryData.playlistImages[index],
            size: 100,
          ),
        ),
      ),
    );
  }
}

class RecentlyText extends StatelessWidget {
  const RecentlyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Text(
        'Recently Played',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
