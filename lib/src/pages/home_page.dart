import 'package:flutter/material.dart';
import 'package:movies_app/src/search/search_delegate.dart';
import 'package:movies_app/src/utils/linearGradient.dart';
import 'package:movies_app/src/providers/movie_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/feedback_message.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopularMovies();

    return Scaffold(
        appBar: AppBar(
          title: Text('the Movies app',
              /* style: Theme.of(context).textTheme.headline4, */
              style: TextStyle(fontSize: 30.0)),
          centerTitle: false,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                }),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: linearGradient()),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.grey[200],
                Colors.grey[100],
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_swiperCards(), _footer(context)],
          ),
        ));
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getInCinema(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasError) {
          return FeedbackMessage(
              text: snapshot.error.toString(), color: 'warning');
        }
        if (snapshot.hasData) {
          return CardSwipper(movies: snapshot.data);
        }
        return Container(
            height: 400.0, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular Movies',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))),
          StreamBuilder(
            stream: moviesProvider.popularMoviesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasError) {
                return FeedbackMessage(
                    text: snapshot.error.toString(), color: 'warning');
              }
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopularMovies,
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
