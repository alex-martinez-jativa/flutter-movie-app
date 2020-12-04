import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actors_model.dart';
import 'package:movies_app/src/providers/movie_provider.dart';
import 'package:movies_app/src/utils/linearGradient.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //argumentos recibidos desde movie horizontal por la ruta
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _createAppbar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: 10.0),
          _moviePosterTitle(context, movie),
          _movieDescription(movie),
          _getCasting(movie),
        ])),
      ],
    ));
  }

  Widget _createAppbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: linearGradient()),
        child: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            movie.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          background: FadeInImage(
            image: NetworkImage(movie.getMovieBackgroundImage()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 50),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _moviePosterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: [
        //Hero que referencia al de la anterior pagina
        Hero(
          tag: movie.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getMoviePoster()),
              height: 150.0,
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _movieDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _getCasting(Movie movie) {
    final moviesProvider = new MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _getActorsPageView(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _getActorsPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          pageSnapping: false,
          itemCount: actors.length,
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemBuilder: (context, i) => _actorCard(context, actors[i])),
    );
  }

  Widget _actorCard(BuildContext context, Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'person-detail',
                  arguments: actor),
              child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  height: 150.0,
                  fit: BoxFit.cover,
                  image: NetworkImage(actor.getCastingImage())),
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
