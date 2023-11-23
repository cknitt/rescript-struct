// Generated by ReScript, PLEASE EDIT WITH CARE

import * as U from "../utils/U.bs.mjs";
import Ava from "ava";
import * as S$RescriptSchema from "rescript-schema/src/S.bs.mjs";

var polySchema = S$RescriptSchema.union([
      S$RescriptSchema.literal("one"),
      S$RescriptSchema.literal("two")
    ]);

Ava("Polymorphic variant", (function (t) {
        U.assertEqualSchemas(t, polySchema, S$RescriptSchema.union([
                  S$RescriptSchema.literal("one"),
                  S$RescriptSchema.literal("two")
                ]), undefined);
      }));

var polyWithSingleItemSchema = S$RescriptSchema.literal("single");

Ava("Polymorphic variant with single item becomes a literal schema of the item", (function (t) {
        U.assertEqualSchemas(t, polyWithSingleItemSchema, S$RescriptSchema.literal("single"), undefined);
      }));

var polyWithAliasSchema = S$RescriptSchema.union([
      S$RescriptSchema.literal("one"),
      S$RescriptSchema.literal("two")
    ]);

Ava("Polymorphic variant with partial @as usage", (function (t) {
        U.assertEqualSchemas(t, polyWithAliasSchema, S$RescriptSchema.union([
                  S$RescriptSchema.literal("one"),
                  S$RescriptSchema.literal("two")
                ]), undefined);
      }));

export {
  polySchema ,
  polyWithSingleItemSchema ,
  polyWithAliasSchema ,
}
/* polySchema Not a pure module */
