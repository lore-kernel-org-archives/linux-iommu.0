Return-Path: <SRS0=68Au=FS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B0C4361B
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 23:23:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D67D22518
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 23:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D67D22518
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1B0CD20516;
	Mon, 14 Dec 2020 23:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3lzNJVGsjKQJ; Mon, 14 Dec 2020 23:23:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BBB9E20493;
	Mon, 14 Dec 2020 23:23:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D1D1C088E;
	Mon, 14 Dec 2020 23:23:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AB73C013B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 23:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3467686B0B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 23:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gk2cejNEIQan for <iommu@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 23:23:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 561E486A50
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 23:23:25 +0000 (UTC)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fd7f3ea0000>; Tue, 15 Dec 2020 07:23:22 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Dec
 2020 23:23:10 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Dec 2020 23:23:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0TODizygapagPoWOTjo6taTHq6zKANVNr/yZxMdYcazg2aEsSqxFDnvhjGrEn/nSxoEuz28N5xZ5WIPto/HfXhN+AsIMNvpoN4vmqO5UBtETRinK2mWzfqWPqw/08Kh4N3xA28I2S7lG1zWHJ/+KFsfAAkjzicYtsQVh3Ss1eWqxUuX8tR4PzQR6JAdmungkwK3LUfpAvpfrwhp3ZhOQM8fT0f9LFBoO3up11FnoFpAoyi3zHVyBNGmWqs8doV52lDaJdV7Lw/pWwOeetrGqK+9BRPVJl7MDIbJfW/luC52AuLKTORaItfxUcT1WBpFgK4Cm//8Qt7itgCb72OHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtVUcrVzqK20Nd2mh56sRckQ4eHBcsSZYHilGqDqP54=;
 b=aOrvsoXDR0KnnUgai4exiiGewNLhQ1XEhVCKB0PsFo4uZUzexNzgsu2ziXbgnmkTRDZZHrLF2NpA+B026tc9dVGWn+0DZJr8QxoL7900GJpxqz/QgMlOfGw0K+Giy92kCFrj+69lMfz07BmxakIVY9Tp15u84RTN37VuK4vRLOl7GR+4S4k3xXTANDaLpsEpVBN+g+HBUkXfRliRahdEjuDLzvGM/HdDpAAyNG+Ho7ZO6RGIlKvXknhVZYVf4hd7TavxFBOE+QtBFNN2KXkBbd9hwxSR3m7gIK32kmSzRmHNVDiw/dVULuVoE3dJH1HTtt/BkC1hMDcgou8xx1bkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 14 Dec
 2020 23:23:07 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::5927:a80d:11c4:529a]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::5927:a80d:11c4:529a%7]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 23:23:07 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Topic: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Index: AQHWjaV1v43mlFtN2UqIsFaHeRMxTalyz8iAgATLrACAABCvgIB3/deAgAcy5YCAANzAUA==
Date: Mon, 14 Dec 2020 23:23:07 +0000
Message-ID: <BY5PR12MB3764B9ECDF030953A9097FEFB3C70@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-11-jean-philippe@linaro.org>
 <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
 <20200924101340.GC170808@myrica>
 <47b244b99f284790b82b2c0a968ba830@huawei.com>
 <BY5PR12MB376486BC4F0789F81F1E9963B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com>
 <X9cxP8g5JgAGS2wD@myrica>
