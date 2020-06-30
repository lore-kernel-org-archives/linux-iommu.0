Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D4EC433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D16B20723
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PsL9QixB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D16B20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 547BA8831B;
	Tue, 30 Jun 2020 17:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CCTlsff5jOSl; Tue, 30 Jun 2020 17:16:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D37FE87EBA;
	Tue, 30 Jun 2020 17:16:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE64BC0865;
	Tue, 30 Jun 2020 17:16:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E37AC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 16745879AB
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:16:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6SSaybvI6VYl for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 17:16:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8DD11879A1
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:16:17 +0000 (UTC)
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efb735f0000>; Wed, 01 Jul 2020 01:16:16 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
 by hkpgpgate102.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 10:16:16 -0700
X-PGP-Universal: processed;
 by hkpgpgate102.nvidia.com on Tue, 30 Jun 2020 10:16:16 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 17:16:12 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 17:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+fUZABkWpK08pLQEbOIHGY8XLy0B+RHNHSnGUoS+NGKOXf8VGFqopWTYz9cuAFyqRpncySLiTlKNNacmi68EoZ/7v6jyTbIaQl2VyjSORWaLU4FBqpOzYTmdm3q/xUWf+YRWsvQ+sugeJhjw/JA/QE7g/0lwIryzlQowdOkE6a2MiN+4g3DmYGQisEGaAezbXp6ziNBB2vt8aJiqqKMA/CCJX3MbdJ9iIPIqpMwXiDCHkLtYVbGfCXzkKVz51atfwySjQNt5ocDPFTdsKkGlN4ME8zqcAdajW0HS9zxlPbEEjTu7e3h0ieRGX5LYMwPY3r1LEwIvGUkZiA/NEJLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rpWkPa4G2BpSb5xcr1KVEdWuniqSALHDaJZNgqVOac=;
 b=WtKai+0yi7qx7YDoCK/TguEaYfMHhtKCT4C1FXjRsHesEXdBtSeNvmOb0fg5MJHB3EgILGJ38ZCDakkQlsEzEoFitHRc0BbVg50dOy5UBbr/hxnY3GErCGcW2lsnoJnhdLaGug2la5+PyX6HZVHyEcLUKnSPf8Y0jUgvC83xFuc9WiqednKQL7XgU8VZYoMibMmgmKUCWin3910im1RQjO6WOxS+GR9t2H89UPdjcYiekO3XxtQ14rOY1dRj71lNN1IKT4HPFddTbOQdvrNHeojrhaze/JW1XC2/HccgnFxR2QrdPkogNiJ68FZJaloZ8SfH7mEdoAVkBTqjtMYI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 17:16:10 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 17:16:09 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
Thread-Topic: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw8nYAgABivFCAAAYNgIAAA0WAgAAGCAA=
Date: Tue, 30 Jun 2020 17:16:09 +0000
Message-ID: <BYAPR12MB2822B43B0218F6E55C97451BB36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
 <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <4037efc7-fbed-e8cf-dac7-212c65014e4e@nvidia.com>
 <eb0ffc7e-f41b-d17c-6a90-049335098cd2@nvidia.com>
