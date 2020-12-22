import 'package:flutter/material.dart';
import 'package:movies_flutter_app/models/movie_list_model.dart';
import 'package:movies_flutter_app/screens/movie_details_page.dart';
import 'package:movies_flutter_app/services/movie_list_services.dart';
import 'package:movies_flutter_app/utils/constants.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  Future<MovieListModel> _movieListModel;

  var getImagesAPI = 'https://image.tmdb.org/t/p/original';

  @override
  void initState() {
    setState(() {
      _movieListModel = MovieListService().getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('All Movies'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        child: allMoviesList(),
      ),
    );
  }

  Widget allMoviesList() {
    return FutureBuilder<MovieListModel>(
        future: _movieListModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.results.length != 0
                ? new ListView.builder(
                    itemCount: snapshot.data.results.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctxt, int i) {
                      return Container(
                        margin: EdgeInsets.only(
                            top: 15, bottom: 5, left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: kListColor,
                            borderRadius: BorderRadius.circular(16.0)),
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.network(
                              "${getImagesAPI + snapshot.data.results[i].backdropPath}",
                              height: 60.0,
                              width: 60.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            '${snapshot.data.results[i].title}',
                            style: TextStyle(
                              color: kTitleColor,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data.results[i].overview}',
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Popularity : ${snapshot.data.results[i].popularity}',
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${snapshot.data.results[i].voteAverage}',
                                  style: TextStyle(
                                    color: kTitleColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]))
                            ],
                          ),
                          onTap: () {
                            var id = snapshot.data.results[i].id;
                            var title = snapshot.data.results[i].title;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetailsPage(
                                        id: id, title: title)));
                          },
                        ),
                      );
                    })
                : Center(
                    child: Text(
                      'No Data Found',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
