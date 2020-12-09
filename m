Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67A1C433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 20:38:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625AD23B99
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 20:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625AD23B99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CFD3B204E6;
	Wed,  9 Dec 2020 20:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BL83JbKFZImd; Wed,  9 Dec 2020 20:38:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 12BDD204CA;
	Wed,  9 Dec 2020 20:38:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E76D2C0FA7;
	Wed,  9 Dec 2020 20:38:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50DDBC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 20:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 38FE686AF3
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 20:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oeqNKFAAxZL3 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 20:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A8CA86AEF
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 20:38:30 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fd135c60000>; Wed, 09 Dec 2020 12:38:30 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 20:38:17 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Dec 2020 20:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GckWugXUuekZBKIWbANm7s1vxMK+LrmW5gmCOzmo6MEYphsSADNNa5ES2Y9VoNzmQbN3Zh3DfXZGquTYipkhLBucZvNdpO0O9obgJnOzYg0u47fD5Gle3iEx/EYaM6D5sjbTM9nZ6Y7LaHZkn+oepeIy3ZNMWDaoOhZt37m2ORf+XETb8WvLUA+PsXixPmtTBj2LV7mIHZhmXX89YFQkY2CvJHOUiF6wIfd6Y2s6LFp8/ZM10JnryU84h6xryRvLj8eXBN9NV6xFiKP5VpXkTLZkmCYTBW89VA3P1qqSmbNlVIm5pcH7kGvR+zATRSmNa2zSuj29ej4SHSNS6nTLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikf6cTJmUg0XYKDGKdpHbzXwEWDgB3pW6RESky/ICZA=;
 b=il2CasL4Eh13SMSaD4cSuiIicrPw94g+PDVspTDa6qlYb89LLJJEpRDwLD1ovEy0dF8mWIcCMxKRfBee1GyJZF4GRMNY777EGx6W+B+B3FW5iiPwHOeiv7RLtJwhskK5RXkaXHuwJM0hhvXzewDqWTKZ6L0GZqT0SB0SPPIHYaMNIBQ05knjK3Easv/sfayrbiOT/mTXd7V42Vhr7j1b8Uhsyb0gup0P/RZOkaU7Cq/bYgVFfxHRjOeZ1EJqpJ169XJTWU2PnHeMh8YG/2bpGJzxUnWNWaTnB5fcLABYOk7EYJ3w2EmF42QYmxIKurP8pGnHO9KslEb4QrXly74rTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB2886.namprd12.prod.outlook.com (2603:10b6:a03:12d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 20:38:16 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::a19d:b025:ca85:62c5]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::a19d:b025:ca85:62c5%7]) with mapi id 15.20.3632.018; Wed, 9 Dec 2020
 20:38:16 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Will Deacon <will@kernel.org>
Subject: RE: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Topic: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Index: AQHWjaV1v43mlFtN2UqIsFaHeRMxTalyz8iAgATLrACAABCvgIB3/deAgAAIoQCAAATxgA==
Date: Wed, 9 Dec 2020 20:38:16 +0000
Message-ID: <BY5PR12MB37641E84D516054387FEE330B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-11-jean-philippe@linaro.org>
 <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
 <20200924101340.GC170808@myrica>
 <47b244b99f284790b82b2c0a968ba830@huawei.com>
 <BY5PR12MB376486BC4F0789F81F1E9963B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com>
 <20201209200741.GA8992@willie-the-truck>
