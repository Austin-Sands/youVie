//(c) 2017 serenader
//This file contains code licensed under MIT license (see licenses/CAROUSEL.LICENSE.TXT)

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:youvie/api/api_config.dart';
import 'package:youvie/models/movie.dart';
import "package:youvie/api/fetch_service.dart";
import "package:youvie/models/genres.dart";

class Carousel extends StatefulWidget {
  const Carousel({
    super.key,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final CarouselController _controller = CarouselController();
  late Future<List<Movie>> movies;

  int _current = 0;

  @override
  void initState() {
    super.initState();
    movies = FetchService().fetchMovies();
  }

  void _update(int index) {
    setState(() {
      _current = index;
    });
  }

  // void _onButtonPress(String buttonName) {
  //   setState(() {
  //     print(buttonName);
  //   });
  // } 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: FutureBuilder(
            future: movies, 
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()),);
              } else if(snapshot.hasData) {
                return RecommendationsCarousel(controller: _controller, updateIndex: _update, snapshot: snapshot,);
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(10, _current),
          ),
        ),
        SizedBox(
          height: 380,
          child: FutureBuilder(
            future: movies, 
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()),);
              } else if(snapshot.hasData) {
                return InformationCarousel(index: _current, snapshot: snapshot);
              } else{
                return const Text('No data to show');
              }
            }
          ),
        ),
      ],
    );
  }
}

class InformationCarousel extends StatelessWidget {
  final int index;
  final AsyncSnapshot snapshot;
  static const double spacerSize = 10;

  const InformationCarousel({
    super.key,
    required this.index, 
    required this.snapshot
  });

  @override
  Widget build(BuildContext context) {
    var item = snapshot.data[index];

    return Column(
      children: [
        TitleRow(item: item),
        const SizedBox(height: spacerSize,),
        ReleaseRatingRow(item: item),
        const SizedBox(height: spacerSize,),
        GenreRow(item: item),
        const SizedBox(height: spacerSize,),
        OverviewCard(item: item),
      ]
    );
  }

}

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.overview, style: Theme.of(context).textTheme.bodyMedium,),
      ),
    );
  }
}

class GenreRow extends StatelessWidget {
  const GenreRow({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Genre(s): ${parseGenres(item.genres)}', style: Theme.of(context).textTheme.labelMedium,)
      ],
    );
  }
}

class ReleaseRatingRow extends StatelessWidget {
  const ReleaseRatingRow({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text('Released: ${item.releaseDate}', style: Theme.of(context).textTheme.labelMedium,),
        const Spacer(),
        const Icon(
          Icons.star_rate,
          //color: Colors.yellow,
        ),
        Text(
          'Rating: ${item.voteAverage.toStringAsPrecision(2)}', 
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const Spacer(),
      ],
    );
  }
}

class TitleRow extends StatelessWidget {
  const TitleRow({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            '${item.title}', 
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          )
        ),
      ],
    );
  }
}

class RecommendationsCarousel extends StatelessWidget {
  final ValueChanged<int> updateIndex;
  
  const RecommendationsCarousel({
    super.key,
    required CarouselController controller, 
    required this.updateIndex,
    required this.snapshot,
  }) : _controller = controller;

  final CarouselController _controller;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 10, 
      carouselController: _controller, 
      options: CarouselOptions(
        height: 300,
        viewportFraction: 0.75,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 0,
        onPageChanged: (index, reason) {
          updateIndex(index);
        },
      ),
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 400,
            width: 325,
            child: Image.network(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              '${APIConfig.imageBaseUrl}${snapshot.data[itemIndex].posterPath}'
            ),
          ),
        );
      },
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.black : Colors.black26,
        shape: BoxShape.rectangle,
      ),
    );
  });
}