In-Reply-To: <X9cxP8g5JgAGS2wD@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [71.202.131.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 474c7e3f-59fa-485d-b0fe-08d8a0873729
x-ms-traffictypediagnostic: BY5PR12MB4194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB419419843712B09D51023439B3C70@BY5PR12MB4194.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eohCFBFCXNdNMYDscSGN9Bk+hOtXbbPiRkvCQXEvbY7TKocpEXhEXC0DozvLq4SYv1kyaRi16CGxvDHprLAuYfP357dZTn2YsEsP9knzYRViMfgC3IT6+LQ/6NyD/ECG8LZy/SNDaSmrwKytzk2MCyGuO/bW36KZjR8tM6TSh3vx3A333BuLiGXzEGuX3ynpfcDHHNSQ0HN3PLA4kJtjqmUF6jesTC0BmfpCUgyGPJ8eN/xQH455PZ5dz0vJFiU06jjuJFrKB7wB72LmcMnn4oYWN/EWeX9/cwEmIoFPT7pvSQIgN+kvjG1wkHFMF/8yAnT8dpLRFM5RC6XCKNYaqknHb3lDSE1zY80jyB/vUUY7kPegsgkbE+LXrdqGW/0Ppw5yydkRTRqwvV97LmsCTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(66446008)(64756008)(66556008)(86362001)(6916009)(4744005)(508600001)(76116006)(54906003)(33656002)(966005)(52536014)(66946007)(5660300002)(107886003)(8936002)(55016002)(4326008)(71200400001)(9686003)(66476007)(8676002)(186003)(83380400001)(7696005)(26005)(2906002)(7416002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uekJ6IW/dKBftQkwuCRiEmlszNIx7u5N9BA3DIDlK3KEAiyQ1TK7RCjEdS4C?=
 =?us-ascii?Q?wrEd8OC/4r4g0b8tjdkzVVvxIkPdIApPDzaXAr96YE3kNm2no91e33KKDIj0?=
 =?us-ascii?Q?N+NNsvtvkbjpXVioI5wK8SyxtZflVNiPf+tZ15t0LluFqN1vl/ys35oH39SK?=
 =?us-ascii?Q?fjLF/3HkC29m2guM1vrhH7pzPPYyc8F0B7JY7InBvclGPicTJdVeiEYwgXOG?=
 =?us-ascii?Q?kR6e8y+yaYmVtwoP7WElh01I7VebGlCL737bUFbEFAOzm3BatwAad1YaHSua?=
 =?us-ascii?Q?CZn0DZMHOdHxZqr4bXVVFO3aqKa43vDUlD6ax/1A8AZ1QennMRKxlFP49/Qm?=
 =?us-ascii?Q?X6oJ9J8lre7Q7+1Jhb6p3WJQrqoobvFu+ZXfT6BLyBg/C8pOS+nDLsx36bRp?=
 =?us-ascii?Q?ALI8K2sCQwPeYDLJKqgVLHAjHFOym/hlgL30G5TOu3aiwJQ07oM0IzFcyv68?=
 =?us-ascii?Q?mancVA3gdOMJhdN3aQjbhXx+YU0wWrsAG/ABwmnjvucRgvbnunir4kh1VimH?=
 =?us-ascii?Q?gVJuHIvnuNYmof5p+BKVCJ4HH2vDg6ftm4l/eTNp3/JtNMG+17buEUucfmY6?=
 =?us-ascii?Q?oSy/VHuEcDgmFTA1yKoq2vsk3uWXRosCx8+dH9WnReDuAeRyHU2t+p6atVIn?=
 =?us-ascii?Q?NHWCI04yrOxRZQ0GSoo0jtQuIxwzUBX8/0UR3WJ3/EUOtIEB3+1uDeJj5vM7?=
 =?us-ascii?Q?CVfWWp7U4xCzDR3iOlYy0x81OzULpCifaToGmL0OSjwAy7gIS1azXXrNHQan?=
 =?us-ascii?Q?IpJ6Y0/xACTqO5WkODtIfHlu/uDKrzh3Oam448r2adG8kw3q/2TTbsbk8tfO?=
 =?us-ascii?Q?PHKTFue91yX7YqPKc8yrjrizuMVvh8YvoMy0QU5e6bm58XslmXKWL1urYSWh?=
 =?us-ascii?Q?3EGi9UCaON2Ap7e1CEJ+NTeor8L70QDDm5CmX4bONEmHTAVYaRFRhIYXRG8C?=
 =?us-ascii?Q?Tq1mazEmFnDMip9nIh6SO51Xmf8M1tXa3kDvD/M9Deo=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474c7e3f-59fa-485d-b0fe-08d8a0873729
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 23:23:07.7754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyPD3xfkCJi9+wWMMqGnVqVwm96sRvbtnYA217EYNkSXWHj7h7Ddt9/nw74Yk+QHZcYjxN6/3w+IIRZveUnuEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607988202; bh=mtVUcrVzqK20Nd2mh56sRckQ4eHBcsSZYHilGqDqP54=;
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
 b=MhoAsAwlwJXbJ8EVk9FvrqvKjWnsoP341xyCgPGUDVcsUb5YK6DElzL30knOQbKD5
 WP5ygTCf/D8MFWY3CwC2MwwtZ9nQJKjHb1wROJFHb+yDoixdLHZtZoDgu5MyGQFCi7
 VH50R9/HS5tf+FpdSCWKXKrusNPqROmYG8gLN6gIO49IrAzPLxJi4gBM1B1pseXb/C
 C2XnFytnV6JAA6LJ0TFYeLhq3Rz9mz6vUSekCCh2gVKRZMysuuRw4hZgmG0A2OWfmh
 7xrflOqjApe4dbUf6JtQtJe+Ic3ST1ayOiJoEOhDjaScLF87eMLC0HYcR9QG69UC0h
 FlglcbkK4jMyA==
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
 Terje Bergstrom <tbergstrom@nvidia.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Alistair Popple <apopple@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 Pritesh Raithatha <praithatha@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

>> The Tegra Next Generation SOC uses arm-smmu-v3, but it doesn't have support for BTM.
>> Do you have plan to get your earlier patch to handle invalidate notifications into upstream sometime soon?
>> Can the dependency on BTM be relaxed with the patch?
>>
>> PATCH v9 13/13] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops 
>> https://www.spinics.net/lists/arm-kernel/msg825099.html

>This patch (which should be in 5.11) only takes care of sending ATC invalidations to PCIe endpoints. With this, BTM is still required to invalidate SMMU TLBs.
> However we could enable command-queue invalidation when ARM_SMMU_FEAT_BTM isn't set.
> Invalidations are still a relatively rare event so it may not be outrageously slow. I can add a patch to my tree if you have hardware to test. 

Thanks! We can test the patch on emulation platform. 

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
