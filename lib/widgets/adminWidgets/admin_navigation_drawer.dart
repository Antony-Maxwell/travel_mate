import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_mate/data/adminPages/about.dart';
import 'package:travel_mate/data/adminPages/add_more.dart';
import 'package:travel_mate/data/adminPages/requests.dart';
import 'package:travel_mate/data/adminPages/usersLists.dart';
import 'package:travel_mate/data/drawerItems.dart';
import 'package:travel_mate/data/items/drawer_items.dart';
import 'package:travel_mate/provider/navigation_Provider.dart';
class adminNavigation extends StatelessWidget {
  const adminNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;
    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          padding: EdgeInsets.only(top: 30, left: 10),
          child: Column(
            children: [
              Container(
                child: buildHeader(isCollapsed),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
                endIndent: 10,
              ),
              SizedBox(
                height: 20,
              ),
              buildList(items: itemsFirst, isCollapsed: isCollapsed),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
                endIndent: 10,
              ),
              SizedBox(
                height: 150,
              ),
              buildList(items: itemSecond, isCollapsed: isCollapsed),
              Spacer(),
              buildCollapseIcon(context, isCollapsed),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? Icon(
          Icons.admin_panel_settings,
          size: 48,
        )
      : Row(
          children: [
            Icon(
              Icons.admin_panel_settings,
              size: 48,
            ),
            Text(
              'Admin Dashboard',
              style: TextStyle(
                fontSize: 25,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        );

  buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          child: Container(
            width: size,
            height: size,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          onTap: () {
            final provider =
                Provider.of<NavigationProvider>(context, listen: false);
            provider.toggleIsCollapsed();
          },
        ),
      ),
    );
  }

  buildList({required List<DrawerItem> items, required bool isCollapsed}) =>
      ListView.separated(
        padding: isCollapsed
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 20,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectedItem(context, index),
          );
        },
      );

  buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = const Color.fromARGB(255, 0, 0, 0);
    final leading = Icon(
      icon,
      color: color,
    );

    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(
                text,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
                ),
              ),
              onTap: onClicked,
            ),
    );
  }
}

selectedItem(BuildContext context, int index) {
  final navigateTo = (page)=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>page),);
  switch (index) {
    case 0:
    navigateTo(usersLists());
    break;
    case 1:
    navigateTo(requests());
    break;
    case 2:
    navigateTo(addMore());
    break;
    case 3:
    navigateTo(aboutApp());
    break;
    case 4:
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('LogOut'),
            content: Text('Do you really want to log out?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async{
                  // Log out logic here
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                child: Text('LogOut'),
              ),
            ],
          );
        },
      );
    break;
  }
}
