Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E131D304;
	Mon, 31 Jul 2023 17:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R95p/g5E0H+TFmZP6QAueObapZ4ZqUAXknEzSPBG/rP15cmVoBBiid+oApFdsfRef4JQMF2VGiTHBNpXew5/obYbRukLX6ARfl+fsiYeTIP25stNQuIyd4w/ggpDz/oo03iLnxeZRBmSgwuC8zUefT/KXHDTgS0L1O8XoyDol+Jiu0961R4beWtES/nCX89Y1kr7XSnK2QlHwQ1OqDBHT5Pz1+yBvY2s4ZZt1CbMelnVqKCtMvUHSyQIoCHZrY0FwdoFBUFGT2Hy9xpmmt9nWobcjeo0D7avnM77p+XRWSU8HViyr/l8rkSLQ7fgva1pUdGxylAAIMt6Py8uk/2nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvwdiC6E5CEiy25PSFgk7REzIIrBWJs/ybCCiwdcjMs=;
 b=XVHlKOPb70hGKVLGgMNOSrC/uJGrhBp6B71UmCieiLz9jw/wL7hT+Il9lqWVlXbavCv5Tr0SorLLiNp/tgJOpdFwubzEQmkZ6DONkTw8uO4EmfrrhKulJzuQeFMXUcYXl6lZjwKRCulfIDrWo+PbZ1DnwAlDMcOZO863NDOeVJRwZZa+Tc74wvKxvdSXhEmIrwnIZk+8tkfvR/UMIph1ZgspEST41rJmvjbh9BjFcXRzhFOcdR/UKl2DhAbpz0xQHoWsy94yOd079mb+U1PKbIZXta0OuUHpsi9J/9SkHtXZS4D8qcBpGr38sgTW6FNjw+LWSrsVpkGytgEim/eRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvwdiC6E5CEiy25PSFgk7REzIIrBWJs/ybCCiwdcjMs=;
 b=XUqB1Zr26e5E0d7k6yswxcoNvJowMDFxJePea8wGa8qDjHtMhvP2LGcCax+lyypS359UAdTTVwz/jizI0Q1BnS563QPfkGUYVq2n8/Y8mbgETgHXI70QLGQbIyAtEfxfIju9cz58VFeMEv2m/h1LWu08Z0XJ94y6KnP8U3vWs0cKa23rPrGR+5MoQapFpwtDtNseSR1O0Wlhp53ZlcLPYiSTHqtaAgibg8L+5REn4kmxcp3zPnlqZ/SD4v8y3VfWQSNQ6MkaNUvxnnFBlXBY2tcQvYf1KjE7FFA0NPE86HfoQDDq1haQYD4Tse+SoHUbEy412wRu3Rx/74n5Bk0nTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:38 +0000
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
Subject: [PATCH v2 05/10] iommu/sprd: Convert to generic_single_device_group()
Date: Mon, 31 Jul 2023 14:50:28 -0300
Message-ID: <5-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: f0967efd-18c0-408e-8f21-08db91eea4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2/C6ywM9FH8t3Oa9/OUgfD35T5901MBRPQWn6n8ri194MnLT3bRiscsSehN9EQLPlThYbxz7V7TMEdNRQWasZyXs3HyaN26TP238XOTti4P3Qwt9V6YRBJTQ+qOFlQqRNWOyFfWve26AypEppm16k7CiOvdMOFgvtemHb459X0N35L9k4Vkspt/iu5tCvkg7JLc5FCCrMn+t1Z3kRk+vZIXajLCnJa6LgdnK35KozCIGhQUznHR7OFUYYdEXtg3JhM5IaiCtwR+6/Lg1JgAdjwijdJJf+Lec+qkV6S4Fp3HH6IVDikKaIn8kl8S0W8X4cUFbmD05jsvEOweU8gU6hwy6PgGsv+4jQXjbzU9/3jhW67SrXGd8Gl3Eofm5PUfcsDtmsus6cvYJnMTQVithC7jWzWza7qIwu3Q2IMfdc08oosPoiIRXq6DNjSKwdgMDsMz/ruNNrmIhOCjjqkofAQJyZBws+cz0x8/D6VwXcK0mTK31Ukz6wd8T54r2hL4LlE9h3HMYgO8SyBRnPEx5DB2/N4ymTu5ZgJLXZN8wLSbOTb7UKo+2IblWqF2J/bNn55BdNABzmPJKKNk3YJ1U9w0d1Qm/kF5yRFNJSULh3gJOR21MS4FrfdYfLdBvDcp5cSUDbTWxEAArjrZYVV2Vyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(478600001)(38100700002)(921005)(86362001)(6512007)(36756003)(6486002)(6666004)(2616005)(186003)(8676002)(26005)(8936002)(6506007)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(41300700001)(54906003)(110136005)(316002)(7416002)(83380400001)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYOpQFNQ/qnwhimnkjyWygl3SZufIOc/Dh7e6dSM2x6t5gdO2r5UKcO8L3LB?=
 =?us-ascii?Q?qOTwTXNDw9EKp8LO0c2JwWjzqcIkYAkJ7gOQuW8N7BrAqJxByv5Eb9gTeS/F?=
 =?us-ascii?Q?n8qO+pEDrKZGiEeVPKFNAR67JNr4Zb2VB5RIAB6HJSvXRwG2mNOXG17DUjmM?=
 =?us-ascii?Q?a8rwY41N/iejjbJVEgLhuzjLcIb4YWASbzSfNpX52+awVfhNSxBioNWHyeGu?=
 =?us-ascii?Q?Xd0kUU3rU3UNZOyVcRockeeLQov5Sqj0CNxMAhB8mt/kxmRrToMCbjgFNTw8?=
 =?us-ascii?Q?GQMXuNc4k46mXoGSOzfMJ1G7NAjNU9avhj0lK1996cFHudefGsc9HU6Ond0g?=
 =?us-ascii?Q?Uu2DpHRY3udMIuxozk8+wKTtr3bKXz8EENH7jKrG87PmeY7yrlugScpHRY5P?=
 =?us-ascii?Q?/8ctQWWZjiAIYSoQRoc46F+SLOM5cRKbRDeOnJQmSss8Ze2f3ZZFj4iJK29Y?=
 =?us-ascii?Q?rwp+ou1xKaHD9mis1bwIwhZhzlzcUNOeN3a/DJAPc+eh+gvDNHqv0otRkZ9O?=
 =?us-ascii?Q?dMJj0o6PwL5opg56QZeKMgTD24nP0qI+IuRQL2zFI/sV6sjUTMdQEoFCmwa9?=
 =?us-ascii?Q?uyjEek4G6V6sW4rrsofJZZ1Rum7t/zjwZyyIDEWItG0sFgyKtMeYhXOliS0A?=
 =?us-ascii?Q?XuYk/hUjdJAnHtQoe7UJxjsgHKce/2czPmPALiuojFSHf3bhhoriVQCmZYS0?=
 =?us-ascii?Q?W9TVqMoMi1mOzrQXkPc6iYKasz7UnXUNH0H6xaRrYmBTYFZf1Ekt+Mr7NFAm?=
 =?us-ascii?Q?BYVUJhzXoDImE5QISH+tq/bFJ7w3jrBtQgoc14fPz+ji3/ba2L2ki3EgikBC?=
 =?us-ascii?Q?mabC4lvKnst/KS3M1nbsZPjl399k7ATMGJrdX3Blff6vPbCCYsZtntycM19P?=
 =?us-ascii?Q?QBhbVUJWCh7ji6++gjks07jeBGQfw49ocGD9zvSDjM2jsRXSWYLFJrqIjowV?=
 =?us-ascii?Q?5ob/9Z91oESVExmI23iMTxgZGXWWJzTSXl7FuEsni9B0ZF4O17lcStgXdFPO?=
 =?us-ascii?Q?BypKG/LDTRGuRaHkK/dINdJ1a+LyDoR68XsscdHi3ODDzXJzgW3x2jaRpCC8?=
 =?us-ascii?Q?SMIMgECNFnfs06wo03lY/b3603Cin4Z3E4wqQEW9W/53MZqw8hPDJM/ol/Uh?=
 =?us-ascii?Q?vmDNiS2THYlkN1RxjUlUFkmiEByY6h7qzbiEEsBumV7uDy/JTEwhdy9JjHR1?=
 =?us-ascii?Q?2q0s3d+6kElst1WHIxt0s3DToMGe18m3wnvIv6FdfvFMiVRY4oD9kzvYEBLU?=
 =?us-ascii?Q?JUXS/gFat7eefNbDgwBhkLMBjBThjoK/EuCPMKuCgNA4OMrha2kNF+YZ6IB7?=
 =?us-ascii?Q?e8nhtYshZwh2HFF52fodjD2tnjj5tCqWM9j0lfUk8znfHTtdDDeFHxTrRpy9?=
 =?us-ascii?Q?+sBzWZ6UmBeO3y5YTItmCnIed53pw7mxOVCZ+00YmyYfBHH9BFQiYwCgcmC+?=
 =?us-ascii?Q?OA8+1BqZgcVBjRh5t6Cm249Hnfbb/DuZKfBcfc+0q2ZfMT+96Qx4zYu4g2it?=
 =?us-ascii?Q?oQ8+6JcDsKkLimvB0GG7dau2ETy5RbP9H9pVnsBc8W0V/suEYAJZEU+oMvaH?=
 =?us-ascii?Q?hXH66AwKi5Pl1Olca3GeGGQv4mMZMEhzVvCf3R/K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0967efd-18c0-408e-8f21-08db91eea4ae
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:35.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vc1P//GNgBxNHCPGW2wzd0PahObZiszYcmVDyzRHNrI85THkHZDdivdQdd1iG347
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320

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

