Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B426EC433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 19:00:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C8620747
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 19:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VSlTYD6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C8620747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5B1C38BE59;
	Wed,  1 Jul 2020 19:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Yv+KyWk1s75; Wed,  1 Jul 2020 19:00:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C47D08BE53;
	Wed,  1 Jul 2020 19:00:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4EDBC0865;
	Wed,  1 Jul 2020 19:00:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01BC0C0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E3D5A8BE56
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KfWExgb8tKDM for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 19:00:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5025E8BE53
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 19:00:26 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efcdce50001>; Wed, 01 Jul 2020 11:58:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Jul 2020 12:00:25 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 12:00:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 19:00:25 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 19:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csGnbFggm+cGQaki/bTCi+M93zyie7VIHL1/wSX45VyC90vZJPpkao8AmHBN+4MiFpgTcRcJa6aqCpOpXUnxyBo5O0o6QgU6CxWePZy8ehe7C6BVUDOWPjCFuoppWB05xQhWN1H8zsO6Clgl4fWMIZ/M1JiXdLGd/PBgMjClDt4WO4oV5fTcp1n0+zKsQneQJF7uUOsCyrs26vnGaRLQj9nYAq65vzzop6ENoZHQqZov/CBoeHIW/tF2Isbfy8kovFItuPIvVMD3OmcGrRgsUZJXRFUM51GaIwAB1urjzRdwNYNhYy2afDltDte+FPNmDdOaMYm1UTDGCjJgkblmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqWGsFp49I3q2K3JAL9PPUBgrphHBlcmniWTcaEYd18=;
 b=kZjEtpik+r97uf8SksbA59694z8+nnd4fl/QwofhGVghXEDeDW/utjANI5rW7HfUANedeYyDKc4PQHQHTpPOHHG9bMKzxjzsrRPTRKNHpFQBG4wEjTePLuU4gXHJIXfZGEj2KWC0SW0KNf2+Dg79sCQZprqSTXzFLJU7iRSFHK6M1S1S0DiwLa64hK1NyiedKttC1DeW9y3BnMgL0Wc4Cyq046VEtbJ4sRqPAtsmf+lumnnki//NvOoXi8UIO6dR6K7w1FZhMXWWx+CeaVZHP1WAOmgd3BP3JrwsB5WkL/X+8H9ios8ulFAUpoqLwgj+8qtY+/C59n/AYVfYeSRNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BY5PR12MB3795.namprd12.prod.outlook.com (2603:10b6:a03:1a9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 19:00:22 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 19:00:22 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Thread-Topic: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
Thread-Index: AQHWTnLtO+c1bLqxQk+6SvUQTirpX6jxFsYAgAH0qfCAAAfXAIAAAiQA
Date: Wed, 1 Jul 2020 19:00:21 +0000
Message-ID: <BYAPR12MB282245DD6BB50ECA700AC69EB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
 <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
