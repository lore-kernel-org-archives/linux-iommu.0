Return-Path: <SRS0=bYB5=FF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE065C64E7A
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 15:27:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DFA2084C
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 15:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DFA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BAFA88647F;
	Tue,  1 Dec 2020 15:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jeE52ydmXLf; Tue,  1 Dec 2020 15:27:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B55486469;
	Tue,  1 Dec 2020 15:27:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47B5AC1833;
	Tue,  1 Dec 2020 15:27:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 146C7C0859
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 12:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 04FB82E128
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 12:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ohd+mRaCi9Vl for <iommu@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 12:54:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by silver.osuosl.org (Postfix) with ESMTPS id A628B2E0DC
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 12:54:06 +0000 (UTC)
Received: from dggeme707-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Clhq314KJz13Kw9;
 Tue,  1 Dec 2020 20:53:19 +0800 (CST)
Received: from dggemi754-chm.china.huawei.com (10.1.198.140) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 1 Dec 2020 20:54:03 +0800
Received: from dggemi754-chm.china.huawei.com ([10.1.198.140]) by
 dggemi754-chm.china.huawei.com ([10.1.198.140]) with mapi id 15.01.1913.007;
 Tue, 1 Dec 2020 20:54:02 +0800
From: wangxingang <wangxingang5@huawei.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: Re: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Thread-Topic: Re: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation
 with unmanaged ASIDs
Thread-Index: AdbH3fUbMyyThiPFQMygEVWlNRJFKg==
Date: Tue, 1 Dec 2020 12:54:02 +0000
Message-ID: <79530f9bac8d49448ba871586e1c6c4b@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.226]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 01 Dec 2020 15:27:37 +0000
Cc: Xieyingtai <xieyingtai@huawei.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "maz@kernel.org" <maz@kernel.org>, "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: multipart/mixed; boundary="===============3078254442710533140=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============3078254442710533140==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_79530f9bac8d49448ba871586e1c6c4bhuaweicom_"

--_000_79530f9bac8d49448ba871586e1c6c4bhuaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Eric

On  Wed, 18 Nov 2020 12:21:43, Eric Auger wrote:
>@@ -1710,7 +1710,11 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>       * insertion to guarantee those are observed before the TLBI. Do be
>       * careful, 007.
>       */
>-      if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1) {
>+     if (ext_asid >=3D 0) { /* guest stage 1 invalidation */
>+              cmd.opcode     =3D CMDQ_OP_TLBI_NH_ASID;
>+              cmd.tlbi.asid    =3D ext_asid;
>+              cmd.tlbi.vmid   =3D smmu_domain->s2_cfg.vmid;
>+     } else if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1) {

Found a problem here, the cmd for guest stage 1 invalidation is built,
but it is not delivered to smmu.

--_000_79530f9bac8d49448ba871586e1c6c4bhuaweicom_
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
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
/* Page Definitions */
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
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Eric<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">On&nbsp; Wed, 18 Nov 2020 12:21=
:43, Eric Auger wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;@@ -1710,7 &#43;1710,11 @@ =
static void arm_smmu_tlb_inv_context(void *cookie)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; &nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;* insertion to guarantee those are observed before the TLBI. Do be<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; &nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;* careful, 007.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt; &nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (smmu_domain-&gt;stage =3D=3D ARM_SMMU_DOMAIN_S1) {<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;&#43;&nbsp;&nbsp;&nbsp;&nbs=
p; if (ext_asid &gt;=3D 0) { /* guest stage 1 invalidation */<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;&#43;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd.opcode&nbsp;&n=
bsp;&nbsp;&nbsp; =3D CMDQ_OP_TLBI_NH_ASID;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;&#43;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd.tlbi.asid&nbsp=
;&nbsp;&nbsp; =3D ext_asid;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;&#43;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd.tlbi.vmid&nbsp=
;&nbsp; =3D smmu_domain-&gt;s2_cfg.vmid;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;&#43;&nbsp;&nbsp;&nbsp;&nbs=
p; } else if (smmu_domain-&gt;stage =3D=3D ARM_SMMU_DOMAIN_S1) {<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Found a problem here, the cmd f=
or guest stage 1 invalidation is built,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">but it is not delivered to smmu=
.<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_79530f9bac8d49448ba871586e1c6c4bhuaweicom_--

--===============3078254442710533140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3078254442710533140==--
