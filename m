From: "Zhuo, Qiuxu" <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Does a new booting kernel by "kexec -l" need to copy IR table from
	previous kernel?
Date: Thu, 27 Apr 2017 15:34:06 +0000
Message-ID: <E6AF1AFDEA62A94A97508F458CBDD47F6EBEFCC9@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8117286978986653876=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============8117286978986653876==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E6AF1AFDEA62A94A97508F458CBDD47F6EBEFCC9SHSMSX101ccrcor_"

--_000_E6AF1AFDEA62A94A97508F458CBDD47F6EBEFCC9SHSMSX101ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Joerg Roedel,

   When we run below command, the kernel message showed below confusing fai=
led messages:
         sudo kexec -l /boot/vmlinuz-4.11.0-rc7 --append=3Droot=3DUUID=3D27=
6659dd-77f0-47f9-967c-7643c260b746 --initrd=3D/boot/initrd.img-4.11.0-rc7
         sudo kexec -e
          ---
     [ 0.203397] DMAR-IR: Failed to copy IR table for dmar2 from previous k=
ernel
        [ 0.211568] DMAR-IR: Failed to copy IR table for dmar1 from previou=
s kernel
        [ 0.219738] DMAR-IR: Failed to copy IR table for dmar0 from previou=
s kernel
        [ 0.227906] DMAR-IR: Failed to copy IR table for dmar3 from previou=
s kernel
   ---

      The driver "intel_irq_remapping.c" uses "is_kdump_kernel()" API to de=
termine whether copy IR table from previous kernel.
      a) When booting a kdump kernel specified by "kexec -p" (loading the n=
ew kernel for use on panic), the "is_kdump_kernel()" API is true then the d=
river copy IR table from previous kernel.
      b) While when booting a new kernel specified by "kexec -l" (loading t=
he new kernel into current kernel) the "is_kdump_kernel()" API is false the=
n the driver prints error message "Failed to copy IR table from
            previous kernel" directly. It looks like the printk is misleadi=
ng and it's nothing actually failed, but just it isn't copying if the new k=
ernel is not a kdump kernel.

       Found that the commit id "af3b358e48115" said:
        ---
        iommu/vt-d: Copy IR table from old kernel when in kdump mode
        When we are booting into a kdump kernel and find IR enabled,
        copy over the contents of the previous IR table so that
        spurious interrupts will not be target aborted.
       ---

       May I ask some questions:
       What are spurious interrupts?
       For kdump kernel can we just reinitializing IR table(as like normal =
kernel boot from power on) to handle the "spurious interrupts" issue instea=
d of copying IR  table from previous kernel?
       For booting a new kernel by "kexec -l" (my test case), do we still n=
eed to copy IR table from previous kernel to handle the "spurious interrupt=
s" issue?

Thanks!
qiuxu




BR
qiuxu


--_000_E6AF1AFDEA62A94A97508F458CBDD47F6EBEFCC9SHSMSX101ccrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:178397522;
	mso-list-type:hybrid;
	mso-list-template-ids:-1618731704 -1149574696 67698713 67698715 67698703 6=
7698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:24.75pt;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:60.75pt;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:96.75pt;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:132.75pt;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.75pt;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:204.75pt;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:240.75pt;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:276.75pt;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:312.75pt;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Joerg Roedel,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;When we run below command, the ker=
nel message showed below confusing failed messages:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sud=
o kexec -l /boot/vmlinuz-4.11.0-rc7 --append=3Droot=3DUUID=3D276659dd-77f0-=
47f9-967c-7643c260b746 --initrd=3D/boot/initrd.img-4.11.0-rc7<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sud=
o kexec -e<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ---<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.0pt"><span style=3D"font-size=
:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#333333;background:w=
hite">&nbsp;&nbsp;&nbsp;&nbsp; [ 0.203397] DMAR-IR: Failed to copy IR table=
 for dmar2 from previous kernel</span><span style=3D"font-size:10.5pt;font-=
family:&quot;Arial&quot;,sans-serif;color:#333333"><br>
<span style=3D"background:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [ 0.211568] DMAR-IR: Failed to copy IR table for dmar1 from previous kerne=
l</span><br>
<span style=3D"background:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [ 0.219738] DMAR-IR: Failed to copy IR table for dmar0 from previous kerne=
l</span><br>
<span style=3D"background:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 [ 0.227906] DMAR-IR: Failed to copy IR table for dmar3 from previous kerne=
l<o:p></o:p></span></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.0pt"><span style=3D"font-size=
:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#333333;background:w=
hite">&nbsp;&nbsp; ---</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The driver &quot;inte=
l_irq_remapping.c&quot; uses &quot;is_kdump_kernel()&quot; API to determine=
 whether copy IR table from previous kernel.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a) When booting a kdu=
mp kernel specified by &quot;kexec -p&quot; (loading the new kernel for use=
 on panic), the &quot;is_kdump_kernel()&quot; API is true then the driver c=
opy IR table from previous kernel.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;b) While when booting=
 a new kernel specified by &quot;kexec -l&quot; (loading the new kernel int=
o current kernel) the &quot;is_kdump_kernel()&quot; API is false then the d=
river prints error message &quot;Failed to copy IR table from
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;previous kernel&quot; directly. It looks like the print=
k is misleading and it&#8217;s nothing actually failed, but just it isn&#82=
17;t copying if the new kernel is not a kdump kernel.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;Found that the =
commit id &quot;af3b358e48115&quot; said: <o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;iommu/vt-=
d: Copy IR table from old kernel when in kdump mode<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;When we a=
re booting into a kdump kernel and find IR enabled,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;copy over=
 the contents of the previous IR table so that<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;spurious =
interrupts will not be target aborted.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;---<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;May I ask some =
questions:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; What are spurio=
us interrupts? <o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For kdump =
kernel can we just reinitializing IR table(as like normal kernel boot from =
power on) to handle the &#8220;spurious interrupts&#8221; issue instead of =
copying IR&nbsp; table from previous kernel?
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For bootin=
g a new kernel by &#8220;kexec -l&#8221; (my test case), do we still need t=
o copy IR table from previous kernel to handle the &#8220;spurious interrup=
ts&#8221; issue?
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal">qiuxu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">qiuxu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_E6AF1AFDEA62A94A97508F458CBDD47F6EBEFCC9SHSMSX101ccrcor_--

--===============8117286978986653876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8117286978986653876==--
