From: "Allan, Bruce W" <bruce.w.allan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: DMA alias quirk
Date: Sat, 15 Nov 2014 01:27:47 +0000
Message-ID: <804857E1F29AAC47BF68C404FC60A1846586CA3B@ORSMSX105.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1605313105923548514=="
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
To: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1605313105923548514==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_804857E1F29AAC47BF68C404FC60A1846586CA3BORSMSX105amrcor_"

--_000_804857E1F29AAC47BF68C404FC60A1846586CA3BORSMSX105amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

For a PCIe device with SR-IOV support enabled (e.g. the PF device ID is 0xf=
001 at 0000:07:00.0 and the 16 VFs have device ID 0xf002 at 0000:07:01.0 th=
rough 0000:07:02.7), if the hardware attempts a DMA read/write of memory th=
at was mapped by the PF devfn but instead uses a requester id of one of the=
 VF devfns (enabled but not yet assigned to a VM) it fails and generates lo=
g messages similar to:

[  416.800881] dmar: DRHD: handling fault status reg 2
[  416.800887] dmar: DMAR:[DMA Read] Request device [07:02.2] fault addr ff=
ff0000
DMAR:[fault reason 02] Present bit in context entry is clear

Shouldn't a DMA alias quirk that sets the PCI_DEV_FLAGS_DMA_ALIAS_DEVFN fla=
g and dma_alias_devfn to the PF devfn for all VF devfns work-around this is=
sue, or am I misunderstanding what a DMA alias quirk is supposed to do?  If=
 a DMA alias quirk cannot resolve this, what is the most appropriate way to=
 handle this?

Thanks,
Bruce.

--_000_804857E1F29AAC47BF68C404FC60A1846586CA3BORSMSX105amrcor_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<p class=3D"MsoNormal">For a PCIe device with SR-IOV support enabled (e.g. =
the PF device ID is 0xf001 at 0000:07:00.0 and the 16 VFs have device ID 0x=
f002 at 0000:07:01.0 through 0000:07:02.7), if the hardware attempts a DMA =
read/write of memory that was mapped
 by the PF devfn but instead uses a requester id of one of the VF devfns (e=
nabled but not yet assigned to a VM) it fails and generates log messages si=
milar to:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[&nbsp; 416.800881] dmar: DRHD: handling fault statu=
s reg 2<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 416.800887] dmar: DMAR:[DMA Read] Request de=
vice [07:02.2] fault addr ffff0000<o:p></o:p></p>
<p class=3D"MsoNormal">DMAR:[fault reason 02] Present bit in context entry =
is clear<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Shouldn&#8217;t a DMA alias quirk that sets the PCI_=
DEV_FLAGS_DMA_ALIAS_DEVFN flag and dma_alias_devfn to the PF devfn for all =
VF devfns work-around this issue, or am I misunderstanding what a DMA alias=
 quirk is supposed to do?&nbsp; If a DMA alias
 quirk cannot resolve this, what is the most appropriate way to handle this=
?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Bruce.<o:p></o:p></p>
</div>
</body>
</html>

--_000_804857E1F29AAC47BF68C404FC60A1846586CA3BORSMSX105amrcor_--

--===============1605313105923548514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1605313105923548514==--
