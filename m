Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822918C34;
	Mon, 31 Jul 2023 17:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDXmMHnJqqDlNJzodEanOZoRM0kCpwJBVFhcMwDz4HvCvuCTiHGEuSGM4LTsBucSChocURErZFs6+RdU9mgo6aSZBZbf3JEi1wIWO3VmMhLPXb2igN19wrltJ2B5xoonEXxFQvYdFzTa8QjvPHj6k86lQ8ceGz5Lb+rIRcmur0H3P/yafNykGtlmqIHMUFoLMYOmegROwQrI/qgS/sjd2qLZDTUHvWpSV892S1UNGblbc764DGeUuxcmDIuODLMqOveCFIm5hAjMNBmGPf2HTPMIl9FtuRt3TqsdY6DtU5hS14sAkineAFzw9tfPASAsFvRy0Av/GaYMYHOY8BvLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsVGvn1CLzcH649pQIKz9cVx8Rm/xdS4JuFMWCG0qS0=;
 b=OwbALvmWVNAu72IHRgr1HZ/yxIHHLHw3bululBMvay8top3F8RCGjtdrHP3yp1k+6WFwWVNAriKeat1CBS4OvrgNurYOimL31PfeGvTZhNCgWNhvDfZ9fsKFIOm7HvkvBiBv/zpLcjaSCwVeJZOVISAik3paJEnc+l+uciq5Q9WBl+iqEZ/vYnbiU1tCZ8GtFsBzuUD6feyNTThQ0AK9xUZBf+1QJvGyGLPUoPls+iCvBvJlGDNIAYaoau9AMv4Jp+5MAqqIX7CZFK5mlSCAPvYMTV4KoKNF4ISi4fKhY89pMKO5hO7VMxzv/tAbensc97HVFm1lMmy8rBCx5SiAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsVGvn1CLzcH649pQIKz9cVx8Rm/xdS4JuFMWCG0qS0=;
 b=AqXyF/y89Zwce+TDk0giA5nNr8N5KIBk9Ng4Gv9LroF8Tfk8dEAajVooOIR9YQ7txfJKVh2+L0JnGp4//sZGAx0StqwAmIbGSGvRETxaq8ppqL3yK0xPRytm8bEkGTBPfyBLH/CFXEdYf2dFvAd5Gdvyr87geYZskjPiodVxDR9dnhV4GM+/xENAI4Y7N3TZWsQPJYVMPXi1ZzZFmPMMrA45GiqBE5poQoo7t/5lUfLmu9QpWDlRPHh5tIavzQkks9NDONqz6ItuCSJDINZwEsZ1uXa43MCIfvceL1nOVUqcTj//6pRh7Uzidu4cklGaa/OnD4kh3HpDLLsMgkFo0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:36 +0000
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
Subject: [PATCH v2 07/10] iommu/ipmmu-vmsa: Convert to generic_single_device_group()
Date: Mon, 31 Jul 2023 14:50:30 -0300
Message-ID: <7-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0044.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b5cf4a-7d74-410a-f741-08db91eea472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y4np+zfeE4m8pervQMr+s8lgiNcQ2bRp85ajSw3pT0E0BIuXt/KwOG1kTIWVCtHW084IOzc5hYn2kAHNSwk4aniRZK0Qx8oBYDbOS6xDffcloSDNzHAiY03UCRUg2s/ud9alrLCao8nxGietqviRvtxbQ70oBSVYEr4sYfT0bvHW8mYYJ/2PtPtiZY+AUXfCJy3Y6hSMJ0HybHkAEBlrz5DG3Zl1N+38izqRycOISjM5t/X8On/loBKwdg8ZiY4JiAzj62/kmhk0sH1xW8TAsjiNLAPmw9tNhm/uVOuULqPp74adFGmFHvomszFWa0RG7jwCeu4QBiALlmstvg4EJ1xlSAObr1bXVh/pAQ1ZxaaN1ncsqip1F6kKbvUuJYRtV/MJi6gcooBKPxsGrLBLX6YdG5+uVlL7C/+uQkpQnyYFaByL04NiREnOt0q55A2lejseoMmZRrmeQlybrScOewnP6KAmFN/YQA1M3PwTSClQMcoa8Hm563dq8UeTAT19SqbvIAicCbtVOMJPWioXiiHOhMsoNqjTVGZk5A4j1+RPV5KPLJGc6N0cTP4D2UZyWNmiUH6Y1RfWqVnR5jW3wuNPXtWknVqBhv2cdRnoGpLBk3HLI580sEyn5nNLa2kcpBPuvGUWwnMrOJWOF/YWoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(41300700001)(921005)(110136005)(38100700002)(66476007)(86362001)(316002)(5660300002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5TyRPmq9x6kEAPO2ljJsnaQa7SbJ20597/xs3b2YF7yZQHwMjV+bXNVGObi?=
 =?us-ascii?Q?Xi5IpDZhQp1M1yz+w1fWAP3sSe6XiThx8cYRfc9XxjZYXQFgbKgLo/tR0051?=
 =?us-ascii?Q?0osNM+v30D8o6+TqaXqN17VLsWpyGC2OvQigHaA5ipheXd802uOCGUSH17jV?=
 =?us-ascii?Q?23Xh2meSROcs+Q1SM2siEAyqqPl9Oe544bNONpTVHNm7ZQcVgLgaHC+OVQtU?=
 =?us-ascii?Q?FobOSf3NZMRr5OQwz2K/dk3yPh7KiCvjDr2HDUbkwxyOKQddCS+Tfq8PFvsv?=
 =?us-ascii?Q?AkhEbC53BfMg7jXLoqZc2iiFQssaKkxsuyuBjee8jvQJP/gEOzfpSElDTXA2?=
 =?us-ascii?Q?zbQuhznYLkBljpMi5UMs2+lL9V9raQ1Ta/sInNCNSvDjJIT1kokWfUn387Zv?=
 =?us-ascii?Q?KKTAXjiKS9/Mic4137weROnEgHctRliggQobmJQnNak7dpqFE5WfMco+HoW8?=
 =?us-ascii?Q?q6R3tdeYO9eG16dK/BqOiMWDkxKg+BCPeUvK5Lj72NFULUVWBqTc4gYToPJ+?=
 =?us-ascii?Q?PTdYe3/z+CX576iiYxSu/ocEv0Joof3wzglNnvUPOip8cVNwev0eYgHg3sIy?=
 =?us-ascii?Q?bADoMnPDbJtdpgdTW/QsnPDZJECmXyEip+S7lZvxStGq8s9/zO6DP4I2fK+Z?=
 =?us-ascii?Q?iOjEAXjP8KeM40IRgJf+BLSxhtiC6QVekuOdqjxRf4GSpGzHrHbkmgKBUYnU?=
 =?us-ascii?Q?13h5N4I/Kpw1vxePmKi2xFErwBdo1HpzEiecEkFzNPzGRM46eKxC52mWdj1x?=
 =?us-ascii?Q?T5FyTWzQo1q0ZeRPGzx6wusAu3pyIYYoYgRd9oLDdbN3U3EpGSXbFkMj/mGY?=
 =?us-ascii?Q?ntXS0EhNjoO3tq8jIugwRIGPUMyLRMXsUZd5UJexc8I2x4BtUqAjP8Kq+THn?=
 =?us-ascii?Q?jZ4QWz3aE57xWLmd1rEglHv/CWt+K20NOjlx6uiJms2eVlQADXpqPkLatXvN?=
 =?us-ascii?Q?KGYWtAWiyGsw8a3AEoAS8rMN53iJpvH6wRNBUZNpAbyS02o+RIM0J6n4rbtG?=
 =?us-ascii?Q?TagIoPlypWxXU8pCeNsFukUjGehCDXXTeABkmNL3tLGqhiws73VYboQ91wJ6?=
 =?us-ascii?Q?rAQBLrT5H4jIsOiWtbvg0Ib5FT3fKloUfNpFKBzsfYy8ge9p+988wG1fIFvl?=
 =?us-ascii?Q?/yXvZoeXD/kNcoXTr1Ram/T0ol0E9LpSOHGYLexqSJouYtLN2rfQU7S4qPRW?=
 =?us-ascii?Q?DfPjblpWplrVyR57+ausfgaWa28Hj5oT0bDDBe6Ipi2dgEmhPmsBpx2Ru+yY?=
 =?us-ascii?Q?4TSGJdrWp0YWuigZgRYEI5bSgWkzEaanCcI7vT/RQCKeodsXAIDskqnRRIqv?=
 =?us-ascii?Q?NyMxgLcIPRpxLCFRVKtjGEQvHad3kJLRxFvjiFWZDkm2zNdnrOIEbQ68oh7p?=
 =?us-ascii?Q?u8yDpmOrlpeWfhJSMw5BL33ruWl0X/3acsmbLsshwbF7UyiUwZaB3kVSKWZ/?=
 =?us-ascii?Q?tOtYwZ/3prAKU/YojAz+AUjHn6axkifGn4bnUH/FqpgBwvdGvUVCGOg2F+27?=
 =?us-ascii?Q?XGi4foG9nRLizTZ2Mu3B5dgjhaK0Mqf2OuCMDxJFp2ox0zIgNGtr60cA0Zgp?=
 =?us-ascii?Q?/TAX+yr1NT78XEGQ/m/pb8Gc+amcfqNuDoX9L41K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b5cf4a-7d74-410a-f741-08db91eea472
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:35.1718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBWBj/L5M1ar2RuiBbOlVHqza4Cca3/GyZ2IbxIxRNS/3RQBjpVEkYpziakmFqdv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

Use the new helper.

This driver is kind of weird since in ARM mode it pretends it has
per-device groups, but ARM64 mode does not.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/ipmmu-vmsa.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f64c5c9f5b90a..55b9b29221461c 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -63,7 +63,6 @@ struct ipmmu_vmsa_device {
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 	s8 utlb_ctx[IPMMU_UTLB_MAX];
 
-	struct iommu_group *group;
 	struct dma_iommu_mapping *mapping;
 };
 
@@ -832,28 +831,17 @@ static void ipmmu_release_device(struct device *dev)
 	arm_iommu_release_mapping(mmu->mapping);
 }
 
-static struct iommu_group *ipmmu_find_group(struct device *dev)
-{
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-	struct iommu_group *group;
-
-	if (mmu->group)
-		return iommu_group_ref_get(mmu->group);
-
-	group = iommu_group_alloc();
-	if (!IS_ERR(group))
-		mmu->group = group;
-
-	return group;
-}
-
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc,
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
 	.probe_finalize = ipmmu_probe_finalize,
+	/*
+	 * FIXME: The device grouping is a fixed property of the hardware's
+	 * ability to isolate and control DMA, it should not depend on kconfig.
+	 */
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
-			? generic_device_group : ipmmu_find_group,
+			? generic_device_group : generic_single_device_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.41.0

