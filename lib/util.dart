import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

bool isAndroid() => !kIsWeb && Platform.isAndroid;

bool isIOS() => !kIsWeb && Platform.isIOS;

bool isMacos() => !kIsWeb && Platform.isMacOS;

bool isWindows() => !kIsWeb && Platform.isWindows;

bool isLinux() => !kIsWeb && Platform.isLinux;

bool isWeb() => kIsWeb;
