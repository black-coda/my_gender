import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_gender/tips/model/tip_model.dart';
import 'package:my_gender/utils/constants/konstant.dart';

class VideoCardWidget extends StatelessWidget {
  const VideoCardWidget({
    super.key,
    required this.tipsVideoModel,
  });

  final TipsVideoModel tipsVideoModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          // height: MediaQuery.of(context).size.height * 0.1,
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: tipsVideoModel.thumbnail.startsWith('data:image')
                        ? MemoryImage(
                            base64Decode(
                                tipsVideoModel.thumbnail.split(',')[1]),
                          )
                        : NetworkImage(
                            tipsVideoModel.thumbnail,
                          ),
                  )),
              width: 120,
            ),
            title: Text(tipsVideoModel.title,
                style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(tipsVideoModel.source,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary)),
                Konstant.sizedBoxHeight2,
                Text(tipsVideoModel.length,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary))
              ],
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
