Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1618C34;
	Mon, 31 Jul 2023 17:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYLV3oN/ek01u1srxsYStEcUq6hDKxxZO2a4XQ0zoDtWpVRcziP7u3mIqVKotxNf0OPtE7XKxsqtMUYAXUFfucbJBJ/h2wkyedbRdAtXEus6pVw4W1zoWcorQs0Mhc2DqtjWsjTXkPIiFIPLQGwFFsVwFOHmbiimHg6QegqTcNse+Tg9B98nLbvOGtIJ96njcOX9ctgEzlG8x2+ioIR/JSCJXkQHx+5W/TQ80r/uV0tb3zHYAyJIAzgj1domd6C875A0QPxyM3QMDJhgxHnhqIYImk32NjN5CkSHzSJsm5PbJamN05YXgPyq3HGmsJ4nh4BiiJmXnztbaVqsTVuL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhnYxwrsnrjdzbpdLkjENtz+lYlfys1ukcorW6kYP5E=;
 b=np3lpiK2ykUG5C9KW05V4v30NjYnECwqsqMElZ6y44jFo9FKYhnUE2WzKYnW30vxpnuNsfJLX7Cg4pPrifC9XmysbhCSSBh6LOicE7jGcIbjMxDfDd0WbLJIf+TK5GYqUrdY5fhokk2XcGQlTvCn7h42kVS+QJiJJDPkQ1kyxB43HJ9jhvuCbSiE/sQn0ptWkoZaSau0Hx78cXTRUPLFeKiGXnGJQprWAcJMMVY7eN52yTSfYlRhoXaUArPPTtcuKiwYMZfL316cNPgkTYnU//NMK0CvTtkusQqEJBtZ07FM5lPnIhpxKs4VleNF41HbcExYdakrIGHOcEBYcEpgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhnYxwrsnrjdzbpdLkjENtz+lYlfys1ukcorW6kYP5E=;
 b=RXbL58vFXJKh9ZUM03kCJz7zOcoKLJUGoH18B5k5VpXZ7Wnw0eCJwCv59OljRrMi3S9XzodwQXZ4D6RXEtrnYJMmx8olC+PcqKbmDRHowNuLo/hXCs5pbT/7SCvXsY6LBnhkQujcsGSTP/Jj+YExzRtVMPXQaJdL3FWgVt9HUWdyqSR4a2fLD6WfMX2ySI3L3G36QW+Y9b9GCQXrpDUKbDt/fN+9/ucjAU6OrJhfDVNjLlt3S1KmEPpNFvw9RB92+ifCJqLSFj6h/GyyrKVOQINIhUxcUQfyrfwxPnonI8y534t8DinsBgy1Y3TK+zdRsM1YzUVJSPu0R4WPnPSzww==
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
Subject: [PATCH v2 01/10] iommu: Remove useless group refcounting
Date: Mon, 31 Jul 2023 14:50:24 -0300
Message-ID: <1-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4d5926-30df-47bb-5968-08db91eea475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WkvjYD5n3KKTtxX1ZA8Shf+zR52ggYfKmEHlBkAIJf3jTjMqMeUzzdYlp0WBUZzI8rvep0gVxdc/6wAOXbAJ1v+jZvWnR9O2SxjmnEV1w9SnzOxdVjU+TqNMw7Y3jCUXOAzJWJgFBOzcM2JyK9lReInAw7Q4DVq3/JalMYK3QkHGVqy6gwo8B0lnhJ0HmIjY0UiZlJQCTmM2aAetMyyVpEvuMPsNu5p/4BmzfYgFEp4shG1gQRZci4UL53tYu1q9ekaZUlX4JaHct5wgqqpclgskBLbZaZUlPcuuHyNSyL2leAkWHSFNYxfcZdpWB1hM03OIowwyLCSJEIE9b/iKRsPAPyT3S33nJiCbImqkxXG4F5dYOd4DkeuRRii15IsFgQ+mdCPV0E8HruYR90FwQiyOcqkRUYmolPA8fyD7dXuF9sSfDZjAD9Ej6Umm0fjmAfTzSrY61IaWgHlQ9z6y1+eNv/f54x289lUv/rGO5NrxFb+ZBGskk2wdReP/hB03mmzmbL/q5qWf2V/5ErMHBZ3GVN4lP6oXB4e9prQjCSYlgzMVhQVIGIN9bKgPI3QPsRVbXHj/bDbIxp1AbXrNZVV3hdBd9c6wxcemI26VOQRiNvlrK1cpClhVGzEktI7d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(41300700001)(921005)(110136005)(38100700002)(66476007)(86362001)(316002)(5660300002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pXH7XxJhNtY0vr9qHKF2wRdwRE0rsSw5p0/EfjqLFJ/tloislSWiHhWekp8D?=
 =?us-ascii?Q?cvdlJtJ7P1NXoZtoNVn41RSQ8MbMu5Mw5vQsX6EGYapXl39P2sO75LIx5opX?=
 =?us-ascii?Q?Mvk/9U/hhD0yZuuXT4+qDN1Hk44NPcprPsvGOygfltGYQ+fJtqn7rVmWxJux?=
 =?us-ascii?Q?d69Glnt3aQiUX+JuQGaBDGeIQZmu4W8gnzFkXDnuUDyEWBEkHYPvoHpiEQfB?=
 =?us-ascii?Q?P3JeJUhXTNkBibLGZZv1L2PUgRWdQClGtA91ITp/EJc8sjd2SaNfai35nlhT?=
 =?us-ascii?Q?0fDoEUn9honSYxh8BWSu4tTgalITKRaVH360tEnfAMTArd2NM9otpNyZXD5Q?=
 =?us-ascii?Q?D69GFPb7m7XzwgBFPlF6TYfjI+pMLMEYtbGOI5H8w4Kj7KSfyeeYaChRkCgl?=
 =?us-ascii?Q?kctfgBmg3G6NHL7HVkl6FADesVYWmDJ8pGR4u9wX4/04Ear9Ex9KLFSxBQe8?=
 =?us-ascii?Q?8P+lwxS/F1NfRYsp9N7wHPPFAfdB0artmV6mABdn6on0N0GtYdRh0TkaiEZ7?=
 =?us-ascii?Q?5fuPhRuu7MoyilRBP+o7ndpNZAHglVAKI8LOYRCRUhvAJtIpwhGdJ663vmv/?=
 =?us-ascii?Q?QwLmtUwhrp2IlGa76sfpBUlmGfDzJaurKf0VVqOCiT++N4rvqX64IAwoZL+Q?=
 =?us-ascii?Q?lu6WxO1hVGlhitBSOos0Sc44morbYBh+PoNPDTNNIAJaJiW2TxllfbWsJ278?=
 =?us-ascii?Q?gAL9DLLqRwhn373q5kLE8aLk+HTwNOL7EQ+PABoeN1vGogMYL1HHBkUXMmNA?=
 =?us-ascii?Q?wFcVSh6fuusZq+uW2etyT7RO1YFuzANFpwyFEbmCW3Y4UHs29F8nR99hwQ32?=
 =?us-ascii?Q?pQ1hxR84QcaBFZFH83vmfMzQGh+J0mvS2f3AfDWacglDZh7jDeJxjCbwYY72?=
 =?us-ascii?Q?ljRi4Ye8LAgpdq6zgn5dI0JI7cict4dCHkLe85MWZB4gqYMpr6xAu8mVW8eA?=
 =?us-ascii?Q?U6rytmSdPJzaaaZnVZGk791CHJlMsCps7X9B8NrOnIueSp/VoQ9aODZwKVSD?=
 =?us-ascii?Q?b1cXFLhqcdlW/AJ9BZ2E/qfOH+zovT++yG/XyEdfGhAa29fZZxCmJV86VQ4r?=
 =?us-ascii?Q?987ON9CuWHONNckiS6LNJ1b196b7U99EWfACWfwg1lU66Qf7Zo4ggtM8CVip?=
 =?us-ascii?Q?IoMazrWwngmIO7ICCEGcHC18Zy65PdQVpSkWkDQunafK34+NploYM/aPmV0E?=
 =?us-ascii?Q?tMclBSUd6712+7cmCVSIRKkXvzbQcGx1sTTSQO4+koLHijZXustVkNJk9WmE?=
 =?us-ascii?Q?s/aca3G9p75atUVhoOiMhsA+VH/z5mZ8mvlRUGQ8lDEi5onBE3wNfd51nB9K?=
 =?us-ascii?Q?DBl4QG2f64p7YGf3trQOWtTlYH1XonIaF/60qeQsojQYPllaUskPBDbRL1li?=
 =?us-ascii?Q?nExpZZT0c1qDzTUEUoQEUNoSMO31+MO+siaHcUgDu8rCIgacjy3FhCIIn+i/?=
 =?us-ascii?Q?aonVnurTLSeISnN4fs37kVKKWu2ptwWZxtRMB9LMvLWSd6q997jwIyqsnAea?=
 =?us-ascii?Q?WEOOtCVRV1IZZBFCQ0RYIx+UfA9hvYtM/+kIBae8zPAZTB7eGUVhStCjeTKb?=
 =?us-ascii?Q?sUGLXDI6QFkhNKVUazJGDX83wLc5rqBPAEZIzCBo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d5926-30df-47bb-5968-08db91eea475
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:35.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw54Lh56omDfFMc9UTh0mOVlyXbA542I4Jt0RhG5tfhrNeotYxLBLci7uOMxpynv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 57 ++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4352a149a935e8..409090eaac543a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2014,10 +2014,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
 
@@ -2034,8 +2034,6 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 
 out_unlock:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
@@ -2050,9 +2048,9 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
-	struct iommu_group *group;
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
-	group = iommu_group_get(dev);
 	if (!group)
 		return;
 
@@ -2064,24 +2062,18 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 
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
 
@@ -3044,7 +3036,8 @@ static bool iommu_is_default_domain(struct iommu_group *group)
  */
 int iommu_device_use_default_domain(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller is the driver core during the pre-probe path */
+	struct iommu_group *group = dev->iommu_group;
 	int ret = 0;
 
 	if (!group)
@@ -3063,8 +3056,6 @@ int iommu_device_use_default_domain(struct device *dev)
 
 unlock_out:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 
@@ -3078,7 +3069,8 @@ int iommu_device_use_default_domain(struct device *dev)
  */
 void iommu_device_unuse_default_domain(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller is the driver core during the post-probe path */
+	struct iommu_group *group = dev->iommu_group;
 
 	if (!group)
 		return;
@@ -3088,7 +3080,6 @@ void iommu_device_unuse_default_domain(struct device *dev)
 		group->owner_cnt--;
 
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
 }
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
@@ -3175,13 +3166,13 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
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
 
@@ -3198,8 +3189,6 @@ int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 	ret = __iommu_take_dma_ownership(group, owner);
 unlock_out:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
@@ -3237,7 +3226,8 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
  */
 void iommu_device_release_dma_owner(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get(dev);
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt > 1)
@@ -3245,7 +3235,6 @@ void iommu_device_release_dma_owner(struct device *dev)
 	else
 		__iommu_release_dma_ownership(group);
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_device_release_dma_owner);
 
@@ -3306,14 +3295,14 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
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
 
@@ -3331,8 +3320,6 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	}
 out_unlock:
 	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
@@ -3349,14 +3336,13 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
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
 
@@ -3378,10 +3364,10 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
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
 
@@ -3390,7 +3376,6 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 	if (type && domain && domain->type != type)
 		domain = ERR_PTR(-EBUSY);
 	xa_unlock(&group->pasid_array);
-	iommu_group_put(group);
 
 	return domain;
 }
-- 
2.41.0

