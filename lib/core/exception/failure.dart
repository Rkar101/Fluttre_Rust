abstract class Failure {
  final String failMessage;
  final int failStatus;
  const Failure(this.failMessage,this.failStatus);
}

class ServerFailure extends Failure{
  ServerFailure(super.failMessage, super.failStatus);
}

class NetworkFailure extends Failure{
  NetworkFailure(super.failMessage, super.failStatus);
}

class DefaultFailure extends Failure{
  DefaultFailure(super.failMessage, super.failStatus);
}