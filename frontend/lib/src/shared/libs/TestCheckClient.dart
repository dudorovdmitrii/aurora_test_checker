import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'LogInterceptor.dart';
import 'log/log.dart';

const testCheckClient = Named('TestCheckClient');

Dio createTestCheckClient(Log logger) {
  final Dio client = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080',
    ),
  )..interceptors.addAll([logInterceptor(logger)]);

  return client;
}
