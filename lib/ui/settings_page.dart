import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makan_apa_app/provider/preferences_provider.dart';
import 'package:provider/provider.dart';
import '../common/styles.dart';
import '../provider/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String settingTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding:
            const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 16),
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    settingTitle,
                    style: headTextTheme1,
                  ),
                  Expanded(
                    child: _buildList(context),
                  )
                ],
            )
        )
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Dark Theme',style: headTextTheme2,),
              trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  activeColor: secondaryColor,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  }),
            ),
          ),
          Material(
            child: ListTile(
              title: const Text('Notification Restaurant',style: headTextTheme2,),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isNotificationRestaurant,
                    activeColor: secondaryColor,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledNotification(value);
                        provider.enableNotificationRestaurant(value);
                      }
                    },
                  );
                },
              ),
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
