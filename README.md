# Simple example of a Flutter gRPC client working with Python gRPC server

This is a simple example of a a Flutter gRPC client working with Python gRPC server. You need to start a gRPC server from [this repo](https://github.com/shelpuk/grpc_add_numbers_python_server_client) to run this code.

The service implements the addition of two numbers. The protobuf description of the service:

```
syntax = "proto3";

message SumRequest {
    int32 a = 1;
    int32 b = 2;
}

message SumResponse {
    int32 sum = 1;
}

service Sum {
    rpc Add (SumRequest) returns (SumResponse);
}
```

You can generate Dart code by the following command line in Windows:

```
protoc proto/add.proto --dart_out=dart_add_grpc/ --plugin=protoc-gen-dart=<path to protoc-gen-dart.bat>
```

![Flutter gRPC app](https://github.com/shelpuk/grpc_add_numbers_flutter/blob/master/screenshots/Screenshot_20210330_191401.png)
