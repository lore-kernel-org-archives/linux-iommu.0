Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DAC433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:49:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1294423B45
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 19:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1294423B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 84E9320392;
	Wed,  9 Dec 2020 19:49:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XQ-OOKo44yyI; Wed,  9 Dec 2020 19:49:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9A07920361;
	Wed,  9 Dec 2020 19:49:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A8D3C0893;
	Wed,  9 Dec 2020 19:49:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EBCCC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F009086AD9
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgfyDDAH6ISW for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 19:49:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 30F9D86BD6
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 19:49:24 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fd12a430002>; Wed, 09 Dec 2020 11:49:23 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 19:49:12 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Dec 2020 19:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYzy1scb2JFhUGm/+TLdqtVr2UqnAGBnzq2hAMa+iL0e5YHB9e7w0KYRSGYNB8LtwoEc33jijUjd59mRis0eONO0mNilFRbwRnrHNHzPqQTDQs93Stro5xeYJap9hs1zVpWdOqDS+r4l29iQkYnHppkgbBqYptPaNqJ5gy8hMpbkynisBt74Och1NC8FzTb5uNYDhm8rP5ZZR66AlxxE/kNsW9ZOlez/EDXyUlZdn2YsCuBn3kO8wBVIy8BGF2K9owUOFC52SZ5xx3WkfzjPXkW/bsaEvNFDT2MH4AY4PBeoQCDe8U24z4Ip7UCrEjI+APSzjoD2tzu0QasjYnKBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXVx7X7rg8fD861XJoSlshxiD08t1h2Uw7JK9hNykGo=;
 b=BzTqYgxGBgALYaCYforNadbFiOSkm4i/LksMcJcjY7tnFzJHqiSIcF5lWulmfGYC4miwWpC8fPBiiSkZ+z+JimNBwRHR/quVJPKCDdZAKfNdAeMGtFw96GVM/oVB68koPpbOdYXRrMy9ZK7P9TFX1MBNJlDpSvQEIpxAolGqY2O/PWEtBFUDmLtxLtmODgdyoNjGozP2JDF2r5+WZ5X4ZgzYGHmMJO3wDlalV1GoyNLKq/fqkXqvVJZflAvJwl4qXUW6aiL7iZYWvPgC3IBNuTHjlbIfYRXk9sttWN6qE+Fh/L0micj0H2A6bAEFhbTegzLRzSstcIS5B2FEVWC4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 19:49:09 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::a19d:b025:ca85:62c5]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::a19d:b025:ca85:62c5%7]) with mapi id 15.20.3632.018; Wed, 9 Dec 2020
 19:49:09 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Topic: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Index: AQHWjaV1v43mlFtN2UqIsFaHeRMxTalyz8iAgATLrACAABCvgIB3/deA
Date: Wed, 9 Dec 2020 19:49:09 +0000
Message-ID: <BY5PR12MB376486BC4F0789F81F1E9963B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-11-jean-philippe@linaro.org>
 <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
 <20200924101340.GC170808@myrica>
 <47b244b99f284790b82b2c0a968ba830@huawei.com>
