(function(h,i){var b=function(l,k,d){if(l.addEventListener){l.addEventListener(k,d,false)}else{if(l.attachEvent){l.attachEvent("on"+k,function(){return d.call(l,window.event)})}}},c,e=new RegExp("\\bhover\\b","g"),a=[],f=function(k){var d=a.length;while(d--){if(a[d]&&k==a[d][1]){return a[d][0]}}return false},g=function(d){while(d&&d!=c&&d!=h){if("LI"==d.nodeName.toUpperCase()){var k=f(d);if(k){clearTimeout(k)}d.className=d.className?(d.className.replace(e,"")+" hover"):"hover"}d=d.parentNode}},j=function(d){while(d&&d!=c&&d!=h){if("LI"==d.nodeName.toUpperCase()){(function(k){var l=setTimeout(function(){k.className=k.className?k.className.replace(e,""):""},500);a[a.length]=[l,k]})(d)}d=d.parentNode}};clickShortlink=function(m){var l=m.target||m.srcElement,d,k;if("undefined"==typeof adminBarL10n){return}while(l&&l!=c&&l!=h&&(!l.className||-1==l.className.indexOf("ab-get-shortlink"))){l=l.parentNode}if(l&&l.className&&-1!=l.className.indexOf("ab-get-shortlink")){d=h.getElementsByTagName("link");if(!d.length){d=h.links}k=d.length;if(m.preventDefault){m.preventDefault()}m.returnValue=false;while(k--){if(d[k]&&"shortlink"==d[k].getAttribute("rel")){prompt(adminBarL10n.url,d[k].href);return false}}alert(adminBarL10n.noShortlink);return false}},b(i,"load",function(){var d=h.getElementsByTagName("body")[0],k=h.getElementById("adminbar-search");c=h.getElementById("wpadminbar");if(d&&c){d.appendChild(c);b(c,"mouseover",function(l){g(l.target||l.srcElement)});b(c,"mouseout",function(l){j(l.target||l.srcElement)});b(c,"click",clickShortlink)}if(k){if(""==k.value){k.value=k.getAttribute("title")}k.onblur=function(){this.value=""==this.value?this.getAttribute("title"):this.value};k.onfocus=function(){this.value=this.getAttribute("title")==this.value?"":this.value}}if(i.location.hash){i.scrollBy(0,-32)}})})(document,window);