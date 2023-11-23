open Ava

module Common = {
  let value = 123
  let any = %raw(`[123]`)
  let invalidAny = %raw(`[123, true]`)
  let invalidTypeAny = %raw(`"Hello world!"`)
  let factory = () => S.tuple1(S.int)

  test("Successfully parses", t => {
    let schema = factory()

    t->Assert.deepEqual(any->S.parseAnyWith(schema), Ok(value), ())
  })

  test("Fails to parse invalid value", t => {
    let schema = factory()

    t->Assert.deepEqual(
      invalidAny->S.parseAnyWith(schema),
      Error(
        U.error({
          code: InvalidTupleSize({
            expected: 1,
            received: 2,
          }),
          operation: Parsing,
          path: S.Path.empty,
        }),
      ),
      (),
    )
  })

  test("Fails to parse invalid type", t => {
    let schema = factory()

    t->Assert.deepEqual(
      invalidTypeAny->S.parseAnyWith(schema),
      Error(
        U.error({
          code: InvalidType({expected: schema->S.toUnknown, received: invalidTypeAny}),
          operation: Parsing,
          path: S.Path.empty,
        }),
      ),
      (),
    )
  })

  test("Successfully serializes", t => {
    let schema = factory()

    t->Assert.deepEqual(value->S.serializeToUnknownWith(schema), Ok(any), ())
  })
}
