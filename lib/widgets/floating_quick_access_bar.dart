import 'package:explore/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:ant_icons/ant_icons.dart';
import 'dart:html' as html;

class FloatingQuickAccessBar extends StatefulWidget {
  const FloatingQuickAccessBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  _FloatingQuickAccessBarState createState() => _FloatingQuickAccessBarState();
}

class _FloatingQuickAccessBarState extends State<FloatingQuickAccessBar> {
  List _isHovering = [false, false, false, false];
  List<Widget> rowElements = [];
  /*https://www.instagram.com/winee.lingerie/ */
  List<String> items = [
    'WhatsApp',
    'Instagram',
  ];
  List<String> link = [
    'https://wa.me/556294869599',
    'https://www.instagram.com/dlivismoda_intima/',
  ];
  List<IconData> icons = [
    AntIcons.phone_outline,
    AntIcons.instagram_outline,
    //Icons.art_track_outlined,
  ];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () {
          print("abre");
          html.window.open(link[i], items[i]);
        },
        child: Text(
          items[i],
          style: TextStyle(
            color: _isHovering[i]
                ? Theme.of(context).primaryTextTheme.button!.decorationColor
                : Theme.of(context).primaryTextTheme.button!.color,
          ),
        ),
      );
      Widget spacer = SizedBox(
        height: ResponsiveWidget.isSmallScreen(context)
            ? widget.screenSize.height / 20
            : widget.screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }

    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.height / 3.3
              : widget.screenSize.height / 1.55,
          left: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
          right: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
        ),
        child: ResponsiveWidget.isSmallScreen(context)
            ? Column(
                children: [
                  ...Iterable<int>.generate(items.length).map(
                    (int pageIndex) => Padding(
                      padding:
                          EdgeInsets.only(top: widget.screenSize.height / 100),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          print("abre");
                          html.window.open(link[pageIndex], items[pageIndex]);
                        },
                        child: Card(
                          color: Theme.of(context).cardColor,
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: widget.screenSize.height / 45,
                                bottom: widget.screenSize.height / 45,
                                left: widget.screenSize.width / 20),
                            child: Row(
                              children: [
                                Icon(
                                  icons[pageIndex],
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                SizedBox(width: widget.screenSize.width / 20),
                                Text(
                                  items[pageIndex],
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .button!
                                          .color,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.screenSize.height / 50,
                    bottom: widget.screenSize.height / 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: generateRowElements(),
                  ),
                ),
              ),
      ),
    );
  }
}
