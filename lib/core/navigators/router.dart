import 'dart:io';

import 'package:blindside/core/navigators/routes.dart';
import 'package:blindside/feature/auth/presentation/pages/login.dart';
import 'package:blindside/feature/auth/presentation/pages/signup.dart';
import 'package:blindside/feature/dashboard/presentation/page/gallary.dart';
import 'package:blindside/feature/dashboard/presentation/page/video_details.dart';
import 'package:flutter/material.dart';

/// Generate routes for navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.loginPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const LoginPage(),
      );
    case Routes.signupPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SignupPage(),
      );

    case Routes.gallery:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const GalleryPage(),
      );
    case Routes.videoDetail:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: VideoScreen(
          videoFile: settings.arguments as Future<File?>,
        ),
      );

    default:
      return MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, required Widget viewToShow}) {
  return MaterialPageRoute<dynamic>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
