import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_app/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyAEJhQ_Fk79ckhubC9kTW6s961slqlkZdU";
const ID_CANAL = "UCwXdFgeE9KYzlDdR7TG9cMw";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> pesquisar(String pesquisa) async {

    http.Response response = await http.get(
        Uri.parse(URL_BASE +
          "search"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$CHAVE_YOUTUBE_API"
          "&chanelId=$ID_CANAL"
          "&q=$pesquisa"
        )
    );

    if ( response.statusCode == 200) {

      Map <String, dynamic> dadosJson = json.decode( response.body );

      List<Video> videos = dadosJson["items"].map<Video> (
          (map){
            return Video.fromJson(map);
          }
      ).toList();

      return videos;
      //print("resultado: " + dadosJson["items"][0]["snippet"]["tittle"].toString());
      
    } else {

    }
    return pesquisar(pesquisa);
  }
}