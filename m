Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71B0C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 20:21:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A181206B6
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 20:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dimS1Y+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A181206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 621558610F;
	Tue, 30 Jun 2020 20:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4L1-_eFarHKv; Tue, 30 Jun 2020 20:21:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ED74C860FE;
	Tue, 30 Jun 2020 20:21:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D97C6C088F;
	Tue, 30 Jun 2020 20:21:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C56EC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 20:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6A4E5879F8
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 20:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4TRPUvt1cyo0 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 20:21:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E5A087895
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 20:21:54 +0000 (UTC)
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efb9ee00000>; Wed, 01 Jul 2020 04:21:52 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
 by hkpgpgate102.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 13:21:52 -0700
X-PGP-Universal: processed;
 by hkpgpgate102.nvidia.com on Tue, 30 Jun 2020 13:21:52 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 20:21:47 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS)
 id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 20:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiFHOpsh7vZK57P/Zpxxxb2Ku6dz4uBgQkop/WEa90petb8S7a5JnJDBCoYAjOOwy6ERUWy3Ne6tMhAazwxuDDDuaQ9zPPX0Tr/OLlGZhIdOE97ts+GzUlxvN4JIW1HiI28U+jDyRyi9EsjNxsmTa/me4XGNSQjikJDJE0c/Yy4Y+9/Bv1NGS5lkWN5AGP9EYcXYNdmZfe22dHkzydD2wm5HYFeGlL0IgFsX/CNwySp0NrjvArew/x6jW0OABaiz91qUkLRtERhEsrOzgUV7ZhXyoO+dHI40oka1SG6r+d/HzGm2fD/X8TdloPrQWlMmBQoYE8LPrUUjQJLh8IxfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9TmtNU1To6IxI+EH+P3BHjtxVj6UUA2yhTMaYLkcJI=;
 b=OFTPqql2e5EqDooH80QUxD5XTlczrsIeCzhUZv9RX82icNm0Ncm0k2L0ABBp3Z5c8MQr3Je3jLobpfaiKWZvMcq+ZsPqrMxECJgDU7f7xbpDeBSaj8r2N5LdiTaisO3G9e9L+n5wvx16LlFM+N7uCUrKSipUWgv5Aw8Ci72XFI+RwsdpX+HFGHZrWvgUnaEC+t69p5Uu8g8rd+e3UrRFShyx0P+isFbvVF2MKbJyCbpW1qfYKVTCoVkTF3r2cmsKVMSeCb6rQBZoD8N31c7MdAmvDAXeaIVMEwa0s+MBo0Fe4Hzd+pcpWnK/nvAimacNKAV1ZBz5xkCVX9odq6KaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 20:21:44 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 20:21:44 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
Thread-Topic: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw8nYAgABivFCAAAYNgIAAA0WAgAAGCACAACC4AIAAFN+A
Date: Tue, 30 Jun 2020 20:21:44 +0000
Message-ID: <BYAPR12MB282290F6E270DB90040379A0B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
 <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <4037efc7-fbed-e8cf-dac7-212c65014e4e@nvidia.com>
 <eb0ffc7e-f41b-d17c-6a90-049335098cd2@nvidia.com>
 <BYAPR12MB2822B43B0218F6E55C97451BB36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <64ffa84f-a8cf-ae81-6306-b5d8b1ff0618@nvidia.com>
