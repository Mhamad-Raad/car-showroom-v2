import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/car_event.dart';
import '/blocs/car_state.dart';
import '/models/car.dart';



class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc() : super(CarsLoading()) {
    on<LoadCars>((event, emit) async {
      emit(CarsLoading());
      try {
        await Future<void>.delayed(const Duration(milliseconds: 400));

        final cars = _generateRandomCars(count: 12);
        emit(CarsLoaded(cars));
      } catch (e) {
        emit(CarsError(e.toString()));
      }
    });
  }

  List<Car> _generateRandomCars({int count = 10}) {
    final r = Random();
    const models = <String>[
      'Toyota Corolla', 'Honda Civic', 'Tesla Model 3', 'Ford Mustang',
      'Hyundai Elantra', 'Kia Sportage', 'Mazda CX-5', 'BMW 3 Series',
      'Audi A4', 'Mercedes C-Class', 'Nissan Altima', 'Chevy Malibu'
    ];

    double rndDouble(double min, double max, {int decimals = 2}) {
      final v = min + r.nextDouble() * (max - min);
      final f = pow(10, decimals) as int;
      return (v * f).round() / f;
    }

    return List<Car>.generate(count, (_) {
      final model = models[r.nextInt(models.length)];
      final distanceKm = rndDouble(5000, 180000, decimals: 1);       
      final fuelCapL = rndDouble(35, 85, decimals: 1);              
      final priceHr = rndDouble(5, 30, decimals: 2);              

      return Car(
        model: model,
        distance: distanceKm,
        fuelCapacity: fuelCapL,
        pricePerHour: priceHr,
      );
    });
  }
}
