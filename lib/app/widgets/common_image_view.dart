import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ImageView extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width, height, radius;

  const ImageView(
      {Key? key,
        required this.url,
        required this.fit,
        this.height,
        this.radius = 5,
        this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius!),
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: const Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 11,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) => Image.asset(
          "assets/images/github_bg.png",
          fit: BoxFit.contain,
        ),
        fit: fit,
        width: width,
        height: height,
      ),
    );
  }
}