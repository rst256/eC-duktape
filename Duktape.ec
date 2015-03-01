


#include "duktape.h"

//I'm dont known how it work, may be this not work anyway
public:
 enum DuktapeTypes {
	DukNone = DUK_TYPE_NONE, 	
	DukUndefined = DUK_TYPE_UNDEFINED, 	
	DukNull = DUK_TYPE_NULL, 	
	DukBool = DUK_TYPE_BOOLEAN, 	
	DukNumber = DUK_TYPE_NUMBER, 	
	DukString = DUK_TYPE_STRING, 	
	DukObject = DUK_TYPE_OBJECT, 	
	DukBuffer = DUK_TYPE_BUFFER, 	
	DukPointer = DUK_TYPE_POINTER, 	
   DukLightfunc = DUK_TYPE_LIGHTFUNC,
};

union ScriptValueStore{
   char * str;
   void * func;
   double num;
   bool boolean;
}


class DuktapeValue
{
public:
   double num;
   int type;
   const char * save_str;
   bool bvalue;
   
   type = DUK_TYPE_UNDEFINED;
   num = 0;
   bvalue = false;
   save_str = "";
   
public:
	const char * GetString()
	{
		return save_str;
	}

	double GetNumber()
	{
		return num;
	}

	bool GetBoolean()
	{
		return bvalue;
	}


}


class DuktapeScript
{
public:
   duk_context *ctx;
   ctx = duk_create_heap_default();

   DuktapeValue Eval(const char * source_code)
   {
      DuktapeValue val {};
      int type;
      duk_push_string(ctx, source_code);
      duk_push_string(ctx, "eval");
      if (duk_pcompile(ctx, 0) != 0) {
         val.type = DUK_TYPE_UNDEFINED;
      }
      else
      {
         duk_call(ctx, 0);      /* [ func ] -> [ result ] */
         type = duk_get_type(ctx, -1);
//          switch(type){
//             case DUK_TYPE_NUMBER:
// 							val {
// 								num = duk_to_number(ctx, -1), 
// 								save_str = duk_safe_to_string(ctx, -1), 
// 								bvalue = (num ~= 0),
// 								type = type 
// 							}
// 							return var;
//             case DUK_TYPE_STRING:
// 							val {
// 								num = duk_to_number(ctx, -1), 
// 								save_str = duk_safe_to_string(ctx, -1), 
// 								bvalue = (num ~= 0),
// 								type = type 
// 							}
// 							return var;
//          }
         
      }
      val.save_str = duk_safe_to_string(ctx, -1);
      duk_pop(ctx);
      return val;
   }
   
   ~DuktapeScript()
   {
      duk_destroy_heap(ctx);
   }
}