In-Reply-To: <64ffa84f-a8cf-ae81-6306-b5d8b1ff0618@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T20:21:42.5016349Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=e86ac2ad-94a5-4360-b4fe-863d47606bad;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [71.202.129.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30b2cd1e-c839-4a24-cf86-08d81d33350a
x-ms-traffictypediagnostic: BYAPR12MB3191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31911783FCEEF540DC5476E7B36F0@BYAPR12MB3191.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9D0EPOHLLsgQl6+NSl7GbzxP6IgfyvIH4wxNzWyxuYt96se0Gl85/kycsYbsOsfSnZ8dmgzrtsCeueL3kOn/ltQ0zaPn+8E6lAMr4iy58gLG07g19ERjY53kvkN+FeimbUhVgiTDTa4BEeM0GNvLZQxgBpOTf/VUyWbXK4OGII5hxx1QJZJwovtDICQSRWMhRNNflv9KG1HoJWpMDkj2p7bXGLYig17JrXRyg58Wa9A4FXbTCl6lh+SYEIJvhBTtiyTiJlXsUNNYU1086Eo35Xs1IS/BYfCdEAFHvqFake+up593NUE3uvEOkCje7N+4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(7696005)(6636002)(6506007)(86362001)(52536014)(83380400001)(9686003)(6862004)(316002)(71200400001)(54906003)(478600001)(4326008)(33656002)(55016002)(186003)(26005)(8676002)(64756008)(8936002)(2906002)(66556008)(66476007)(66446008)(76116006)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7XsW8+8X7Z15I+wTuT6GOEjHQUcvy8XdL6/5rqupM7RikkG4yNpjWVxR/iJAF8KUkESek7/1xZNln/6boM0/zXMEiyRZnjE2uEDkTkpQ/eoeoaxToPjT1s2vX9yFgxSi8+XDh92fBjHHjO7jXQqRH2N9g/pogNkDX+e93PNWWJLCuRNr5oYuIB87GPXi4cbpN+GZYdTl55EmIf979njpXTexKuQ7QYA1L8lbEHgVx0NHuPDGk4lnz0GcD/WCmPhXkKtwDpg9GODsEkoTJCCSQEZK1Y3eI2DphzARK7oLYzX6PHzV14JNQqJwVnD1ncyJCzpLeEaHIQlkeK3W9XiQgyDeGifAJPMFWaN/JDNXgWXR7hNIFt4H9iu0RDJiD3o2m2GbXD9FJrwL33u9AseQC6laurKAY7np2qJQ9IRZULYCunm/MNKqhQ/R+SxNgoF6rseRe6dkbGMSd5NJPx2VovJAtrgmSzSevgWjZgj2oG4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b2cd1e-c839-4a24-cf86-08d81d33350a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 20:21:44.2524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meKE/dIyBW3rLkFmkswNJh4YdbB/mC4rtz6W4v+VFF1SNJkk6qnB003Cy10yOHDABRBDznaaqOmqZkMWHtiUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593548512; bh=V9TmtNU1To6IxI+EH+P3BHjtxVj6UUA2yhTMaYLkcJI=;
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
 b=dimS1Y+T9Itbi7CoQXzOmbB575VMGNHXMRu7ycjyJaS5vO4sKz4zxyZNqgFDtbz2T
 eH8VTkGalhEFoxaKMFtbtJwA1rCeMC404y27WK/5SO1dtweefzvuroiJhqFY0WI4kQ
 zFSBMNJmu3eg3oX5SQxrkcOTZnvbhhr7DZ7yvokpky7v6CG0SDiEUiVfJkh2fxKzGD
 8O/54d15VOWzNsQ+52IjZLUkXWcJI91eb8GfVs4d1cU1aI2JMUZ5s3Eds5dkIpqAZt
 9NTRk1IyclyVOeC9Tp6vNzwesom4yvwhVgGtg2cGjvY3gzO/ZKoQIzmhJdsJRmX4eu
 lGikUzqk+0HzA==
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

>> The driver intend to support up to 3 instances. It doesn't really mandate that all three instances be present in same DT node.
>> Each mmio aperture in "reg" property is an instance here. reg = 
>> <inst0_base, size>, <inst1_base, size>, <inst2_base, size>; The reg can have all three or less and driver just configures based on reg and it works fine.

>So it sounds like we need at least 2 SMMUs (for non-iso and iso) but we have up to 3 (for Tegra194). So the question is do we have a use-case where we only use 2 and not 3? If not, then it still seems that we should require that all 3 are present.

It can be either 2 SMMUs (for non-iso) or 3 SMMUs (for non-iso and iso).  Let me fail the one instance case as it can use regular arm smmu implementation and don't  need nvidia implementation explicitly.
 
>The other problem I see here is that currently the arm-smmu binding defines the 'reg' with a 'maxItems' of 1, whereas we have 3. I believe that this will get caught by the 'dt_binding_check' when we try to populate the binding.

Thanks for pointing it out! Will update the binding doc.

-KR

--
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
