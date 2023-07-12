import 'package:flutter/material.dart';
import 'package:hyll_test_task/debounce.dart';
import 'package:hyll_test_task/model/adventure.dart';
import 'package:hyll_test_task/presentation/screen/feed/feed_adventure_tile.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LoadedStatusStateWidget extends StatefulWidget {
  const LoadedStatusStateWidget({
    super.key,
    required this.adventure,
    required this.refresh,
    this.loadMore,
  });

  final List<Adventure> adventure;
  final Future<void> Function() refresh;
  final void Function()? loadMore;

  @override
  State<LoadedStatusStateWidget> createState() =>
      _LoadedStatusStateWidgetState();
}

class _LoadedStatusStateWidgetState extends State<LoadedStatusStateWidget> {
  final Debounce debounce = Debounce(Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.refresh,
      child: CustomScrollView(
        slivers: [
          if (widget.adventure.isEmpty)
            SliverFillRemaining(
              fillOverscroll: false,
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'There is nothing to show right now',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (widget.adventure.isNotEmpty)
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 8,
                ),
                ...widget.adventure
                    .map<Widget>(
                      (e) => FeedAdventureTile(
                        key: ValueKey<Adventure>(e),
                        adventure: e,
                      ),
                    )
                    .toList(),
                if (widget.loadMore != null)
                  VisibilityDetector(
                      key: UniqueKey(),
                      onVisibilityChanged: (VisibilityInfo info) {
                        if (info.visibleFraction >= 1) {
                          debounce.call(() {
                            widget.loadMore?.call();
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                          ),
                        ),
                      )),
              ]),
            )
        ],
      ),
    );
  }
}
