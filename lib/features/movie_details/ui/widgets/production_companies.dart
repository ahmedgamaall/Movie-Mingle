import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_mingle/core/helpers/spacing.dart';
import 'package:movie_mingle/core/theming/colors.dart';
import 'package:movie_mingle/core/theming/styles.dart';
import 'package:movie_mingle/features/movie_details/data/models/movie_details_response.dart';
import 'package:movie_mingle/features/movie_details/logic/movie_details_cubit.dart';
import 'package:movie_mingle/features/movie_details/logic/movie_details_state.dart';

class ProductionCompanies extends StatelessWidget {
  const ProductionCompanies({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Production Companies', style: TextStyles.font20Gray500),
          verticalSpace(10),
          SizedBox(
            height: 140.h,
            child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
              buildWhen:
                  (previous, current) =>
                      current is SuccessMovieDetails ||
                      current is ErrorMovieDetails ||
                      current is LoadingMovieDetails,
              builder: (context, state) {
                if (state is SuccessMovieDetails) {
                  MovieDetailsResponse movie = state.movieDetailsResponse;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.productionCompanies!.length,
                    itemBuilder: (context, index) {
                      ProductionCompany company =
                          movie.productionCompanies![index];
                      return Column(
                        children: [
                          company.logoPath != null
                              ? Container(
                                height: 100.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.white,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original${company.logoPath!}',
                                  errorWidget:
                                      (context, url, error) => Image.asset(
                                        'assets/images/icon_logo.png',
                                      ),
                                ),
                              )
                              : Container(
                                height: 100.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'assets/images/icon_logo.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                          verticalSpace(10),
                          Text(company.name, style: TextStyles.font22White500),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => horizontalSpace(20),
                  );
                } else if (state is ErrorMovieDetails) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryCardColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        verticalSpace(10),
                        Text('Loading...', style: TextStyles.font22White500),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => horizontalSpace(20),
                  itemCount: 8,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
