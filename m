Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B96AC433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 18:18:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B522085B
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V+cHt8eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B522085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A249A8942F;
	Wed,  1 Jul 2020 18:18:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q3LLSo-zA0Lv; Wed,  1 Jul 2020 18:18:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 23E8A893E2;
	Wed,  1 Jul 2020 18:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 180F5C0865;
	Wed,  1 Jul 2020 18:18:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE9D9C0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CCDA18BEED
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Ngluye-xCaP for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 18:18:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 14F218BEEC
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:18:29 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efcd3730000>; Thu, 02 Jul 2020 02:18:27 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Wed, 01 Jul 2020 11:18:27 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Wed, 01 Jul 2020 11:18:27 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 18:18:25 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 18:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuJmycHzz63HlGHyoWUuLrEL/l19JWk1xUrqodFitxkDMp6QHftEo4n+bP/NvGEriUdj/BOs8GRoh5eMkAUOqYreSCQgfS5daVxHUFy0jdKx/WsCBi03PgAIBMeEoJMJ5c8DlOsoAgrtoaGQJwXRRbqY8IYilDeVlL5fM+8+JPfUJmeupgT3whlUZUKCOwI/CcK3WVSdTKoYYfHTKoYBuhz9/DiJu6dUdcjp8jNfh+a4NwEIZUL2Qtm8pQHyDkIsym/8sj1RQFhe1pMaOl9Vh0y7eSvp2hAtkt/0iYgKZrIXYi94YTs+TZg3QGBc0Exz2xo+zBTHTYq4WuLnyVy77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7C3atUq1LuvE2CvWbVGIYDosljQe+RDinSpV3NPLho=;
 b=g3yrgPq13V/QBZW6mZqIRA/cyC0QJNBG12JG30lGQKewfImCrLl/vkFpzFsDFBylaVI2sw8IGi7FbOvBWfgHU8e8JpfE6cmQ7q8YE7M0j5GSwHh79KScExHZmhrkISsthaxArVcr7WqkPkjbpr9HmuNJe+i/asfFz5SmmPr5FvATiDEStZmRBi0YcqnNNu0DOaP+MaGXRFyy6l9aAHiVe95ppQq0XXJewEaOzmhnZh6pvp5+13BQMiNjqpuIp/KfOgwS0FL3uwGOkluCsHjk7mnkYa4jkNPlcst08dWBXE4q5d94Q8bmQAsbOyau2D8noNED5e7SinRlZhADzVIsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BY5PR12MB3652.namprd12.prod.outlook.com (2603:10b6:a03:1a7::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 18:18:23 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:18:23 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
Thread-Topic: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Thread-Index: AQHWTnLtXe5vi7jgbE2pRnyepolCC6jw0WKAgABuEYCAAcm6kA==
Date: Wed, 1 Jul 2020 18:18:22 +0000
Message-ID: <BYAPR12MB2822FC263456303302EF30BEB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
 <d59b7220-168c-419f-db16-194307e11065@arm.com>
In-Reply-To: <d59b7220-168c-419f-db16-194307e11065@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T18:18:20.8637026Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=6266cff6-bcdc-4161-a25a-ca87c66af69e;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100efe29-4fda-44a1-3e86-08d81deb23f3
x-ms-traffictypediagnostic: BY5PR12MB3652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3652C51DFA594249C8A21333B36C0@BY5PR12MB3652.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHm4dL9BROvPVopmwZB+7kCG+V/5Hero35uT0HbZsw5YR1zIM3mgverxV2mORRFtISu+g1VJXz6lNjJgNkVe9KRhwHZiYxCEGqv/7OUAEMxaDMupiiDs+++smsYq23B9lFCb6YKSftSzROL+WxmICCRQF34awf/ZQD+isalMhrcpderasU6Cm4NXYa9QsLrjv7NFWswl1mSsKRzjfbCWrJZNuzXHo782+NoXqInw2VjeardKoNXfOdWHl95LMeBRlvnedhJ7huNNxN5hUpFX+mJ2G7o9VMeS5LAW7Mymj6vpr24Ff16WGMJ0maSNtXjoPpI0GOHtErmnThwW7X1niw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2822.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(66476007)(66446008)(64756008)(66556008)(86362001)(76116006)(66946007)(5660300002)(33656002)(4326008)(6506007)(9686003)(107886003)(71200400001)(55016002)(52536014)(7696005)(186003)(26005)(2906002)(83380400001)(8676002)(8936002)(54906003)(110136005)(478600001)(6636002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YoK/60TJfoMRuUaLFY4cZbQKfSjIaVW4Ws5hDfgBmMzeohofFywp6IFXI0AwIXLfXCH6PeD29IuGBIjuZXsDyt8zYE12reY6ra00rytZecH18wbqCR/Sey6863OdNgXFEEw+Bg+mq/pE15tNMxbGO684ZUtQIFz1PQ2M0itTOwY7vi0bn6KOaXhzU9hlI4ckn8C9+25BcU8eCM+fVfEo8AvgtmRwSMShdVXuIxYyCDb166+pcB1Z/OtNX9jXDqaoEXnNZzQF4kuzc3CFa6Ldqe9S4CZnxVp2Tg8flQhrobhP3bEEcYw2mUL7ZBIVxM54On0TLasi7/ARi5dqn7bayxUscXI5Q+AfxAkC4U6djXulZLYzz9WNFKXAuYNMRpaDf6ng2a1ljUu29znGsND7P9yHA2TAjJRheBdwkLQrgENLwquRV+kuRabGacaW7v4hagp9PW6RbfLIs1R4GjqrswibZqx56UZeC8qyAcTxn6l/UJaM8R2fWUis88Yjeoex
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100efe29-4fda-44a1-3e86-08d81deb23f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:18:22.8360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4a4MQfWQhcj1+VVHHpXZkPxdSAIKXsp2GUCV0loX/5uoEndD9TWvGdE0uGWKhuy6xSsXPjIDHnJRy6gwKl4+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3652
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593627507; bh=R7C3atUq1LuvE2CvWbVGIYDosljQe+RDinSpV3NPLho=;
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
 b=V+cHt8euQEyi+PGKFCmqLM40k5OPP4eV5eS9wlYRFUJFHN+zYdMRfiLaFlM3cfAXm
 gCwdhVLkJQQ+9pAbrBhERV6BV/84XmyK5zLLjVr3Ksvc1Izd6KzuatrmmCK0AuxaNr
 4pNq1FCTlzOujRojL/h8UNtw8p5fOLK7e1BppfpiX6c3nO0mhacPBCqjpGpJyZyf5c
 O/AtPCvWuVKfdmcaUbe7QFFXD40IP55VE751rdXeN7UNpOalzlIeONod/sVTzs8F7B
 K8mt3oDZxvrKwBfL0Vp9ibwbZg3DQjEoyHj5SdZmIcpbuZOhoCk0ZMJU9jyBoUIWik
 y4DzcigBP4NNw==
Cc: Timo Alho <talho@nvidia.com>, Thierry Reding <treding@nvidia.com>, Bryan
 Huntsman <bhuntsman@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Sachin Nikam <Snikam@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Pritesh
 Raithatha <praithatha@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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

>> + * When Linux kernel supports multiple SMMU devices, the SMMU device 
>> +used for
>> + * isochornous HW devices should be added as a separate ARM MMU-500 
>> +device
>> + * in DT and be programmed independently for efficient TLB invalidates.

>I don't understand the "When" there - the driver has always supported multiple independent SMMUs, and it's not something that could be configured out or otherwise disabled. Plus I really don't see why you would ever want to force unrelated SMMUs to be >programmed together - beyond the TLB thing mentioned it would also waste precious context bank resources and might lead to weird device grouping via false stream ID aliasing, with no obvious upside at all.

Sorry, I missed this comment.
During the initial patches, when the iommu_ops were different between, support multiple SMMU drivers at the same is not possible as one of them(that gets probed last) overwrites the platform bus ops. 
On revisiting the original issue, This problem is no longer relevant. At this point, It makes more sense to just get rid of 3rd instance programming in arm-smmu-nvidia.c and just limit it to the SMMU instances that need identical programming.

-KR



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
