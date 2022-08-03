import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payment/app.dart';
import 'package:payment/shared/components/bloc_observer.dart';
import 'package:payment/shared/network/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}
