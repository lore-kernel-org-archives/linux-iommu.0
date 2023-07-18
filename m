Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0A168C7;
	Tue, 18 Jul 2023 19:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i29eL/tZdPg1vVMF5gZf+BjRfFnIXh14DseczAaURECLy10corm7/5oXKXT0+t7SXjPUc00AlFJ0STwGo187HsuxXLNgXRHt1atDPanAaXJ5Z79nteUycXIHeZ0lyyzZAFmnPbuGcrXEvBMewzueGoTuk6LdaOnnswV33H1PNuJ1YsZao80uztj2qRaskRSVNcsXJ36/dchh30E8sucnEG7jN9H9qOVMJngzvasmUB5Bb1JOpipD0Nob3OCPFP47G3xGqbhED77IoJKEN2B9FZ+UfBdKzNy2yFCcaHHIUfniBt1aKml5e+E2imxpnrC7F5dFZ+OFvtXwRRAO4ub6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvwdiC6E5CEiy25PSFgk7REzIIrBWJs/ybCCiwdcjMs=;
 b=iUsXfKZ4aQoD9Ayh82Ix5re1gReinVIjthI/0FuJxmHDCcGufXAu7suYdbMpVvfSzvdRerA6XaxN3XbdQgWM4Vsi2eQhFNyDCqJoBVGA6Sr0yk58jn0jhOmCeWf94sllECIQK2qQVyhi2x936a38Z7Txjjaue0nwHTrYcy8mwTcbz2gcsTJzRMKdCg8EivTq/5j02EJdX9LuCFuzSKlJwU39VIPxinuTZDt6oUEhO7TwNe6rOgIM3fRslGjifOsfQ182wo0RW/ryXKLQ8k39n/xN+nRIRy3CISzswJy1XfqYLZR+UszqK3Rx0qbfm+LCtYJH3aZsU6nHM3YTF6sjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvwdiC6E5CEiy25PSFgk7REzIIrBWJs/ybCCiwdcjMs=;
 b=gMHMbfMbWIQafZQIpEklpBBJ5yFUyCGeuhJf5nuEg4Otm/BmZO1mDUpz2wP5/iRfAOoIcPNBoeKXcrRt2S04CreWxddUgDGskzDsukBtMEXL1XUCBH2/26bovdufutC2yhyIE9mFBkh9dp3DEJWq9pM4K3kox5yv0TKZFw+lJpY0eyXI35g6Fa9OtmZIeUwYBnMMnlSnhaWzd6BCyEh76M2/+HvC43SSEvz9fpEz8rqtDgGCPMWTGaTuY9RboqAB5teAoFWJhRNd1FXuh0EuzjMYm9ik8CR6B5Qpy6CWS4rovi0XHtgAIWJM/vlBsk9hOATxLiXfcFsHTUfdbX5QYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:02 +0000
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
Subject: [PATCH 05/10] iommu/sprd: Convert to generic_single_device_group()
Date: Tue, 18 Jul 2023 16:05:53 -0300
Message-ID: <5-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:610:cd::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 66291ebd-c23e-4706-1845-08db87c20741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nGqKpBzPonSXjnixyKZOAlmwq9swWBnZqZbLdCR2x2I7fkaRd8r+HF/59Uppo4Rc8sxb6NnsB+5RhtA5YSnCBzWGEOAIxeaUeKvNwtlt5PD+dxC6tsC8GppBHCtxCso/WJ6DJq6aJpyRivwZsHBJqpr6VlqfdcVhsVu4JEVU8+Ur6J2eJSTJfQ4yiXb+b8tJ+JEO1BySt8xxZQYiyrhE752CcaTv1yrm8RzgQ1ia8+V4mB1UEg/EJbkDmrNhnd8CSjFNZ5fJucGrmo/Zp3pBAcFiWqhErHjDA5sg4zfjUGRUhDv2A56QljN4igrDKoQWKgnQnP2HlBuQmvklvHQt/We/bokM3uETDKYJ0uzQY2LduP0GhG1s8jUqXadRg/4WnKGOhSaPIVBZy+6LleEc38WjcI0ObFIziBGYUqaLgsdidFLOvvh0kfBZwUPxIA7KgIV8KeLDDD3SrWwp+DdIv54r0fLb174Nb6encIR/g2hZ/LSgtsE9iKebz0f3fEYgZc7V5VvR4NOnoYx6XTI6iwuGyONHH34qgM7mOOT5lPDie9z0aU8uH8kQKWRKNviuq3BSy3TUVlFiR8SkgMC7tYkEUOxecLe/vkqTAjK9HUeAuo5TJfZxchU82vYOMbqajDrklWRLim4NST4HoTkeNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAiSilI2AEX1WM/+id/sdhA7Sabg2oFT7Rz8jcvV6tlet+s1695z79Zb8SdO?=
 =?us-ascii?Q?kcEjO8nb0La5LWSqQS7HXqB3MJ6m0vTc7Qp/A2089BuFMAhMiRfJ5/5d9NVz?=
 =?us-ascii?Q?IAU28R+eGsHc7dATe4yfLlDN8eYv2cqyxoC/DkME2NLtYtBEGeClvGGCeGyf?=
 =?us-ascii?Q?RtI7QXyy5PGwq3eyKORR2JVi+ZxsJXz0spKJuQXO3diKFuPZgngbdogm+zeP?=
 =?us-ascii?Q?SvRywSowbqNJN0vTobPJDhV+C67krlmv5XAW2U/5QcwtcrnBrHMDec2B8Ji2?=
 =?us-ascii?Q?vwlyu86dW1AQCldVCjNX+XYIk5/wC5lH1CrIrabH8vaxm3X8wa1nl1iKFpV4?=
 =?us-ascii?Q?0hGrtxBGPK7YjXvTuWjqf+NXLJsKUEJ+Q8m2Y6r2bcTtzqpUjihdTrbhSTyG?=
 =?us-ascii?Q?JkQ9a+IlDgexwsH+GWmMZujW6i8bWpx2FFb5XIDzhcvP9B/ONBxMU8YTJbWj?=
 =?us-ascii?Q?EjLOgS2naqKzbcULq39YE39ZTuf+qdaF8wXllRoRoVp9WsqKXmQrp+9XUdTl?=
 =?us-ascii?Q?YM0CJtquKHxcZptTyiE1/SSeeIliCpS/3bLgsxvuq2uLq+JpB3VWicoy/6bV?=
 =?us-ascii?Q?iiSHr0McGMBwLFn9ZKY9i/7Kgg4tBF5mt7hF1AywWrHRACppg4Eif1RsCmqI?=
 =?us-ascii?Q?oNLSRkAkfGlxv3/y7M9kKcECTlAK1f0UlxQdu6o8uIvceQWeCEgKjEdoILSo?=
 =?us-ascii?Q?rRv3/r3bM3vFUrVjqlFdrb+pTICkziD48cj3Iht+Rk4ZRgJa0hW3xr7z0tJ+?=
 =?us-ascii?Q?DqXWX0A4V/Ve77vnL2lE73gbL71+EBPgDP74z32V5EtY+l088oNhqLbpAQ+z?=
 =?us-ascii?Q?xeWdjWmhYizZ/WogpRxmsdvY0rBxaY+K/WONE7LbJFCOE886QPkzGPq2nzsm?=
 =?us-ascii?Q?1e+Y57DZ8zSpqhrR7c+QR3LgpOtqliDrE78TOaUsgm/X09auXPZay7cseaR6?=
 =?us-ascii?Q?GlUM92rt/GV2VT0tChAnOLOaGpT8f+W16KT81w37UywvYFiZC+2Q7hiHMwVc?=
 =?us-ascii?Q?D9gxm5wd4rQcxi5CId60jxYpRndSVkHqKkBDelmFEk9gWKy6w5FklhEdY5i9?=
 =?us-ascii?Q?pCtSolqvOWvKq3Hwzr+fLfHTBMZicjcbn6bDCzpDT7PJngwcBR+9u+1zr/Uu?=
 =?us-ascii?Q?m46ixLOaB1d6xbweBPb5/aGboh0Raka+4rr7oYgznpvgOiqHvDQ6KlWX7e2i?=
 =?us-ascii?Q?vnx/q3vqMEjqN1qOFPsesJIKt1SAmctzeKgp9kTFPrdVTGVDw0lA3LkvWRcC?=
 =?us-ascii?Q?G5VyCCH/0hX+2gwqaH675i+c+GZgTc1XJULSM9HpN2W1Lzlo8HffGrmJ4qM7?=
 =?us-ascii?Q?j78fBW7eGhkmYQD/ayBGg09hcJyCyJ+NP9vx70UtqGGNIsnuR4fgNCISZNOO?=
 =?us-ascii?Q?J6H3u9T/cI+YuA28h4MpmxP2D33zxvolLQfcoi3kKA0TSlxhX83hYuuBpEy+?=
 =?us-ascii?Q?n8tVf1KWF333+clYksfcc8QxUQnf/i+0AtPLcegfoGQ3TB8VjU1VFmL1K5ns?=
 =?us-ascii?Q?Jq9kzsN8BqjMNZM9YnG3s4TxeYOu3PTj6RycDLw16Nur4RpxMF9H+iC8MJUu?=
 =?us-ascii?Q?+TJ4It8wXxCdWUODzTq6lgv5PUI2zFOgwA/pBWtR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66291ebd-c23e-4706-1845-08db87c20741
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:01.9531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1fLm+e+dNOUIVGtjFXvVl4SwvvGDDoGqezA6eaUbD9qMzaHOqW/dCHX/Rcdd6dF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Use the new helper.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sprd-iommu.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 39e34fdeccda78..9fc98fd144e445 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -69,7 +69,6 @@ struct sprd_iommu_device {
 	void __iomem		*base;
 	struct device		*dev;
 	struct iommu_device	iommu;
-	struct iommu_group	*group;
 	struct clk		*eb;
 };
 
