Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E908FC43462
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 22:06:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF19613ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 22:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF19613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E148B60861;
	Tue, 20 Apr 2021 22:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2D_m4jwFjxGm; Tue, 20 Apr 2021 22:06:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB8E560730;
	Tue, 20 Apr 2021 22:06:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDDE9C000F;
	Tue, 20 Apr 2021 22:06:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2B07C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 22:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9339140663
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 22:06:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hr78h8NF9K4s for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 22:06:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2926540617
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 22:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6BkJiyrDCajzt4LlYhbkEanVD1Qm4KiuMOBV1F5HRlav/gKwN7kaaUVzVpUzqxJKURjriw+Pa/5y0blGIOYhQDgNUSUy4k/n+lqob9K/wbwg4+uzDYgEeRkkU38KhFBnnDWac+4VlhsgLUV4I+ndjY+y55of5BLOrDFPu74fX6zcGp9Pb5GHPzIKsP5MEQwzd1U/tkOeZNAzwH9mb5qEY/OneViVz8KrccG8lcwGqIN9c1DcZiwazJSbwARYoOR90r7GYbnJyNElmHrFYDxSmcMwBTQ5ZAb1sguMc4kzRlDRfhBnckb8UqWB30w/MPYM1BNPy8lNyjWlIF9nu9j+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avR6c479LV26wwzp0tRVq+lt/s57J3D1Y6N9KBZqh9w=;
 b=nIXoxAB+se0hheFGJ4TWIgEqQTSFOUGtIxFD+uCed7H+q7PVBTE92AxRuDD3OBphPa/+JFZMUsukW/KmwMnd4fgc7J0ghWWMZkNDU7QK0JM3QzwUqn6KtnLvHFDf21Rkf37KMCzQFyhtKDKTggy41wfAU8Jh1GChv34KZJ2IkoTbYNWT50dNBWDRXNeGjf9HdemNWuYIuhRIoJzKl/6j562bRqGLT2wlQIpJHxM2lxgNZiM1jg/yTvvVrnNkcNEjANt7k1H8Ujfl7hFL0vMGfZx6vrxXS1jmrx2fFV9GJX/ElT32VPRL6WSpCokXED8jejXCkTQXHcnjbTFfv0WwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avR6c479LV26wwzp0tRVq+lt/s57J3D1Y6N9KBZqh9w=;
 b=GcD4r7vXYLQSeRBI3luDFez0rp5HTKjqGrkdGGui7o1sPennwWMS0+5USKvygAnePnPN7D6Ky/cpzBxG5udExY5S6tLaImYmmI5DNTkh9EtTzIkrO2mpLifsviBB6/1B/Ty4v32ALOAdIsTWV+iZI/CxZM1oqbgOlZqscRl0XZoxQyPtPMp3HZf9a15HAAWd4AJUnzms1Hpmg0Yttk70OdFzxoj2kxC3ATJbc+oq0E0IDi+Lo9tKqwgWYfYf+tIWf8jhpYhVBWc4G5JJZ8ZYIXnmSjACs0OpxDHPlE+9lerAWQNgsvMoGoBxNfDd+2k2TJTsQqbonIJMgnuzZP5/7w==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB3810.namprd12.prod.outlook.com (2603:10b6:a03:1a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 22:06:26 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 22:06:26 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 04/10] iommu/arm-smmu: tegra: Detect number of
 instances at runtime
Thread-Topic: [PATCH v2 04/10] iommu/arm-smmu: tegra: Detect number of
 instances at runtime
