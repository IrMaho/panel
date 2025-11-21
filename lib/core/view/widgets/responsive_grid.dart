import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double aspectRatio;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const ResponsiveGrid({
    super.key,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 4,
    this.spacing = 24,
    this.aspectRatio = 1.0,
    required this.itemCount,
    required this.itemBuilder,
  });

  int _getColumnCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 650) return mobileColumns;
    if (width < 1100) return tabletColumns;
    return desktopColumns;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getColumnCount(context),
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: aspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
