Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F71D2E6;
	Tue, 22 Aug 2023 16:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOlOodWOp+2rRQJ4PIDbu5XqiHFWxZ9DIixWhFLQ3Ri8EDjvd1k7yppjJyyQl6JDCWbtZTtULN7Dz4AamdMYqmvMh7dwcCGKwx5n4zHnVHcCaS+FxwT0nrPOxRl6PtrWbGrK58fBarOmLFJwA2wxoEsGtCgiNj8FAasmIZ6dpyFt+JS2cd4g+7dSfRfS0Iwm6WZt3/uOddz9tr45HD4HKPzhKeOxZlZNrB6+0ryrQYSCobnjqk/ZqxqKDrvW4cxuQw9z0LuK1MuKhvNc0F5wtXgbFi7mE9fOLkXJuR9hU9Qi5xux9ashiYflRSB4VqYgZhoS+3Pusb9eWCjfGjsC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZbD14POHu2WrHgEO8Jvpv+BAByIdXDcXCIfoGvu5FQ=;
 b=HmK6KZYtrgxkEHjrGyBI/bB1G7d5b9qiKsvvKxZGzkADO/cICE07srIM+pZBv1jtqZEl/xWQwLlTRpfZaGAdAerwruiBhMZP8paX9eLt4hfRc+NUvK11wITprn5ImPDix6qK61tYyH3Zf5mgbHm3A9O3+Eu7+c0jmLEpJ9XrcBAfcqwKlE4a1Iw7xOh07A2S6yHZpsxGlOeWJ438eQqlloHQn8y2DRH6T6/SIRUvh77TkuOVt9ItRsfFpo24CuxHdJ1ciWnDQKE4staUYl5zCVV1waNCmz4UR6c0/g27N8QTy06AnsW1Exx737qjDexwNeyucBmUb38cd0NBC9Xt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZbD14POHu2WrHgEO8Jvpv+BAByIdXDcXCIfoGvu5FQ=;
 b=QWq7+l5rTrZ/08Qm0aeM+wytJ+yFy6cqZdBgWb9O6FQ1yte1TFl35yxE8blKRlqUYinlNUGrh1+YOA4MwDQYzWI2BkVCSj0zSsd7SjkJvduXwn28im4NKoVr+BEhZgcl5DlISz+MWidT/hA3r7Vzz0A5za47t27cGdSr3E0GOMQRs1QHgvQaVDPPOrwR2r0Ln6MtoGs6sBlfbCsX3r1irDUnpCK+6uiqX6XBYenzC/mC3KtO6a+pPZmibN8WTRSBws3dx2iP+MNmRbRQDjRkim56W4KZcIf8B9GdvDbgqnOMI+0rZB+t+uU8zBKzAbHk6EOIJ4WAdRUZXGHmaoC2iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 16:16:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:16:03 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 7/7] iommu/omap: Convert to generic_single_device_group()
