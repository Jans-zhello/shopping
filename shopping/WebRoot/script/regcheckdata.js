//这个JS文件中的检查主要是弹出警告框   
function checkdata() {   
        
      //将用户名先转化成小写   
      var ssn=form.username.value.toLowerCase();   
        
      //用户名检查   
      if (!checkUserName(ssn)) return false;   
        
      //密码位数的检查   
      if( strlen(form.password.value)<6 || strlen(form.password.value)>16 ) {   
            alert("\正确地登录密码长度为6-16位，仅可用英文、数字、特殊字符！");   
            //将光标定位到密码输入栏，提高用户体验   
            form.password.focus();   
            return false;   
      }   
        
      //确认密码位数的检查   
      if( strlen2(form.password.value) ) {   
            alert("\您的密码中包含了非法字符，仅可用英文、数字、特殊字符！");   
            form.password.focus();   
            return false;   
      }   
        
      if( form.password.value == form.username.value ) {   
            alert("\用户名和密码不能相同！");   
            form.password.focus();   
            return false;   
      }   
        
      if( form.password2.value =="" ) {   
            alert("\请输入密码确认！");   
            form.password2.focus();   
            return false;   
      }   
        
      if( form.password2.value != form.password.value ) {   
            alert("\两次密码输入不一致！");   
            form.password.focus();   
            return false;   
      } 
      if( form.phone.value =="" ) {   
          alert("\请输入电话!");   
          form.phone.focus();   
          return false;   
      }
      //电话中是否有空格的检查   
      if (isWhiteSpace(form.phone.value)){   
            alert("\请输入正确的电话,电话中不能包含空格！");   
            form.phone.focus();   
            return false;   
      }
      if( form.addr.value =="" ) {   
          alert("\请输入地址!");   
          form.addr.focus();   
          return false;   
      }
      //地址中是否有空格的检查   
      if (isWhiteSpace(form.addr.value)){   
            alert("\请输入正确的地址,地址中不能包含空格！");   
            form.addr.focus();   
            return false;   
      }

      //所有单项的检查均通过，则该表单的检查通过   
      return true;   
}   
    
//检查用户名的函数   
function checkUserName(ssn){   
      //用户名长度检查   
      if( ssn.length<3 || ssn.length>18 ) {   
            alert("\请输入正确的用户名,用户名长度为3-18位！");   
            form.username.focus();   
            return false;   
      }   
      //用户名中是否有空格的检查   
      if (isWhiteSpace(ssn)){   
            alert("\请输入正确的用户名,用户名中不能包含空格！");   
            form.username.focus();   
            return false;   
      }   
      //用户名中是否含有不符合要求的字符的检查   
      if (!isSsnString(ssn)){   
            alert("\    对不起，您选择的用户名格式不正确或已被占用！用户名\n由a～z的英文字母(不区分大小写)、0～9的数字、点、减\n号或下划线组成，长度为3～18个字符，只能以数字或字母\n开头和结尾,例如:kyzy_001。");   
            form.username.focus();   
            return false;   
      }   
      return true;   
}   
    
//计算字符串的长度（字节个数）

// str.length:字符个数；这里说的是字符串中字节的个数，例如中为占2个字节

function strlen(str){   
      var len;   
      var i;   
      len = 0;   
      for (i=0;i<str.length;i++){   
            if (str.charCodeAt(i)>255) len+=2; else len++;   
      }   
      return len;   
}   
    
//检查是否是特殊字符（ASCII码的值大于255）   
function strlen2(str){   
      var len;   
      var i;   
      len = 0;   
      for (i=0;i<str.length;i++){   
            if (str.charCodeAt(i)>255) return true;   
      }   
      return false;   
}   
    
//检查是否有空格（包括空格、tab键、换行、回车）   
function isWhiteSpace (s)   
{   
      var whitespace = " \t\n\r";   
      var i;   
      for (i = 0; i < s.length; i++){     
            var c = s.charAt(i);   
            if (whitespace.indexOf(c) >= 0) { 
            // str.indexOf(subStr) 返回str中第一次出现子串subStr的位置 

                  return true;   
            }   
      }   
      return false;   
}   
    
//检查是否是特殊字符   
function isSsnString (ssn)   
{   
      var re=/^[0-9a-z][\w-.]*[0-9a-z]$/i;   
      // 请注意加^$,否则只要子串匹配了就会返回true; i表示忽略大小写 

      if(re.test(ssn)) 

      // RegExpObject.test(string) 如果字符串 string 中含有与 RegExpObject 匹配的文本，则返回 true，否则返回 false。调用 RegExp 对象 r 的 test() 方法，并为它传递字符串 s，与这个表示式是等价的：(r.exec(s) != null)。 
            return true;   
      else   
            return false;   
}   
    
function checkssn(gotoURL) {   
   var ssn=form.username.value.toLowerCase();   
   if (checkUserName(ssn)){   
         var open_url = gotoURL + "?username=" + ssn;   
         window.open(open_url,'','status=0,directories=0,resizable=0,toolbar=0,location=0,scrollbars=0,width=322,height=200');   
      }   
} 
