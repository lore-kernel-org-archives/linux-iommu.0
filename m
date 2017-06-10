From: "Wuzongyong (Cordius Wu, Euler Dept)" <wuzongyong1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: What differences and relations between SVM, HSA, HMM and Unified
	Memory?
Date: Sat, 10 Jun 2017 04:06:28 +0000
Message-ID: <9BD73EA91F8E404F851CF3F519B14AA8CE753F@SZXEMI503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7613027119385003390=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: zh-CN
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Wanzongshun (Vincent)" <wanzongshun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "oded.gabbay-5C7GfCeVMHo@public.gmane.org" <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7613027119385003390==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_9BD73EA91F8E404F851CF3F519B14AA8CE753FSZXEMI503MBSchina_"

--_000_9BD73EA91F8E404F851CF3F519B14AA8CE753FSZXEMI503MBSchina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Could someone explain differences and relations between the SVM(Shared Virt=
ual Memory, by Intel), HSA(Heterogeneous System Architecture, by AMD), HMM(=
Heterogeneous Memory Management, by Glisse) and UM(Unified Memory, by NVIDI=
A) ? Are these in the substitutional relation?
As I understand it, these aim to solve the same thing, sharing pointers bet=
ween CPU and GPU(implement with ATS/PASID/PRI/IOMMU support). So far, SVM a=
nd HSA can only be used by integrated gpu. And, Intel declare that the root=
 ports doesn't not have the required TLP prefix support, resulting  that SV=
M can't be used by discrete devices. So could someone tell me the required =
TLP prefix means what specifically?
With HMM, we can use allocator like malloc to manage host and device memory=
. Does this mean that there is no need to use SVM and HSA with HMM, or HMM =
is the basis of SVM and HAS to implement Fine-Grained system SVM defined in=
 the opencl spec?

Thanks,
Zongyong Wu


--_000_9BD73EA91F8E404F851CF3F519B14AA8CE753FSZXEMI503MBSchina_
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
	{margin:0cm;
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could someone explain differences and relations betw=
een the SVM(Shared Virtual Memory, by Intel), HSA(Heterogeneous System Arch=
itecture, by AMD), HMM(Heterogeneous Memory Management, by Glisse) and UM(U=
nified Memory, by NVIDIA) ? Are these
 in the substitutional relation?<o:p></o:p></p>
<p class=3D"MsoNormal">As I understand it, these aim to solve the same thin=
g, sharing pointers between CPU and GPU(implement with ATS/PASID/PRI/IOMMU =
support). So far, SVM and HSA can only be used by integrated gpu. And, Inte=
l declare that the root ports doesn&#8217;t
 not have the required TLP prefix support, resulting &nbsp;that SVM can&#82=
17;t be used by discrete devices. So could someone tell me the required TLP=
 prefix means what specifically?<o:p></o:p></p>
<p class=3D"MsoNormal">With HMM, we can use allocator like malloc to manage=
 host and device memory. Does this mean that there is no need to use SVM an=
d HSA with HMM, or HMM is the basis of SVM and HAS to implement Fine-Graine=
d system SVM defined in the opencl
 spec?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Zongyong Wu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_9BD73EA91F8E404F851CF3F519B14AA8CE753FSZXEMI503MBSchina_--


--===============7613027119385003390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7613027119385003390==--
