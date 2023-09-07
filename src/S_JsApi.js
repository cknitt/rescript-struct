import * as S_Js from "./S_JsApi.bs.mjs";
import * as S from "./S.bs.mjs";

export const StructError = S_Js.RescriptStructError;
export const string = S.string;
export const boolean = S.bool;
export const integer = S.$$int;
export const number = S.$$float;
export const json = S.json;
export const never = S.never;
export const unknown = S.unknown;
export const optional = S_Js.optional;
export const nullable = S.$$null;
export const array = S.array;
export const record = S.dict;
export const jsonString = S.jsonString;
export const union = S.union;
export const object = S_Js.object;
export const Object = S.$$Object;
export const String = S.$$String;
export const Number = S.Float;
export const Array = S.$$Array;
export const custom = S_Js.custom;
export const literal = S.literal;
export const tuple = S_Js.tuple;
export const asyncParserRefine = S_Js.asyncParserRefine;
export const refine = S_Js.refine;
export const transform = S_Js.transform;
export const description = S.description;
export const describe = S.describe;
export const parse = S_Js.parse;
export const parseOrThrow = S_Js.parseOrThrow;
export const parseAsync = S_Js.parseAsync;
export const serialize = S_Js.serialize;
export const serializeOrThrow = S_Js.serializeOrThrow;
