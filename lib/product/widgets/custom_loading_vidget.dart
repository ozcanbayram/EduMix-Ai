import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const animationUrl = ProjectText.firstAnimationUrl;

    return Padding(
      padding: const PagePadding.all(),
      child: Column(
        children: [
          const LinearProgressIndicator(color: ColorItems.project_blue),
          Center(
            child: Lottie.network(animationUrl),
          ),
        ],
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomLoadingWidget());
  }
}

class SearchIndicator extends StatelessWidget {
  const SearchIndicator({
    super.key,
  });
  static const searchAnimationUrl = ProjectText.searchAnimationUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        searchAnimationUrl,
      ),
    );
  }
}
