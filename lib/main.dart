import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Movie {
  final String title;
  final String year;
  final String genre;
  final String overview;
  final String posterUrl;

  const Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.overview,
    required this.posterUrl,
  });
}

final List<Movie> nowPlaying = [
  Movie(
    title: 'Black Bag',
    year: '2024',
    genre: 'Slice of Life',
    overview: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    posterUrl: 'assets/images/Black-Bag-44.jpg',
  ),
  Movie(
    title: 'Comrades',
    year: '2024',
    genre: 'War',
    overview: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    posterUrl: 'assets/images/Comrades-06.jpg',
  ),
  Movie(
    title: 'Die My Love',
    year: '2024',
    genre: 'Drama',
    overview: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    posterUrl: 'assets/images/Die-My-Love-04.jpg',
  ),
];

final List<String> daftarGambar = [
  'assets/images/Lord-of-War-65.jpg',
  'assets/images/Titanic-26.jpg',
  'assets/images/The-Monkey-02.jpg',
  'assets/images/Black-Bag-44.jpg',
  'assets/images/Comrades-06.jpg',
  'assets/images/Die-My-Love-04.jpg',
];

List<Movie> dummyList(List<String> gambar) {
  return gambar.map((path) {
    return Movie(
      title: 'Judul',
      year: '2024',
      genre: 'Drama',
      overview: 'Lorem ipsum dolor sit amet.',
      posterUrl: path,
    );
  }).toList();
}

final List<Movie> trending = dummyList(daftarGambar);
final List<Movie> popular = dummyList(daftarGambar);
final List<Movie> topRated = dummyList(daftarGambar);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 44,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NowPlayingCarousel(),
              const SizedBox(height: 12),

              SectionHeader(title: 'Trending', onMore: () {}),
              const SizedBox(height: 8),
              PosterCarousel(movies: trending),
              const SizedBox(height: 16),

              SectionHeader(title: 'Popular', onMore: () {}),
              const SizedBox(height: 8),
              PosterCarousel(movies: popular),
              const SizedBox(height: 16),

              SectionHeader(title: 'Top Rated', onMore: () {}),
              const SizedBox(height: 8),
              PosterCarousel(movies: topRated),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class NowPlayingCarousel extends StatelessWidget {
  const NowPlayingCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: nowPlaying.length,
      options: CarouselOptions(
        height: 280,
        viewportFraction: 0.8,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      itemBuilder: (context, index, realIndex) {
        final movie = nowPlaying[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              PosterImage(url: movie.posterUrl),

              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xCC000000)],
                    stops: [0.45, 1.0],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 56,
                bottom: 12,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${movie.year}   ${movie.genre}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      movie.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                bottom: 20,
                child: InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PosterCarousel extends StatelessWidget {
  final List<Movie> movies;
  const PosterCarousel({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      options: CarouselOptions(
        height: 130,
        viewportFraction: 0.27,
        padEnds: false,
        enableInfiniteScroll: false,
        disableCenter: true,
        pageSnapping: false,
      ),
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: EdgeInsets.only(left: index == 0 ? 8 : 4, right: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: PosterImage(url: movies[index].posterUrl),
          ),
        );
      },
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMore;
  const SectionHeader({super.key, required this.title, this.onMore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onMore,
            child: const Text(
              'More',
              style: TextStyle(fontSize: 10, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class PosterImage extends StatelessWidget {
  final String url;
  const PosterImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stack) => Container(
        color: const Color(0xFF1E1E1E),
        child: const Icon(Icons.movie, color: Colors.white24),
      ),
    );
  }
}
