Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA470C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 16:23:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F8E20774
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="khxBb12J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F8E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7B8708733B;
	Tue, 30 Jun 2020 16:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fsgP_lJ5U9vB; Tue, 30 Jun 2020 16:23:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AF234870DE;
	Tue, 30 Jun 2020 16:23:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1889C088F;
	Tue, 30 Jun 2020 16:23:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCC8EC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ABA0987E3C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:23:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wh0hwOTYy1L for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 16:23:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0EBB687DD7
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 16:23:47 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efb67050000>; Tue, 30 Jun 2020 09:23:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 09:23:46 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 09:23:46 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 16:23:43 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 16:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaFBSQl2T87NKzAlrVJYGVGBc2+wqbVwCzDImB5WYA8JNj1Zv5hDol0/BH0TpXV7iVSoCTbABEKzBkBQ4+iZphCgyfkWr6qyQ1nfEMcKtG3SS9AG/hKIS3yZmLa1hhmIzotjs0UTKBZqmJOFcjdw75Wr16cJ0npYL3IbLvEgNENjsS7HdOYi07lQo0vZbTipOvVNse7+MFbnxuCWIYFAl6LUqVL3H4rA9X09jpH9fM6AO8uUMRedcEUQL0rC8UJS9NEa+xVzgo3oBOdY+u/PPMf1fTJnXFNeLedGUI76CpxGwXonxuZKhixwaYb/1ZqHAiKM0P/pDlzF63aIO7pXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+CTaHKsFXKP4MOAavIIVbQwTQ3rL7S/DLc0fjBW07Q=;
 b=gkoEmz4U4Tb7hrsEpwr93UEA7+/enX0nbycBAl2MGkeov0sB6Xu/lgU9QNnJK8Ah5VU1Cb4ZWN2UlOzrG+ge2cz279ZSEqLxtsuWVLQh0DPn19v+YoYPkoDhfmil9WYWUUe0gZNrXBuDQqKnQrkpLTMdrcwHb8KNLtqJwu/q6rwQAYPu5FEw1aus8iVz/9GI0f8ysXce4oPFxXYk45exId+DOrklGixsD4j9b0SUNAiiVX6bZzaeALAcqc/WLVigoKDgTCbjfJiuNhBERxAWgiBxcu0wB29LfxUIPM4v9YwR0e7Rf0lPz9MIuQUO00pBbe3jFhQz0baTXRPN3kbX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 30 Jun
 2020 16:23:41 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 16:23:41 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
Thread-Topic: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw8nYAgABivFA=
Date: Tue, 30 Jun 2020 16:23:41 +0000
Message-ID: <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
In-Reply-To: <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-30T16:23:32.8444925Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=b8df2971-a5e7-4a93-aa2b-232be9dec607;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71e1966-005c-44ee-312d-08d81d11f3e4
x-ms-traffictypediagnostic: BY5PR12MB4291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4291DDBD9932FC2DDA0DCA86B36F0@BY5PR12MB4291.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0msH39rd2gWanPF6PygEFgKFz0sruDuhnN1EbapVuLqxO6X1thKyKgFmNrs0fRPwYVxtaismF0gmf0Mcr3YAKmiXhT969fKxCN8VSdDAPmG4aU+dtztA4mawYG72+bu3gG1IkWJheDeXkrXpnXILbYd7BN/ZSXtm7J+6G3hoM7Dl44HTh+q4Vd9lUoyv5hXNwNk66JUL+xjmNgbygW0fdRsyfSPGTRccvRRgJEmp/Tt+pY9wugxSVIrS+KmeLczVSHYoNYSxm1YJ64tVqVRsKpWBWjeVKSbLKomLvWsn4A5u0YIGUS9DrTGjz125g7Ql0hlAGAlxEjR0WT8k5xUVWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(4326008)(26005)(2906002)(8936002)(6862004)(66946007)(6506007)(5660300002)(66446008)(66556008)(8676002)(71200400001)(55016002)(186003)(9686003)(86362001)(83380400001)(66476007)(64756008)(76116006)(7696005)(54906003)(478600001)(52536014)(6636002)(316002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 2usiz6AVV7AjMJEyNCaBvZc64mkFOyZBdD1ENJ4EKB5RfDRddSATa0RMoJWNUc4sQcAj8vrFD87EImdor7gPQT30dqGWaR7ldYjIw67eWtwDn8tQyrqMhrz7pY0qHsRZQtFcV9yFy8NhU7XIkJ6oQbzTgcxG1jnK5HqueCEjLH0FAFgRLGODY521+JToTLcIxdiuqZ9iHWtlAGbOZXoRszjmOsqBN0WbMLu7uBOQQypH43Y86i83hWj1Qu1u66824BKF7aqY8aPcZCr0hfBwPNSftgmTFbcXh6+9UYJZ+/GqFdwjuWI4L8nTqYC+NdLu8pJ1UJwP8v6lNRpThA0AwP/AtpqDOz6Qi7g1L/+V+tcmLQIJDH9I4BXLFsGYd2gG90wzIJ5f8E8/F6izmOZdrmkFc5zo4Srd/6khmPrseSVw5YGbBXlyhJPeyUWzBG/USOOvdEZRpzfwUCMST+3xFrJPQSEcca3LLpWEkCR8I/FF4WXWyGx3s701FTj4OFTB
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71e1966-005c-44ee-312d-08d81d11f3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 16:23:41.4843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoMbj5ocoXhyf/aQkfkqTGWPNoAIU7iZhZmH3RCzRlINdkDYEbbmP5RRXJKZUUII8hDYEH+NKi8cGLzEszZfUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593534213; bh=y+CTaHKsFXKP4MOAavIIVbQwTQ3rL7S/DLc0fjBW07Q=;
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
 b=khxBb12Jl9wW2fU84FzJlFSQXKU7DCa9DBrkOA90aRhMe7fuaNsZ9cCQkGKklf0e4
 Bvsl+eBpC5LFlshMU9P8OaP68PPOpTMvKZ80pZR6tzQUzBrka/JwJaKJOvRoIrcDB4
 9f2aZ4K/ADwWYQFJmDyPqOXa0xG/04NIppD3zJ57rDqi91qKXwahP3W2z3AYnE2mEZ
 mTIM1dfM8xdv7KiqYSthPeZWhTCmRnMTzZcAZojUG+8Liegin3WoOhPBCHmZonz7vj
 VL21GQyi6mlqRZS1/ID7kd8Vz6diJukt7pwqmuF6TX85WFK0axhJqLyJrUF7FBTgwQ
 mjJ+hCakXwk0A==
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

>> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device 
>> +*smmu) {
>> +	unsigned int i;
....
>> +	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
>> +		struct resource *res;
>> +
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>> +		if (!res)
>> +			break;

>Currently this driver is only supported for Tegra194 which I understand has 3 SMMUs. Therefore, I don't feel that we should fail silently here, I think it is better to return an error if all 3 cannot be initialised.

Initialization of all the three SMMU instances is not necessary here.
The driver can work with all the possible number of instances 1, 2 and 3 based on the DT config though it doesn't make much sense to use it with 1 instance.
There is no silent failure here from driver point of view. If there is misconfig in DT, SMMU faults would catch issues.

>> +		nvidia_smmu->bases[i] = devm_ioremap_resource(smmu->dev, res);
>> +		if (IS_ERR(nvidia_smmu->bases[i]))
>> +			return ERR_CAST(nvidia_smmu->bases[i]);

>You want to use PTR_ERR() here.

PTR_ERR() returns long integer. 
This function returns a pointer. ERR_CAST is the right one to use here. 


--
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
