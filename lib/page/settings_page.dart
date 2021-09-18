import 'package:babe_resto/common/styles.dart';
import 'package:babe_resto/widgets/remove_scroll_glow.dart';

import '../data/providers/preferences_provider.dart';
import '../data/providers/scheduling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text('Dark Theme'),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: Text('Daily Reminder'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyReminderActive,
                      onChanged: (value) async {
                        scheduled.scheduledReminder(value);
                        provider.enableDailyReminder(value);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Settings',
          style: theme.textTheme.subtitle1!.copyWith(
            fontWeight: extraBold,
            color: theme.accentColor,
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: _buildList(context),
      ),
    );
  }
}
