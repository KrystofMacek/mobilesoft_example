// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_service.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EmployeeDao? _employeeDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Employee` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `department` TEXT NOT NULL, `salary` INTEGER NOT NULL, `photoUrl` TEXT NOT NULL, `address` TEXT NOT NULL, `encodedPhoto` BLOB NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EmployeeDao get employeeDao {
    return _employeeDaoInstance ??= _$EmployeeDao(database, changeListener);
  }
}

class _$EmployeeDao extends EmployeeDao {
  _$EmployeeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _employeeInsertionAdapter = InsertionAdapter(
            database,
            'Employee',
            (Employee item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'department': item.department,
                  'salary': item.salary,
                  'photoUrl': item.photoUrl,
                  'address': item.address,
                  'encodedPhoto': item.encodedPhoto
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Employee> _employeeInsertionAdapter;

  @override
  Stream<List<Employee>> watchEmployees() {
    return _queryAdapter.queryListStream(
      'SELECT * FROM Employee',
      mapper: (Map<String, Object?> row) => Employee(
          id: row['id'] as int,
          name: row['name'] as String,
          department: row['department'] as String,
          salary: row['salary'] as int,
          photoUrl: row['photoUrl'] as String,
          address: row['address'] as String,
          encodedPhoto: row['encodedPhoto'] as Uint8List),
      queryableName: 'Employee',
      isView: false,
    );
  }

  @override
  Future<void> addEmployees(List<Employee> emp) async {
    await _employeeInsertionAdapter.insertList(emp, OnConflictStrategy.replace);
  }

  @override
  Future<void> addEmployee(Employee emp) async {
    await _employeeInsertionAdapter.insert(emp, OnConflictStrategy.replace);
  }
}
