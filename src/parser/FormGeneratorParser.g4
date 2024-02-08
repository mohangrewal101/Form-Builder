parser grammar FormGeneratorParser;
options { tokenVocab=FormGeneratorLexer; }

program: OBJECT_START pages (SEP variables)?  OBJECT_END;

// Pages Array
pages: PAGES_KEY COLON page_array;
page_array: LIST_START page (SEP page)* LIST_END;
page: OBJECT_START page_fields OBJECT_END;
page_fields: id_field (SEP header_field)? (SEP instructions_field)? (SEP displayQuestions_field)? (SEP goTo_field)? (SEP variables)? (SEP questions_field)?;
id_field: ID_KEY COLON STRING;
header_field: HEADER_KEY COLON (STRING | expression | variable_name);
instructions_field: INSTRUCTIONS_KEY COLON (STRING | expression | variable_name);
questions_field: QUESTIONS_KEY COLON question_array;
goTo_field: GOTO_KEY COLON goTo_object;
displayQuestions_field: DISPLAY_QUESTIONS_KEY COLON boolean;

// Vars object
variables: VARIABLES_KEY COLON variables_object;
variables_object: OBJECT_START (variable (SEP variable)*)? OBJECT_END;
variable: variable_name COLON variable_value;
variable_name: STRING;
variable_value: array | NUM | STRING | REGEX;

// goTo object {if: string, goTo: object}
goTo_object: OBJECT_START (IF_KEY COLON STRING SEP go_object)? OBJECT_END;

// go object { string, string, ... }
go_object: GO_KEY COLON OBJECT_START (go_object_key COLON go_object_value (SEP go_object_key COLON go_object_value)*)? OBJECT_END ;
go_object_key: STRING;
go_object_value: STRING;

// Question Array
question_array: LIST_START (question (SEP question)*)? LIST_END;
question: OBJECT_START question_fields OBJECT_END;
question_fields: id_field (SEP type_field)? (SEP label_field)? (SEP options_field)? (SEP dependsOn_field)? (SEP displayIf_field)? (SEP loop_field)? (SEP isRequired_field)? (SEP correctAnswer_field)? (SEP variables)? ;
type_field: TYPE_KEY COLON question_type;
label_field: LABEL_KEY COLON (STRING | expression | variable_name);
options_field: OPTIONS_KEY COLON array;
dependsOn_field: DEPENDS_ON_KEY COLON STRING;
displayIf_field: DISPLAY_IF_KEY COLON STRING | REGEX | expression;
loop_field: LOOP_KEY COLON NUM;
isRequired_field: IS_REQUIRED_KEY COLON boolean;
correctAnswer_field: CORRECT_ANSWER_KEY COLON STRING | NUM | REGEX | expression;


// Array & object definition
/** Start Code Generated by Copilot on Jan 30, 2024 */
array: LIST_START (array_value (SEP array_value)*)? LIST_END;
array_value: NUM | STRING;
/** End Code Generated by Copilot on Jan 30, 2024 */


// Question Types
question_type: TEXT_INPUT | RADIO | CHECKBOX | DROPDOWN;

// expressions
expression: math_expression | string_expression;

//math expression
math_expression: math_expression_with_op | math_expression_extended;
math_expression_with_op: (math_expression_val1 math_op math_expression_val2);
math_expression_extended: (NUM math_op math_expression);
math_expression_val1: NUM;
math_expression_val2: NUM;

//string expression
string_expression: string_expression_with_num | string_expression_extended;
string_expression_with_num: string_expression_val1 PLUS (string_expression_val2 | string_expression_num);
string_expression_extended: (STRING PLUS string_expression);
string_expression_val1: STRING;
string_expression_val2: STRING;
string_expression_num: NUM;


// Misc
boolean: TRUE | FALSE;
math_op: PLUS | MINUS | MULTIPLY | DIVIDE | MODULO;

