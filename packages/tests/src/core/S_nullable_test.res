open Ava
open RescriptCore

module NullCommon = {
  let value = None
  let any = %raw(`null`)
  let invalidAny = %raw(`123.45`)
  let factory = () => S.nullable(S.string)

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

  test("Successfully serializes (to undefined)", t => {
    let schema = factory()

    t->Assert.deepEqual(value->S.serializeToUnknownWith(schema), Ok(%raw(`undefined`)), ())
  })

  test("Compiled parse code snapshot", t => {
    let schema = factory()

    t->U.assertCompiledCode(
      ~schema,
      ~op=#parse,
      `i=>{if(i!==void 0&&(i!==null&&(typeof i!=="string"))){e[0](i)}let v1;if(i!==void 0){let v0;if(i!==null){v0=i}else{v0=void 0}v1=v0}return v1}`,
    )
  })

  test("Compiled async parse code snapshot", t => {
    let schema = S.nullable(
      S.unknown->S.transform(_ => {asyncParser: i => () => Promise.resolve(i)}),
    )

    t->U.assertCompiledCode(
      ~schema,
      ~op=#parse,
      `i=>{let v1;if(i!==void 0){let v0;if(i!==null){v0=e[0](i)}else{v0=()=>Promise.resolve(void 0)}v1=v0}else{v1=()=>Promise.resolve(void 0)}return v1}`,
    )
  })

  test("Compiled serialize code snapshot", t => {
    let schema = factory()

    t->U.assertCompiledCode(
      ~schema,
      ~op=#serialize,
      `i=>{let v2;if(i!==void 0){let v0=e[0](i),v1;if(v0!==void 0){v1=e[1](v0)}else{v1=null}v2=v1}return v2}`,
    )
  })
}

test("Successfully parses primitive", t => {
  let schema = S.nullable(S.bool)

  t->Assert.deepEqual(JSON.Encode.bool(true)->S.parseAnyWith(schema), Ok(Some(true)), ())
})

test("Successfully parses JS undefined", t => {
  let schema = S.nullable(S.bool)

  t->Assert.deepEqual(%raw(`undefined`)->S.parseAnyWith(schema), Ok(None), ())
})

test("Successfully parses object with missing field that marked as nullable", t => {
  let fieldSchema = S.nullable(S.string)
  let schema = S.object(s => s.field("nullableField", fieldSchema))

  t->Assert.deepEqual(%raw(`{}`)->S.parseAnyWith(schema), Ok(None), ())
})

test(
  "Successfully parses null and serializes it back to undefined for deprecated nullable schema",
  t => {
    let schema = S.nullable(S.bool)->S.deprecate("Deprecated")

    t->Assert.deepEqual(
      %raw(`null`)->S.parseAnyWith(schema)->Result.map(S.serializeToUnknownWith(_, schema)),
      Ok(Ok(%raw(`undefined`))),
      (),
    )
  },
)

test("Classify S.nullable as Option(Null(value))", t => {
  let schema = S.nullable(S.bool)

  t->U.unsafeAssertEqualSchemas(schema, S.option(S.null(S.bool)))
})
