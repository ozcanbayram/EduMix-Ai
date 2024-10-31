import 'package:edumix/core/constants/color_items.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const animationUrl =
        'https://lottie.host/c3a288a2-a8c2-4887-9623-0eb730256bfb/QepoZQEDa0.json';

    return Column(
      children: [
        const LinearProgressIndicator(color: ColorItems.project_blue),
        Center(
          child: Lottie.network(animationUrl),
        ),
      ],
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
  static const searchAnimationUrl =
      'https://lottie.host/c4bb20e8-5175-4d59-bd3e-9fc2c3ba6941/RoAOEbKWZh.json';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        searchAnimationUrl,
      ),
    );
  }
}
