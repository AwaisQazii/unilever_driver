import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unilever_driver/app/navigation_helper.dart';
import 'package:unilever_driver/app/routes.dart';
import 'package:unilever_driver/utils/app_colors.dart';
import 'package:unilever_driver/utils/assets.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  permissionHandler() async {
    final permissions = await Permission.location.request();
  }

  initialization() async {
    permissionHandler();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );
    _controller?.forward();

    Future.delayed(
      Duration(seconds: 5),
      () {
        pushNamedRemoveAll(AppRoutes.login);
      },
    );
  }

  @override
  void initState() {
    initialization();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) {
              return Opacity(
                opacity: _animation?.value ?? 1,
                child: Transform.scale(
                  scale: _animation?.value,
                  child: child,
                ),
              );
            },
            child: Image.asset(
              AssetsPath.appLogo,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          )),
        ],
      ),
    );
  }
}