In-Reply-To: <eb0ffc7e-f41b-d17c-6a90-049335098cd2@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T17:16:08.1378150Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=9312166d-7c3d-4376-93ca-0c1bb1b6d0ee;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49c3dc5a-94f8-4b05-3ef7-08d81d194875
x-ms-traffictypediagnostic: BYAPR12MB3126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31267AEF461B142437C9446DB36F0@BYAPR12MB3126.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoZSV0Jgzs5uYk/Hdd0uSh8EsZvevrHBZ+AUcR3+z7sjftWvQObYM9JxyRmNdLGWYSiW7EnupfO/U0tYdSO9n0G2g1UDRD0QuUmGBp/ea5SnNU4HXaGz5O1bdkys8B9niCwHhe6hPYr9xea+kIdUQ7J6KUatjHqMJI9F7LFlwPaS3SLmNuINnyWOisiWAPmhETTiV0hceDSRQFPTblDs8BYeR0SW90vCtf5gIQr5FMeow7WXD1ahTg2W/awAatixTTK1B/GWGg44DcrxRFVKvE2i/0EF+WbCukSLDMsJht4ydTnrmb/IKWbWQXsJrUi8EZvO4EQM3kiuCvv167NALg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(9686003)(7696005)(6636002)(6506007)(86362001)(4744005)(8936002)(71200400001)(33656002)(5660300002)(478600001)(2906002)(8676002)(54906003)(4326008)(66446008)(26005)(6862004)(316002)(55016002)(76116006)(66946007)(66556008)(66476007)(64756008)(52536014)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ffo5rliOMSfvJ2bDNl0uodDl+d6TocgWCq8GIFaxaXVu9Gl5RHzthZgQoeuAwJVYsDVAKH9ri88H+NOhY4/Y/5BfdDovSyUmFCcDwFHpNWhPvFPI5H+Brc//ZNCjP5UbGsFcCnMARJWVHBQZcn41qdSO/yGrJeJFVilS3PQ6jZN/zq8ZsbXoWFSNkulMssWyvrcDIZDVl2cyRdtmpStkrme8ddxs+FiqBHglM2SKorAag47ixZ6rPJ6+MaG/em+vdB84gYLyvRPnqZtexbRLgswZiWjTv0iXVVuq/NUx78xoTHPXqZy31yJ2PjTJGkrHzRBGoMyv7rcZzYS97gYGNun0lUolksua1j6dwdh98zZzNSnafM0HD5ZkZfTQew3l7Qp7wi7fdDD7w42xeMKWADlc7z7X+t+HGrSaRh4u/0ZuMqxQYFedW/BB3oMfKfhTM5wjtmkELObyiyCX9/Hj3Vg335SK0TJZ4gFYUPlkZlyB7r8dJOs2dyQNneaLRiwT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c3dc5a-94f8-4b05-3ef7-08d81d194875
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 17:16:09.7947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wr4H5bsA5FtAIF0kmWiL6iiIYHO28paKasv6WgqZQZvE1MQ+KWF9SXd6rK494r8nQdJJHJyWay+NSY5WlY14+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593537376; bh=/rpWkPa4G2BpSb5xcr1KVEdWuniqSALHDaJZNgqVOac=;
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
 b=PsL9QixBsP51o7ATracMVmH1L2RSjzITpziJo81J/oGMjvJ7XhQohBdYXs7bC1/I2
 rlvSHLB04gRQPm8a5F/3hIIGhN5+NHlvWVg4W7xu3farHJfrbgr6G3kJyvr9TRwdKn
 jYCWnrcQPZiZuWz7DMdyM/F2vOYRH0eUoyILgdND3GCpbS6J0rpjg1qhmB/YE0LBVp
 dQXrNeo3LNdrd21xON4c2qMTJ0VpCbHKXMkdjfWkUnTkSTKKZEgG4ukeUo+vfVZOi/
 zBFlcJpW72wHRo0GVtD2VXOE1mSfuMZdOX5+arcOmmH8PzbjKkYmAhdrGf0Qf/95wX
 AZpvLlmiAhudg==
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

>OK, well I see what you are saying, but if we intended to support all 3 for Tegra194, then we should ensure all 3 are initialised correctly.

The driver intend to support up to 3 instances. It doesn't really mandate that all three instances be present in same DT node.
Each mmio aperture in "reg" property is an instance here. reg = <inst0_base, size>, <inst1_base, size>, <inst2_base, size>;
The reg can have all three or less and driver just configures based on reg and it works fine.

>It would be better to query the number of SMMUs populated in device-tree and then ensure that all are initialised correctly.

Getting the IORESOURCE_MEM is the way to count the instances driver need to support.  
In a way, It is already querying through IORESOURCE_MEM here. 


-KR

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
