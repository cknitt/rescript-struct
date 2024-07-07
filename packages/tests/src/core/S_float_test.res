open Ava

module Common = {
  let value = 123.
  let any = %raw(`123`)
  let invalidAny = %raw(`"Hello world!"`)
  let factory = () => S.float

  test("Successfully parses", t => {
    let schema = factory()

    t->Assert.deepEqual(any->S.parseAnyWith(schema), Ok(value), ())
  })

  test("Fails to parse", t => {
    let schema = factory()

    t->U.assertErrorResult(
      invalidAny->S.parseAnyWith(schema),
      {
        code: InvalidType({expected: schema->S.toUnknown, received: invalidAny}),
        operation: Parse,
        path: S.Path.empty,
      },
    )
  })

  test("Successfully serializes", t => {
    let schema = factory()

    t->Assert.deepEqual(value->S.serializeToUnknownWith(schema), Ok(any), ())
  })

  test("Compiled parse code snapshot", t => {
    let schema = factory()

    t->U.assertCompiledCode(
      ~schema,
      ~op=#parse,
      `i=>{if(typeof i!=="number"||Number.isNaN(i)){e[0](i)}return i}`,
    )
  })

  test("Compiled serialize code snapshot", t => {
    let schema = factory()

    t->U.assertCompiledCodeIsNoop(~schema, ~op=#serialize)
  })
}

test("Successfully parses number with a fractional part", t => {
  let schema = S.float

  t->Assert.deepEqual(%raw(`123.123`)->S.parseAnyWith(schema), Ok(123.123), ())
})

test("Fails to parse NaN", t => {
  let schema = S.float

  t->U.assertErrorResult(
    %raw(`NaN`)->S.parseAnyWith(schema),
    {
      code: InvalidType({expected: schema->S.toUnknown, received: %raw(`NaN`)}),
      operation: Parse,
      path: S.Path.empty,
    },
  )
})
