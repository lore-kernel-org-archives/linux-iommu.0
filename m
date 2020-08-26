Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA22BC433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 14:30:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F55D208E4
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 14:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EwUVFDRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F55D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1C06B87B3C;
	Wed, 26 Aug 2020 14:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLxjk98hPptK; Wed, 26 Aug 2020 14:30:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7938887B2E;
	Wed, 26 Aug 2020 14:30:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB90C016F;
	Wed, 26 Aug 2020 14:30:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22468C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 14:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0BAA887B3C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 14:30:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zlvp+t+QgthY for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 14:30:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3BA6787B2E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 14:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inOzT54MksqS8dfxovnNubKyEDYEduKICel/tL/UO5b38ryQXs6SS14l//MadC0bAkDbGSp7whc7IZqfarPARgIp6+ghTRkANRH09mOi/64iQr5ja+NZPaIyeR1PZ7n/QUWnfyJpjfiayirdG26OwNwfq61USwK5Kx0WLT1DB3qk1idGZtuVF07/JzeBOSqITZ3qeVRPd20eVC5JxSUYJ2zrtq9yw1MwqPsh0lYscgJ3G5PBjXypwHcx1ENHpvZSJBMkdwy+Hj9R2R1pO6uKcK4i2/iyR4G6Q42P0UMW8KoIgLzOwwP1wSSyaaQ4lYorN4NFmig9OG7jVj9Sy4dzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybRcWzBQyIaEgyANLxc03lmfB6FRpuNDl18kFFnA4Gs=;
 b=VSf/PF1/BGR/xNpNcMubMcfdRFMOlDhpXBD5oq4NpiGmEA9zaF883ZMjk1f8YZPwFGAQArWHALyBZNdvVaP/w1FGFAR/r4FQCCq/uMtO7iR93lZYS7NXn61AeyTE3WEfHxZVNTr7vhWbNrgSMmfd1TvMCYg99VRmuwcrVRQwVjSMYHj1Y0a2mv631S6ZdJC3982bG4ze9KPTPAHOVa1Hw+bOczj7p639/VWlV7No61anXQXG5NOn9SIkr7cDH4YjQoyS50sozsJ9PW/v/XgRqJz5bl+Vmqtw2AxMSyOCsz/PbgYUXLwWiLOA3rVnbduSM5UzxiBDUPghQY4GaC5L+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybRcWzBQyIaEgyANLxc03lmfB6FRpuNDl18kFFnA4Gs=;
 b=EwUVFDRv5r48lmx6YHSAbCn5cOQDYsBXyxMSduEb2hhvZj8gWKDeerIghdTkSp5FV/yjsfeZ33j33dEvCqxcwN7SlpjEPwWQAYQirxMlqN5voDRpUOTU5gKgrG4EOJKze3mScO3/NeDq0bTvEUr/FQnYC+rqEPfTQOr5QzQnKPk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3917.namprd12.prod.outlook.com (2603:10b6:208:166::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 14:14:43 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 14:14:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Topic: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Index: AQHWegTrKFaLvteaIU+zNTDEWFvNM6lKcXK8
Date: Wed, 26 Aug 2020 14:14:43 +0000
Message-ID: <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824105415.21000-1-joro@8bytes.org>
In-Reply-To: <20200824105415.21000-1-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-26T14:14:42.982Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac88b153-1235-473b-a297-08d849ca615b
x-ms-traffictypediagnostic: MN2PR12MB3917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB391746027C86EAB2E6401E5EF7540@MN2PR12MB3917.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIp25s7IfdFSki/0g+rd/1h/ocqKz0gAqOarZArzCxep/9azfiwE38KGnFNo5w6KKQVp1cyNygqmnZVWdxcRUtiIoD7tu3YpC+yhZ5FcyIvTtuE3+qStiz+9/v95AreBXSWvyppjS4XJ0ZWr7saE4FshzpYvRqk1Cmwnk2gj87y1b4IIrnnM57gA/A0IBucx+X4BUo72/JHCmpS+zuaCyTRT2haYDRoU1WIwOJU4bMjY2vkfTqWKiaEsDSS3+/W4RCqO8TB0UQfJSedpPAsJlb7/YDG8c8GdhAEoV78Y/14Dkd+CPUyWXGaXfg9+fxNaPkp9JPC/v9bkI6stCWnbJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(86362001)(9686003)(55016002)(52536014)(110136005)(54906003)(478600001)(6636002)(316002)(26005)(6506007)(19627405001)(53546011)(5660300002)(76116006)(8676002)(33656002)(4326008)(83380400001)(66446008)(66556008)(66946007)(66476007)(64756008)(186003)(2906002)(7696005)(71200400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: n7yljLWwp3ogStRiJOkn+n9IO9r7XZLJ4S2NApMis+rXVShpaGUojxbB2I+su7s9waz2HhalKkqn9AAbtIVwEfReeA5xhhsK22vLnA3Zw+cvx0QhtXpnEQIfaZhREB1OjGpwLJGew4wDWwR/dsjNEhj2X/V4ZuUVtJFaDdkJ8FM/tRba2YmINUY6G+ryaTe1eurWZQcXswKn221Plmhea1tMi1Xzae8dVqthWrTIs+GJWCzVlUH+WpY9m/4xLvDVcNbdgZPE1vuE+SvGC5J1hQ43JR++g4VTX6KlKJq0ofh2aINWtg8wiWrpg4tN9nLmwBkO/h6LA7V8IMSx2D8262VHDffUzKWM3+qTqkPwbzZ6pRUepCWctuDQL7Waxtrl494Ods0iSU9Z/LYR8PVoGwUTj+F8CwRAukZfBp9LyviQF+RT1jNOF6wdmGrnAWSPPQ9dbZSTsUsZEKUhrUacB4GFUHzSupYjdV7X5Umdhy7ez/8DVYgNR97B31Af6NNWhyH1O+q2OrwTbvCLbHP/7C1I4ra1aYjitlBDFn9ixMVSfAgGWvKk2cDJBls27QlVK0yfDQAXYxdknEmMniSwAJC7aUEo4Z5LNvkj/VCWZ6fQxF4OBX8RgbUERFiojWXQlLLJhxiHbheKAUR6iqwiJA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac88b153-1235-473b-a297-08d849ca615b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 14:14:43.7247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAtMRXcpcQJq90rsGtGnA1hEr2dzY7qQhIEUX/CfJ4Beb0omYQJA35f2IqsoFB9XDorUQ13TcA6Dx7tDU3LHNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3917
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "jroedel@suse.de" <jroedel@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: multipart/mixed; boundary="===============1387312929836075644=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1387312929836075644==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D6B7BBF98845DF796E0BF7540MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D6B7BBF98845DF796E0BF7540MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

+ Felix
________________________________
From: Joerg Roedel <joro@8bytes.org>
Sent: Monday, August 24, 2020 6:54 AM
To: iommu@lists.linux-foundation.org <iommu@lists.linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>; jroedel@suse.de <jroedel@suse.de>; Lend=
acky, Thomas <Thomas.Lendacky@amd.com>; Suthikulpanit, Suravee <Suravee.Sut=
hikulpanit@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; linux-=
kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active

From: Joerg Roedel <jroedel@suse.de>

Hi,

Some IOMMUv2 capable devices do not work correctly when SME is
active, because their DMA mask does not include the encryption bit, so
that they can not DMA to encrypted memory directly.

The IOMMU can jump in here, but the AMD IOMMU driver puts IOMMUv2
capable devices into an identity mapped domain. Fix that by not
forcing an identity mapped domain on devices when SME is active and
forbid using their IOMMUv2 functionality.

Please review.

Thanks,

        Joerg

Joerg Roedel (2):
  iommu/amd: Do not force direct mapping when SME is active
  iommu/amd: Do not use IOMMUv2 functionality when SME is active

 drivers/iommu/amd/iommu.c    | 7 ++++++-
 drivers/iommu/amd/iommu_v2.c | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

--
2.28.0


--_000_MN2PR12MB4488D6B7BBF98845DF796E0BF7540MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
+ Felix<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Joerg Roedel &lt;joro=
@8bytes.org&gt;<br>
<b>Sent:</b> Monday, August 24, 2020 6:54 AM<br>
<b>To:</b> iommu@lists.linux-foundation.org &lt;iommu@lists.linux-foundatio=
n.org&gt;<br>
<b>Cc:</b> Joerg Roedel &lt;joro@8bytes.org&gt;; jroedel@suse.de &lt;jroede=
l@suse.de&gt;; Lendacky, Thomas &lt;Thomas.Lendacky@amd.com&gt;; Suthikulpa=
nit, Suravee &lt;Suravee.Suthikulpanit@amd.com&gt;; Deucher, Alexander &lt;=
Alexander.Deucher@amd.com&gt;; linux-kernel@vger.kernel.org &lt;linux-kerne=
l@vger.kernel.org&gt;<br>
<b>Subject:</b> [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is acti=
ve</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Joerg Roedel &lt;jroedel@suse.de&gt;<br>
<br>
Hi,<br>
<br>
Some IOMMUv2 capable devices do not work correctly when SME is<br>
active, because their DMA mask does not include the encryption bit, so<br>
that they can not DMA to encrypted memory directly.<br>
<br>
The IOMMU can jump in here, but the AMD IOMMU driver puts IOMMUv2<br>
capable devices into an identity mapped domain. Fix that by not<br>
forcing an identity mapped domain on devices when SME is active and<br>
forbid using their IOMMUv2 functionality.<br>
<br>
Please review.<br>
<br>
Thanks,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Joerg<br>
<br>
Joerg Roedel (2):<br>
&nbsp; iommu/amd: Do not force direct mapping when SME is active<br>
&nbsp; iommu/amd: Do not use IOMMUv2 functionality when SME is active<br>
<br>
&nbsp;drivers/iommu/amd/iommu.c&nbsp;&nbsp;&nbsp; | 7 ++++++-<br>
&nbsp;drivers/iommu/amd/iommu_v2.c | 7 +++++++<br>
&nbsp;2 files changed, 13 insertions(+), 1 deletion(-)<br>
<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D6B7BBF98845DF796E0BF7540MN2PR12MB4488namp_--

--===============1387312929836075644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1387312929836075644==--
