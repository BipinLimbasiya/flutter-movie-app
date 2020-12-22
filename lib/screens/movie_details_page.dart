import 'package:flutter/material.dart';
import 'package:movies_flutter_app/models/movie_details_model.dart';
import 'package:movies_flutter_app/services/movie_details_services.dart';
import 'package:movies_flutter_app/utils/constants.dart';

class MovieDetailsPage extends StatefulWidget {
  var id;
  var title;
  MovieDetailsPage({Key key, @required this.id, this.title}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState(id, title);
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  var getImagesAPI = 'https://image.tmdb.org/t/p/original';
  var id;
  var title;
  _MovieDetailsPageState(this.id, this.title);

  Future<MovieDetailsModel> _movieDetailsModel;

  @override
  void initState() {
    setState(() {
      // MovieDetailsService.getData(id).then((value) => {});
      _movieDetailsModel = MovieDetailsService().getData(id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // title: Text('$title',
        //     style: TextStyle(color: kMainColor, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kMainColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 15, bottom: 5, left: 20, right: 20),
          child: allMoviesList(),
        ),
      ),
    );
  }

  Widget allMoviesList() {
    return FutureBuilder<MovieDetailsModel>(
        future: _movieDetailsModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.id != null || snapshot.data.id != 0
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${snapshot.data.genres.isEmpty ? '' : snapshot.data.genres[0].name}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Text('${snapshot.data.status}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            new BoxShadow(
                              color: Colors.grey,
                              blurRadius: 22.0,
                            ),
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Image.network(
                              '${getImagesAPI + snapshot.data.backdropPath}',
                              height: 230.0,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Text('$title',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Spacer(),
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
                                text: '${snapshot.data.voteAverage}',
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]))
                          ],
                        ),
                        SizedBox(height: 5),
                        Text('Release Date : ${snapshot.data.releaseDate}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        SizedBox(height: 5),
                        Text('Popularity : ${snapshot.data.popularity}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        SizedBox(height: 5),
                        Text('Budget : ${snapshot.data.budget}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        SizedBox(height: 20),
                        Text('Overview',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('${snapshot.data.overview}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        SizedBox(height: 20),
                        Text('Tagline',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('${snapshot.data.tagline}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ],
                    ),
                  )
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