Date: Tue, 22 Aug 2023 13:16:02 -0300
Message-ID: <7-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
In-Reply-To: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:610:4d::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 4815ff2b-eaba-4d59-f3d1-08dba32b14dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nFzrUNvYQNaBDsIhFlqWw/E/6QqZBkSzTjdCYnZ8zU1kAkUJIq7ezUDPLoW218yHNf6/nCZFUREgjyRBb9XtrSGL5TEF+K56q/VeRXNQ3UUS2CcXouZty4yQXt/nRKikID+pe/B4FqgImRq7BAEZzr1YFTawh9Lgc9pwywRVvLHn8AxLb7/elmwq++W+OejZ9vvVcjs+y94Fk0TeuDk8SwThmtisYo7ZB7ohiCofodOCxjbB3y9bd66LBZPAWLB5FApjDIBuUzNmkMI8NpAtnuznOre2Ira3cdKQRINowVh7LDT2ZWO9PQXebKAFzLX5ItB1Uq37yy7S3TMCt8tNgGdyJA505wuoh82lxNgEMhNc4nfbNWgq0oa1XelKmVcjvhDvLniUJHUXinUeuOxJ4WMunNEVYQ2E3oYp0pmSUZNHM46gzVYpiPBsG6yBWXC38TCxsjAm86wVT4jyd/lAqNQ885eRGtwQSV6nyh6LNR7DkEMzaYnvbAeulQpU4siQLM+mOrIyyg7IUz8OAO78p4+ta/xFYK8vUvxWA8nesJSzCe2XztHLaIhGzo0+OvXUfMkJz5iiBkgMc8rBP3fT+J6sHKVaTtdxJPQHLAH2kTl43St304U/DuJN4xUfKHMGEbWvFtKU68uAXn4VCzy7pQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(1800799009)(451199024)(186009)(4326008)(8676002)(8936002)(316002)(478600001)(66556008)(110136005)(66476007)(54906003)(66946007)(41300700001)(6506007)(6486002)(6512007)(921005)(38100700002)(7416002)(36756003)(26005)(5660300002)(2906002)(2616005)(83380400001)(86362001)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+xlOYImExYhkKku7dpnoSzA/8TMt9COPEFbW9rZoDFJuPdLAwS3tYk8amDpi?=
 =?us-ascii?Q?c8vS5JhC3wiFuIGNSea4YvkE/mUbBEWVqHdtAAmu2fWbnOK67STWANXXPxVD?=
 =?us-ascii?Q?6nve0a6JjnAP3XubbhkcZrj32DZeL2kq4/IAyj75hLUgUBu2Tc1h1AwCv6ku?=
 =?us-ascii?Q?sB03PYD8gB1hjRJDkiRVBq/NdNdwc20tWv2Z2jISG9HkbOO9/4d1pgiZ2fjf?=
 =?us-ascii?Q?+s7u7s3wp6jIIWs98csDVzq0rVVQLv6M3L5JkGSYxFs3mGlapgCYZJDvdX5G?=
 =?us-ascii?Q?QOMVztGpz9l559BqRFLnm1MGbRACNhOjZrMPqei8Nqk+HxC8JGS4nfUhH9yC?=
 =?us-ascii?Q?RAB2bFcvD+KnpbWDr/3o49NFjCAlP3X3uMkOka2Z4rkeijtnaDjP8V0MGb7+?=
 =?us-ascii?Q?th/yhAJjtKMpzkEFXScfBffs9yrKt6rs8abhe7aNUTmDuBFcPks6MYq4qSw8?=
 =?us-ascii?Q?ANWi4YO85lhwI4vqps5Bv3oGWow/7EIUI17XC8UaB5RnhJyxlfFTO4lp8OzL?=
 =?us-ascii?Q?kVSikFHSifp3ReeUNkwSuHDuQeU6+IU3a5vXf/eo62jI43ZK1guhjhI9oUax?=
 =?us-ascii?Q?huQi8kFSehpzE7jvgpKhoIE2MJQeDRKsUd6EaWJdHIBUVdGsZ/9r/4gauRdP?=
 =?us-ascii?Q?CsgtX26zvwHZxMtIF42vBftaxGpALdhJOGqzo7tudTX4Qqg6UCKdqrkHe5Y+?=
 =?us-ascii?Q?M3WfOs0w2QIxzJZeUasHhTuLYh9IjnGO7Xy1Gj04NXAEpMEo0QolC8QTLGRl?=
 =?us-ascii?Q?J37zIWLBtDH99dlAcMyZkIRPpx8LoLKUFfjSN8MM2rFNFdr/pQixoWkYSdPg?=
 =?us-ascii?Q?7mAlyb/u3fgr+cRcuMpLiX4huPiikMCU4GkRWwICnt3AMamTwgwbA1DWo7TM?=
 =?us-ascii?Q?W22x5pWluparHxFZD966Wns5L7+DalaFhqEr8HIh1LioVO5L6KKOfQQHZsV6?=
 =?us-ascii?Q?3R7dyJKlEk8knuUQlW5zYTOe6tsyg2VuaRWA0B9Xmm8VJrcJriFZvEZLlHP4?=
 =?us-ascii?Q?CH1EI9DDEADmbF1PI3LKlzie8dvwt9/yNTIKu7ElhygMsGj3hXJgkKhO+evp?=
 =?us-ascii?Q?tOC3cIwnQydAPw1OLGBjdbU2mRPnJ9EOIcL0ufSaCM1P3s1T75EY2LrPw/8A?=
 =?us-ascii?Q?8Ti+rEhuwebhgJOe8KcC1ipN15kpixTW67zYboOkHc3TUmbNxzFwcvJ1DRuR?=
 =?us-ascii?Q?wp4OuDj7UAVdQ7ELkBO9qqpxq4oUXk2eM9aKtI2p7ueiFpw64NCz/oR2gS/d?=
 =?us-ascii?Q?pt/P9qsKk7tzPfvNQXYjLO64/pXemxmr09Jm63tY4ZJd3xPOoliEPrw9luES?=
 =?us-ascii?Q?tyC4bDmAwv/vCZX1cDdROeTlEe6Iy1D0dznaN4fxmP7KyDrIyCx9UPt6EeOc?=
 =?us-ascii?Q?2is7by2Tky4Cxek8CNrAupNOTkAYLbkYCKpWMcE+PMYB9GYQ2ZF5U5bwSnqQ?=
 =?us-ascii?Q?rF915YXnXxfuuCMn9uYRcRNr/LBxP+tT7qB0O431aMv2gxWJyFSu9DUGB18G?=
 =?us-ascii?Q?0+Pm3jseALvs/lIXTD6QXTKlCg/J+jhnHl6Xw8oiFAucRGqW34n5JGRFQihF?=
 =?us-ascii?Q?SL6KShQ8FXj0BF4yKbD9sv668+emmBrGquFIj2zG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4815ff2b-eaba-4d59-f3d1-08dba32b14dd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:16:03.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5d6Fe30Ozr5panqyr8TMCaaea6x9eagcANb5Swr8ARYouf5duafLpwANRINcDXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655

