<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
  <head>
    <title>口令对称加密</title>
    <link rel="stylesheet" href="<c:url value="/resource/style.css" />" />
    <script type="text/javascript" src="<c:url value="/resource/script.js" />"></script>
  </head>
  <script type="text/javascript">
  window.addOnLoadListener(function() {
      var alg = $('algorithm');
      alg.value = '${algorithm}';
      if(alg.value == '') {
        alg.value = alg.options[0].value;
      }
    });
  window.addOnLoadListener(function() {
      var alg = $('algorithm');
      var opts = alg.options;
      for(var i = 0, k = opts.length; i < k; i++) {
        opts[i].title = opts[i].innerHTML;
      }
    });
  </script>
  <body>
    <h1>口令对称加密</h1>
    <form action="<c:url value="/CryptologyServlet" />" method="post">
      <table cellpadding="0">
        <colgroup>
          <col class="width15" />
          <col class="width30" />
          <col class="width15" />
          <col class="width30" />
        </colgroup>
        <tr>
          <th>数据</th>
          <td colspan="3"><textarea name="data" class="input">${data}</textarea></td>          
        </tr>
        <tr>
          <th>算法</th>
          <td>
            <select name="algorithm" id="algorithm" class="input">              
              <option value="PBEWithMD5AndDES">PBEWithMD5AndDES</option>
              <option value="PBEWithMD5AndTripleDES">PBEWithMD5AndTripleDES</option>
              <option value="PBEWithSHA1AndDESede">PBEWithSHA1AndDESede</option>
              <option value="PBEWithSHA1AndRC2_40">PBEWithSHA1AndRC2_40</option>
              <option value="PBEWithMD5AndRC2">PBEWithMD5AndRC2 (BC)</option>
              <option value="PBEWithSHA1AndDES">PBEWithSHA1AndDES (BC)</option>
              <option value="PBEWithSHA1AndRC2">PBEWithSHA1AndRC2 (BC)</option>
              <option value="PBEWithMD5And128BitAES-CBC-OpenSSL">PBEWithMD5And128BitAES-CBC-OpenSSL (BC)</option>
              <option value="PBEWithMD5And192BitAES-CBC-OpenSSL">PBEWithMD5And192BitAES-CBC-OpenSSL (BC)</option>
              <option value="PBEWithMD5And256BitAES-CBC-OpenSSL">PBEWithMD5And256BitAES-CBC-OpenSSL (BC)</option>              
              <option value="PBEWithSHA256And128BitAES-CBC-BC">PBEWithSHA256And128BitAES-CBC-BC (BC)</option>
              <option value="PBEWithSHA256And192BitAES-CBC-BC">PBEWithSHA256And192BitAES-CBC-BC (BC)</option>
              <option value="PBEWithSHA256And256BitAES-CBC-BC">PBEWithSHA256And256BitAES-CBC-BC (BC)</option>              
              <option value="PBEWithSHAAnd128BitAES-CBC-BC">PBEWithSHAAnd128BitAES-CBC-BC (BC)</option>
              <option value="PBEWithSHAAnd192BitAES-CBC-BC">PBEWithSHAAnd192BitAES-CBC-BC (BC)</option>
              <option value="PBEWithSHAAnd256BitAES-CBC-BC">PBEWithSHAAnd256BitAES-CBC-BC (BC)</option>              
              <option value="PBEWithSHAAnd40BitRC2-CBC">PBEWithSHAAnd40BitRC2-CBC (BC)</option>
              <option value="PBEWithSHAAnd40BitRC4">PBEWithSHAAnd40BitRC4 (BC)</option>
              <option value="PBEWithSHAAnd128BitRC2-CBC">PBEWithSHAAnd128BitRC2-CBC (BC)</option>
              <option value="PBEWithSHAAnd128BitRC4">PBEWithSHAAnd128BitRC4 (BC)</option>      
              <option value="PBEWithSHAAnd2-KeyTripleDES-CBC">PBEWithSHAAnd2-KeyTripleDES-CBC (BC)</option>
              <option value="PBEWithSHAAnd3-KeyTripleDES-CBC">PBEWithSHAAnd3-KeyTripleDES-CBC (BC)</option>
              <option value="PBEWithSHAAndIDEA-CBC">PBEWithSHAAndIDEA-CBC (BC)</option>
              <option value="PBEWithSHAAndTwoFish-CBC">PBEWithSHAAndTwoFish-CBC (BC)</option>              
            </select>
          </td>
          <th>口令</th>
          <td><input type="text" name="password" value="${password}" class="input" /></td>
        </tr>
        <tr>
          <th>加密解密盐</th>
          <td colspan="3"><textarea name="parameterSpec" class="input">${parameterSpec}</textarea></td>
        </tr>
        <tr>
          <th>加密解密</th>
          <td>
            <input type="radio" name="mode" value="1" checked="checked" />加密
            <input type="radio" name="mode" value="2" <c:if test="${mode eq '2'}"> checked="checked"</c:if> />解密
          </td>
          <th>使用 BC</th>
          <td><input type="checkbox" name="bc" value="bc"<c:if test="${bc eq 'bc'}"> checked="checked"</c:if> /></td>
        </tr>
      </table>
      <input type="hidden" name="service" value="PBECrypto" />
      <input type="submit" value="提交" />
    </form>
    <span>调用信息: </span>${info}
    <c:if test="${not empty result}">
    <table cellpadding="0">
      <colgroup>
        <col class="width15" />
        <col class="width30" />
        <col class="width15" />
        <col class="width30" />
      </colgroup>
      <tr>
        <th>加密算法</th>
        <td>${result.algorithm}</td>
        <th>Provider</th>
        <td>${result.provider}</td>
      </tr>
      <c:if test="${mode eq 1}">
        <tr>
          <th>密文长度</th>
          <td colspan="3">${result.crypto.bitLength} bit(s), ${result.crypto.length} byte(s)</td>
        </tr>
        <tr>
          <th>密文<br/>(HEX)</th>
          <td colspan="3"><textarea readonly="readonly">${result.crypto.hex}</textarea></td>
        </tr>
        <tr>
          <th>密文<br/>(Base64)</th>
          <td colspan="3"><textarea readonly="readonly">${result.crypto.base64}</textarea></td>
        </tr>
      </c:if>
      <c:if test="${mode eq 2}">
        <tr>
          <th>解密明文</th>
          <td colspan="3"><c:out value="${result.crypto.string}" /></td>
        </tr>
        <tr>
          <th>解密明文<br/>(HEX)</th>
          <td colspan="3"><textarea readonly="readonly">${result.crypto.hex}</textarea></td>
        </tr>
      </c:if>
      <c:if test="${not result.parameterSpec['empty']}">
        <tr>
          <th>盐长度</th>
          <td colspan="3">${result.parameterSpec.bitLength} bit(s), ${result.parameterSpec.length} byte(s)</td>
        </tr>
        <tr>
          <th>盐<br/>(HEX)</th>
          <td colspan="3"><textarea readonly="readonly">${result.parameterSpec.hex}</textarea></td>
        </tr>
      </c:if>
    </table>
    </c:if>
  </body>
</html>