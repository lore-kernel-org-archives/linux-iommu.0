Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697C18C34;
	Mon, 31 Jul 2023 17:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7bqMvQBrw1sRVSzRHcXZLmi6ykBUgBKcTffvrH8lMLVi33brrvoEePnQfAzS8smDO3L5nbnG1kT4zobYiDAXSsnMoc03ZyedRgC3qG3XjRUrTcGl+Q9476F4jPlwm0yFR5P6Q36jdX5VWx0ZtApaPPohwxqrb76CwI0KTQlhjp9W3Wg8t/S+yuzgZlyfWh4pQFVAiI04XaROMT5w57+lcrlBzolqJ8k5nl176SNYEShulQPSmKUx6EcKVvAq3p2t+JnwxGoZUVtDwMpDmhT8+SUsA3lZ9RGPaPWdEW8mB8CFIAKZPMUEMwCDUe4ggiWyduk4o4LW702RGh/GEODpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrLde/OIC0cgtPmLWXIJF5U19mbUA+17Secmw/4gCag=;
 b=ZIdXmDWgOW3unTdZQskpf+n0HmxnhCRKld9eygCnCT4GL5PPIrR620WezWe1L7OOhXexbnWGIw/aBcb8Z+wXR06fs4VPIQYot7TvK4lLIv8gxID+HIbHpelVIH6Gxkfkl1sfO9faaNl7gVEmbEj0wEnfKGoP3TuFroB1wx+1C4jQWtiYqEQv38pVAVunA5CADa+EvSTZ7Tz//Xo//6LwH7oyJOGgxaq6XlP2uFOL5d9RQ+7DF+pc/tmsLiNp4n9BdnfrAMLS8PFRonw9i3MaedvFcE6ZweAIhizlee32LKOhRgf+pA8ylskC4Lw6yBp10FsjMW4KttCR4cG/abikdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrLde/OIC0cgtPmLWXIJF5U19mbUA+17Secmw/4gCag=;
 b=RAZXl1rJWXqSWA76F2G0W08Si7S3Dtr682bNiZ7+GmN+Dl0YggG1c7AwCcYd+7QzZ36sUpiCY4U0x0h3xQL/E+l4SCiCYCJlKEHBnRX+3W/L55mZguvjZ2KFZMrsZd+Q1Q7oyGNEdLmXL/pa8GbA7YZld2hyiwYvgxofyZ9ZTBIp0MwSBnHguXDVPJvIKpd2+bNAQSzsZhPDVan+31V/34b7KuOlLGHKmUUpMkWdlp0l7wwf/KlXvVkNCAz46gcIxPKliplWm8OU6wDb58AOP41DjyGXHWFrObXGmElpIL06nhjdNBVs05ho6Ew4Y9n91ytB1Gc4QMf4ea1RCqfefg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 04/10] iommu/sun50i: Convert to generic_single_device_group()
