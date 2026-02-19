// WARP_PROMPT: Define an abstract StorageProvider for local/cloud swap. Methods: saveBloomData(Map<String, dynamic>), loadBloomData().

abstract class StorageProvider {
  Future<void> saveBloomData(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> loadBloomData();
}

// Local impl (SQLite) - stubbed for now; implement with sqflite later.
class LocalStorageProvider implements StorageProvider {
  @override
  Future<void> saveBloomData(Map<String, dynamic> data) async {
    // TODO: Persist using sqflite in a "bloom" table
    // For now, this is a no-op stub to keep the app compiling.
  }

  @override
  Future<Map<String, dynamic>?> loadBloomData() async {
    // TODO: Load from sqflite and return last saved row as a Map
    return null;
  }
}
