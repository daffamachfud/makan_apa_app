import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:makan_apa_app/data/api/api_service.dart';
import 'package:makan_apa_app/data/model/restaurant.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('loadRestaurantData', () {
    test(
        'Should returns an RestaurantModel if the http call completes successfully',
        () async {
      final client = MockClient();
      when(client.get(Uri.parse("https://restaurant-api.dicoding.dev/list")))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}',
              200));
      expect(await ApiService().listExplore(client), isA<RestaurantResult>());
    });
  });
}
