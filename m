Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04898C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDF421534
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDF421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 518AB87183;
	Tue, 15 Dec 2020 01:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5X+UGwamyboN; Tue, 15 Dec 2020 01:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6DD287165;
	Tue, 15 Dec 2020 01:09:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6FF8C088E;
	Tue, 15 Dec 2020 01:09:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B491C013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 01:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F87387174
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 01:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d2uP8GnMTVFv for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 01:09:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4BBCA87165
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 01:09:42 +0000 (UTC)
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fd80cd30000>; Tue, 15 Dec 2020 09:09:39 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Dec
 2020 01:09:31 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS)
 id
 15.0.1473.3 via Frontend Transport; Tue, 15 Dec 2020 01:09:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiJu6kHqo+3rADvRtDdSGeX4+zmeY/91PE14FomKh3xPUsROjRzhvCEoaiAL7oOkG7DL1W2YI+vgnmbce1v14QK8kvTxI5KkukPjsBPrl8aQdz/gbLNYVGBbcQYBTRO0k0FUu1ZJryz6lJETfsDdav9kEgVvLh7cEZ6DEgSpV5qsL4ZPemKjTPgbjI6SYVXBCf2c5GhigLcmv7p+WvfSjZHhQSetXlfGZJfYmS4ATZhT9FcksOA/bdGh4DUIreVAe0K/m0nmDVTaBCt2uF7yzsBpIInLqnE0bLVx4d9HmRPSGKxfHV7AgUDwPUR49e+4csaMx612CiBUYEBd26ZneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpBETAQyxfqXizUb243MUxzcv2y9qimDAKePUchZasc=;
 b=GZ6AP7he74Ad7I4lW4spEzlc82/0JhOM4olSXeQTLByUG0TyX3t/IMJccDpGRLBzjwrZPJwxiyPZjRB2a/LwBekifDa8QA0Gw3CC3+nNhOCHB1G5odbtLfmvVGSakMbPav0IbhFCFJ8FXUWg3H1rShac3bNRAId89RVw6ZVthY3iKJ4viQKQZP4S5ShMZsvOI+JxdXacogEE5dcaIorRUP6auHr5RhXuHGbVwsCyDbSdUbpdjVaEKOAXRt2O+WYN0WTXmfaU91c3zfySf2Oe9B5QvCeoL9VyJ1lfddwfc1u56WiUwXcB2JaoUmvShuCkH4yh+L8bt3UUmW0hbSdMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB3665.namprd12.prod.outlook.com (2603:10b6:a03:1a6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 01:09:29 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::5927:a80d:11c4:529a]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::5927:a80d:11c4:529a%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 01:09:29 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
