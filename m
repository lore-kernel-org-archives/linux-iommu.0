Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBC1DA4F;
	Tue, 22 Aug 2023 16:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9H1sNYcP/AKNhKXwQl+Z7u5oit8VPW42vCXWPnIZIu2c6wb6RFeJUww+LkpwXzjorAhr1qc8vpggkJOUftw2UOIZgkJLNL4ZlmcSr+MsW5Dmm+9eGmyGhufrAcwq+iXclHfMTBVBhVZvpWvuVM74/xDGX7k3MRNtxko8NZdlyUVBAYZBCGZiGSKmWA1MIFusEfs1NLvOpEPCRR8iaiv9N08HyZffDrRaJpUXp/wt8n1OAduZwAWgNKL/yeyvRBnWiWkbDfJAb9Mm7XDUDEUiHOjoTTbcorvWnBXhjYg8H5a/45FTWlqqGxzI49doudLBBD5U0/K+TeZKHsQbmZApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF20GgUKOoytttAX7Lh/dfU2iYeWLRAsCCkrvp7s/OM=;
 b=AiDIQYH6GI60yPzzPMn54mrp15O4GEb9EBoY7kp5V8EexlsceM8YRmZ1J3aNxHu0QceugkZcqry6BMvasXKZ9zD2HYM2qTFD8lm2HlFnBR65VYzsCRR6em2eSScaUmUyJnAfTORylq+alHlt/GJc3IVyOfLXe7BPt465Lk8oVOTkluapcg7U6R7OyT5F8X+xnEp3aWdj1+vbFJLTg6lIHKMMcqf8gHQKD/PPhG8UPml+heJoFYbCdl+8SiozOauEvLp061lFqsDxq95gHZGc4FrHP7yUdiCY2N4W/8Y3srzs2Xbz1UPOr7Ny3Rxo3mgdAibt/UgP0HUKN3oL7D0O7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF20GgUKOoytttAX7Lh/dfU2iYeWLRAsCCkrvp7s/OM=;
 b=FBozIvRHPNSCk1f7+fpNYevrJJ/cwWeRjLAZ8Bvh3vM7COXDbDviZI53lyu+oNgDLwVMmP675tTXWVM1SIfpp2Yc/WJHGdvblrK7vKzSgjDPCTBT2W7yWCYNw5nhTxM07eoTscF0KE4d1SxAMXuQahcwFvWv+U15v+XQ0CGeuZoevN6AB6vQpZyVxgqMG0Kg49mzk0nrGan+8vPKiqHDyHXdVmRsiN67aXkMdeibEh+oov0oKIDFAGf5gZS0f5KI/Il7B7u32DffMI6HV+zJ1UjD8in+vTPXvhUUS9kM9zpvQ9ei9nz12oezrJ2sEXGiPbyEIy5FHwXhbs5HgWqj7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 16:16:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:16:06 +0000
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
Subject: [PATCH 5/7] iommu/rockchip: Convert to generic_single_device_group()
Date: Tue, 22 Aug 2023 13:16:00 -0300
Message-ID: <5-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
In-Reply-To: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:610:53::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4a6b75-ace7-429f-cda7-08dba32b1670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AJ1+CA/2tsmP4qEhyNXcopRkv51VwsQrejA7dmtTf5enhIfSv5x6to8NLb0uetJRYhM/mjhjaQrA0WSP5WZTE5jQh8Q+pRnEoNUhU/Gd3PkIoPZ3pB8TMVmwqX1gqJrmWjuj0ypA7Z0mnqprnM4ENRL5mG1E711mQtcFHzMBjnCJBqOqOD8zegTtN82+WP7oemc7amJDE+vmDbVhbDU4RisJpO3231AH3eLBbvdNit9eNAFQudCqDw0F16iEyclGCcAkV9UkYxAXTN6pPEYoIXELXTGlMzo7yrLx56c7h1Rkh0mqXByWz4nkp+lGBlVOErVRa9sqYl4Dl3G/44yFvVlkq/dKWsEIuEWZC86hBlUDVp+kT/4tIKF2d0xdj3ea9skUn2vI8LCODFQZNG42pJo4b7IrX9/SRR58/hO2oB4KP5a74gUWsa8NK8IS7MToxT85YytIYsEaN5c/M85yPm27O/brTdiQ2LLDROFQ3/Ofz9U9VhjFb2HAiQvZnAocqMIuPd74XLYrNroULAUhFcJKm9ql6/yLfJZoTJU564JBrztsdU9kJcCahPjxxPujwksRKxR6cmr7qhHsioCMaoOWzENVws6LdLNyhF/0Jpncv3JlxofRc9wvrMf4n/iioWoCUkNGsU75g+/JZI0V6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199024)(1800799009)(186009)(83380400001)(478600001)(921005)(26005)(6506007)(6486002)(2616005)(6512007)(6666004)(86362001)(5660300002)(4326008)(2906002)(7416002)(66556008)(38100700002)(110136005)(316002)(54906003)(66476007)(41300700001)(8676002)(8936002)(36756003)(66946007)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OSXUxCje1rDULGSL9SjICK7UPgfxBP8ULtlNggFlvW/jkv1gz4XrBepSA6sI?=
 =?us-ascii?Q?m1aMLOHMA9pEnkqE2Hj7rMTCdhtRRr1iWsS3r9c30Bhw2JJFJirnk3YPJ8HI?=
 =?us-ascii?Q?D7pxSvPA9UEuhu3FTmK6BvfMyWylSw+XVw0uxxLoJRKvowK8ol1UTm7AqwXq?=
 =?us-ascii?Q?y+wuQK/IMPRrKH9hAK+RIWjTkg1NJer/Mnx20HsVGbH9Y/FnCNv9W7A4iYE3?=
 =?us-ascii?Q?dioroB84h1jqGbAWAXQuVAMJ6ZSIcd9wGkmXGkazC1hy6uUNxghIg+eISskL?=
 =?us-ascii?Q?CfwAQrCW+eHzPmrVGL9u4CJokx8ynpe+8hYCwfY3QS41UJKVsn0AgHzzaGDw?=
 =?us-ascii?Q?8T6nWsWjaXJUmfJM4nqMW2d15rL6TbDRNS88zKtUYy7P/XjnPRJxSEl7xlHs?=
 =?us-ascii?Q?xh9PC/fp5ZDKIO3wV2dGz+J6rqbxO3JVC/gtFFxoO7x3LeT3qizqfK148CRK?=
 =?us-ascii?Q?GLNanY+fu4VHs5cMCn5102qFWb5nKmw69zcI1oNUoSKL5u3GEYCIG1+JW871?=
 =?us-ascii?Q?HppcJRvTL8aCn6aMidjRzdKiLPEyN8gO+EmqHdDaubZwUVgxlFD8BoCBc/tM?=
 =?us-ascii?Q?J5bLwKm60vCChsrJEe/si17GEa8UR2gEvvFbTxDnT3xeZbM8mYl5OyUyKMoe?=
 =?us-ascii?Q?MKOWBVwSx6q/Gla/wfp7/teViKqaIeunYK5ZUQwhlKASUUEvr946AfFqEAVI?=
 =?us-ascii?Q?UpMCvL+VuieugXZYZLuuo3DeHyrxdsO6C7Kg0VNz6Hv0+qCvOMG9w1IDUHMT?=
 =?us-ascii?Q?Fld9fyDGRpwE9SSbOfBCFwxtvUpdGESMQnrthLvp8QFqlnyO7U5YnvFcbynD?=
 =?us-ascii?Q?OUGLqnWxN0ypNN0GIsmUkG5l0m41cDu+znTYC0pdzbLqoDwiZZKgCHy7v50q?=
 =?us-ascii?Q?ptsTVZnfx1FbIGPvxL7znTzJum8Lginufio8J0+zsmtqLTY/ELgdVqo62GNR?=
 =?us-ascii?Q?MgXDtwtLC2DvJGGk1wG5q4kP5K12OmiD+OdKosL5ZkbmPwm9BdhI3r1/ceuy?=
 =?us-ascii?Q?FoIlhoET8nkq6IZE+hMEtQ21wMK6h91FVc1qk0U8cgsci2NDju2x9eUXcVTx?=
 =?us-ascii?Q?CuaR7nhFdXgO6A6+d0CpfwYe86lHA2utLQNAxirYD+2J5fwcmalHietdKSVu?=
 =?us-ascii?Q?1EMGdIbcua8G10lVKhmX1Nw7anpf5tBOz6VJujU3iBS7VT9cJU5/iwlOUtBE?=
 =?us-ascii?Q?V8OrQqDdJNw822rlyKlyP+uMi00iyr9UlvcjfXEAvtFoWx+/xwkwOtzvMcug?=
 =?us-ascii?Q?m2MeTbqBhkicnvVEgHDdjBZARGbgydCOHPB0mUFXOTIQKwtJMpt7xUmYT3Ts?=
 =?us-ascii?Q?qMOPb63HhUJqJ8Ye5t1mx2WEoVGhd1+cZs3MERBAr1CvaAHvKGIwQMCPgNya?=
 =?us-ascii?Q?ybf4EWvy3NTWhSE2uJnnTLS3fyJGaYOIifnrgVIqy1UBTQlxSr6/O6aI2E2w?=
 =?us-ascii?Q?4mYatRqeWaKKjdr+3Tb+b3JJCOTTLNOqgF1FroDu5D75h46OLMZkYYvGvUd9?=
 =?us-ascii?Q?KDSt2EHmEDW5Yh/mJmggjn8/NKI9mXZNU/cad6nZcoXB2L8zmS5eOcJmVsgy?=
 =?us-ascii?Q?rSRKHzTL4aN6g9HI2/mioz+aWc45BiA2GUz2lmdP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4a6b75-ace7-429f-cda7-08dba32b1670
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:16:05.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gXXYyWnwvXMR6SJ8giS3TK7QvpPaIL7gz00eNTL1tBGnGFXeYtsEcjx7v3njwNv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Use the new helper.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/rockchip-iommu.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 8ff69fbf9f65db..91f13cc9411548 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -113,7 +113,6 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
-	struct iommu_group *group;
 };
 
 struct rk_iommudata {
@@ -1155,15 +1154,6 @@ static void rk_iommu_release_device(struct device *dev)
 	device_link_del(data->link);
 }
 
