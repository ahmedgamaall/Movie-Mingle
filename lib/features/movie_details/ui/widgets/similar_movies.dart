import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mingle/core/helpers/spacing.dart';
import 'package:movie_mingle/core/models/movies_response.dart';
import 'package:movie_mingle/core/theming/styles.dart';
import 'package:movie_mingle/core/widgets/movie_posters_list.dart';
import 'package:movie_mingle/core/widgets/loading_movie_posters_list.dart';
import 'package:movie_mingle/features/movie_details/logic/movie_details_cubit.dart';
import 'package:movie_mingle/features/movie_details/logic/movie_details_state.dart';

class SimilarMovies extends StatelessWidget {
  const SimilarMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Similar', style: TextStyles.font30White600),
        verticalSpace(10),
        BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          buildWhen:
              (previous, current) =>
                  current is SuccessMovieSimilar ||
                  current is ErrorMovieSimilar ||
                  current is LoadingMovieSimilar,
          builder: (context, state) {
            if (state is SuccessMovieSimilar) {
              List<MovieResponse> movies = state.moviesResponse.movies;
              return MoviePostersList(movies: movies);
            } else if (state is ErrorMovieSimilar) {
              return Center(
                child: Text(state.error, style: TextStyle(color: Colors.white)),
              );
            }
            return LoadingMoviePostersList();
          },
        ),
      ],
    );
  }
}