Subject: RE: [PATCH v10 11/13] iommu/arm-smmu-v3: Add SVA device feature
Thread-Topic: [PATCH v10 11/13] iommu/arm-smmu-v3: Add SVA device feature
Thread-Index: AQHWjaV1d2KW4azDX0GL2jXeKmbeXan3zrBA
Date: Tue, 15 Dec 2020 01:09:29 +0000
Message-ID: <BY5PR12MB3764F5D07E8EC48327E39C86B3C60@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-12-jean-philippe@linaro.org>
In-Reply-To: <20200918101852.582559-12-jean-philippe@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [71.202.131.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17592f27-9489-4017-a244-08d8a09612e3
x-ms-traffictypediagnostic: BY5PR12MB3665:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3665D561CAF525B3C45EC6F7B3C60@BY5PR12MB3665.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rz6+tvKxy+WzxerYnUHWi0shSpaL0R1/nMdUbKCJvpL57/HBmnd7BxQElqqwxwmpx48wzIFWTDnzuJ726haZxilPsKD0uHxZ3KE6Lr/G/KEcRG2n4qSMM1X+u+1J/xzgrF8GcDR0NjGN1duGGivx4CDkV3LW4qTiazM8z74ROuCldhOsIHnb+Ui85KWr1JYF2kmRxa13pIU3Szgnevs7/RCpJuE4iCYxwXV8mT2BggJ6C9yZ53XUrzjP9PLj5hVmuhzMisHkyjNwvRF3sf0oMbeLR4k3RT57eqcwmAkuXWxDddn2Wfnjs86WyXBf43uAdqAtxspsqCnYb59t3zhRyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(83380400001)(4326008)(26005)(8676002)(33656002)(2906002)(6506007)(7696005)(71200400001)(186003)(86362001)(76116006)(508600001)(8936002)(107886003)(66556008)(55016002)(52536014)(9686003)(66476007)(64756008)(110136005)(5660300002)(66446008)(4744005)(54906003)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vBTumwMLq4FhvNlpeF26Pl5/QOVpO5uDN4EOx2L0dGids8/nxUNBEh47WGeR?=
 =?us-ascii?Q?58yH9FjtrzKPtn2zVriVQhdLi3mqSuP9Xgiklxk26rxz7yrOb0O0o5dR3Gsm?=
 =?us-ascii?Q?iGJxpO9VvyQip3DXwNpG+guwt4m+msE+MGvV5KAjR2XgvJfuHn1xHhWBbbQP?=
 =?us-ascii?Q?H980h6vK1c7pKJQckqowhgpJkxXy43iHPTcWJTm50P7mv1DFmjRiOOnGEo8W?=
 =?us-ascii?Q?zBqf7GoiJI3m1ujUjJYSe/W1i9CqcTedBicsd494zZjuh2rTcPR0rt984BCP?=
 =?us-ascii?Q?Y/P7BkvwJr1sz6xOejNcWsq6DUz/iguv0axt2ZcEUlq2m2MD9lksf91AavyH?=
 =?us-ascii?Q?YFKDjwPTcSBVN6Dg6d3wnnwKkdmKb33IBk2L/Idc/G4LzlD6m/Z1fgsZ+beV?=
 =?us-ascii?Q?vtkWUMJdPdajI7gaX2AAJR+qUnAovw+aOqk3SFrID992xcUQMITDNDoXqkN5?=
 =?us-ascii?Q?ybAZdlriinZbOgxkozVuUV1aDTQANhoq3m8HZh42tKrO1dJ68Gp8FYzdzc6D?=
 =?us-ascii?Q?ZIBjxRf+0dvymZwUD2z+L6AcMX3tpZlcyo2xwhlrWgvMT5G2opA49ra/PIUt?=
 =?us-ascii?Q?CbK/k2sW8KePPuzKALtPUw3CEniwUDhGfP9tyCbuzyeZh/xL0gk0ZzWFlz98?=
 =?us-ascii?Q?jq87svt+90PEyDpM1Ed3L7IBOi1ENfAbxk+xnJkZbT9CX1jKTWRzm+jHBqFR?=
 =?us-ascii?Q?/D1zvmg0Mejxoaz+gVgCaDq5hScWgsGB03Nmw1B60CfxXqFLO+8LextYv7sI?=
 =?us-ascii?Q?1d9dZ7gtkABRy4Jl9No/C975wCv7dN1WsgbcBTOcdGd9l0TTVFEmGS/S46mL?=
 =?us-ascii?Q?7818NBHwO8PZ/AwnVqWxPFopknaCK55AjH7U2+VD80U7tE1cCbRbgkB9Vdng?=
 =?us-ascii?Q?vHuCASOarUaiK8k801UCBvoC4h8Yu1mUCGRmDwpfteIECELBAMncecktRLOk?=
 =?us-ascii?Q?1hoUhJM85Li8zxN+xKr/kFRKf4Gi/ltNp3+rRv7sZRo=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17592f27-9489-4017-a244-08d8a09612e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 01:09:29.4102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsaV7oHAsxo9nnLn9iQS7pL3HLUWzniGosRXtXfjNnTOSyV6cU8dRM3v2HKe7EFLDCLm/u44CfSrHtYik4otyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3665
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607994579; bh=bpBETAQyxfqXizUb243MUxzcv2y9qimDAKePUchZasc=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=oTjsYTPmnuL1ZK6cZC4xJVd97Pbg6ZSdKjuKBXPhbmazdUwoiEgIV0Q0SpRj40xmZ
 HOstLDz1yT9KQCOGMQQMzhKbs1xnZu+EAkF4YBCUdzq0lc87wZq0zX3xaHJ11/28MK
 +6X2mGfCRy92Z+/boCbe7c3rs7Q2RuAPXV/9PSz/ILDYC9Br9WcJMOLPF7LAnEahpt
 uOAQ/SBpZzDA1JKMlHQSVu4fJ+8RHVdZdjlQOl7JE2I7T+RAAxFYV0I9WvaKArz6r+
 bqYkzmixLAs5hSrz1lOfbmc/ri7GAwzTCkt5jgZvDGcSayFNskuy1FjDxE0ge0f3bi
 wvFi+kRO7UEYg==
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 Terje Bergstrom <tbergstrom@nvidia.com>, Nate
 Watterson <nwatterson@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
 Pritesh Raithatha <praithatha@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

Hi Jean,

> +bool arm_smmu_master_sva_supported(struct arm_smmu_master *master) {
> +       if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
> +               return false;
+
> +       /* SSID and IOPF support are mandatory for the moment */
> +       return master->ssid_bits && arm_smmu_iopf_supported(master); }
> +

Tegra Next Gen SOC has arm-smmu-v3 and It doesn't have support for PRI interface.
However, PCIe client device has capability to handle the page faults on its own when the ATS translation fails.
The PCIe device needs SVA feature enable without PRI interface supported at arm-smmu-v3.
At present, the SVA feature enable is allowed only if the smmu/client device has PRI support. 
There seem to be no functional reason to make pri_supported as a pre-requisite for SVA enable.
Can SVA enable be supported for pri_supported not set case as well? 
Also, It is noticed that SVA  enable on Intel doesn't need pri_supported set. 

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
