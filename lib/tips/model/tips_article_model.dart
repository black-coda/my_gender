// To parse this JSON data, do
//
    // final articleTipsModel = articleTipsModelFromJson(jsonString);

import 'dart:convert';

ArticleTipsModel articleTipsModelFromJson(String str) =>
    ArticleTipsModel.fromJson(json.decode(str));

String articleTipsModelToJson(ArticleTipsModel data) =>
    json.encode(data.toJson());

class ArticleTipsModel {
  final RequestInfo requestInfo;
  final SearchParameters searchParameters;
  final SearchMetadata searchMetadata;
  final SearchInformation searchInformation;
  final AnswerBox answerBox;
  final List<DiscussionsAndForum> discussionsAndForums;
  final List<RelatedQuestion> relatedQuestions;
  final List<OrganicResult> organicResults;

  ArticleTipsModel({
    required this.requestInfo,
    required this.searchParameters,
    required this.searchMetadata,
    required this.searchInformation,
    required this.answerBox,
    required this.discussionsAndForums,
    required this.relatedQuestions,
    required this.organicResults,
  });

  ArticleTipsModel copyWith({
    RequestInfo? requestInfo,
    SearchParameters? searchParameters,
    SearchMetadata? searchMetadata,
    SearchInformation? searchInformation,
    AnswerBox? answerBox,
    List<DiscussionsAndForum>? discussionsAndForums,
    List<RelatedQuestion>? relatedQuestions,
    List<OrganicResult>? organicResults,
  }) =>
      ArticleTipsModel(
        requestInfo: requestInfo ?? this.requestInfo,
        searchParameters: searchParameters ?? this.searchParameters,
        searchMetadata: searchMetadata ?? this.searchMetadata,
        searchInformation: searchInformation ?? this.searchInformation,
        answerBox: answerBox ?? this.answerBox,
        discussionsAndForums: discussionsAndForums ?? this.discussionsAndForums,
        relatedQuestions: relatedQuestions ?? this.relatedQuestions,
        organicResults: organicResults ?? this.organicResults,
      );

