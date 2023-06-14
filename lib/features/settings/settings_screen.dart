import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/constants/breakpoints.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: ListView(
              children: [
                SwitchListTile.adaptive(
                  value: _notifications,
                  onChanged: _onNotificationsChanged,
                  title: const Text('Adaptive(AOS/IOS) Enable Notifications'),
                ),
                SwitchListTile(
                  value: _notifications,
                  onChanged: _onNotificationsChanged,
                  title: const Text('Android Enable Notifications'),
                ),
                CheckboxListTile(
                  activeColor: Colors.black,
                  value: _notifications,
                  onChanged: _onNotificationsChanged,
                  title: const Text('Enable Notifications'),
                ),
                ListTile(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    );
                    print(date);
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    print(time);
                    final booking = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                              appBarTheme: const AppBarTheme(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black)),
                          child: child!,
                        );
                      },
                    );
                    print(booking);
                  },
                  title: const Text("What is your birthday?"),
                ),
                ListTile(
                  title: const Text('Logout (IOS)'),
                  textColor: Colors.red,
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Do you want to logout?'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('No'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: const Text('Yes'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Logout (AOS)'),
                  textColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Do you want to logout?'),
                        actions: [
                          TextButton(
                            child: const Text('No'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Logout (IOS / Bottom)'),
                  textColor: Colors.red,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: const Text('Are you sure?'),
                        message: const Text('message'),
                        actions: [
                          CupertinoActionSheetAction(
                            child: const Text('No'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            child: const Text('Yes'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const AboutListTile(),
              ],
            ),
          ),
        ));
  }
}
