import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/global/app_style.dart';

class AppModal extends StatelessWidget {

  final List<Widget> children;
  final VoidCallback? onBack;
  final bool showBack;
  final AppBar? appBar;
  final bool lineOnTop;

  static Future<T?> show<T>(BuildContext context, {
    List<Widget> children = const [],
    VoidCallback? onBack,
    bool showBack = true,
    AppBar? appBar,
    bool lineOnTop = true,
  }) {
    return showModalBottomSheet<T>(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (ctx) => AppModal(
          onBack: onBack,
          showBack: showBack,
          appBar: appBar,
          lineOnTop: lineOnTop,
          children: children,
        )
    );
  }

  const AppModal({
    required this.children,
    this.onBack,
    required this.showBack,
    this.appBar,
    required this.lineOnTop,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(AppStyle.defaultPaddingVal, 0, AppStyle.defaultPaddingVal, AppStyle.defaultPaddingVal),
        decoration: const BoxDecoration(
          color: AppColor.primaryDark,
          borderRadius: BorderRadius.vertical(top: AppStyle.defaultRadius),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
