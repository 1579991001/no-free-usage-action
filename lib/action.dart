///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2020-09-05 19:57
///
import 'package:http/http.dart' as http;
import 'package:no_free_action/constants/constants.dart';

Future<bool> tips({
  @required String token,
  @required IssueEvent event,
  @required String repo,
  @required String tips,
}) async {
  final Comment comment = await HttpUtils.fetch(
    url: '$baseUrl/repos/$repo/issues/${event.issue.number}/comments',
    fetchType: FetchType.post,
    body: <String, dynamic>{
      'body': tips,
    },
    headers: <String, dynamic>{'Authorization': 'Bearer $token'},
  );
  if (comment != null) {
    print('Issue replied with tips.');
  } else {
    print('Issue reply failed.');
  }
  return comment != null;
}

Future<bool> close({
  @required String token,
  @required IssueEvent event,
}) async {
  final Issue issue = await HttpUtils.fetch(
    url: event.issue.url,
    fetchType: FetchType.patch,
    body: <String, dynamic>{
      'state': 'closed',
    },
    headers: <String, dynamic>{'Authorization': 'Bearer $token'},
  );
  if (issue != null) {
    print('Issue closed.');
  } else {
    print('Issue close failed.');
  }
  return issue != null;
}

Future<bool> lock({
  @required String token,
  @required IssueEvent event,
  @required String repo,
}) async {
  final http.Response response = await HttpUtils.getResponse(
    url: '$baseUrl/repos/$repo/issues/${event.issue.number}/lock',
    fetchType: FetchType.put,
    body: <String, dynamic>{
      'lock_reason': 'spam',
    },
    headers: <String, String>{'Authorization': 'Bearer $token'},
  );
  if (response != null) {
    print('Issue locked with \'spam\'.');
  } else {
    print('Issue locked failed.');
  }
  return response != null;
}