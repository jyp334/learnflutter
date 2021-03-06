/**
 * author:
 * time:2019/8/2
 * descript:
 */

import 'package:flutter/material.dart';

import 'dart:async';

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Translations {
  Translations(Locale locale) {
    this.locale = locale;

    _localizedValues = null;
  }

  Locale locale;

  static Map<dynamic, dynamic> _localizedValues;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);

    String jsonContent =
        await rootBundle.loadString("resource/${locale.languageCode}.json");

    _localizedValues = json.decode(jsonContent);

    return translations;
  }

  get currentLanguage => locale.languageCode;
}

/// 自定义的localization代表，它的作用是在验证支持的语言前，初始化我们的自定义Translations类

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    print("TranslationsDelegate locale=${locale.languageCode}");
    return ['en', 'fr', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
