import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/widgets/pago_paralax.dart';
import 'package:explore/widgets/web_scrollbar.dart';
import 'package:explore/widgets/bottom_bar.dart';
import 'package:explore/widgets/carousel.dart';
import 'package:explore/widgets/destination_heading.dart';
import 'package:explore/widgets/explore_drawer.dart';
import 'package:explore/widgets/featured_heading.dart';
import 'package:explore/widgets/featured_tiles.dart';
import 'package:explore/widgets/featured_heading_pago.dart';
import 'package:explore/widgets/featured_tiles_pago.dart';
import 'package:explore/widgets/floating_quick_access_bar.dart';
import 'package:explore/widgets/responsive.dart';
import 'package:explore/widgets/top_bar_contents.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.white60,
                  onPressed: () {
                    EasyDynamicTheme.of(context).changeTheme();
                  },
                ),
              ],
              title: Container(
                height: screenSize.height / 16,
                child: ClipRRect(
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                    color: Colors.white60,
                  ),
                ),
              )

              /*Text(
                "D' livis",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 40,
                  fontFamily: 'Ello',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),*/
              )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity),
            ),
      //drawer: ExploreDrawer(),
      body: WebScrollbar(
        isAlwaysShown: ResponsiveWidget.isSmallScreen(context) ? false : true,
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: ResponsiveWidget.isSmallScreen(context) ? 10 : 15,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          //physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: _scrollPosition / 1.7,
                    child: Container(
                      child: SizedBox(
                        height: ResponsiveWidget.isSmallScreen(context)
                            ? screenSize.height * 0.35
                            : screenSize.height * 0.70,
                        width: screenSize.width,
                        child: Image.asset(
                          'assets/images/baner.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  /*    padding: EdgeInsets.only(
          top: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.height / 3.3
              : widget.screenSize.height / 1.55,*/
                  Positioned(
                    top: ResponsiveWidget.isSmallScreen(context)
                        ? screenSize.height / 2.87
                        : screenSize.height / 1.428,
                    child: Container(
                        color: Theme.of(context).backgroundColor,
                        width: screenSize.width,
                        height: screenSize.height / 1),
                  ),
                  Column(
                    children: [
                      FloatingQuickAccessBar(screenSize: screenSize),
                      Container(
                        child: Column(
                          children: [
                            FeaturedHeading(
                              screenSize: screenSize,
                            ),
                            FeaturedTiles(screenSize: screenSize)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              DestinationHeading(screenSize: screenSize),
              DestinationCarousel(),
              FeaturedHeading_pago(
                screenSize: screenSize,
              ),
              // FeaturedTiles_pago_paralax(screenSize: screenSize),
              FeaturedTiles_pago(screenSize: screenSize),
              SizedBox(height: screenSize.height / 10),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
