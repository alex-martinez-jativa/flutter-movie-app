import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actors_model.dart';
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

  Widget _showPersonInfo(List<Person> items) {
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

  Widget _personCard(BuildContext context, Person actor) {
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
                image: NetworkImage(actor.getPersonCastingImage()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
