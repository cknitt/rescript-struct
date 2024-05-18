open Ava

test("Successfully parses valid data", t => {
  let schema = S.string->S.pattern(%re(`/[0-9]/`))

  t->Assert.deepEqual("123"->S.parseAnyWith(schema), Ok("123"), ())
})

test("Fails to parse invalid data", t => {
  let schema = S.string->S.pattern(%re(`/[0-9]/`))

  t->Assert.deepEqual(
    "abc"->S.parseAnyWith(schema),
    Error(U.error({code: OperationFailed("Invalid"), operation: Parsing, path: S.Path.empty})),
    (),
  )
})

test("Successfully serializes valid value", t => {
  let schema = S.string->S.pattern(%re(`/[0-9]/`))

  t->Assert.deepEqual("123"->S.serializeToUnknownWith(schema), Ok(%raw(`"123"`)), ())
})

test("Fails to serialize invalid value", t => {
  let schema = S.string->S.pattern(%re(`/[0-9]/`))

  t->Assert.deepEqual(
    "abc"->S.serializeToUnknownWith(schema),
    Error(U.error({code: OperationFailed("Invalid"), operation: Serializing, path: S.Path.empty})),
    (),
  )
})

test("Returns custom error message", t => {
  let schema = S.string->S.pattern(~message="Custom", %re(`/[0-9]/`))

  t->Assert.deepEqual(
    "abc"->S.parseAnyWith(schema),
    Error(U.error({code: OperationFailed("Custom"), operation: Parsing, path: S.Path.empty})),
    (),
  )
})

test("Returns refinement", t => {
  let schema = S.string->S.pattern(%re(`/[0-9]/`))

  t->Assert.deepEqual(
    schema->S.String.refinements,
    [{kind: Pattern({re: %re(`/[0-9]/`)}), message: "Invalid"}],
    (),
  )
})

test("Returns multiple refinement", t => {
  let schema1 = S.string
  let schema2 = schema1->S.pattern(~message="Should have digit", %re(`/[0-9]+/`))
  let schema3 = schema2->S.pattern(~message="Should have text", %re(`/\w+/`))

  t->Assert.deepEqual(schema1->S.String.refinements, [], ())
  t->Assert.deepEqual(
    schema2->S.String.refinements,
    [{kind: Pattern({re: %re(`/[0-9]+/`)}), message: "Should have digit"}],
    (),
  )
  t->Assert.deepEqual(
    schema3->S.String.refinements,
    [
      {kind: Pattern({re: %re(`/[0-9]+/`)}), message: "Should have digit"},
      {kind: Pattern({re: %re(`/\w+/`)}), message: "Should have text"},
    ],
    (),
  )
})
