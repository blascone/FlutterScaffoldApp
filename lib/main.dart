import 'package:flutter/material.dart';
import 'data/gallery_options.dart';
import 'package:bla_flutter_app/deferred_widget.dart';
import 'package:bla_flutter_app/app/app.dart' deferred as rally;
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:bla_flutter_app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:bla_flutter_app/themes/gallery_theme_data.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModelBinding(
        initialModel: GalleryOptions(
          themeMode: ThemeMode.system,
          textScaleFactor: systemTextScaleFactorOption,
          customTextDirection: CustomTextDirection.localeBased,
          locale: null,
          timeDilation: timeDilation,
          platform: defaultTargetPlatform,




        ),
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'Finance App',
              debugShowCheckedModeBanner: false,
              themeMode: GalleryOptions.of(context).themeMode,
              theme: GalleryThemeData.lightThemeData.copyWith(
                platform: GalleryOptions.of(context).platform,
              ),
              darkTheme: GalleryThemeData.darkThemeData.copyWith(
                platform: GalleryOptions.of(context).platform,
              ),
              localizationsDelegates: const [
                ...GalleryLocalizations.localizationsDelegates,
                LocaleNamesLocalizationsDelegate()
              ],
              initialRoute: "/",
              supportedLocales: GalleryLocalizations.supportedLocales,
              locale: GalleryOptions.of(context).locale,
              localeResolutionCallback: (locale, supportedLocales) {
                deviceLocale = locale;
                return locale;
              },

            home: DeferredWidget(rally.loadLibrary, () => rally.RallyApp())
          );
        }));
  }
}
