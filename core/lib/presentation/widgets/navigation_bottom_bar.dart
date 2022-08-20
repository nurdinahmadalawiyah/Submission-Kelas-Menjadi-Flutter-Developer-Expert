import 'package:core/core.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tv_series/tv_series.dart';


class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({Key? key}) : super(key: key);

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: <Widget>[
        HomeMoviePage(),
        HomeTVSeriesPage(),
      ][_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.movie),
              title: const Text('Movies'),
              selectedColor: kMikadoYellow,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.tv),
              title: const Text('TV Series'),
              selectedColor: kMikadoYellow,
            ),
          ],
        ),
      ),
    );
  }
}
