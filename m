Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61929415
	for <iommu@lists.linux.dev>; Tue,  3 Oct 2023 16:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiGJ+p9dZSa4TUN/DiahL9pzTYNPAS9KXfffSjotnpmrlNI3+L03aeF3qzx2hE243juureS4xKUPUCz883VRRoc/z/POafdiy4SGRTVsOO+IazAE6v86KtVfw2yL0wgQfY2mfAa+S3c1AwX3nDMA/cOr+QtKGR5KE2mfji5GFl0ay5ZN8rNsAd1gkD9O0UmuD1vicV+DmEfhmOuZ8b7/SwKXSheE0RwLw5tmXUKYH/g1/t95CmlW6aJgcdb4xgkmtRHeq7P2uISpsIVp2fmtsnBru91Rrm9o36FpAtxakAfTci344lbFLP/2dEQnXTZ9n/0p064MYDtBigneXhHsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhl5OHf0IU8TfTF5s5Y4A9WLanbLOgwqHGB3aN6s1VE=;
 b=DMCVb6d8PIuOMhpOe1DzD8g60jBHljFeEz73jxI8B5GkJihS/U/IwX0JZLdNlzbcNIlxB6oNiNgIS3MEyy+EDNI8P3LEdkl7d8ypmkhad5XrBnlccjUD2rQZLG6D1lC7v1trlWhoXiKq88OUTgKFMNRLTCotk88kELjf7cJCs8qlOt1dojh5ggzvlGUEbL6uQb9/7+hab1+7Xocov0DNGsoDEA9UbY0989ufQgF2B1icn4pSquoVJeovLzELti2QHSv3eVTds4MGjc3lgOYBonmC5L9CroGL/4hQJJ4VdtMKHStaXgXMI269eHv/oc6i7X6lyliWkelwwJjwKKS6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nhl5OHf0IU8TfTF5s5Y4A9WLanbLOgwqHGB3aN6s1VE=;
 b=tFUHeCnlUsIItR565bpYSizeLULUvKB9TIblTat+F2b9HdvXSKTrDps7X0O0HJNMQQUSifp6RXU53U/oKhHlavP18mLkQSJVT6edm26fMGStnUCflwvgGONULFonrDtSlVsXsl9m20Q65ykVg60yOqcGKqjdyfFNF21X0RZ6+IAUlaAWvcVrV2P/mtrSLGfJ9rRCoFlZwnvsQ9de2dc24hQNDVWqm0rsT4+/z6u/hK6eF3z6MG4UT9N2VAkddxPod5EFj0Qe2XHz4BGCZQrWttQ71omK39AmsOpWo2/SkEyaWs6hKNOxXqri1wMMs9hMz95yqFlCpuqivqbYfmJZnw==