Use the new helper.

For some reason omap will probe its driver even if it doesn't load an
iommu driver. Keep this working by keeping a bool to track if the iommu
driver was started.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/omap-iommu.c | 30 ++++--------------------------
 drivers/iommu/omap-iommu.h |  2 +-
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 537e402f9bba97..97c45f50bf4332 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1225,18 +1225,15 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, obj);
 
 	if (omap_iommu_can_register(pdev)) {
-		obj->group = iommu_group_alloc();
-		if (IS_ERR(obj->group))
-			return PTR_ERR(obj->group);
-
 		err = iommu_device_sysfs_add(&obj->iommu, obj->dev, NULL,
 					     obj->name);
 		if (err)
-			goto out_group;
+			return err;
 
 		err = iommu_device_register(&obj->iommu, &omap_iommu_ops, &pdev->dev);
 		if (err)
 			goto out_sysfs;
+		obj->has_iommu_driver = true;
 	}
 
 	pm_runtime_enable(obj->dev);
@@ -1252,8 +1249,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 out_sysfs:
 	iommu_device_sysfs_remove(&obj->iommu);
-out_group:
-	iommu_group_put(obj->group);
 	return err;
 }
 
@@ -1261,10 +1256,7 @@ static void omap_iommu_remove(struct platform_device *pdev)
 {
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
-	if (obj->group) {
-		iommu_group_put(obj->group);
-		obj->group = NULL;
-
+	if (obj->has_iommu_driver) {
 		iommu_device_sysfs_remove(&obj->iommu);
 		iommu_device_unregister(&obj->iommu);
 	}
@@ -1717,25 +1709,11 @@ static void omap_iommu_release_device(struct device *dev)
 
 }
 
-static struct iommu_group *omap_iommu_device_group(struct device *dev)
-{
-	struct omap_iommu_arch_data *arch_data = dev_iommu_priv_get(dev);
-	struct iommu_group *group = ERR_PTR(-EINVAL);
-
-	if (!arch_data)
-		return ERR_PTR(-ENODEV);
-
-	if (arch_data->iommu_dev)
-		group = iommu_group_ref_get(arch_data->iommu_dev->group);
-
-	return group;
-}
-
 static const struct iommu_ops omap_iommu_ops = {
 	.domain_alloc	= omap_iommu_domain_alloc,
 	.probe_device	= omap_iommu_probe_device,
 	.release_device	= omap_iommu_release_device,
-	.device_group	= omap_iommu_device_group,
+	.device_group	= generic_single_device_group,
 	.set_platform_dma_ops = omap_iommu_set_platform_dma,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 18ee713ede784d..27697109ec79a5 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -80,7 +80,7 @@ struct omap_iommu {
 	u32 id;
 
 	struct iommu_device iommu;
-	struct iommu_group *group;
+	bool has_iommu_driver;
 
 	u8 pwrst;
 };
-- 
2.41.0

