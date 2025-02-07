import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
    const SettingsPage({super.key});

    @override
    State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
    int _characterType = 0;
    String _version = '';

    @override
    void initState() {
        super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) {
            final box = GetStorage();
            String str = box.read('settings') ?? '{}';
            final Map<String, dynamic> settings = json.decode(str);
            setState(() {
                _characterType = settings['characterType'] ?? 0;
            });
             PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
                if (!mounted) return;
                setState(() {
                    _version = packageInfo.version;
                });
            }).onError((error, stackTrace) {
                if (!mounted) return;
                setState(() {
                    _version = 'Unknown';
                });
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text("Settings"),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        const SizedBox(height: 20),
                        Text("Chinese Characters", style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Radio<int>(
                                            value: 0,
                                            groupValue: _characterType,
                                            onChanged: (int? value) {
                                                setState(() {
                                                    _characterType = value!;
                                                    final box = GetStorage();
                                                    box.write('settings', json.encode({'characterType': _characterType}));
                                                });
                                            },
                                        ),
                                        Text("Traditional"),
                                    ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Radio<int>(
                                            value: 1,
                                            groupValue: _characterType,
                                            onChanged: (int? value) {
                                                setState(() {
                                                    _characterType = value!;
                                                    final box = GetStorage();
                                                    box.write('settings', json.encode({'characterType': _characterType}));
                                                });
                                            },
                                        ),
                                        Text("Simplified"),
                                    ],
                                ),
                            ],
                        ),
                        const SizedBox(height: 30),
                        Text("Version: $_version"),
                    ],
                ),
            ),
        );
    }
}