  factory ArticleTipsModel.fromJson(Map<String, dynamic> json) =>
      ArticleTipsModel(
        requestInfo: RequestInfo.fromJson(json["request_info"]),
        searchParameters: SearchParameters.fromJson(json["search_parameters"]),
        searchMetadata: SearchMetadata.fromJson(json["search_metadata"]),
        searchInformation:
            SearchInformation.fromJson(json["search_information"]),
        answerBox: AnswerBox.fromJson(json["answer_box"]),
        discussionsAndForums: List<DiscussionsAndForum>.from(
            json["discussions_and_forums"]
                .map((x) => DiscussionsAndForum.fromJson(x))),
        relatedQuestions: List<RelatedQuestion>.from(
            json["related_questions"].map((x) => RelatedQuestion.fromJson(x))),
        organicResults: List<OrganicResult>.from(
            json["organic_results"].map((x) => OrganicResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request_info": requestInfo.toJson(),
        "search_parameters": searchParameters.toJson(),
        "search_metadata": searchMetadata.toJson(),
        "search_information": searchInformation.toJson(),
        "answer_box": answerBox.toJson(),
        "discussions_and_forums":
            List<dynamic>.from(discussionsAndForums.map((x) => x.toJson())),
        "related_questions":
            List<dynamic>.from(relatedQuestions.map((x) => x.toJson())),
        "organic_results":
            List<dynamic>.from(organicResults.map((x) => x.toJson())),
      };
}

class AnswerBox {
  final int answerBoxType;
  final List<Answer> answers;
  final int blockPosition;

  AnswerBox({
    required this.answerBoxType,
    required this.answers,
    required this.blockPosition,
  });

  AnswerBox copyWith({
    int? answerBoxType,
    List<Answer>? answers,
    int? blockPosition,
  }) =>
      AnswerBox(
        answerBoxType: answerBoxType ?? this.answerBoxType,
        answers: answers ?? this.answers,
        blockPosition: blockPosition ?? this.blockPosition,
      );

  factory AnswerBox.fromJson(Map<String, dynamic> json) => AnswerBox(
        answerBoxType: json["answer_box_type"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        blockPosition: json["block_position"],
      );

  Map<String, dynamic> toJson() => {
        "answer_box_type": answerBoxType,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "block_position": blockPosition,
      };
}

class Answer {
  final String answer;
  final String classification;

  Answer({
    required this.answer,
    required this.classification,
  });

  Answer copyWith({
    String? answer,
    String? classification,
  }) =>
      Answer(
        answer: answer ?? this.answer,
        classification: classification ?? this.classification,
      );

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answer: json["answer"],
        classification: json["classification"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "classification": classification,
      };
}

class DiscussionsAndForum {
  final String discussionTitle;
  final String link;
  final DiscussionsAndForumSource source;
  final int blockPosition;

  DiscussionsAndForum({
    required this.discussionTitle,
    required this.link,
    required this.source,
    required this.blockPosition,
  });

  DiscussionsAndForum copyWith({
    String? discussionTitle,
    String? link,
    DiscussionsAndForumSource? source,
    int? blockPosition,
  }) =>
      DiscussionsAndForum(
        discussionTitle: discussionTitle ?? this.discussionTitle,
        link: link ?? this.link,
        source: source ?? this.source,
        blockPosition: blockPosition ?? this.blockPosition,
      );

  factory DiscussionsAndForum.fromJson(Map<String, dynamic> json) =>
      DiscussionsAndForum(
        discussionTitle: json["discussion_title"],
        link: json["link"],
        source: DiscussionsAndForumSource.fromJson(json["source"]),
        blockPosition: json["block_position"],
      );

  Map<String, dynamic> toJson() => {
        "discussion_title": discussionTitle,
        "link": link,
        "source": source.toJson(),
        "block_position": blockPosition,
      };
}

class DiscussionsAndForumSource {
  final String sourceTitle;
  final String domain;
  final String sourceCommunity;
  final String commentsCount;
  final String? time;

  DiscussionsAndForumSource({
    required this.sourceTitle,
    required this.domain,
    required this.sourceCommunity,
    required this.commentsCount,
    this.time,
  });

  DiscussionsAndForumSource copyWith({
    String? sourceTitle,
    String? domain,
    String? sourceCommunity,
    String? commentsCount,
    String? time,
  }) =>
      DiscussionsAndForumSource(
        sourceTitle: sourceTitle ?? this.sourceTitle,
        domain: domain ?? this.domain,
        sourceCommunity: sourceCommunity ?? this.sourceCommunity,
        commentsCount: commentsCount ?? this.commentsCount,
        time: time ?? this.time,
      );

  factory DiscussionsAndForumSource.fromJson(Map<String, dynamic> json) =>
      DiscussionsAndForumSource(
        sourceTitle: json["source_title"],
        domain: json["domain"],
        sourceCommunity: json["source_community"],
        commentsCount: json["comments_count"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "source_title": sourceTitle,
        "domain": domain,
        "source_community": sourceCommunity,
        "comments_count": commentsCount,
        "time": time,
      };
}

class OrganicResult {
  final int position;
  final String title;
  final String link;
  final String domain;
  final String displayedLink;
  final String snippet;
  final bool prerender;
  final int blockPosition;
  final RichSnippet? richSnippet;
  final String? prefix;
  final String? date;
  final DateTime? dateUtc;

  OrganicResult({
    required this.position,
    required this.title,
    required this.link,
    required this.domain,
    required this.displayedLink,
    required this.snippet,
    required this.prerender,
    required this.blockPosition,
    this.richSnippet,
    this.prefix,
    this.date,
    this.dateUtc,
  });

  OrganicResult copyWith({
    int? position,
    String? title,
    String? link,
    String? domain,
    String? displayedLink,
    String? snippet,
    bool? prerender,
    int? blockPosition,
    RichSnippet? richSnippet,
    String? prefix,
    String? date,
    DateTime? dateUtc,
  }) =>
      OrganicResult(
        position: position ?? this.position,
        title: title ?? this.title,
        link: link ?? this.link,
        domain: domain ?? this.domain,
        displayedLink: displayedLink ?? this.displayedLink,
        snippet: snippet ?? this.snippet,
        prerender: prerender ?? this.prerender,
        blockPosition: blockPosition ?? this.blockPosition,
        richSnippet: richSnippet ?? this.richSnippet,
        prefix: prefix ?? this.prefix,
        date: date ?? this.date,
        dateUtc: dateUtc ?? this.dateUtc,
      );

  factory OrganicResult.fromJson(Map<String, dynamic> json) => OrganicResult(
        position: json["position"],
        title: json["title"],
        link: json["link"],
        domain: json["domain"],
        displayedLink: json["displayed_link"],
        snippet: json["snippet"],
        prerender: json["prerender"],
        blockPosition: json["block_position"],
        richSnippet: json["rich_snippet"] == null
            ? null
            : RichSnippet.fromJson(json["rich_snippet"]),
        prefix: json["prefix"],
        date: json["date"],
        dateUtc:
            json["date_utc"] == null ? null : DateTime.parse(json["date_utc"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "title": title,
        "link": link,
        "domain": domain,
        "displayed_link": displayedLink,
        "snippet": snippet,
        "prerender": prerender,
        "block_position": blockPosition,
        "rich_snippet": richSnippet?.toJson(),
        "prefix": prefix,
        "date": date,
        "date_utc": dateUtc?.toIso8601String(),
      };
}

class RichSnippet {
  final Top top;

  RichSnippet({
    required this.top,
  });

  RichSnippet copyWith({
    Top? top,
  }) =>
      RichSnippet(
        top: top ?? this.top,
      );

  factory RichSnippet.fromJson(Map<String, dynamic> json) => RichSnippet(
        top: Top.fromJson(json["top"]),
      );

  Map<String, dynamic> toJson() => {
        "top": top.toJson(),
      };
}

class Top {
  final DetectedExtensions detectedExtensions;
  final List<String> extensions;

  Top({
    required this.detectedExtensions,
    required this.extensions,
  });

  Top copyWith({
    DetectedExtensions? detectedExtensions,
    List<String>? extensions,
  }) =>
      Top(
        detectedExtensions: detectedExtensions ?? this.detectedExtensions,
        extensions: extensions ?? this.extensions,
      );

  factory Top.fromJson(Map<String, dynamic> json) => Top(
        detectedExtensions:
            DetectedExtensions.fromJson(json["detected_extensions"]),
        extensions: List<String>.from(json["extensions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "detected_extensions": detectedExtensions.toJson(),
        "extensions": List<dynamic>.from(extensions.map((x) => x)),
      };
}

class DetectedExtensions {
  final int price;
  final String symbol;
  final Currency currency;

  DetectedExtensions({
    required this.price,
    required this.symbol,
    required this.currency,
  });

  DetectedExtensions copyWith({
    int? price,
    String? symbol,
    Currency? currency,
  }) =>
      DetectedExtensions(
        price: price ?? this.price,
        symbol: symbol ?? this.symbol,
        currency: currency ?? this.currency,
      );

  factory DetectedExtensions.fromJson(Map<String, dynamic> json) =>
      DetectedExtensions(
        price: json["price"],
        symbol: json["symbol"],
        currency: Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "symbol": symbol,
        "currency": currency.toJson(),
      };
}

class Currency {
  final String name;
  final String code;
  final String symbol;

  Currency({
    required this.name,
    required this.code,
    required this.symbol,
  });

  Currency copyWith({
    String? name,
    String? code,
    String? symbol,
  }) =>
      Currency(
        name: name ?? this.name,
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
      );

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        code: json["code"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "symbol": symbol,
      };
}

class RelatedQuestion {
  final String question;
  final String answer;
  final RelatedQuestionSource source;
  final Search search;
  final int blockPosition;

  RelatedQuestion({
    required this.question,
    required this.answer,
    required this.source,
    required this.search,
    required this.blockPosition,
  });

  RelatedQuestion copyWith({
    String? question,
    String? answer,
    RelatedQuestionSource? source,
    Search? search,
    int? blockPosition,
  }) =>
      RelatedQuestion(
        question: question ?? this.question,
        answer: answer ?? this.answer,
        source: source ?? this.source,
        search: search ?? this.search,
        blockPosition: blockPosition ?? this.blockPosition,
      );

  factory RelatedQuestion.fromJson(Map<String, dynamic> json) =>
      RelatedQuestion(
        question: json["question"],
        answer: json["answer"],
        source: RelatedQuestionSource.fromJson(json["source"]),
        search: Search.fromJson(json["search"]),
        blockPosition: json["block_position"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "source": source.toJson(),
        "search": search.toJson(),
        "block_position": blockPosition,
      };
}

class Search {
  final String link;
  final String title;

  Search({
    required this.link,
    required this.title,
  });

  Search copyWith({
    String? link,
    String? title,
  }) =>
      Search(
        link: link ?? this.link,
        title: title ?? this.title,
      );

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        link: json["link"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "title": title,
      };
}

class RelatedQuestionSource {
  final String link;
  final String displayedLink;
  final String title;

  RelatedQuestionSource({
    required this.link,
    required this.displayedLink,
    required this.title,
  });

  RelatedQuestionSource copyWith({
    String? link,
    String? displayedLink,
    String? title,
  }) =>
      RelatedQuestionSource(
        link: link ?? this.link,
        displayedLink: displayedLink ?? this.displayedLink,
        title: title ?? this.title,
      );

  factory RelatedQuestionSource.fromJson(Map<String, dynamic> json) =>
      RelatedQuestionSource(
        link: json["link"],
        displayedLink: json["displayed_link"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "displayed_link": displayedLink,
        "title": title,
      };
}

class RequestInfo {
  final bool success;
  final int topupCreditsRemaining;
  final int creditsUsedThisRequest;

  RequestInfo({
    required this.success,
    required this.topupCreditsRemaining,
    required this.creditsUsedThisRequest,
  });

  RequestInfo copyWith({
    bool? success,
    int? topupCreditsRemaining,
    int? creditsUsedThisRequest,
  }) =>
      RequestInfo(
        success: success ?? this.success,
        topupCreditsRemaining:
            topupCreditsRemaining ?? this.topupCreditsRemaining,
        creditsUsedThisRequest:
            creditsUsedThisRequest ?? this.creditsUsedThisRequest,
      );

  factory RequestInfo.fromJson(Map<String, dynamic> json) => RequestInfo(
        success: json["success"],
        topupCreditsRemaining: json["topup_credits_remaining"],
        creditsUsedThisRequest: json["credits_used_this_request"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "topup_credits_remaining": topupCreditsRemaining,
        "credits_used_this_request": creditsUsedThisRequest,
      };
}

class SearchInformation {
  final bool originalQueryYieldsZeroResults;
  final int totalResults;

  SearchInformation({
    required this.originalQueryYieldsZeroResults,
    required this.totalResults,
  });

  SearchInformation copyWith({
    bool? originalQueryYieldsZeroResults,
    int? totalResults,
  }) =>
      SearchInformation(
        originalQueryYieldsZeroResults: originalQueryYieldsZeroResults ??
            this.originalQueryYieldsZeroResults,
        totalResults: totalResults ?? this.totalResults,
      );

  factory SearchInformation.fromJson(Map<String, dynamic> json) =>
      SearchInformation(
        originalQueryYieldsZeroResults:
            json["original_query_yields_zero_results"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "original_query_yields_zero_results": originalQueryYieldsZeroResults,
        "total_results": totalResults,
      };
}

class SearchMetadata {
  final DateTime createdAt;
  final DateTime processedAt;
  final double totalTimeTaken;
  final String engineUrl;
  final String htmlUrl;
  final String jsonUrl;

  SearchMetadata({
    required this.createdAt,
    required this.processedAt,
    required this.totalTimeTaken,
    required this.engineUrl,
    required this.htmlUrl,
    required this.jsonUrl,
  });

  SearchMetadata copyWith({
    DateTime? createdAt,
    DateTime? processedAt,
    double? totalTimeTaken,
    String? engineUrl,
    String? htmlUrl,
    String? jsonUrl,
  }) =>
      SearchMetadata(
        createdAt: createdAt ?? this.createdAt,
        processedAt: processedAt ?? this.processedAt,
        totalTimeTaken: totalTimeTaken ?? this.totalTimeTaken,
        engineUrl: engineUrl ?? this.engineUrl,
        htmlUrl: htmlUrl ?? this.htmlUrl,
        jsonUrl: jsonUrl ?? this.jsonUrl,
      );

  factory SearchMetadata.fromJson(Map<String, dynamic> json) => SearchMetadata(
        createdAt: DateTime.parse(json["created_at"]),
        processedAt: DateTime.parse(json["processed_at"]),
        totalTimeTaken: json["total_time_taken"]?.toDouble(),
        engineUrl: json["engine_url"],
        htmlUrl: json["html_url"],
        jsonUrl: json["json_url"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "processed_at": processedAt.toIso8601String(),
        "total_time_taken": totalTimeTaken,
        "engine_url": engineUrl,
        "html_url": htmlUrl,
        "json_url": jsonUrl,
      };
}

class SearchParameters {
  final String q;
  final String engine;

  SearchParameters({
    required this.q,
    required this.engine,
  });

  SearchParameters copyWith({
    String? q,
    String? engine,
  }) =>
      SearchParameters(
        q: q ?? this.q,
        engine: engine ?? this.engine,
      );

  factory SearchParameters.fromJson(Map<String, dynamic> json) =>
      SearchParameters(
        q: json["q"],
        engine: json["engine"],
      );

  Map<String, dynamic> toJson() => {
        "q": q,
        "engine": engine,
      };
}
