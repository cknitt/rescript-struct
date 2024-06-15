// Generated by ReScript, PLEASE EDIT WITH CARE

import * as U from "../utils/U.bs.mjs";
import Ava from "ava";
import * as S$RescriptSchema from "rescript-schema/src/S.bs.mjs";

Ava("Creates schema with the name schema from t type", (function (t) {
        U.assertEqualSchemas(t, S$RescriptSchema.string, S$RescriptSchema.string, undefined);
      }));

Ava("Creates schema with the type name and schema at the for non t types", (function (t) {
        U.assertEqualSchemas(t, S$RescriptSchema.$$int, S$RescriptSchema.$$int, undefined);
      }));

var reusedTypesSchema = S$RescriptSchema.tuple(function (s) {
      return [
              s.item(0, S$RescriptSchema.string),
              s.item(1, S$RescriptSchema.$$int),
              s.item(2, S$RescriptSchema.bool),
              s.item(3, S$RescriptSchema.$$float)
            ];
    });

Ava("Can reuse schemas from other types", (function (t) {
        U.assertEqualSchemas(t, reusedTypesSchema, S$RescriptSchema.tuple(function (s) {
                  return [
                          s.item(0, S$RescriptSchema.string),
                          s.item(1, S$RescriptSchema.$$int),
                          s.item(2, S$RescriptSchema.bool),
                          s.item(3, S$RescriptSchema.$$float)
                        ];
                }), undefined);
      }));

var stringWithDefaultSchema = S$RescriptSchema.$$Option.getOr(S$RescriptSchema.option(S$RescriptSchema.string), "Foo");

Ava("Creates schema with default", (function (t) {
        U.assertEqualSchemas(t, stringWithDefaultSchema, S$RescriptSchema.$$Option.getOr(S$RescriptSchema.option(S$RescriptSchema.string), "Foo"), undefined);
      }));

var stringWithDefaultAndMatchesSchema = S$RescriptSchema.$$Option.getOr(S$RescriptSchema.option(S$RescriptSchema.url(S$RescriptSchema.string, undefined)), "Foo");

Ava("Creates schema with default using @s.matches", (function (t) {
        U.assertEqualSchemas(t, stringWithDefaultAndMatchesSchema, S$RescriptSchema.$$Option.getOr(S$RescriptSchema.option(S$RescriptSchema.url(S$RescriptSchema.string, undefined)), "Foo"), undefined);
      }));

var stringWithDefaultNullAndMatchesSchema = S$RescriptSchema.$$Option.getOr(S$RescriptSchema.$$null(S$RescriptSchema.url(S$RescriptSchema.string, undefined)), "Foo");

Ava("Creates schema with default null using @s.matches", (function (t) {
        U.assertEqualSchemas(t, stringWithDefaultNullAndMatchesSchema, S$RescriptSchema.$$Option.getOr(S$RescriptSchema.$$null(S$RescriptSchema.url(S$RescriptSchema.string, undefined)), "Foo"), undefined);
      }));

var ignoredNullWithMatchesSchema = S$RescriptSchema.option(S$RescriptSchema.string);

Ava("@s.null doesn't override @s.matches(S.option(_))", (function (t) {
        U.assertEqualSchemas(t, ignoredNullWithMatchesSchema, S$RescriptSchema.option(S$RescriptSchema.string), undefined);
      }));

var schema = S$RescriptSchema.string;

var fooSchema = S$RescriptSchema.$$int;

export {
  schema ,
  fooSchema ,
  reusedTypesSchema ,
}
/*  Not a pure module */
