import 'package:flutter/material.dart';

import '../widgets/brand_mark.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.onIndexChanged,
  });
  final Widget child;
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;
  static const items = [
    (Icons.home_rounded, 'الرئيسية'),
    (Icons.chat_bubble_rounded, 'المحادثة'),
    (Icons.workspace_premium_rounded, 'الاشتراك'),
    (Icons.settings_rounded, 'الإعدادات'),
    (Icons.person_rounded, 'الملف الشخصي'),
    (Icons.login_rounded, 'تسجيل الدخول'),
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide = constraints.maxWidth >= 800;
      return Scaffold(
        appBar: wide ? null : AppBar(title: const BrandMark(compact: true)),
        body: Row(
          children: [
            if (wide)
              _Sidebar(
                selectedIndex: selectedIndex,
                onIndexChanged: onIndexChanged,
              ),
            Expanded(child: child),
          ],
        ),
        bottomNavigationBar: wide
            ? null
            : NavigationBar(
                selectedIndex: selectedIndex > 4 ? 0 : selectedIndex,
                onDestinationSelected: onIndexChanged,
                destinations: items
                    .take(5)
                    .map(
                      (item) => NavigationDestination(
                        icon: Icon(item.$1),
                        label: item.$2,
                      ),
                    )
                    .toList(),
              ),
      );
    },
  );
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.selectedIndex, required this.onIndexChanged});
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;
  @override
  Widget build(BuildContext context) => NavigationRail(
    selectedIndex: selectedIndex,
    onDestinationSelected: onIndexChanged,
    labelType: NavigationRailLabelType.all,
    leading: const Padding(
      padding: EdgeInsets.only(bottom: 28),
      child: BrandMark(),
    ),
    destinations: AppShell.items
        .map(
          (item) => NavigationRailDestination(
            icon: Icon(item.$1),
            label: Text(item.$2),
          ),
        )
        .toList(),
  );
}
