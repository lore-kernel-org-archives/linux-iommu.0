Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE40168C7;
	Tue, 18 Jul 2023 19:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LllfVeens09LQryR9nR1xRCTB+5Rnl38z5AVV1jXCuTjIO3V6vkcieHC3p9/iKsXMY+45wf9Bjwk8Ai+9c8eMp/LOjDPfEqGPNl+a8gUd/jHcp4DYNnynqpWqUxRSwXlZnRrVaO4tjdeg0dw/IL0oMuA26Nx+Reb3DFWCpEIvVFbLocWxq0a0POu7JVNXPZrDSKsqvvUWoYepUDubCOhD4OPzAUHxLgyhTJB8xV90wYkgyBZGIx+yN33Y8L9wVSiZw6a5l5bgKeLSSYRSqSELs/PNfEYzsHGdS3RoWM69dQv0X6TSr3p3K1JfUbA8GZCz6kG2gcF8m7QvHlYCMMOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrLde/OIC0cgtPmLWXIJF5U19mbUA+17Secmw/4gCag=;
 b=lGrq7IRSqNZBk6IbygcB29yiIdq5MEk88nWjGMvCMJIfBstg23nTOjIZB3M2LAHJcyMDizVttIaIQhvIxlGWXdovP6EKKfboLLPDAMA3F/tlj7eB2eNuhGDpETEcIp8R0SSrGuhGrOsc4AJW0Lilly+EPmB9z3R9xsSd4SObbCDHGMw9X9nf41GlH8AeduMR3SxVPLoKbtRCDykCzFLke01ZpjO3ogLBnKy6mapFZLkxyuEBdAFy5YAmQBQCmnymLpnMfEk1E/VHlCUDOV0jxaYfoHTwtYD0aT4k+LYeExh8JgGUxdZ6hGzWBnpgjLI8hSuiKu3y7j4wfIGJDj8c7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrLde/OIC0cgtPmLWXIJF5U19mbUA+17Secmw/4gCag=;
 b=kYo6NlixnJAa8D/JmbI1R6TSESnq/G3jbfFAv/NFAlmqA2zZfceoqXZIEazRYFqb2LIIqs10Ij3P+Pwe0cjg4t5zidP0ZDZstDsPLywVHLj3w+6OcIRs0JGKnsQ6U9wzYKmWiidBwfwSRyU29RfiiG0yqtm2LiLMvkznbfxV0OdZaIbFMOH3Fgofee/yf6ZjhTTnmVnRJPC98YMJ7c+nHsNDVCTvRhXbEO8bOhVpeDJCNIZOCwswzvM2l/u/T5cHtB76za0lBfRef/6fPwaH+MtuAB0GMAx32RK7o4olAd5/Mba1y4h5G9v1keGc6mKoRvjxT8YmL6Ro3qXHduZlaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:00 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 04/10] iommu/sun50i: Convert to generic_single_device_group()
