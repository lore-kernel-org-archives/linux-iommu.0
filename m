Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAB1D2E6;
	Tue, 22 Aug 2023 16:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEcm0vkiertNFWcuXh51pa7JfIBtAeJTOVmCxuMpJ+qwiEt+4TiheLYinydFn3wpQg4vDuRY8AG/FhQlfFYpz3vadWB1Cr5lVkfwt/tENhrSqIGvDyb1wx5fsCa/WTZKIvWyHj+iYJ8+bnpEusXVVryq6es3x18ZbXOX9fLbia6bWU6lXJF2AfW5jNrIkTzYq/g8u0NdqRL2WQuwLJqjXwo6hVvXM2oisMIhuE2LUWNnNh3SSM7W1MXWfm3qEIuf7QOc/jfvrK8FsjKNodelB+sis4hIR5TObhr6J76IDkBYo+GfAwxOd4Yr/mFgkbZZ1pQ9VfwDo7xYCdfyX37maA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSOg7xqDOO88Vnx209EahJSnqmdGE28hMiqI5PgO454=;
 b=WoL+Y3Txeu+nyd6hmtiogPh20C7kKPNuo4oAp2F6g0aDGFlswGsLCOendakxz5uQIZxc5DKt9AfSbu/YAK/ILrBV37RebqDiY2Hy4KGuSJjW6NpJtcl29yUA0lhMFnO3g1dT5I9bbV9TCsIOgGSIdvjMkv1zn9wx09Mor9/HsWW+Bpd5V/hc3mmINXPxOENqa5A90uOAeMtsUgU6y1VRf72e4q3AitoNqKGYt0uyQhT+thdBknwphv35hdy7U9X9U6QczVgZiISdWzE9fwzMcohJwKm0hB+QZ+zJSwrQvCLy1Xp/ten9M9QRwNOKZL9/f8H3IHTICGRXPqNkStmL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSOg7xqDOO88Vnx209EahJSnqmdGE28hMiqI5PgO454=;
 b=hp92YfIagmnc8LN38MVnREg2Aq3rqr719vUM2HlVVzdTDmSsh169oVYsvlrrIM9GwFd00IyiIWHxSFmpJ+x+pYXgwHLjDvnSGMQfmgwjKFtQFmMwgzuqzevSKRNDgt0QEzi/35i16PpqPAZQjejwLOOJhAzVy7h/bRdbJ4ko1mBdrDDFABWvuf4INYjxPy6ls7uJ6SK6mw0Zbn57radEF3pa3S3V3LsrkA0v77Mr4eY7gyDzKQAdOJSFkB7o+L6VsrgHw2PBDLtoP8LOHE0gmqv91GkB3QNYuh4wSpO/KJ6cc/Hs7arXchePxPHHoQk5t5a9pgF4eimw9FPP18ivJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 16:16:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:16:05 +0000
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
Subject: [PATCH 1/7] iommu: Remove useless group refcounting
Date: Tue, 22 Aug 2023 13:15:56 -0300
Message-ID: <1-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
In-Reply-To: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:610:53::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aead877-dac3-460e-eb07-08dba32b153a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GvHdbCpvvJdLEga5ntaYaBWkvQg8LGRCdhbsczKgbKFzfpfm6oXl+t5HbAFQhNNs6L9m9bjGtsADLnZfnCiPY5WXqdVUB1H3oXywHLCQvA2S93pgTrAZkDdFCaf1w5hD4X4mzmxz0LZwXyrSLF80bFFJcJ0ROql2hAcg6SHYmnAi30ZpMVpahtu7kwZ3MwqZvNWbzlRLmf9Yc/3vvsDufDVkf2FbgPuuk4etYsVP8Kli9rPKtMGXeH+1lDnp1VJNE1hTJDKZ1ZShLcWtvwUS3DYY0UftG7yXEt50bW4fW+Vz4PRPTNnfjr0MHtqja1cHUNOFMqpHvTstXhqs0eCEaFnU1BZfJgcYWKf/GzPp7Br//Uhtjp6sTBvg9G+rDDl9GgHV9PTw+IDasaInTDKOScMBPmRp4/OuxOqL/UXPum/siKwfzW+mAEUT1yMP1IDaQzflqq3QIvdKgZ4dMwz01oW9tNLB8mhzZWk5Cwj0tTBoZRElQTJsai8aWK6FDlXrIfyEpQclTQc80VezNEFacjut2/jB0/u9Ls67DG397HuzRE9EoPef8V7+VTXhX2E5SkCJNM3GHpNfsF8zlprX4NJ5qxoONT4bhYdxS/4k6F8KjTFdG5h73WgM+1usR0e2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(451199024)(1800799009)(186009)(2906002)(7416002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(66946007)(6512007)(54906003)(66556008)(66476007)(110136005)(498600001)(921005)(6666004)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L3LK/cBYLPyMTgKQzyl0OjPIxBXS4v9/LaLPGxlQqvCL7DJtghtebS1e3nHc?=
 =?us-ascii?Q?fAhymrI8d53kD6xBDhRMkM2RDvJZL4JlSeabheZo6iJgw+2WQzX9m7YJXouv?=
 =?us-ascii?Q?gR2HPCncXz7bE82BbtmyvMVma9c9oO46Ed7aNFUEbKOnJx8FTwudgITpbXOp?=
 =?us-ascii?Q?GHyzQfT+n5wjVbr/BxHQLBNTN/fF4aUs58RbEWWY81KpeLFSa1lMVqBtlO1j?=
 =?us-ascii?Q?VxET6Odp5SMyNfShH0Gvav+UbyJ6au9IsQ5SjjIJNfaHHYBW5fzJsgQlzYo9?=
 =?us-ascii?Q?Lkt2ADcv8Rxs4ilKJQ0wsu7IDvdoBseq+sH5tWG0tW9zYqHGiujaMQGFMsHl?=
 =?us-ascii?Q?nX0yPDnqet/620QRvmbHnzWdgAnqHZwZDibngJnJQcwY+/sDZSiA8ZVgGuGH?=
 =?us-ascii?Q?o3dbC1DaCpD36CrHb1HcJ5GxLD8tP+lTj9IXL/Nq6yuYUECcQeV8tyKjhzMS?=
 =?us-ascii?Q?uFBF1/920lEONFJLv2encP4c16prz+q8dXf4qVr5vpR1roS7uFJKH7hG/EvB?=
 =?us-ascii?Q?bFVA+LxKnoYxZ4JIFCOQrStC3vPQ8HbP6KNlG57p7IUjh0VP5uzmMJ8eZck6?=
 =?us-ascii?Q?9vaX50HR97/G/kdQO61YMcwPeHMqToAmoDSzeS2DScm4XPnKgW0HGbQYw+Im?=
 =?us-ascii?Q?L6S8A462kCHgAZl19B2hdgJDyMvhYK95fdej9ztPTuCMnkr4PRfbPPGc27db?=
 =?us-ascii?Q?HhaTIVE+qDE/asbngZ1hlT+clI8MIiai6w5BUD1zkGUTdNYG2yeCv1aLo5+X?=
 =?us-ascii?Q?MVZfP2FqJpZrvcvR8SzZ1BHvTwpe9LLuzvvTyWIAhzNAUW7qmZZT5gwCFrjF?=
 =?us-ascii?Q?fzQ6Na60ZAzZ+sYss9bTa6pef8B3tjS0X4VIe+OQEvI+OF7YBDd7+rF8EQvH?=
 =?us-ascii?Q?3qhzy6h7ZV5uCFesGv3ANnGIDfdhHCv1nI5ofb16Jv2CM4YZUSI91vlQE989?=
 =?us-ascii?Q?VWWzbAPabM9NOOBFV59bXOE4Hn91J4/aZ/uNH/2oJqbBLLCRxbonV4+NeTZc?=
 =?us-ascii?Q?INE42BGHcX6JstoQCqKz/rSJ4f3LlswKXNZlZal7VgngAu88fKEBIOduOCl3?=
 =?us-ascii?Q?7I5nbYkP0K2C89GTgFuPsb8M3F5PDOw1QnRYz34sTUkDH34h7iYrVURzvTsv?=
 =?us-ascii?Q?Ymo7MSXy0z3lqody85o4SZGZtyOkqaB0SgX7U/HEGk7szfaQSpkkzAhmNb5p?=
 =?us-ascii?Q?MS+XK5I5CVioy2HmUnW6HkIjeyVUwk0M0WaHjQz+twfCPJCBdnb2WxKVBlzp?=
 =?us-ascii?Q?3eBUHMdmzepo/vD1jolNgMmaDaxKa9o4zkiNlDPLTDd24cfNAhil/g1aeL5/?=
 =?us-ascii?Q?VwFOn7YCIOFenhscKFtT+Ra+IGwBmtcR8VviNrEXTRq3CnzjnO6qE+BKDRg5?=
 =?us-ascii?Q?I/KtOg/fRYJFyRLxk5re0nSkCRyhsXbAum18m+x0NF1+KJd3foA6oKllbm9o?=
 =?us-ascii?Q?hhrZLauFq3F/Qqv1GBbHYQzgK2eg7BmMK0sxo0sih4khS10//s72bxAylmJk?=
 =?us-ascii?Q?/Bxq+gUgjq1VSW8zdjozefjnj5p3rXVHp3RNFNfs4KBvFr3rHsRrSDt+gJDQ?=
 =?us-ascii?Q?M0UUsJPip+t2pxG1Lj01FqLq+JvMlQDOi0h17EZT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aead877-dac3-460e-eb07-08dba32b153a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:16:04.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXoBl782wAeSFFlw1qjrWP+nY55rktTiuMpLGGyL2pWw+iw+f3pOlue7mY1Uds/T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831

