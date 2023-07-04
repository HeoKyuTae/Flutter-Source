class TodoApiClient {
  static final TodoApiClient _client = TodoApiClient._internal();
  factory TodoApiClient() => _client;

  TodoApiClient._internal();
}
