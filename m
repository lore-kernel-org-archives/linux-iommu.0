Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACBFC28EBD
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 02:24:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992932064A
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 02:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992932064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 47C40CC6;
	Fri,  7 Jun 2019 02:24:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E26382C
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 02:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 868757F8
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 02:24:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Jun 2019 19:24:41 -0700
X-ExtLoop1: 1
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
	by orsmga002.jf.intel.com with ESMTP; 06 Jun 2019 19:24:41 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
	ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Thu, 6 Jun 2019 19:24:41 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.154]) by
	ORSMSX116.amr.corp.intel.com ([169.254.7.166]) with mapi id
	14.03.0415.000; Thu, 6 Jun 2019 19:24:40 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Device specific pass through in host systems - discuss user interface
Thread-Topic: Device specific pass through in host systems - discuss user
	interface
Thread-Index: AdUczaahXstQhucvR3yNMqqPH3ycoQ==
Date: Fri, 7 Jun 2019 02:24:39 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzVhZDE4ODgtMzRjZC00NmQwLThlMDAtNmE3NzM4YmZlNmNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWmhBV2VqdEZMeXhxemZJUCsyZFRCY2dONXJTcEZKdTh6bVZPNzN6UFBqM3RPWlBsTXQxbFV4Y1VLRTQ2allGUyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>, "Raj,
	Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"hch@lst.de" <hch@lst.de>, "Lu, Baolu" <baolu.lu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5533393041650543818=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============5533393041650543818==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_FFF73D592F13FD46B8700F0A279B802F48DA796EORSMSX114amrcor_"

--_000_FFF73D592F13FD46B8700F0A279B802F48DA796EORSMSX114amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am working on an IOMMU driver feature that allows a user to specify if th=
e DMA from a device should be translated by IOMMU or not. Presently, we sup=
port only all devices or none mode i.e. if user specifies "iommu=3Dpt" [X86=
] or "iommu.passthrough" [ARM64] through kernel command line, all the devic=
es would be in pass through mode and we don't have per device granularity, =
but, we were requested by a customer to selectively put devices in pass thr=
ough mode and not all.

Since, this feature could be generic across architectures, we thought it wo=
uld be better if the user interface is discussed in the community first. We=
 are envisioning this to be used both during boot time and runtime and henc=
e having a kernel command line argument along with a sysfs entry are needed=
. So, please pour in your suggestions on how the user interface should look=
 like to make it architecture agnostic.


1.      Have a kernel command line argument that takes a list of BDF's as a=
n input and puts them in pass through mode

a.      Accepting BDF as an input has a downside - BDF is dynamic and could=
 change if BIOS/OS enumerates a new device in next reboot

b.      Accepting <vendor_id:device_id> pair as an input has a downside - W=
hat to do when there are multiple such devices and user would like to put o=
nly some of them in PT mode

2.      Have a sysfs file which takes 1 or 0 as an input to enable/disable =
pass through mode. Some places that seem to be reasonable are

a.      /sys/class/iommu/dmar0/devices/

b.      /sys/kernel/iommu_groups/<id>/devices

I am looking for a consensus on *how the kernel command line argument shoul=
d look like and path for sysfs entry*. Also, please note that if a device i=
s put in pass through mode it won't be available for the guest and that's o=
k.

Regards,
Sai

PS: Idea credits: Ashok Raj

--_000_FFF73D592F13FD46B8700F0A279B802F48DA796EORSMSX114amrcor_
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
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:856650828;
	mso-list-type:hybrid;
	mso-list-template-ids:-833043052 845841552 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
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
<p class=3D"MsoNormal">Hi All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am working on an IOMMU driver feature that allows =
a user to specify if the DMA from a device should be translated by IOMMU or=
 not. Presently, we support only all devices or none mode i.e. if user spec=
ifies &#8220;iommu=3Dpt&#8221; [X86] or &#8220;iommu.passthrough&#8221;
 [ARM64] through kernel command line, all the devices would be in pass thro=
ugh mode and we don&#8217;t have per device granularity, but, we were reque=
sted by a customer to selectively put devices in pass through mode and not =
all.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Since, this feature could be generic across architec=
tures, we thought it would be better if the user interface is discussed in =
the community first. We are envisioning this to be used both during boot ti=
me and runtime and hence having a
 kernel command line argument along with a sysfs entry are needed. So, plea=
se pour in your suggestions on how the user interface should look like to m=
ake it architecture agnostic.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">1.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Have a kernel command line argument that takes a li=
st of BDF&#8217;s as an input and puts them in pass through mode<o:p></o:p>=
</p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level2 lfo1">
<![if !supportLists]><span style=3D"mso-list:Ignore">a.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Accepting BDF as an input has a downside &#8211; BD=
F is dynamic and could change if BIOS/OS enumerates a new device in next re=
boot<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level2 lfo1">
<![if !supportLists]><span style=3D"mso-list:Ignore">b.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Accepting &lt;vendor_id:device_id&gt; pair as an in=
put has a downside &#8211; What to do when there are multiple such devices =
and user would like to put only some of them in PT mode<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">2.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Have a sysfs file which takes 1 or 0 as an input to=
 enable/disable pass through mode. Some places that seem to be reasonable a=
re<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level2 lfo1">
<![if !supportLists]><span style=3D"mso-list:Ignore">a.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>/sys/class/iommu/dmar0/devices/<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l0 level2 lfo1">
<![if !supportLists]><span style=3D"mso-list:Ignore">b.<span style=3D"font:=
7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>/sys/kernel/iommu_groups/&lt;id&gt;/devices<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am looking for a consensus on *<b>how the kernel c=
ommand line argument should look like and path for sysfs entry</b>*. Also, =
please note that if a device is put in pass through mode it won&#8217;t be =
available for the guest and that&#8217;s ok.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">PS: Idea credits: Ashok Raj<o:p></o:p></p>
</div>
</body>
</html>

--_000_FFF73D592F13FD46B8700F0A279B802F48DA796EORSMSX114amrcor_--

--===============5533393041650543818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5533393041650543818==--
