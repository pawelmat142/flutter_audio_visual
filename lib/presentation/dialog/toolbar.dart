import 'package:flutter/material.dart';
import 'package:flutter_audio_visual/services/extension.dart';

class ToolBarItem {
  ToolBarItem({
    required this.label,
    this.menuLabel,
    required this.icon,
    this.disabled = false,
    required this.onTap,
    this.color,
  });

  String label;
  String? menuLabel;
  IconData icon;
  bool disabled;
  VoidCallback onTap;
  Color? color;
}

class Toolbar extends StatelessWidget {

  final List<ToolBarItem> toolbarItems;
  final List<ToolBarItem>? menuItems;
  final Color defaultColor;
  final Color defaultLabelColor;
  final Color defaultMenuLabelColor;

  const Toolbar({
    required this.toolbarItems,
    this.menuItems,
    this.defaultColor = Colors.blueAccent,
    this.defaultLabelColor = Colors.black54,
    this.defaultMenuLabelColor = Colors.black87,
    Key? key}) : super(key: key);


  Iterable<ToolBarItem> get _menuItemsFromToolbarItems => toolbarItems
      .where((toolbarItem) => toolbarItem.menuLabel?.isNotEmpty ?? false);

  List<ToolBarItem> get _menuItems => [...(menuItems ?? []), ..._menuItemsFromToolbarItems];

  List<ToolBarItem> _toolbarItems(BuildContext context) => _menuItems.isEmpty
      ? toolbarItems
      : [...toolbarItems, menuToolbarItem(context)];

  static const String menuLabel = 'menu';

  ToolBarItem menuToolbarItem(BuildContext context) => ToolBarItem(
    label: menuLabel,
    icon: Icons.menu,
    color: defaultColor,
    onTap: () {
      _onToolbarMenu(context);
    }
  );

  int currentIndex(BuildContext context) {
    final i = _toolbarItems(context).indexWhere((item) => item.label == menuLabel);
    return i == -1 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex(context),
      elevation: 10,
      selectedItemColor: defaultLabelColor,
      unselectedItemColor: defaultLabelColor,
      // selectedLabelStyle: AppStyle.listTileSubtitle,
      // unselectedLabelStyle: AppStyle.listTileSubtitle,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (i) => _onItemTap(i, context),
      items: _toolbarItems(context).map((i) => BottomNavigationBarItem(
        icon: Icon(i.icon,
          color: i.disabled ? Colors.black26 : i.color ?? defaultColor
        ),
        label: i.label.capitalize(),
      )).toList(),
    );
  }

  _onItemTap(int i, BuildContext context) {
    final item = _toolbarItems(context)[i];
    if (item.label == menuLabel) {
      _onToolbarMenu(context);
    } else {
      final ToolBarItem tappedItem = _toolbarItems(context)[i];
      if (tappedItem.disabled) return;
      tappedItem.onTap();
    }
  }

  _onToolbarMenu(BuildContext context) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Menu'),
        content: Column(children: _menuItems.map((menuItem) => ListTile(
          title: Text(
            (menuItem.menuLabel ?? menuItem.label).capitalize(),
            style: TextStyle(color: menuItem.color ?? defaultMenuLabelColor,)
          ),
          trailing: Icon(menuItem.icon, color: menuItem.color ?? defaultColor,),
          onTap: () {
            Navigator.pop(ctx);
            menuItem.onTap();
          },
        )).toList())
    ));
  }

}