Received: from PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 16:52:42 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 16:52:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 16:52:40 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH] iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled
Date: Tue,  3 Oct 2023 13:52:36 -0300
Message-ID: <0-v1-20700abdf239+19c-iommu_no_dma_iommu_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|PH8PR12MB6795:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 12627733-ffba-45d0-36ab-08dbc4312795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	slYsU80te2oY1WKDqy2dOMA29HE9xdNMW+7ocwY6plGb203KF6/18PNqWRD0HTfcj9yYgBnUBX2/1+GZy5c2tlpFv7RR8mgBgRJ2qiFItjipkCpt1m7xBhbiAvsjN76LFDmFihVXSBgi3GkPsD7I7si5awGBxeqbzhkQOimF9I7v5qU8KO4JOxFbCBVHwFdWsmHJCz0WvwlJj07SATutjamNZXdT2RjIt7MFBubRxz9J+/aoRQp0O7Qu9rXovPd57IsfEbIJ8C+l/tLptjgA0uaj0LXTVnpELxrE3T9gSJdtRVXOps2mwbz/XiKIjVWJoOhVKRUpETFCdRHqoLsFtc+zd8GIGU/TLkJNJAiiH8pBXCACorpeaVIr/Ad35hPwKgBHVMWUO2p9XAm1v7hZRrKe5TFwTbDZ5nQOndeiIwazKPmW9YX+cM+Zpi/47vtcTY8jO6+jAKSqY+AJ/IeS+hRPn9IPt+CHittH3KnTY6WMVL1BqRJoMxiC9dfDeW3MWSEUKq8Ajc6OQ0WD49QplXz2qjMi0biGLaSyazbmaWYXBMydu8LN5APgCgG2rGAkOSjxmHM1prM8FVQKfljan0anfrdEEwqKbiZa07ClDTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6795.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(316002)(66556008)(66476007)(54906003)(41300700001)(66946007)(110136005)(83380400001)(6506007)(8676002)(4326008)(8936002)(966005)(38100700002)(26005)(86362001)(2616005)(5660300002)(6512007)(6486002)(6666004)(36756003)(7416002)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mkULbafF7xR5bKlgfZAA3E9eN+AEzRu6fDOcu/C8ON//MhF99+sFzRjeIFW5?=
 =?us-ascii?Q?OnoKhowdcL4XeKCUKgCcQZnGiE0pqstKp55sgLMxykKTlDUm/ZmsgbeEI1MS?=
 =?us-ascii?Q?LrJQrDr64ATgWHE5lgHotenIOhjiKxym+8zd+eRsxq59MB0yGa7z7DrSroha?=
 =?us-ascii?Q?szxu7jzWZUFMbUIR/Z6t9ljVk4cT/5EjHIJSFDT34d+X1BeVwLjyfgb2Jpds?=
 =?us-ascii?Q?iGwni994NeN6UnLQly/G6c4nPP/nTktTpxVjdGz+6M5aZtGsUNGWa1PdO6O1?=
 =?us-ascii?Q?IidmUEKvAgoERIWUKMpPaXH20l2sMzgM/xqgTMZ9i8SVw2czthHy9WVDCe7j?=
 =?us-ascii?Q?geTODh97V+c4AcnCMKv1m6We960kccpVtIn52mG3GPnZZOjhWD4yTOiDyJF2?=
 =?us-ascii?Q?e0gZwr+nJuSRFZ7QbOvYzI24UXoqBxpOWjEEsQbyPwPZD0/vParGSqXwTkLa?=
 =?us-ascii?Q?acEWqlbi/ymUUwQZ6cGo10BkQADyATRYDTpPOzOQZm4eylgbdmojE2H5yO5R?=
 =?us-ascii?Q?1UxeH5sHuAuIEj3ipA1fNyJ38eX2DTSc6UZW8blixuhU5WJrwSlqeUI3OWqB?=
 =?us-ascii?Q?+rhrsHiSdg2eyhTHCnLYQ4ppnfayL+eFncvJ0RfM1deJS6gKKs/4eF9Ifssa?=
 =?us-ascii?Q?iJTTC+rpdI090Lb40629XnyQxxaHuALmrtEyntrt8zh+mb4bPW5puKCvpp/g?=
 =?us-ascii?Q?/Luz/HHAtbkMpiBTMUOvYt3nqleR3pnsFyjzjD5d2jhPfuBOuHPB7Me3YUmn?=
 =?us-ascii?Q?ooimpVdrKTHy+YA+hUq1hm886N3TSzUvmP5T0eDLQpopTZTgQAutgHFYB3Ih?=
 =?us-ascii?Q?Rgy9Mv6764ENXAuzD+U3/Q0Qj+Bkgit32JUnKqE6wQI+a4aIiuX6ixw0Ujip?=
 =?us-ascii?Q?Bfd+/fQ9OQYl6gBjREbJNoOXgX5FTPz5UZdsVwOVk9Bs063Jl4GaaVo3097/?=
 =?us-ascii?Q?qOzDqnXFgTzi1jg/lEX9myxtA4GtRq1Cty09gjmSKQk1nLuSIzyPqL5MHnEo?=
 =?us-ascii?Q?1N4lyxfz+UqFvh+BBX515g8HNKNo/io45H243b0XJLFX0rLVEezRRo6yC4wa?=
 =?us-ascii?Q?KYsadqYGKh2QeZ9aFsiIoZ7/+pkW4xiSDsR1WIxLv/03dVz9ExQ7uyM94Xs1?=
 =?us-ascii?Q?NCJdn4VMSv1s/FUGzhMNEih3tVjZblKuqIG+9g87PUZK90ToELyYcltpM6KA?=
 =?us-ascii?Q?OkeFeb3L/CHUhvp6EGOoN/Wl4+upbNnRoeUh5nIHABTX/0Ne4MWA2oPsy/X1?=
 =?us-ascii?Q?EjHyyt7iwOEfjYAr+PZ7PArJtrOpPzkWOS+tmvKnhaYb4RNxo4PpEd+sHORY?=
 =?us-ascii?Q?ZNffCuUVqWm1HXoZhNllGvNHmdFMneOrI7JyJocF7s8ok8EJOy9miRpU8qdx?=
 =?us-ascii?Q?eIqchAdzYQj4LxwALc9BGfsKfiwUZDTtGgz269td1Px975xGifQvHKOFnBBG?=
 =?us-ascii?Q?wHD3Z3eWr+BAUdhUwXcRkCxkdVha3Vl1TPodXkInjz/LkPfHl7RNBYqiMKwM?=
 =?us-ascii?Q?2eaUOLdkGBLhxCDovZ/+xjL5P7efnyGdKQLHr/eMvA+f8zS9lb9z8A+Et2KJ?=
 =?us-ascii?Q?d3lanuQZjZk8N3ylPuw5SwMqrsZXmTcC3nFjew8N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12627733-ffba-45d0-36ab-08dbc4312795
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:52:40.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0sj7TzOZSNXUOy0QBPBro4word9+qa/jJYS2oQBDp3/MbGtKQi9OmrvfNZ3nPpL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

msm_iommu platforms do not select either CONFIG_IOMMU_DMA or
CONFIG_ARM_DMA_USE_IOMMU so they create a IOMMU_DOMAIN_DMA domain by
default and never populate it. This acts like a BLOCKED domain and breaks
the GPU driver on the platform.

Detect this and force use of IDENTITY instead.

Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/linux-iommu/CAA8EJprz7VVmBG68U9zLuqPd0UdSRHYoLDJSP6tCj6H6qanuTQ@mail.gmail.com/
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

Dmitry, I changed the patch from what I got you to test, probably best if you
can confirm this is OK too. This should fix any other drivers beyond msm that are
doing the same thing. Thanks

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1ecac2b5c54f4a..21d45e6a5931a1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1920,6 +1920,18 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 		}
 	}
 
+	/*
+	 * If the common dma ops are not selected in kconfig then we cannot use
+	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
+	 * selected.
+	 */
+	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
+		if (WARN_ON(driver_type == IOMMU_DOMAIN_DMA))
+			return -1;
+		if (!driver_type)
+			driver_type = IOMMU_DOMAIN_IDENTITY;
+	}
+
 	if (untrusted) {
 		if (driver_type && driver_type != IOMMU_DOMAIN_DMA) {
 			dev_err_ratelimited(

base-commit: dd5c4a1fe62738b4494deaf387d9a63a7c9f9519
-- 
2.42.0

