import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_mingle/core/di/dependency_injection.dart';
import 'package:movie_mingle/core/helpers/constants.dart';
import 'package:movie_mingle/core/helpers/custom_observer.dart';
import 'package:movie_mingle/core/helpers/extensions.dart';
import 'package:movie_mingle/core/helpers/shared_pref_helper.dart';
import 'package:movie_mingle/core/routing/app_router.dart';
import 'package:movie_mingle/core/theming/colors.dart';
import 'package:movie_mingle/movie_mingle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDi();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: ColorsManager.bkColor),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await checkIfLoggedInUser();
  Bloc.observer = CustomBlocObserver();
  await ScreenUtil.ensureScreenSize();
  runApp(MovieMingle(appRouter: AppRouter()));
}

checkIfLoggedInUser() async {
  String? userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.guestSessionId,
  );
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
