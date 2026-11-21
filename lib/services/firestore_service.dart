import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/todo.dart';

class FirestoreService {
  final CollectionReference _todosCollection =
    FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo(String taskName) async{
    final newTodo = Todo(
      id: '',
      task: taskName,
      isDone: false,
    );

    await _todosCollection.add(newTodo.toMap());
  }

  Stream<List<Todo>> getTodos(){
    return _todosCollection
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList());
  }

  //update status todo
  Future<void> UpdateTodoStatus(String id, bool currentStatus) async {
    await _todosCollection.doc(id).update({'isDone' : !currentStatus});
  }

  //delete tugas atau todo
  Future<void> deleteTodo(String id) async {
    await _todosCollection.doc(id).delete();
  }
}