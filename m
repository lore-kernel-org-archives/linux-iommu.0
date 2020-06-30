Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79142C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:04:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F7120768
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q+4aMz5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F7120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1BE8F87740;
	Tue, 30 Jun 2020 17:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oqahwsm4Ovj8; Tue, 30 Jun 2020 17:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D03C876C4;
	Tue, 30 Jun 2020 17:04:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 707B0C0865;
	Tue, 30 Jun 2020 17:04:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A90F6C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9740A876E3
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJuybmdm7wpl for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 17:04:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 89BFA876C4
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:04:20 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efb70920001>; Wed, 01 Jul 2020 01:04:18 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 10:04:18 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Tue, 30 Jun 2020 10:04:18 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 17:04:16 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 17:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz8ogrX3yphWMmj28G0zrl7DPe4pQhteLVAFJ3I7kQ/KJhO2Wozbv7gXfv0VOT0uNlCGFrkGAzvQSrJnu7uPIt6dD9qkAgv/ULGMdoXkZlobPv4m9H07jXhb8bgVVOPdufivUVKCJubKB8KwQtWWejli8KS7PdAdaPsgssrIsxNM1zvT+vlbgRNmIg4Z7am6TGfGdPSNptIG7JpyccEYwOtcvH9dyzLYU8RvV/yvoQKoEx2pV6njMdSvBguj5DwTiMCE9g2B0H6xsQxLhlUZo4dPOBK25H3d4IxZmUQF1iZbVFmY8w68WJmkptXZa52Zy8TetqORzTfULfo3SWb3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjNOaagwuwlxcGNhARe11W8Vg/6fDbq00jf8kXsGFpM=;
 b=Hju9NBO0NoH2/YFmcfONRsocQFUHlElkjYrLSMDnKKm4220o/Ds2hBurjMQLjk+dqGyh92EqG5b+aE4yCmfZHNgN4x3QpRaSeMq+c6GxI2pa7OFnhmkXadc86P9VQYMGjM9eRSv7QbRnsNU/jzjCV2VewQ6VqP23K7HtIA/dfRhVt3RZjGKPthQUE/xy6e3A1+SwkHiKi5a2lxoUHX4WvpwUo5twCm5Uz8wrAtXGN0eO9i57X3qpEtB3N1Xr17DvSg8aHQqmKgPcyDgZN98Vu+qfOigXtGmUe2ytdcsHxbQb9+mhAD5F1vsxmTUO/xA3ORw6dGDBS7+EkXojsAoYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3415.namprd12.prod.outlook.com (2603:10b6:a03:d5::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 17:04:14 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 17:04:14 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
Thread-Topic: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw0WKAgACIGaA=
Date: Tue, 30 Jun 2020 17:04:14 +0000
Message-ID: <BYAPR12MB2822A100F2BE2D8141F0B585B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
In-Reply-To: <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T17:04:11.9890059Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=1317b412-78b4-4c24-ad7a-bf78d36dcba8;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bf44a11-efd4-4268-871c-08d81d179def
x-ms-traffictypediagnostic: BYAPR12MB3415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34154605E88379628E115FC5B36F0@BYAPR12MB3415.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7c10Hx2l3Ev3xlDCp68s7kxv9uT+ln8wmM49Rs5d9HWAm6bLtccoHC45IZklzUuMavhS7IJGKObnf7+KsO5QzSYCmWCtMz9y88zkdsBOF7rxJvEKY/XvI6dJ57uDN6uXxI7/ifnNlAk+Mfub+vKupYQLoUoJkMHbCSG+yJg7W88Tyfon0TiEWuCViIPfNja89d2gK5NsjjtG5Q2r6JIYEliYb357lmmwpz7YrYO/l3M2WmmKrIlz5RjR3g4DyzM/zWTOzT8qVswqID3BzsBugzoxcESvqjls7IaD8Op2N43VFSfFOhdHCqSninTRraR2EKiJa5EBNe7/a5xslmA/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(33656002)(478600001)(52536014)(316002)(5660300002)(54906003)(4326008)(71200400001)(6862004)(86362001)(66946007)(83380400001)(66556008)(76116006)(186003)(8676002)(6506007)(6636002)(55016002)(8936002)(9686003)(66476007)(64756008)(26005)(2906002)(66446008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 2vnzISzZQpZYaqDlxu9/jD4BcEO30jDyrtwkZb3Z1X85yCR3spEOplLKKFUZzVDK1olYyuOhkK+ntaymhnG+x1r+TJMajYrNqw+XCiP84OKIsKsGiMgrUtcthSVwaHdCBWx4bgb1HA2fnDiHX9ERKRpprS0pD6GXhhhBrvSByYU6m+jvOgE8DcD5tLq+Bac9uvSvCVvcJRT64RcHWDsDiVRqvuezfeQ7YC3ejvsa1/JkD2ulHOCJJ939MdhyAjfESm9+20ZnlsC1xBzBQ2MuVHJlV6W6vRCSVhpmHsPw2fs8gKcTjkeFQtfZfA54wt62ka1Df1bniCa2TIro2tVrFJoLfqFoBrYNsDChdkB8aO5/en+MUJef8QvvyPnM25nrmzxoY1VhdGnUjAYFirMcSNB1877VQMwvS+iXH/cYQ0UI4P+AddFY6Bey+0IeDt7Zuzcoe0sxKxyiGU8bActWRJ3eptSyF+CyduHKpkLwX7Uu9BL8hZ0M4BcTLO/QV+5T
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf44a11-efd4-4268-871c-08d81d179def
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 17:04:14.2559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4T/k9HB8ANt54+6wzcq2P4uBbQZC6nZcPS/uI8zN5sA2GnKRFygrgOPfUlACApHLTo0nnPcNoH4JGxz1p0ya3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3415
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593536658; bh=PjNOaagwuwlxcGNhARe11W8Vg/6fDbq00jf8kXsGFpM=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
 authentication-results:x-originating-ip:x-ms-publictraffictype:
 x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
 x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
 x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
 Content-Language:Content-Type:Content-Transfer-Encoding;
 b=q+4aMz5Qz5bkS1AddwShxE8G6xtJksYT9+3ID/I7SVXJJw6t7JZR7wtvj08qrMSUr
 l0vvKl7YlyGXkb0BPUzxAGN2JFbXoXSf4qY8dbQIQ+G2tGwPA7bj88NVefwft007Ce
 ltfPru16byiZkAIEspWN6szfEO2B2T7cMNSHMKgSxXSviaw31LJS0bTyMjAhAuki/k
 ahuYDch9nEyKRkveshf7CHiMiNzjbDpgunEuxE/DiK0Oi95s5V+JbP2AlXmxaeHB9i
 RGpf4sbVcTZovXfHhn2XAO9cq6dxujYpm2HDCD8iZiWCl7L345KVilgvDCc5my8ZXA
 iTCUS87vbwTfw==
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Bryan Huntsman <bhuntsman@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, Timo Alho <talho@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Yu-Huan
 Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Bitan Biswas <bbiswas@nvidia.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

>> NVIDIA's Tegra194 SoC uses two ARM MMU-500s together to interleave 
>> IOVA accesses across them.
>> Add NVIDIA implementation for dual ARM MMU-500s and add new compatible 
>> string for Tegra194 SoC SMMU topology.

>There is no description here of the 3rd SMMU that you mention below.
>I think that we should describe the full picture here.

This driver is primarily for dual SMMU config.  So, It is avoided in the commit message.
However, Implementation supports option to configure 3 instances identically with one SMMU DT node
and is documented in the implementation.

>> +
>> +static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
>> +			       unsigned int inst, int page)

>If you run checkpatch --strict on these you will get a lot of ...

>CHECK: Alignment should match open parenthesis
>#116: FILE: drivers/iommu/arm-smmu-nvidia.c:46:
>+static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
>+			       unsigned int inst, int page)

>We should fix these.

I will fix these if I need to push a new patch set.

>> +static void nvidia_smmu_write_reg(struct arm_smmu_device *smmu,
>> +			    int page, int offset, u32 val) {
>> +	unsigned int i;
>> +	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
>> +
>> +	for (i = 0; i < nvidia_smmu->num_inst; i++) {
>> +		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;

>Personally, I would declare 'reg' outside of the loop as I feel it will make the code cleaner and easier to read.

It was like that before and is updated to its current form to limit the scope of variables as per Thierry's comments in v6. 
We can just leave it as it is as there is no technical issue here.

-KR

--
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
