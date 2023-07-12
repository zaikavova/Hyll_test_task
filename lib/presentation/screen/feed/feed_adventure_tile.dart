import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hyll_test_task/model/adventure.dart';
import 'package:hyll_test_task/model/content.dart';

class FeedAdventureTile extends StatelessWidget {
  const FeedAdventureTile({super.key, required this.adventure});

  final Adventure adventure;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(adventure.title),
              if (adventure.shortDescription != null)
                Text(adventure.shortDescription ?? ''),
              SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16,
                spacing: 16,
                children: [
                  ...adventure.contents.take(4).map<Widget>((Content e) {
                    switch (e.type) {
                      case ContentType.image:
                        return CachedNetworkImage(
                          imageUrl: e.resourceUrl,
                          width: MediaQuery.of(context).size.width / 3,
                        );
                      default:
                        return SizedBox();
                    }
                  })
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      );
}