Date: Tue, 18 Jul 2023 16:05:52 -0300
Message-ID: <4-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:610:cd::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 03351347-0704-4c80-a92a-08db87c20620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ItdDadcKRdMIMco/7BzdkAYYRW4Zf2xcKztRlaWF5AviCzpWfbzzIqcSI+J4lqxRxTknvgp2bUWQ7ZFrS2H0oZ9gYhqYv3/vdPiWauWouiy1GFCQ4owSg76AFMmxee+pYbiywfvvXETTQwT6rp/OpySplELSnnEGujvPpXZ4Cjvk9cxuP3xeG9wRyO4ThxaIrK3mkJG25CMPc5Xf9jNXVb2pCdD0DRlms6HJmA+GEOX+ohs0OdDimEIj1VUZgQTmkKTKz0VIJflrwvWUNA2GPchR4tD1E1dOT50ae++CjzcCqKF7rjhPjNc3IuE+fqq2asN2jjb6sz3z6vXwL3aHcRObT6MahuOKkA28MmSrArdDKMkTGvcrOmqxlLFg1ozA6lex0uzlYuhCvUZeWcgKzz1rxoL00eKSmNuBksWFyBc77Pxsefrg/A5E1B2HAQ3153NlUiID3l2P0/gl2UyvoVKCrYEcr2gb1U6CQQj6N5gyXo764C1oP+Ts2GfP1SJgES8HwPvuoj+NotYnJnvjto1VACpKHyaInnz4cvHDfMjZbvOBctmzRfeSwISX9Ghr4gRnJPaJn2MH+i5qDtSlBzzv0iqtbCmDy9v63LW1VSd8qB0XRxSy/uElVN5kbfheAXXE9UByTh9mjwsjTZkilA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jVFq/mIBTF0GfZKJiDlUMRkv8EfEqKLymaUFXO8k4A5E6yywtNcbasPdVSzl?=
 =?us-ascii?Q?NLKMFIqsIS6KxL0yPX9noktB3hPVESA08AH2eFL2N0W4tF3437sB9NNqpjCl?=
 =?us-ascii?Q?OMLBgg68/TVSaqQBC+lMyrT4XZQK8mTobcOyEwvqA7Z/jZQbaf/xILsuLt0Q?=
 =?us-ascii?Q?HYLWJ7J+Ji2awu+h6urdBin2zrSHyyIfIRWcWvq3b6xO1o9Mokn8RaYNfLPO?=
 =?us-ascii?Q?a1x0bSIaWAWV8dMC1u9iDjZvKCDOA+W0DkqeoFvZGpklNiVSNvQhH+tg27UF?=
 =?us-ascii?Q?AWa3YGwytSHujQNCtk0TgBfJqenycWepXe/AQBmOYuV5h6Z7Px1VLQLdXf7C?=
 =?us-ascii?Q?qZNICUILWPBQrxEPuutLUC6vOT7oA+oLBPM+ZgNuAr3knwhvZn4u0RawXh4l?=
 =?us-ascii?Q?dm5lJ2pPxHuy9uqO8A14aaIJw70q91qWQz0RvgfA7JK8H0vDM/eBRz26+eUN?=
 =?us-ascii?Q?rzYiZ35+QKEsK1t829TXDusEHUXO8tTtVlcFaEOof/mLt46/bm9XdY1VpNB+?=
 =?us-ascii?Q?UWg0bMiCRqMDpeyFF9UibMFLk8fgwocRJQ6cXmaLUcQt8lTUHNgaBRiPc3vX?=
 =?us-ascii?Q?LbniL2x7yTOsyWMGGH/uLV8vRVANLwyNWUCCiAedv69mfXoEshXm5B5nLxKn?=
 =?us-ascii?Q?3K8cXNQL3VwNJnv4d4JfOWDri0i8fwvNd0Yb3rmLxTJDiHVFPmwwrwFvADhs?=
 =?us-ascii?Q?zdQrae8kMWHksMmcRQnlciBccfj7ie2PA8YDEQCA4Lqa7Taf373V1ePdQrOP?=
 =?us-ascii?Q?ZxrdrhxkrqCCvNuLwp65gRDF0iggJS8Fe8m62Ui1XXkTV2SPZZEShbWP6n5s?=
 =?us-ascii?Q?LQy7IL/i95Q87XkCrwtNXOvfuXV46oNer1SWMdagbURB0RZCMv6PjQjkNlSo?=
 =?us-ascii?Q?LXddwxOOknC6zTJwfJWMyn30zauTABXFRSubV/zXlWcODGbGxTw+j9nUT5p6?=
 =?us-ascii?Q?h+uGRSjgYr/0eD39udCnO/xsMrtg2tJdtGVl8ld3+KQNyUvBh1UV31Nvjsmt?=
 =?us-ascii?Q?1Huyy/cvL9mdxT/HH8a5fCXYobTHMBgeL8U/ZlcZbGM9ReBJ9MDdSUkHkiyV?=
 =?us-ascii?Q?Ct2LJjxE91UMhMvM2amwvN/J5ZINBseoF9wNZV5V2fGTeUuuu1S1ciGtxar/?=
 =?us-ascii?Q?OgIE6BTqZhRUvNthAiLHDtr9p0LGj7apL/PtU2TCfNwX1bxcWG/XoK7DztPY?=
 =?us-ascii?Q?4C3EzRyii5LMo8lR1nDS1UhqtDrWka+/PY6e0Ga+w2MdJbWAjl8OkKttxrRX?=
 =?us-ascii?Q?zZ6rCEOSf6L4s+iCn4sTdtEydMTIw3ZdiWZORE0xHZje83uC7VsnPGm5pSJo?=
 =?us-ascii?Q?ts0BSafsB9KaJTvqMzac3Y0rSdxOwXKY9fMGhuzGvpUI6pRIh4v+uSwRxwne?=
 =?us-ascii?Q?nPxUwT0S2KTozk0TyXpHbE5rpwQsLmojf6os9mHq+Q8RwCa1kYZm/d68JOZ7?=
 =?us-ascii?Q?API2bnwgX4FcagvGHsZI+9IsLnRqzdzwygscwrgy296wKdGNxPUXyRHz6J1U?=
 =?us-ascii?Q?Dy5TJuAXUrqRVgOIPlvp8auTpwHpsclqtVNX6rdQqvKz695C0rRbqOl+JpeA?=
 =?us-ascii?Q?HfHDZQqAL0TTwbJHR5ynMFZ4Up94p1bDiwEuu8x0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03351347-0704-4c80-a92a-08db87c20620
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:00.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGL0EpBMkX5GJkRnQFxShH67lJDtUcHePitGFHTNAHQpgqY8HQGN0WBzKjQGxcnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Use the new helper.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sun50i-iommu.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 74c5cb93e90027..b8df655185ab2a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -107,7 +107,6 @@ struct sun50i_iommu {
 	struct clk *clk;
 
 	struct iommu_domain *domain;
-	struct iommu_group *group;
 	struct kmem_cache *pt_pool;
 };
 