In-Reply-To: <20201209200741.GA8992@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bff8707b-d78b-431f-60f6-08d89c825b3e
x-ms-traffictypediagnostic: BYAPR12MB2886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2886F95DA681FBCD579C9048B3CC0@BYAPR12MB2886.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4eLwY/6vT0Gg+6GoFw/8refC8FrxhhqGbyL+6Krd72IqEAHJ2+NHLs0ECylWS0x1uR65VRrn+z3cXtbvHCUegO8HnEZZQT6eJIHsvB6JfCn5TAqHAJOxI8doQSpa/CCH7eCT0ZlF269R8Anzt6TpbYK0vbbFxGOMYsdHZvVwMXWY3PqK2piZ1r+6hslMLSqOqaTKUjTjO0D7VjhZD2NDbIib272MiROfNtnNrw8lnInZHJvI+TLAMkMEtoc24yja6urfTtRRZ8WjqWQNoeNNA7ZBt+CJtlZ18GFhd/lDG+LFAyamSijsDMGWQifEgl/qObsdjrb7U9+8Mw+Spt2ytQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(8936002)(52536014)(6506007)(5660300002)(4744005)(8676002)(66476007)(7696005)(83380400001)(71200400001)(6916009)(66556008)(54906003)(4326008)(86362001)(508600001)(64756008)(55016002)(66446008)(33656002)(26005)(76116006)(9686003)(186003)(7416002)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sBkJVJ/QsIIlsTjl8Ex/LO5gW+pYgoVO4ElvhKYUbYjnnxnNLY3KziC4iw/q?=
 =?us-ascii?Q?w/uq3x/Zirc837KQVxwihBoJoDfiGcnQ3Hctpl06SueWFrzHE+2US/Ec29x+?=
 =?us-ascii?Q?IOYXxQlAz260n/1kAs430BdjhfBIQS1BPIPwfy79cxy4q4ipU7bXPx4TJOY3?=
 =?us-ascii?Q?TJspMuneh+XmJdmUW7FthlH/xIUULG7hpD+AzbD7GBUOFEFxHVEgDOziy/ne?=
 =?us-ascii?Q?kC93fehaOyLzL+3iqKADm1aHzFcDICuRmhOt5NLGr6kdq9waSGOMqXbHMkXz?=
 =?us-ascii?Q?MM0YHspEMnrPbPDKJ+Z4lEmOcFmsB5/F/RMakfiyYi3xgugukI/Io0HykYaz?=
 =?us-ascii?Q?GOIfIG3AdA+R3HlyHwvGxEh8ikX1DTnmfRJuEJ06LL5SQvKtqHkX9+TH7mgw?=
 =?us-ascii?Q?TwSZm6k8f0jmaIUIVd+UqJcr2qToHAHD0piVIT0Z8GjnEn7vzPCCjeSVebOO?=
 =?us-ascii?Q?j89UXsImxgeNUil+/npQGIJzj1f4Lybo/KqPnFp5gVq7EdlnhcdAvyJ+5is6?=
 =?us-ascii?Q?MPnWDCQBxRq1hf3U5/3Z9st5emFglklZ4q40NOq66JRnEGX2CHQhMM8C+ncb?=
 =?us-ascii?Q?efIf9MdghPKjGhRIJWQ/aAP61+hveZgRZIGpU+AXbu69fNcT7gZQxrp3or1d?=
 =?us-ascii?Q?UT7zB3ZPBSs7GD2HVRKCz+fd9rx5og95v2joYW2MSAQd9J1ECLmXZFYL+0rF?=
 =?us-ascii?Q?r0DXhyb4KW9XVlSbFQ4r1+Wrnj98sUcbLDxBosTKH1rQp/c5Rr5tqWmB32wX?=
 =?us-ascii?Q?dOTXl8yko0jzEAx6VfyBcMDrfKuDZ5we7+lv9sDCpj1nxGITL2mTRuPZAajh?=
 =?us-ascii?Q?pl3n2jbAokon+BeQCjqmYbn9tLfX0GvUT7P7h6KYpH+G+bPuwEdWJ7cHpa8s?=
 =?us-ascii?Q?5By59DH0JG8wR6RzNuIEe1+U4dUP0ixa809ugAibjb6YuWxnW7W7kLo54tpY?=
 =?us-ascii?Q?XyHDvp0sWMuUoJWw6kvK/joCIPt5KaLBAGxB3KoAass=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff8707b-d78b-431f-60f6-08d89c825b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 20:38:16.2002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bU/t365n9F9ZWPvnkl5tRVIgZyYZcuEvBlESSSXlYsBmghK3bbs0O1EU7YqJPkmI0oGNKEAzg871ox1YHjxqgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2886
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607546310; bh=ikf6cTJmUg0XYKDGKdpHbzXwEWDgB3pW6RESky/ICZA=;
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
 b=ihz4W5bY4MJS2vgyv/ONhYQ03VMqL89I1SE+xd2aiIDvH12OBlvxiCxCTPjbBqZpM
 F+VKHzN9LoRbr23Ay2iaoREEFr+eRmUOukrcEB80F/+RRiZj2Rc16UXZVmpSH43kRV
 9KaAH/vI1t/TGnrXemWzsEUMGiQejwAk1bVnHcXVpiD6wmL916RQf0Z4XGGJnBJEmu
 m0C0bDWe+t99C1KuAKMhGn7FA1PRfL0eD1Y4PIHQb6aaeBRZfBhS8wSaKRAtNDv2eb
 2xR8PLDYmmzy/B3viAQFT0we8JgPer2wtr+E6xhXSkAlHVqtO3nJqzrUViidJhpWOr
 aTpgsrGNxqneg==
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Alistair Popple <apopple@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 Pritesh Raithatha <praithatha@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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

> > The Tegra Next Generation SOC uses arm-smmu-v3, but it doesn't have support for BTM.
> > Do you have plan to get your earlier patch to handle invalidate 
> > notifications into upstream sometime soon?

>Is that a limitation of the SMMU implementation, the interconnect or the integration?

It is the limitation of interconnect. The DVM messages don't reach SMMU. 
The BTM bit in SMMU IDR does indicate that it doesn't support BTM. 

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