Several functions obtain the group reference and then release it before
returning. This gives the impression that the refcount is protecting
something for the duration of the function.

In truth all of these functions are called in places that know a device
driver is probed to the device and our locking rules already require
that dev->iommu_group cannot change while a driver is attached to the
struct device.

If this was not the case then this code is already at risk of triggering
UAF as it is racy if the dev->iommu_group is concurrently going to
NULL/free. refcount debugging will throw a WARN if kobject_get() is
called on a 0 refcount object to highlight the bug.

Remove the confusing refcounting and leave behind a comment about the
restriction.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 57 ++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 39601fbfd0e0ca..50afc55eaca8e6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2017,10 +2017,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
  */
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	int ret;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return -ENODEV;
 
@@ -2037,8 +2037,6 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 
 out_unlock:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
@@ -2053,9 +2051,9 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return;
 
@@ -2067,24 +2065,18 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 
 out_unlock:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
 struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 {
-	struct iommu_domain *domain;
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return NULL;
 
-	domain = group->domain;
-
-	iommu_group_put(group);
-
-	return domain;
+	return group->domain;
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
 
@@ -3062,7 +3054,8 @@ static bool iommu_is_default_domain(struct iommu_group *group)
  */
 int iommu_device_use_default_domain(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller is the driver core during the pre-probe path */
+	struct iommu_group *group = dev->iommu_group;
 	int ret = 0;
 
 	if (!group)
@@ -3081,8 +3074,6 @@ int iommu_device_use_default_domain(struct device *dev)
 
 unlock_out:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 
@@ -3096,7 +3087,8 @@ int iommu_device_use_default_domain(struct device *dev)
  */
 void iommu_device_unuse_default_domain(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller is the driver core during the post-probe path */
+	struct iommu_group *group = dev->iommu_group;
 
 	if (!group)
 		return;
@@ -3106,7 +3098,6 @@ void iommu_device_unuse_default_domain(struct device *dev)
 		group->owner_cnt--;
 
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
 }
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
@@ -3193,13 +3184,13 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
  */
 int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	int ret = 0;
 
 	if (WARN_ON(!owner))
 		return -EINVAL;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return -ENODEV;
 
@@ -3216,8 +3207,6 @@ int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 	ret = __iommu_take_dma_ownership(group, owner);
 unlock_out:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
@@ -3255,7 +3244,8 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
  */
 void iommu_device_release_dma_owner(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt > 1)
@@ -3263,7 +3253,6 @@ void iommu_device_release_dma_owner(struct device *dev)
 	else
 		__iommu_release_dma_ownership(group);
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_device_release_dma_owner);
 
@@ -3324,14 +3313,14 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	void *curr;
 	int ret;
 
 	if (!domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return -ENODEV;
 
@@ -3349,8 +3338,6 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	}
 out_unlock:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
@@ -3367,14 +3354,13 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 			       ioasid_t pasid)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid);
 	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
 	mutex_unlock(&group->mutex);
-
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
 
@@ -3396,10 +3382,10 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 						    ioasid_t pasid,
 						    unsigned int type)
 {
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 	struct iommu_domain *domain;
-	struct iommu_group *group;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return NULL;
 
@@ -3408,7 +3394,6 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 	if (type && domain && domain->type != type)
 		domain = ERR_PTR(-EBUSY);
 	xa_unlock(&group->pasid_array);
-	iommu_group_put(group);
 
 	return domain;
 }
-- 
2.41.0