@@ -808,13 +807,6 @@ static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
 	return &iommu->iommu;
 }
 
-static struct iommu_group *sun50i_iommu_device_group(struct device *dev)
-{
-	struct sun50i_iommu *iommu = sun50i_iommu_from_dev(dev);
-
-	return iommu_group_ref_get(iommu->group);
-}
-
 static int sun50i_iommu_of_xlate(struct device *dev,
 				 struct of_phandle_args *args)
 {
@@ -828,7 +820,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 
 static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
-	.device_group	= sun50i_iommu_device_group,
+	.device_group	= generic_single_device_group,
 	.domain_alloc	= sun50i_iommu_domain_alloc,
 	.of_xlate	= sun50i_iommu_of_xlate,
 	.probe_device	= sun50i_iommu_probe_device,
@@ -995,42 +987,36 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	if (!iommu->pt_pool)
 		return -ENOMEM;
 
-	iommu->group = iommu_group_alloc();
-	if (IS_ERR(iommu->group)) {
-		ret = PTR_ERR(iommu->group);
-		goto err_free_cache;
-	}
-
 	iommu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(iommu->base)) {
 		ret = PTR_ERR(iommu->base);
-		goto err_free_group;
+		goto err_free_cache;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto err_free_group;
+		goto err_free_cache;
 	}
 
 	iommu->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(iommu->clk)) {
 		dev_err(&pdev->dev, "Couldn't get our clock.\n");
 		ret = PTR_ERR(iommu->clk);
-		goto err_free_group;
+		goto err_free_cache;
 	}
 
 	iommu->reset = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(iommu->reset)) {
 		dev_err(&pdev->dev, "Couldn't get our reset line.\n");
 		ret = PTR_ERR(iommu->reset);
-		goto err_free_group;
+		goto err_free_cache;
 	}
 
 	ret = iommu_device_sysfs_add(&iommu->iommu, &pdev->dev,
 				     NULL, dev_name(&pdev->dev));
 	if (ret)
-		goto err_free_group;
+		goto err_free_cache;
 
 	ret = iommu_device_register(&iommu->iommu, &sun50i_iommu_ops, &pdev->dev);
 	if (ret)
@@ -1049,9 +1035,6 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 
-err_free_group:
-	iommu_group_put(iommu->group);
-
 err_free_cache:
 	kmem_cache_destroy(iommu->pt_pool);
 
-- 
2.41.0

