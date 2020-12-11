import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actors_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/models/person_cast_model.dart';
import 'package:movies_app/src/providers/movie_provider.dart';
import 'package:movies_app/src/utils/linearGradient.dart';

class PersonDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Actor actor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _appbar(actor),
      body: _getInfoPersonContent(context, actor),
    );
  }

  Widget _appbar(actor) {
    return AppBar(
        title: Text(actor.name, style: TextStyle(fontSize: 30.0)),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: linearGradient()),
        ),
        centerTitle: false);
  }

  Widget _getInfoPersonContent(context, actor) {
    final moviesProvider = new MoviesProvider();

    return Container(
      child: FutureBuilder(
          future: moviesProvider.getPersonInfo(actor.id.toString()),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return _showPersonInfo(snapshot.data);
            }
            return Container();
          }),
    );
  }

  Widget _showPersonInfo(List<PersonFilm> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        return Container(
          child: Column(
            children: [_personCard(context, items[i])],
          ),
        );
      },
    );
  }

  Widget _personCard(BuildContext context, PersonFilm film) {
    double _width = MediaQuery.of(context).size.width * 0.6;
    String releaseDate;
    film.uniqueId = '${film.id}-detail';
    if (film.releaseDate.isNotEmpty) {
      releaseDate = film.releaseDate;
    } else {
      releaseDate = 'n/a';
    }
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(05.0),
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, 'detail', arguments: film),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 60.0,
                /* height: 150.0, */
                fit: BoxFit.contain,
                image: NetworkImage(film.getPersonCastingImage()),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              width: _width,
              child: Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      film.character,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      film.originalTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      releaseDate,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Icon(Icons.star_border),
                      Text(film.voteAverage.toString()),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