@@ -397,13 +396,6 @@ static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
 	return &sdev->iommu;
 }
 
-static struct iommu_group *sprd_iommu_device_group(struct device *dev)
-{
-	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
-
-	return iommu_group_ref_get(sdev->group);
-}
-
 static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	struct platform_device *pdev;
@@ -421,7 +413,7 @@ static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 static const struct iommu_ops sprd_iommu_ops = {
 	.domain_alloc	= sprd_iommu_domain_alloc,
 	.probe_device	= sprd_iommu_probe_device,
-	.device_group	= sprd_iommu_device_group,
+	.device_group	= generic_single_device_group,
 	.of_xlate	= sprd_iommu_of_xlate,
 	.pgsize_bitmap	= SPRD_IOMMU_PAGE_SIZE,
 	.owner		= THIS_MODULE,
@@ -494,16 +486,9 @@ static int sprd_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sdev);
 	sdev->dev = dev;
 
-	/* All the client devices are in the same iommu-group */
-	sdev->group = iommu_group_alloc();
-	if (IS_ERR(sdev->group)) {
-		ret = PTR_ERR(sdev->group);
-		goto free_page;
-	}
-
 	ret = iommu_device_sysfs_add(&sdev->iommu, dev, NULL, dev_name(dev));
 	if (ret)
-		goto put_group;
+		goto free_page;
 
 	ret = iommu_device_register(&sdev->iommu, &sprd_iommu_ops, dev);
 	if (ret)
@@ -528,8 +513,6 @@ static int sprd_iommu_probe(struct platform_device *pdev)
 	iommu_device_unregister(&sdev->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&sdev->iommu);
-put_group:
-	iommu_group_put(sdev->group);
 free_page:
 	dma_free_coherent(sdev->dev, SPRD_IOMMU_PAGE_SIZE, sdev->prot_page_va, sdev->prot_page_pa);
 	return ret;
@@ -541,9 +524,6 @@ static void sprd_iommu_remove(struct platform_device *pdev)
 
 	dma_free_coherent(sdev->dev, SPRD_IOMMU_PAGE_SIZE, sdev->prot_page_va, sdev->prot_page_pa);
 
-	iommu_group_put(sdev->group);
-	sdev->group = NULL;
-
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&sdev->iommu);
 	iommu_device_unregister(&sdev->iommu);
-- 
2.41.0

