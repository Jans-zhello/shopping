//���JS�ļ��еļ����Ҫ�ǵ��������   
function checkdata() {   
        
      //���û�����ת����Сд   
      var ssn=form.username.value.toLowerCase();   
        
      //�û������   
      if (!checkUserName(ssn)) return false;   
        
      //����λ���ļ��   
      if( strlen(form.password.value)<6 || strlen(form.password.value)>16 ) {   
            alert("\��ȷ�ص�¼���볤��Ϊ6-16λ��������Ӣ�ġ����֡������ַ���");   
            //����궨λ������������������û�����   
            form.password.focus();   
            return false;   
      }   
        
      //ȷ������λ���ļ��   
      if( strlen2(form.password.value) ) {   
            alert("\���������а����˷Ƿ��ַ���������Ӣ�ġ����֡������ַ���");   
            form.password.focus();   
            return false;   
      }   
        
      if( form.password.value == form.username.value ) {   
            alert("\�û��������벻����ͬ��");   
            form.password.focus();   
            return false;   
      }   
        
      if( form.password2.value =="" ) {   
            alert("\����������ȷ�ϣ�");   
            form.password2.focus();   
            return false;   
      }   
        
      if( form.password2.value != form.password.value ) {   
            alert("\�����������벻һ�£�");   
            form.password.focus();   
            return false;   
      } 
      if( form.phone.value =="" ) {   
          alert("\������绰!");   
          form.phone.focus();   
          return false;   
      }
      //�绰���Ƿ��пո�ļ��   
      if (isWhiteSpace(form.phone.value)){   
            alert("\��������ȷ�ĵ绰,�绰�в��ܰ����ո�");   
            form.phone.focus();   
            return false;   
      }
      if( form.addr.value =="" ) {   
          alert("\�������ַ!");   
          form.addr.focus();   
          return false;   
      }
      //��ַ���Ƿ��пո�ļ��   
      if (isWhiteSpace(form.addr.value)){   
            alert("\��������ȷ�ĵ�ַ,��ַ�в��ܰ����ո�");   
            form.addr.focus();   
            return false;   
      }

      //���е���ļ���ͨ������ñ��ļ��ͨ��   
      return true;   
}   
    
//����û����ĺ���   
function checkUserName(ssn){   
      //�û������ȼ��   
      if( ssn.length<3 || ssn.length>18 ) {   
            alert("\��������ȷ���û���,�û�������Ϊ3-18λ��");   
            form.username.focus();   
            return false;   
      }   
      //�û������Ƿ��пո�ļ��   
      if (isWhiteSpace(ssn)){   
            alert("\��������ȷ���û���,�û����в��ܰ����ո�");   
            form.username.focus();   
            return false;   
      }   
      //�û������Ƿ��в�����Ҫ����ַ��ļ��   
      if (!isSsnString(ssn)){   
            alert("\    �Բ�����ѡ����û�����ʽ����ȷ���ѱ�ռ�ã��û���\n��a��z��Ӣ����ĸ(�����ִ�Сд)��0��9�����֡��㡢��\n�Ż��»�����ɣ�����Ϊ3��18���ַ���ֻ�������ֻ���ĸ\n��ͷ�ͽ�β,����:kyzy_001��");   
            form.username.focus();   
            return false;   
      }   
      return true;   
}   
    
//�����ַ����ĳ��ȣ��ֽڸ�����

// str.length:�ַ�����������˵�����ַ������ֽڵĸ�����������Ϊռ2���ֽ�

function strlen(str){   
      var len;   
      var i;   
      len = 0;   
      for (i=0;i<str.length;i++){   
            if (str.charCodeAt(i)>255) len+=2; else len++;   
      }   
      return len;   
}   
    
//����Ƿ��������ַ���ASCII���ֵ����255��   
function strlen2(str){   
      var len;   
      var i;   
      len = 0;   
      for (i=0;i<str.length;i++){   
            if (str.charCodeAt(i)>255) return true;   
      }   
      return false;   
}   
    
//����Ƿ��пո񣨰����ո�tab�������С��س���   
function isWhiteSpace (s)   
{   
      var whitespace = " \t\n\r";   
      var i;   
      for (i = 0; i < s.length; i++){     
            var c = s.charAt(i);   
            if (whitespace.indexOf(c) >= 0) { 
            // str.indexOf(subStr) ����str�е�һ�γ����Ӵ�subStr��λ�� 

                  return true;   
            }   
      }   
      return false;   
}   
    
//����Ƿ��������ַ�   
function isSsnString (ssn)   
{   
      var re=/^[0-9a-z][\w-.]*[0-9a-z]$/i;   
      // ��ע���^$,����ֻҪ�Ӵ�ƥ���˾ͻ᷵��true; i��ʾ���Դ�Сд 

      if(re.test(ssn)) 

      // RegExpObject.test(string) ����ַ��� string �к����� RegExpObject ƥ����ı����򷵻� true�����򷵻� false������ RegExp ���� r �� test() ��������Ϊ�������ַ��� s���������ʾʽ�ǵȼ۵ģ�(r.exec(s) != null)�� 
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