Thread-Index: AQHXNgozPJpXjhLUyEWzXfFdB21t4qq99odg
Date: Tue, 20 Apr 2021 22:06:25 +0000
Message-ID: <BY5PR12MB3764DA150606275026E7596EB3489@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <20210420172619.3782831-5-thierry.reding@gmail.com>
In-Reply-To: <20210420172619.3782831-5-thierry.reding@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [12.97.180.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa74d7ca-1e08-4105-8211-08d904488ab4
x-ms-traffictypediagnostic: BY5PR12MB3810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3810B49603B49405273F6183B3489@BY5PR12MB3810.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qK1qXyn5mFlMWEqaaJwsgK2WuzYcFk56g2Cz98TuNBzRxyd8HDmkP0gW6EXmObIcWUujEot7HDhSuMfDaTkGLi0KwITqIEJVb/2uwWHrA3yn6Gq5lUhKAoqogo/tlgTYaxQwmQK+B6yL0c6mdFb9VQXBt4zHYWlJnz6z3HeviwdZ6LfojK3Bsl12m5JIhJ1hhh1WnD6lusD5jRji/ULIu++5MeF3xfND2+F1l1rndFba2yc84g20+1RGQ1jkkcJQyZtsnI3EThnTKLNRU/EtMRPpaP5P8mhpN8w9u+7KEbM42iwpkKIijnXPByE5O62b1zurDClpg0jlzwQuo2zPN4ErPR8pEEw+kHGUMG0ihkn1FLGcx/3CMn8zqXAaVkNy4XkSncrIh2aTVILraJoAxg560XBRPthg5+Wil2X3HpcRFcmc5zcR8CoZFoKjHCclFMhwFe+FqwcXcQx8vaU6REZ2CfR77uCHcEIZdEyUat8hRZNQsGJMXOgGogy+qb/6YJMRSUwxbl34D9yzG0475c0w2fkrbX0XDEp0aKYCz6SYs4t8xroWzxmvW9a9gdYIGvFrY8mQKMKKEvTuEPVf7Oe0U5u3v83FVZKWj3rROxc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(558084003)(52536014)(66446008)(8936002)(2906002)(64756008)(316002)(71200400001)(26005)(66476007)(186003)(8676002)(122000001)(38100700002)(110136005)(54906003)(76116006)(66946007)(66556008)(9686003)(55016002)(33656002)(478600001)(86362001)(4326008)(6506007)(7696005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pKNj/H5InqlJsD/ifrC9VPRvRIJSu9iP9sAnJmbaq7kTTIvm3U3P2QIkpQQl?=
 =?us-ascii?Q?JNAzBW3JgxjIkYa5dEINJzRMOFpi66RP5pEMBUrg+C/rzqTt1p9priJ8juNn?=
 =?us-ascii?Q?gioI8F5OBdWFnHfdMt3i+IOSkOk+FhfTmaQR7rXMOQ2/siQ5UU19jlGRAU/t?=
 =?us-ascii?Q?jLShUyIJnrunUyHaqL7D04Q/2D1ga4c4rxTog5S+yiJ7L3os2vOI+RpcwbW8?=
 =?us-ascii?Q?YIYTBNZ+D4Ae7cDjYIm0Hw4rX3hD3w/IYIB+FlSbJ99ibvJ05R/Xu/T1yuSJ?=
 =?us-ascii?Q?ufdUCIp2B3+MD8NxtW0X/1npUaXCxQsD7q78mApYSFXTlGyNhYdcAC+MZk8/?=
 =?us-ascii?Q?TOpxzlleawff1VE786SDxm0N0GrnI2RMln6PDvtXy2m/lTF/YEpOqPMB3VbM?=
 =?us-ascii?Q?83TQ3nvjZZfjqvaqwpiWiMG9DY+lbbsOXt7ufdKeU/QuhF2FE3fjlZUHXWIj?=
 =?us-ascii?Q?BvXPJryfpdQ2tyqPTueJ4WruJpn8FLbRubmEqzBdoGcs8qif6d8IpYFwoNE+?=
 =?us-ascii?Q?1LCeAQBdDWVL2OZWe9yAtfckOWgvDZ8/vQa65JWeTHiVpKyXhZq/Omz0OP8i?=
 =?us-ascii?Q?FjMCnBKGYMxcekVPpIbJCehuzgADsvHHFLHo8XwdySNOFSKRIBrhfl5AcZXc?=
 =?us-ascii?Q?lGAmaxKXmuT8J89RRO0aXFMTKaAhjDgfxu0yUMB8eC8IkTKVioKGZs4K+7eA?=
 =?us-ascii?Q?3K76YlslPviIM8wzfX9MOECuRxEk6mK8RNBmB5qkW6fjCfHyf9HROKQitxFb?=
 =?us-ascii?Q?NposQDRzqiFRiaKpw9Ak1gbQ2NRIQXIGMMTZz5mBsOQMajj3N7cCRnvfAN4b?=
 =?us-ascii?Q?MmthbOPtOkSMcl67eN3HyTyHftttJipykXFplJ1vioRvw+Oz+8NZK4iZQlNw?=
 =?us-ascii?Q?ekgQXOHI0NWZLgKVti73QcYuPJPDYEbVyS9ap4SQUtEsIbWIJgx3lgfBrAQm?=
 =?us-ascii?Q?u4N5RbrZS7r68ahEuFHrEPBnYsQdca2MK79MLgYoeqzTynrgIGaUv237+J4N?=
 =?us-ascii?Q?HWyMLq6aFZNQiU+kvbuzsM6/djMTP87M/+VnuX0No5KXpJjzvxPLWZl4uks1?=
 =?us-ascii?Q?N/PC/4JisKS+GPEb3IofgXJ8m8zNkYZPIStozc0mgqIQ/qQgnKlKZyncYbHa?=
 =?us-ascii?Q?f7dj5HyEdCI2jRBsNFdm6PAqobR7kPFm/XJj32gNhlq9ZASfZmax2K9F+F4S?=
 =?us-ascii?Q?wMB1zSIboyeLr7uS35wPQMURL1jhzNlXGiraJrWxUwIqPk9X/MoVV+WV/S8a?=
 =?us-ascii?Q?Bmk8pVxBbN5Xzus45SJNKNZQEMhsQB78F3B+2DNRi2aysPvR+CNwid3GzqbF?=
 =?us-ascii?Q?+bc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa74d7ca-1e08-4105-8211-08d904488ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 22:06:25.9598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfgpqwB1/WT2iNynsvJ/4B5sbHIU7Qz4KKOjjkeR7hJfCkRQnFWFbLKiMqxh/UTjbL5cIEpB5+ZUQmq5q6nBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3810
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
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

>+static const struct arm_smmu_impl nvidia_smmu_single_impl = {
>+       .probe_finalize = nvidia_smmu_probe_finalize,
>+};

nvidia_smmu_probe_finalize is used before it is defined. It is defined in patch 5.

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
