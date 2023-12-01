open Ppxlib
open Parsetree
open Ast_helper
open Util

type field = {
  name: string;
  maybe_alias: expression option;
  schema_expr: expression;
}

let generate_decoder fields =
  (* Use Obj.magic to cast to uncurried function in case of uncurried mode *)
  [%expr
    S.Object.factory
      (Obj.magic (fun (s : S.Object.ctx) ->
           [%e
             Exp.record
               (fields
               |> List.map (fun field ->
                      let original_field_name_expr =
                        match field.maybe_alias with
                        | Some alias -> alias
                        | None ->
                          Exp.constant
                            (Pconst_string (field.name, Location.none, None))
                      in

                      ( lid field.name,
                        [%expr
                          s.field [%e original_field_name_expr]
                            [%e field.schema_expr]] )))
               None]))]

let parse_decl {pld_name = {txt}; pld_loc; pld_type; pld_attributes} =
  let maybe_alias =
    match getAttributeByName pld_attributes "as" with
    | Ok (Some attribute) -> Some (getExpressionFromPayload attribute)
    | Ok None -> None
    | Error s -> fail pld_loc s
  in
  let optional_attrs = ["ns.optional"; "res.optional"] in
  let is_optional =
    optional_attrs
    |> List.map (fun attr -> getAttributeByName pld_attributes attr)
    |> List.exists (function
         | Ok (Some _) -> true
         | _ -> false)
  in
  let schema_expr = Codecs.generateSchemaExpression pld_type in
  let schema_expr =
    if is_optional then [%expr Obj.magic S.option [%e schema_expr]]
    else schema_expr
  in

  {name = txt; maybe_alias; schema_expr}

let generateSchemaExpression decls =
  let fields = List.map parse_decl decls in
  generate_decoder fields
