From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/1] x86/iommu: use bit structures for context_entry
Date: Thu, 26 Dec 2013 05:12:04 +0000
Message-ID: <E959C4978C3B6342920538CF579893F001D3C26D@SHSMSX104.ccr.corp.intel.com>
References: <1387529101-29769-1-git-send-email-zhen-hual@hp.com>
	<CAOtp4KqUgSnwadP0T=aWYX7rRzDBn3qkuqMzceDBO0c_bhpFwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1605219915166384178=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOtp4KqUgSnwadP0T=aWYX7rRzDBn3qkuqMzceDBO0c_bhpFwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kai Huang <dev.kai.huang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1605219915166384178==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E959C4978C3B6342920538CF579893F001D3C26DSHSMSX104ccrcor_"

--_000_E959C4978C3B6342920538CF579893F001D3C26DSHSMSX104ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think if using |=3D operation, it should use &=3D operation to clear thos=
e bits first.

Thanks,
Feng

From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-bounces@lists.=
linux-foundation.org] On Behalf Of Kai Huang
Sent: Thursday, December 26, 2013 9:55 AM
To: Li, Zhen-Hua
Cc: David Woodhouse; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-fy+rA21nqHI@public.gmane.org=
rnel.org
Subject: Re: [PATCH 1/1] x86/iommu: use bit structures for context_entry

Just curious, why would |=3D operation cause problem? :)

On Fri, Dec 20, 2013 at 4:45 PM, Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org<mailto:zhen=
-hual-VXdhtT5mjnY@public.gmane.org>> wrote:
There is a structure named context_entry used by intel iommu, and there
are some bit operations on it. Use bit structure may make these operations
easy.
Also the function context_set_address_root may cause problem because it use=
s
 |=3D operation, not set the new value. And this patch can fix it.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org<mailto:zhen-hual-VXdhtT5mjnY@public.gmane.org>>
---
 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 43b9bfe..65cd480 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -221,47 +221,64 @@ get_context_addr_from_root(struct root_entry *root)
  * 8-23: domain id
  */
 struct context_entry {
-       u64 lo;
-       u64 hi;
+       union {
+               struct {
+                       u64     present:1,
+                               fpd:1,
+                               translation_type:2,
+                               reserved_l:8,
+                               asr:52;
+               };
+               u64 lo;
+       };
+       union {
+               struct {
+                       u64     aw:3,
+                               avail:4,
+                               reserved_h1:1,
+                               did:16,
+                               reserved_h2:40;
+               };
+               u64 hi;
+       };
 };

 static inline bool context_present(struct context_entry *context)
 {
-       return (context->lo & 1);
+       return context->present;
 }
 static inline void context_set_present(struct context_entry *context)
 {
-       context->lo |=3D 1;
+       context->present =3D 1;
 }

 static inline void context_set_fault_enable(struct context_entry *context)
 {
-       context->lo &=3D (((u64)-1) << 2) | 1;
+       context->fpd =3D 1;
 }

 static inline void context_set_translation_type(struct context_entry *cont=
ext,
                                                unsigned long value)
 {
-       context->lo &=3D (((u64)-1) << 4) | 3;
-       context->lo |=3D (value & 3) << 2;
+       context->translation_type =3D value;
 }

 static inline void context_set_address_root(struct context_entry *context,
                                            unsigned long value)
 {
-       context->lo |=3D value & VTD_PAGE_MASK;
+       context->asr =3D value >> VTD_PAGE_SHIFT
 }

 static inline void context_set_address_width(struct context_entry *context=
,
                                             unsigned long value)
 {
-       context->hi |=3D value & 7;
+       context->aw  =3D value;
 }

 static inline void context_set_domain_id(struct context_entry *context,
                                         unsigned long value)
 {
-       context->hi |=3D (value & ((1 << 16) - 1)) << 8;
+       context->did =3D value;
 }

 static inline void context_clear_entry(struct context_entry *context)
--
1.8.4.3

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org<mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
https://lists.linuxfoundation.org/mailman/listinfo/iommu