In-Reply-To: <47b244b99f284790b82b2c0a968ba830@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ce2dc96-dd54-4b8b-a2ad-08d89c7b7eaf
x-ms-traffictypediagnostic: BYAPR12MB2759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2759F8FFD04A8AEFCBA6EDECB3CC0@BYAPR12MB2759.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wz4jMNB01wnsiynPmc+ub3MEPXhzclIoTUe5x6DyPlL395XH/EueJc3Vywfu3w4RvwJTdR9aGZ/qgWac6wkTalGWHKkoCOmGCGayNvoXGRta9JazTTwE6jgjWt/G8D/KnVZUSjPnWxU6/wPrz+51vKFIfdJWq02PU7SthnFE6Oe1EVWkdPzzIJfSAYl8+RwmUZIkiCUFrw5nT7Q1Q4XHIk0039b5jgy0AY5z70htF1AqplhTxzlRjlfYp3IAt75+mwp5Hc/x10kUx2ltPWCJctWt2NCppOaUGOgp27iMwmdDGGnPShJlfjaoGa17rQyk6h6FzYkiWwi8qrGVsMK1JbfiiikvdvAxsQoMLbu3rz00W5hGu7+jyRCMeQFC3vrM/9hWZqjaSTm/4CMM0bUwbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(66446008)(66946007)(54906003)(76116006)(508600001)(6506007)(7696005)(26005)(52536014)(71200400001)(8676002)(4326008)(8936002)(83380400001)(7416002)(66556008)(966005)(6916009)(66476007)(186003)(5660300002)(64756008)(86362001)(9686003)(33656002)(55016002)(4744005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?msdRkHibEPQm89OntYAYqBoQ/ccgQVZup57FaIX6xMw2EtfpiGFPaARh2YvX?=
 =?us-ascii?Q?ENV2VpwhWVIRwniUR4/3bFDsXiWNIgiv6kb282lq0J2EFG1WcQMzX3LrsxQb?=
 =?us-ascii?Q?Nnhl26JXIIEE+FT8QgaF9MV5ebm22u1z6lDVBjmlaLQtcziNp9h+QAhdh1Ls?=
 =?us-ascii?Q?goSxW44VAFLkJOu9/pXrQggl4qnx9Vl8uxdIWBNgv2/5jD4aAMWJ+iqk2YJv?=
 =?us-ascii?Q?EKTgbNQxtE4HDCz3BcAwopNP4oOEqoXt9rGVcvZL0l2GdP1WNizvekL5L4ZL?=
 =?us-ascii?Q?y4QAnv8UuaF2j0PiGikjAaHD0wJX0nV283j4j354mTqmcM2Bymr4rNXUL0mQ?=
 =?us-ascii?Q?fbG/Ols8ap+AkvSKuTr+MFaqo8BuhW6bNQB8e0K4v7fCuaGPqSHcU5vzHYfB?=
 =?us-ascii?Q?My5MV26qOzfC3gsWXdSjDR+CKB45ajJF439n76oI7WtCmmg0WIv77H2w2Gdf?=
 =?us-ascii?Q?yMMt+8sscIytWIuu1yfFp14SJOc+aRJSA0eBWjs9DVMwp0cw2EtnMIztiDHr?=
 =?us-ascii?Q?NjxsGTfIRD7BozjEijt/HM5flqRF6JvJHaCli8N1kS9boA8mfoESUljyt/x1?=
 =?us-ascii?Q?u5PLuYSyIOnVQOVqRGYHDPJyB+3IAoxt8cmgMbbE9tWYc/I/KX1T1vLqFR3r?=
 =?us-ascii?Q?kPH3UrhH4schrp+53NVrdlAbE42xEXUfhYsu1SB7OHlUXzd8Ap8F5kayKV+e?=
 =?us-ascii?Q?dBvw2HVSSaYzdm1B1GGGZTS4JbSehzofI2LYmnBb6CpWLOvTNcnSa+6Fss0d?=
 =?us-ascii?Q?Q2G9u01BluEdfQjXs/lLiS9EFRPljISAqU2WUASAyanhSDan0wOy61VQTC9S?=
 =?us-ascii?Q?sZ27k2AlL3Jrrn/rll6vCHxf+0lORU7nhH3r7CG/KZsI76VVgrJiP8v5a+gR?=
 =?us-ascii?Q?i+FrDfSSWHe1UBYkP1EPmz2K5E4m1C0qfMs3nA0v50AP/KLLi1a2zdbE1+9f?=
 =?us-ascii?Q?R0MqhJxcwgjURLP+8RNokbWZr6Kk/3y90YYmP2Ek+ww=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce2dc96-dd54-4b8b-a2ad-08d89c7b7eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 19:49:09.1766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivByn8oCcfCFjUvraC1Ws9FvuRQw5c+xaNq8ViJXCJcMEqq7ebUeJ225ZyTOFravXfbVLXrsjB0tzWHFX+oMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2759
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1607543363; bh=ZXVx7X7rg8fD861XJoSlshxiD08t1h2Uw7JK9hNykGo=;
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
 b=FImhpd0NES/8wlzJCjcgRJlOWnxMYtEmSSN4ImgLZ1QuDtOMTuKT2eGxhKmlda0/2
 rZCNm6WqEhU7rK3tO4gl0LWOncctcwEpm4QZF+o1bqEksCctZESmUvkkiOsgQpv9Vm
 CBrAOyQiGvulGU3rjGiFU9x5pmmYaNZ841vOvb/OdK12Bbs+rqDLaNFY6lchKkPLBq
 y2NhdcIKHNWK618UJ+q3xenYqQroNrlaSiBQr7P2VuBBJvSWjBXVSYTaDaezg8WSDe
 7zIU2F5pUTzopze7wzn7dV67vBtfK/YjjifMRY7/SQd0SygkkVWUidZTCpA3hMsJ86
 a28P6zmeDTXqA==
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
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

Hi Jean,
> > Why is BTM mandated for SVA? I couldn't find this requirement in 
> > SMMU spec (Sorry if I missed it or this got discussed earlier). But 
> > if performance is the
> only concern here,
> > is it better just to allow it with a warning rather than limiting 
> > SMMUs without
> BTM?
>
> It's a performance concern and requires to support multiple 
> configurations, but the spec allows it. Are there SMMUs without BTM 
> that need it?

The Tegra Next Generation SOC uses arm-smmu-v3, but it doesn't have support for BTM.
Do you have plan to get your earlier patch to handle invalidate notifications into upstream sometime soon? 
Can the dependency on BTM be relaxed with the patch?

PATCH v9 13/13] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
https://www.spinics.net/lists/arm-kernel/msg825099.html

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
