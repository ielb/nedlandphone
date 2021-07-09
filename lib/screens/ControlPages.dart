import 'package:nedlandphone/Services/socket_service.dart';
import 'package:nedlandphone/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'Account.dart';
import '../config/Constants.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'MainChatRoom.dart';



class ControlPages extends StatefulWidget {
  final index ;
  ControlPages(this.index);
  @override
  _ControlPagesState createState() => _ControlPagesState();
}

class _ControlPagesState extends State<ControlPages> {
  PageController _pageController ;
  int _selectedIndex  ;
  void _onPageChanged(int index) {
    if (!mounted) return;
      setState(() {
        _selectedIndex = index;
      } );
  }
  void  _onItemTaped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
}


@override
void initState()  {   
 var user = Provider.of<AuthProvider>(context,listen: false); 
  var socketService = SocketService();
  socketService.connect(user);
    super.initState();    
  _selectedIndex =widget.index;
  _pageController = PageController(initialPage: _selectedIndex,);
}




List<Widget>  _screens= [MainChatRoom(),AccountPage() ];
List<IconData> iconList = [ Icons.home_filled,Icons.person ];

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        _onPageChanged(index);
      },
      children:  _screens,
    
    );
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      
        backgroundColor: secondColor,
      body: buildPageView(),
      bottomNavigationBar:AnimatedBottomNavigationBar(
        iconSize: 30,
        height: 50,
      gapLocation: GapLocation.center,
      icons: iconList,
      activeColor: mainColor,
      splashColor: mainColor,
      backgroundColor: firstColor,
      inactiveColor: textColor,
      activeIndex: _selectedIndex,
      leftCornerRadius: 20,
      rightCornerRadius: 20,
      onTap: _onItemTaped),
      //other params
    );
  }
}