--_000_E959C4978C3B6342920538CF579893F001D3C26DSHSMSX104ccrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.hoenzb
	{mso-style-name:hoenzb;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">I think if=
 using |=3D operation, it should use &amp;=3D operation to clear those bits=
 first.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Thanks,<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Feng<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&qu=
ot;sans-serif&quot;"> iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iomm=
u-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org]
<b>On Behalf Of </b>Kai Huang<br>
<b>Sent:</b> Thursday, December 26, 2013 9:55 AM<br>
<b>To:</b> Li, Zhen-Hua<br>
<b>Cc:</b> David Woodhouse; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel@=
vger.kernel.org<br>
<b>Subject:</b> Re: [PATCH 1/1] x86/iommu: use bit structures for context_e=
ntry<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Just curious, why would |=3D op=
eration cause problem? :)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US">=
<o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">On Fri, Dec 20, 2013 at 4:45 PM=
, Li, Zhen-Hua &lt;<a href=3D"mailto:zhen-hual-VXdhtT5mjnY@public.gmane.org" target=3D"_blank">zh=
en-hual-VXdhtT5mjnY@public.gmane.org</a>&gt; wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">There is a structure named cont=
ext_entry used by intel iommu, and there<br>
are some bit operations on it. Use bit structure may make these operations<=
br>
easy.<br>
Also the function context_set_address_root may cause problem because it use=
s<br>
&nbsp;|=3D operation, not set the new value. And this patch can fix it.<br>
<br>
Signed-off-by: Li, Zhen-Hua &lt;<a href=3D"mailto:zhen-hual-VXdhtT5mjnY@public.gmane.org">zhen-hu=
al-VXdhtT5mjnY@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/iommu/intel-iommu.c | 37 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;1 file changed, 27 insertions(&#43;), 10 deletions(-)<br>
<br>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br>
index 43b9bfe..65cd480 100644<br>
--- a/drivers/iommu/intel-iommu.c<br>
&#43;&#43;&#43; b/drivers/iommu/intel-iommu.c<br>
@@ -221,47 &#43;221,64 @@ get_context_addr_from_root(struct root_entry *roo=
t)<br>
&nbsp; * 8-23: domain id<br>
&nbsp; */<br>
&nbsp;struct context_entry {<br>
- &nbsp; &nbsp; &nbsp; u64 lo;<br>
- &nbsp; &nbsp; &nbsp; u64 hi;<br>
&#43; &nbsp; &nbsp; &nbsp; union {<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct {<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; u64 &nbsp; &nbsp; present:1,<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fpd:1,<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; translation_type:2,<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reserved_l:8,<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; asr:52;<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; u64 lo;<br>
&#43; &nbsp; &nbsp; &nbsp; };<br>
&#43; &nbsp; &nbsp; &nbsp; union {<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct {<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; u64 &nbsp; &nbsp; aw:3,<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; avail:4,<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reserved_h1:1,<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; did:16,<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reserved_h2:40;<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };<br>
&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; u64 hi;<br>
&#43; &nbsp; &nbsp; &nbsp; };<br>
&nbsp;};<br>
<br>
&nbsp;static inline bool context_present(struct context_entry *context)<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; return (context-&gt;lo &amp; 1);<br>
&#43; &nbsp; &nbsp; &nbsp; return context-&gt;present;<br>
&nbsp;}<br>
&nbsp;static inline void context_set_present(struct context_entry *context)=
<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; context-&gt;lo |=3D 1;<br>
&#43; &nbsp; &nbsp; &nbsp; context-&gt;present =3D 1;<br>
&nbsp;}<br>
<br>
&nbsp;static inline void context_set_fault_enable(struct context_entry *con=
text)<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; context-&gt;lo &amp;=3D (((u64)-1) &lt;&lt; 2) | 1;<=
br>
&#43; &nbsp; &nbsp; &nbsp; context-&gt;fpd =3D 1;<br>
&nbsp;}<br>
<br>
&nbsp;static inline void context_set_translation_type(struct context_entry =
*context,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; unsigned long value)<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; context-&gt;lo &amp;=3D (((u64)-1) &lt;&lt; 4) | 3;<=
br>
- &nbsp; &nbsp; &nbsp; context-&gt;lo |=3D (value &amp; 3) &lt;&lt; 2;<br>
&#43; &nbsp; &nbsp; &nbsp; context-&gt;translation_type =3D value;<br>
&nbsp;}<br>
<br>
&nbsp;static inline void context_set_address_root(struct context_entry *con=
text,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; unsigned long value)<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; context-&gt;lo |=3D value &amp; VTD_PAGE_MASK;<br>
&#43; &nbsp; &nbsp; &nbsp; context-&gt;asr =3D value &gt;&gt; VTD_PAGE_SHIF=
T<br>
&nbsp;}<br>
<br>
&nbsp;static inline void context_set_address_width(struct context_entry *co=
ntext,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;unsigned long value)<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; context-&gt;hi |=3D value &amp; 7;<br>
&#43; &nbsp; &nbsp; &nbsp; context-&gt;aw &nbsp;=3D value;<br>
&nbsp;}<br>
<br>
&nbsp;static inline void context_set_domain_id(struct context_entry *contex=
t,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsi=
gned long value)<br>
&nbsp;{<br>
- &nbsp; &nbsp; &nbsp; context-&gt;hi |=3D (value &amp; ((1 &lt;&lt; 16) - =
1)) &lt;&lt; 8;<br>
&#43; &nbsp; &nbsp; &nbsp; context-&gt;did =3D value;<br>
&nbsp;}<br>
<br>
&nbsp;static inline void context_clear_entry(struct context_entry *context)=
<br>
<span class=3D"hoenzb"><span style=3D"color:#888888">--</span></span><span =
style=3D"color:#888888"><br>
<span class=3D"hoenzb">1.8.4.3</span><br>
<br>
<span class=3D"hoenzb">_______________________________________________</spa=
n><br>
<span class=3D"hoenzb">iommu mailing list</span><br>
<span class=3D"hoenzb"><a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">=
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a></span><br>
<span class=3D"hoenzb"><a href=3D"https://lists.linuxfoundation.org/mailman=
/listinfo/iommu" target=3D"_blank">https://lists.linuxfoundation.org/mailma=
n/listinfo/iommu</a></span></span><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_E959C4978C3B6342920538CF579893F001D3C26DSHSMSX104ccrcor_--

--===============1605219915166384178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1605219915166384178==--
