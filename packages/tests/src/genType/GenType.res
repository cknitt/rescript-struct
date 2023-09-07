@genType
let stringStruct = S.string

@genType
let error: S.error = {
  operation: Parsing,
  code: OperationFailed("Something went wrong"),
  path: S.Path.empty,
}
