open Ava

type x = {
  a: int,
  b: int,
}

type y = {c: float}

type z = {
  ...x,
  d: bool,
  ...y,
}

test("Successfully parses manually created struct using type spread", t => {
  let zStruct = S.object(s => {
    a: s.field("a", S.int),
    b: s.field("b", S.int),
    c: s.field("c", S.float),
    d: s.field("d", S.bool),
  })

  t->Assert.deepEqual(
    %raw(`{a: 1, b: 2, c: 3.3, d: true}`)->S.parseAnyWith(zStruct),
    Ok({a: 1, b: 2, c: 3.3, d: true}),
    (),
  )
})