-static struct iommu_group *rk_iommu_device_group(struct device *dev)
-{
-	struct rk_iommu *iommu;
-
-	iommu = rk_iommu_from_dev(dev);
-
-	return iommu_group_ref_get(iommu->group);
-}
-
 static int rk_iommu_of_xlate(struct device *dev,
 			     struct of_phandle_args *args)
 {
@@ -1189,7 +1179,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.domain_alloc = rk_iommu_domain_alloc,
 	.probe_device = rk_iommu_probe_device,
 	.release_device = rk_iommu_release_device,
-	.device_group = rk_iommu_device_group,
+	.device_group = generic_single_device_group,
 #ifdef CONFIG_ARM
 	.set_platform_dma_ops = rk_iommu_set_platform_dma,
 #endif
@@ -1280,15 +1270,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	iommu->group = iommu_group_alloc();
-	if (IS_ERR(iommu->group)) {
-		err = PTR_ERR(iommu->group);
-		goto err_unprepare_clocks;
-	}
-
 	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
 	if (err)
-		goto err_put_group;
+		goto err_unprepare_clocks;
 
 	err = iommu_device_register(&iommu->iommu, &rk_iommu_ops, dev);
 	if (err)
@@ -1325,8 +1309,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
-err_put_group:
-	iommu_group_put(iommu->group);
 err_unprepare_clocks:
 	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
 	return err;
-- 
2.41.0

