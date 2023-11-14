import 'package:boni/fragments/tracking.dart';
import 'package:boni/fragments/map.dart';
import 'package:boni/fragments/profile.dart';
import 'package:boni/fragments/search.dart';
import 'package:boni/users/preferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navigation extends StatelessWidget {
  Navigation({super.key});

  CurrentUser currentUser = Get.put(CurrentUser());

  final List<Widget> _menuItems = [
    Maps(),
    const Tracking(),
    const Search(),
    Profile()
  ];

  final List _navigationProperties = [
    {
      "active_icon": Icons.map,
      "none_active_icon": Icons.map_outlined,
      "label": "Map"
    },
    {
      "active_icon": Icons.gps_fixed,
      "none_active_icon": Icons.gps_fixed_outlined,
      "label": "Tracking"
    },
    {
      "active_icon": Icons.search,
      "none_active_icon": Icons.search_outlined,
      "label": "Search"
    },
    {
      "active_icon": Icons.person,
      "none_active_icon": Icons.person_outline,
      "label": "Profile"
    }
  ];

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CurrentUser(),
        initState: (currentState) {
          currentUser.getUserInfo();
        },
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
                child: Obx(
              () => _menuItems[_indexNumber.value],
            )),
            bottomNavigationBar: Obx(() => BottomNavigationBar(
                  currentIndex: _indexNumber.value,
                  onTap: (value) {
                    _indexNumber.value = value;
                  },
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white,
                  backgroundColor: Colors.black,
                  items: List.generate(4, (index) {
                    var navProperties = _navigationProperties[index];
                    return BottomNavigationBarItem(
                        backgroundColor: Colors.black,
                        icon: Icon(
                          navProperties["non_active_icon"],
                          color: Colors.white,
                        ),
                        activeIcon: Icon(
                          navProperties["active_icon"],
                          color: Colors.white,
                        ),
                        label: navProperties["label"]);
                  }),
                )),
          );
        });
  }
}
