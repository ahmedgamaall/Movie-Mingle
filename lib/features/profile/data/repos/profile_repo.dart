import 'package:movie_mingle/core/networking/api_service.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

  // Future<Either<ApiErrorModel, List<TabCategoryResponse>>> getSpecialization() async {
  //   try {
  //     final response = await _apiService.getSpecialization();
  //     return right(response);
  //   } catch (error) {
  //     return left(ApiErrorHandler.handle(error));
  //   }
  // }
}