Date: Mon, 31 Jul 2023 14:50:27 -0300
Message-ID: <4-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5083ec-369c-4ea3-092c-08db91eea486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	efqiC01FRoHj0Ym9PZZrklkAgy2MXMyDI22K2Tc8Jy3BHQxKq+Jn6gvxGwEk84TJ9/Xykc3PIMu6J8plMfWH9nOzhF1RLAPScs/CgVYX8CUkabpFLm28nQsxhNhrwab0tww3SDRVFDsuvDNZNA97wDsZ04f1r9m4be5HeoXntfeFdlWUWa7kw+ZhgR897CDm+FASwYVpRzntRo5ndTn4JRtwkxvKUAjEVyW0fZUpmGNzhhc68BCaxx/oSQYSb97Gs5iBHxE3LNmXteOAYLmkvbDsXBgqQ89yhskdCvRh7TueNbOvhWtfPSB8+a27sSZs9EyPtZYTwWUvR4gFKXdok1/41gS3aW7VcShKV+FnmT2WeTouZ4SOcoRlR+CQsSQK93na4Y2wKgyVXESsEE67Ukn4QjLT92RODRuVLBvpAaT/v/2P8MpJ/b+jHsVYRDLeKRGe6cknbINo3grWHrnCuuJns/sqE+D1NxGCozocIvJBPnIKtQdEdk4SEwC/1sT8Y3ygIwK3CEhnMIzSRIihDjk0N9cfj9ZjnjUaMiFhdjDEMRWhxVe6xMf8EfMVf8K4iq5RtpFv5+h5nv6+T6Msw8b/XONkTubaxku6tqtZCB1rH8vmCxVYnSORFigBVHiI0ekqAKDetd412hBM0qEtJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(41300700001)(921005)(110136005)(38100700002)(66476007)(86362001)(316002)(5660300002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DWht0jx4cMbK+WRz6P++YXkShMxZvvIAmrF92yZYGdMpsUBHYZhYh35m2bCH?=
 =?us-ascii?Q?AJxocmYofPlMUfyPToThAYPl3sYSCPqlxAd749tkM/7Mo4NYjExZU3/V+XfR?=
 =?us-ascii?Q?i9FeZLKVFwG4AG7qgyby8IqGtuDqbj7LUllOEYkhO6gUgwGo3AjYgnAqrHHG?=
 =?us-ascii?Q?y8Rv2e+TY0DYdI5wCBZb8cMqqx3oQM4Bem3904fXAXOIZWrbn321HCZs50Kk?=
 =?us-ascii?Q?lRDPer81u3dVqNDtMCrMvdPkoTkuqRgbjfRE5dn/hgcAbihSYjfp+iwX2wer?=
 =?us-ascii?Q?tG+gBGe/v+sBU97fnJTTs64+E3kZ8pYaSumIdHt5r9pgkyvfBHRECBlAKL2H?=
 =?us-ascii?Q?MzqwK8dRcT1IhbduLYBI5fdjaDNOKRKuFd1Iir5O/UTHYVPUTy081Vo8LINv?=
 =?us-ascii?Q?9H+Xaz8Nu83ZMU3Psl7hRww+REbGgFLyAdTdWULwQRgfMbd3nk52SJyjfcg0?=
 =?us-ascii?Q?zmg9fvAQRgk0YeohjSFrQKVK5QWjfBBCHOzDv8Pg9PR9IGyNEpAFcd6Sn4l7?=
 =?us-ascii?Q?ge8XuMSX0Acgn2nsL/06VhyokVJzBr5b0vfzoVNCOa5znhDUFa7CRg0qn+60?=
 =?us-ascii?Q?9StuAJhI7Iat1wX1zWH4YmURX1WVY8Zw/yf0w5CllX42douZqySYDVTgBmPS?=
 =?us-ascii?Q?Z1e2+WBJdKLfqkJULFQOET8pA5l5YlrjWLE8aRJ7WJ0vFRQtcCVw5de5K3uy?=
 =?us-ascii?Q?Oy8a9fajgjVbQ1Htfxear45B1bNeMJhrpN4uVjCd4oGzWgm8b9CMwJ9a/jmr?=
 =?us-ascii?Q?fdBCn5ELzRuDJzlHkt/faz4vil1Qpptqf7Wnq9m03fBbKHfrqfIzfRGBEjB9?=
 =?us-ascii?Q?d3uachF9Fav+xgNmr5fDiCyrKcPKls72KvOvOa1TfekNFPZshysq+AIHa14W?=
 =?us-ascii?Q?GdgGT2vVOI1ULdtfATjgqTeH76+fP2BHzeUTyHJ/HX8j1vV9pZySfUCW33A1?=
 =?us-ascii?Q?AivvqscHKw7JqM/gdH4TFmh6o7KN7eLLdemndYjkBNUPRwLrGBdGfISspJUK?=
 =?us-ascii?Q?CM0xbMSzMGhs0dYrVL0zjH1p9D9AYCaElbZc68uhcqFMZzKmmVD3zk+wHpvH?=
 =?us-ascii?Q?QdWO7qykYpzn57/XGXQn8DINhu9KSSpm/e9a7ywnZll57nx6NmHCrudKWCP7?=
 =?us-ascii?Q?cXSUxOsLznU5TsKh7qhlfan1ij400JTPVa7Q8Zoliwd5mu9zkoR4N2G8e1cH?=
 =?us-ascii?Q?gB0dTnccbv+5pn+ijwylTANFtm+7wjEW4dcPkCLCoJh6oOMrdv9idJV3b/w3?=
 =?us-ascii?Q?ilYRWiBCNHRFqKUKjxJ19g1BOgksxW3t/DInyX5oMxNRzZC6oJYgvyZg5If9?=
 =?us-ascii?Q?ezjDcIEywXGFRjO5dYUhuYMrwssmzdAHJ0WL+Lr+p6Y5AdD3536LxYTHr3i7?=
 =?us-ascii?Q?sJITRMEM5W5Q6VdiAZlpsGOYGzlx2KfvQygLsY6PtY1c/JNqTSyG0sCIS6sF?=
 =?us-ascii?Q?HeddbORmTm8tBtV07nRgG2HttAB2t+7kuk4l0A1KHdU1XGJeoixjdb0WO9tE?=
 =?us-ascii?Q?UG1vGPYJ1+tudK4aTAjwNmqdUEkiX8N1JSJJrK6bqZAVJZuu3dwXNbgS3Hc2?=
 =?us-ascii?Q?xUKm3PngNe1Tll/rT4uMAk0zIC+3cuDq061ZWzu1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5083ec-369c-4ea3-092c-08db91eea486
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:35.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLWppAQV/Eja5IzsaE5x//+vv1sYX6+UusDItUUoVIRGqpTkxbxD50cU97c+Qe1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

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

