abstract class Usecase<Type, Params> {
  // The use case class contains the a generic type parameters
  // all use case has a call method
  Future<Type> call({Params parms});
}
