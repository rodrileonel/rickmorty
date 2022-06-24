// ignore_for_file: unnecessary_new, prefer_collection_literals

import 'dart:convert';

List<EpisodeResponse> episodesResponseFromJson(String str) =>
    List<EpisodeResponse>.from(
        json.decode(str).map((x) => EpisodeResponse.fromJson(x)));

class EpisodeResponse {
  int? id;
  String? name;
  String? airDate;
  String? episode;
  List<String>? characters;
  String? url;
  String? created;

  EpisodeResponse(
      {this.id,
      this.name,
      this.airDate,
      this.episode,
      this.characters,
      this.url,
      this.created});

  EpisodeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    airDate = json['air_date'];
    episode = json['episode'];
    characters = json['characters'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['air_date'] = airDate;
    data['episode'] = episode;
    data['characters'] = characters;
    data['url'] = url;
    data['created'] = created;
    return data;
  }
}
