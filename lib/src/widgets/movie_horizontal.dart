import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.30,
      child: PageView.builder(
        pageSnapping: true,
        controller: _pageController,
        /* children: _cards(context), */
        itemCount: movies.length,
        itemBuilder: (context, i) => _card(context, movies[i]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-item';

    final itemCard = Container(
        margin: EdgeInsets.only(right: 15.0, top: 15.0),
        child: Column(
          /* mainAxisAlignment: MainAxisAlignment.center, */
          children: [
            Hero(
              //tag con id unico
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    fit: BoxFit.cover,
                    height: 160.0,
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(movie.getMoviePoster())),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ));

    return GestureDetector(
      child: itemCard,
      onTap: () {
        /* print(movie.title); */
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

  /* List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
          margin: EdgeInsets.only(right: 15.0, top: 15.0),
          child: Column(
            /* mainAxisAlignment: MainAxisAlignment.center, */
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    fit: BoxFit.cover,
                    height: 160.0,
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(movie.getMoviePoster())),
              ),
              SizedBox(height: 5.0),
              Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ));
    }).toList();
  }*/
}
