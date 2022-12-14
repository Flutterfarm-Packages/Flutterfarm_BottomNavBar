import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

class BottomIndicatorNavigationBarItem {
  final IconData? icon;
  final Color backgroundColor;

  BottomIndicatorNavigationBarItem({
    required this.icon,
    this.backgroundColor = Colors.white,
  });
}

class HomePageWithIndicatorBar extends StatefulWidget {
  @override
  State createState() => _HomePageWithIndicatorBarState();
}

class _HomePageWithIndicatorBarState extends State<HomePageWithIndicatorBar> {
  final List<BottomIndicatorNavigationBarItem> items = [
    BottomIndicatorNavigationBarItem(icon: Icons.home),
    BottomIndicatorNavigationBarItem(icon: Icons.search),
    BottomIndicatorNavigationBarItem(icon: Icons.settings),
    BottomIndicatorNavigationBarItem(icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Indicator Bottom Bar"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: BottomIndicatorBar(
        currentIndex: 1,
        onTap: (index) => print("Selected Index: $index"),
        items: items,
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
        indicatorColor: Colors.teal,
      ),
    );
  }
}

class BottomIndicatorBar extends StatefulWidget {
  final Color indicatorColor;
  final Color activeColor;
  final Color inactiveColor;
  final bool shadow;
  int currentIndex;
  IconData? iconData;
  final ValueChanged<int> onTap;
  final List<BottomIndicatorNavigationBarItem> items;

  BottomIndicatorBar({
    Key? key,
    required this.onTap,
    required this.items,
    this.activeColor = Colors.teal,
    this.inactiveColor = Colors.grey,
    this.indicatorColor = Colors.grey,
    this.shadow = true,
    this.currentIndex = 0,
    this.iconData,
  }) : super(key: key);

  @override
  State createState() => _BottomIndicatorBarState();
}

class _BottomIndicatorBarState extends State<BottomIndicatorBar> {
  static const double BAR_HEIGHT = 60;
  static const double INDICATOR_HEIGHT = 2;

  List<BottomIndicatorNavigationBarItem> get items => widget.items;
  int index = 0;
  double width = 0;
  late Color activeColor;
  Duration duration = Duration(milliseconds: 170);

  double? _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr)
      return lerpDouble(-1.0, 1.0, index / (items.length - 1));
    else
      return lerpDouble(1.0, -1.0, index / (items.length - 1));
  }

  @override
  void initState() {
    super.initState();
    widget.iconData = widget.items[0].icon;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    activeColor = widget.activeColor;

    return Container(
      height: BAR_HEIGHT + MediaQuery.of(context).viewPadding.bottom,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: widget.shadow
            ? [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ]
            : null,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            top: INDICATOR_HEIGHT,
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: items.map((item) {
                    index = items.indexOf(item);
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () => _select(index, item),
                          child: _buildItemWidget(
                              item, index == widget.currentIndex),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          /*   Positioned(
          top: 0,
          width: width,
          child: AnimatedAlign(
            alignment:
            Alignment(_getIndicatorPosition(widget.currentIndex)!, 0),
            curve: Curves.linear,
            duration: duration,
            child: Container(
              color: widget.indicatorColor,
              width: width / items.length,
              height: INDICATOR_HEIGHT,
            ),
          ),
        ),*/
        ],
      ),
    );
  }

  _select(int index, BottomIndicatorNavigationBarItem item) {
    widget.currentIndex = index;
    widget.iconData = item.icon;
    widget.onTap(widget.currentIndex);

    setState(() {});
  }

  Widget _setIcon(BottomIndicatorNavigationBarItem item) {
    return Icon(
      item.icon,
      color: widget.iconData == item.icon ? activeColor : widget.inactiveColor,
      size: 35.0,
    );
  }

  Widget _buildItemWidget(
      BottomIndicatorNavigationBarItem item, bool isSelected) {
    return Container(
      color: item.backgroundColor,
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _setIcon(item),
        ],
      ),
    );
  }
}
