import 'package:flutter/material.dart';

class Parent extends StatelessWidget {
  const Parent(
      {super.key,
      this.child,
      this.appBar,
      this.avoidBottomInset = false,
      this.floatingButton,
      this.bottomNavigation,
      this.drawer,
      this.endDrawer,
      this.backgroundColor,
      this.scaffoldKey,
      this.extendBodyBehindAppBar = false,
      this.bottomSafeArea = true,
      this.topSafeArea = true});
  final Widget? child;
  final PreferredSizeWidget? appBar;
  final bool avoidBottomInset;
  final Widget? floatingButton;
  final Widget? bottomNavigation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final Key? scaffoldKey;
  final bool extendBodyBehindAppBar;
  final bool bottomSafeArea;
  final bool topSafeArea;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: avoidBottomInset,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          body: SafeArea(
              bottom: bottomSafeArea,
              top: topSafeArea,
              child: child ?? const SizedBox()),
          drawer: drawer,
          endDrawer: endDrawer,
          floatingActionButton: floatingButton,
          bottomNavigationBar: bottomNavigation,
        ));
  }
}