In-Reply-To: <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T19:00:16.0734995Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=fdb2a29b-e17e-4027-8621-051533513461;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aa1dc65-bc72-429d-9f13-08d81df1015c
x-ms-traffictypediagnostic: BY5PR12MB3795:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB379509C96A7B7BF3BF3A6DC5B36C0@BY5PR12MB3795.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6y95LW5S9DBVdiBQWzWv09ELj5pbM/FrRZeyk9aNDygDuzJyz6GFjdTwYZH2z2LLq7K7btEBKyh9lWzBTp96oiOyNsBQy4Yito3KrVYRcxwNrehnxHShHJ6AeFXMi1zxWZqO4wBT0x13FlSBp6jPDgvxF5/+rDLrs92x6gnIaUdvW9Hx2bmsg2FoWpn3oRw447K+4ujd/8DGYlwPWYAGvGESmcZDxysqeIYG8aOafBS2chOo8QG6t9flSULFKbtLsCrMrrUmC90YlvMZi4pcnDwRZX3XlLa4C45IzTt5fUHNn+pO5/8EojqniDa+YMAf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(55016002)(83380400001)(66476007)(66556008)(7696005)(66446008)(64756008)(4326008)(2906002)(33656002)(478600001)(6506007)(54906003)(316002)(9686003)(110136005)(186003)(71200400001)(26005)(86362001)(66946007)(8936002)(76116006)(8676002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8fz7jYVIayBCiWs/J8eimJ1PJL3oHtGlIZdfnIRlrPYgluqPMRdYqCr/y7ZeBGAIQLF7r+Ncqr8c7q/zhIad9GRlMaizH2/BMbDLy0LbduouOnRe4XrjsWDVMa+0bVLex0qL79q65Lud3hwyRy/8ltdTq2WTyXonJ/TH5wlrysFOeSO04xC7I5aHmgGWFDi/5ypFqgTsOXHEGDWmXH8AjhZVvRlnK7VrRyPC1Ww/8eFCurtIjAcPqrTH+2JvcgGHR6dBpv72XvfB9hG93vzppz8EpYNwZg8mEHYhg21RpgJZbMCsnr7U7yPRWMBQGpSxsk+2hTVZnz5qfLPan4Ga7eiKqMjNqEyNwN5Lh7bbJp/EFGApJsKw8kdD3RkLW4NEXn6/4Ure/54YB939I+3tzZt8Nj4SJLy342IB/O1sFzjczy7ZK2dDCW8GCLWC7/BKP71L/oWyOlEEb4ZVBn1wDFsVP4doEpidkCUKwgw8sjgWV65GpmtpEDqv7mjonSMH
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa1dc65-bc72-429d-9f13-08d81df1015c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 19:00:21.8107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mj29hfH/ToKkeA7CsJ49hoc0b3lM59FAZYfktJ42QS7U5uTyrBFLYF4qJvcti54kxqnKc5LTwCHmnaamgU5o1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3795
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593629925; bh=DqWGsFp49I3q2K3JAL9PPUBgrphHBlcmniWTcaEYd18=;
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
 b=VSlTYD6FW92jvzFhwuddm4sffVUongyYF9hz2MliI/GJPjH/BjY1CE7q8LCzTd3XC
 Byg+yIug43S6H7wry9QIsoh+Fg40iKHn2Ogn47bHokRKWbu6da759QeSigUOGkD2CJ
 8TSC92MKvHKDqJ4iDm7qnVatqEqGlvi/o5TSu3uoQnmq6U8iWH45CjHipmDB0Jg4Pv
 no/T7dExRwH2qppIHRuAW73o7XIZvZ35trsmPSNHTulTiXNrfhnvLbLeqQEVOE8q9v
 i61JJNXp682G4trB3LbwE4RSHbm/EYZG8x5MTrCbXxgxTlClBqgQEKo5XzyQcWMAxJ
 tNRQ7Vgro0J3g==
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Bryan Huntsman <bhuntsman@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, Timo Alho <talho@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Yu-Huan
 Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
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

>>>> +        items:
>>>> +          - enum:
>>>> +              - nvdia,tegra194-smmu
>>>> +          - const: arm,mmu-500
> >
>>> Is the fallback compatible appropriate here? If software treats this as a standard MMU-500 it will only program the first instance (because the second isn't presented as a separate MMU-500) - is there any way that isn't going to blow up?
> >
>> When compatible is set to both nvidia,tegra194-smmu and arm,mmu-500, implementation override ensure that both instances are programmed. Isn't it? I am not sure I follow your comment fully.

>The problem is, if for some reason someone had a Tegra194, but only set the compatible string to 'arm,mmu-500' it would assume that it was a normal arm,mmu-500 and only one instance would be programmed. We always want at least 2 of the 3 instances >programmed and so we should only match 'nvidia,tegra194-smmu'. In fact, I think that we also need to update the arm_smmu_of_match table to add 'nvidia,tegra194-smmu' with the data set to &arm_mmu500.

In that case, new binding "nvidia,smmu-v2" can be added with data set to &arm_mmu500 and enumeration would have nvidia,tegra194-smmu and another variant for next generation SoC in future. 

-KR
--
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
