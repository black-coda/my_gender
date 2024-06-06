class TipsApiKonstant {
  static const videoBaseEndpoint = "https://www.searchapi.io/api/v1/search";
  static const Map<String, String> videoBaseParams = {
    "engine": "google_videos",
    "q": "menstruation education",
    "api_key": "h4wP1C9JGrZ3fDzwrsZXj95W"
  };

  static const articlesBaseEndpoint = "https://newsapi.org/v2/top-headlines";
  static const Map<String, String> articlesBaseParams = {
    // "country": "us",
    "apiKey": "fbb96b7c240d4c9f8594df880f30fff6",
    "q": "menstruation"
  };
}
