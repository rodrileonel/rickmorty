import 'package:rickmorty/domain/models/character.dart';

const String DEFAULT_ERROR = 'Default error';
const String UNKNOW_ERROR = 'Unknown error';
const String API_ERROR = 'Api error';

const genderValues = {
  "Female": Gender.female,
  "Male": Gender.male,
  "Unknown": Gender.unknown,
  "All": Gender.all,
};

const statusValues = {
  "Alive": Status.alive,
  "Dead": Status.dead,
  "Unknown": Status.unknown,
  "All": Status.all,
};
