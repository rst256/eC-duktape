import "ecere"
import "Duktape"

class Form1 : Window
{
   caption = $"Form1";
   background = formColor;
   borderStyle = sizable;
   hasMaximize = true;
   hasMinimize = true;
   hasClose = true;
   menu = {  };
   clientSize = { 320, 304 };
   anchor = { horz = -7 };

   DuktapeScript duktapeScript{};
   EditBox editBox1 { this, caption = $"editBox1", size = { 294, 147 }, position = { 16, 16 }, multiLine = true, contents = $"function f(x){return x*x;}\n5+6+f(6)" };
   Button evalBtn
   {
      this, caption = $"Eval", size = { 40, 21 }, position = { 264, 176 };

      bool NotifyClicked(Button button, int x, int y, Modifiers mods)
      {
         DuktapeValue dv;
         dv = duktapeScript.Eval(editBox1.contents);
         evalResult.contents = dv.save_str;
         return true;
      }
   };
   EditBox evalResult { this, caption = $"editBox2", size = { 230, 91 }, position = { 24, 176 }, contents = $"uyuu" };

   bool OnCreate(void)
   {

      return true;
   }
}

Form1 form1 {};
