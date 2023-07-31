Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22F1D304;
	Mon, 31 Jul 2023 17:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qpz43rVbO1Wrd94DRTk++oKEfII4fQybdKhBi7ryg1tmYH7W2UTDjiXk0nm83bJBfQ5MPJBaBO4AyJ4WtQtBL3/7FORC0zmFC6HGWfCd30c1uaIKjFTwZYeEBXyInkEuNUM4rO0nSrXwAQpyTaGctDUoN0wLJdkezFHHcsnobTegYBkYJnx2QKEtVh+ODcrfxXcm7bwI4bhug85QMlfQY7KBN5pdo1Hq/4w6+9EcvvuR4mAc2ZfjC7km6n3seXtoiUG8UUz+EJjKOGgDf7ouUva9j0ndh1eNxbQA9373enHagc3/rP5dD7sKkVbzea4hkbyGqhLbNvtV/ydz8nr2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm5LUa3xn01J65w1U0t9fA9MeZit4npwSMlbpQZiOng=;
 b=CcU5igDD078g45AuVtwRxUGo2NdjkChIPmj6b0XHhosNeFvKJDwzXzFmRzYEq7HEt3IVa78dMHeJ2RIj+rc5z+fyYha8pqFhBeiB6fCGn6CUyFdYRjZ2zB2QDdP50FMhckIsrLc7KnxUWq4B/xqlb/02wiwhI8w7Rs6EXinIb0JjbI3B+tPZpBLKkdvvMRwLSVgfN3BCEQ7LBupVw3wMDE290FMAXTItsyPvs9InbA8JscYVSASrXSJmWntz+ZhCdPLoVHtP8Y/r3rSPjQ+yixA3iPyxGyQpaM+yX9kWwG7zKiyWHp5gTy9D44iUZWl9rXran+lSsjakrPgqWfdjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm5LUa3xn01J65w1U0t9fA9MeZit4npwSMlbpQZiOng=;
 b=FkiaZvM5Bb4nt9MmnBZdslMPn29F/I2X6mp2ssawrd8Qn7m0YHZLfJJYCfXyC8FZGUOLn1tV5/j7EEu42PhFiIhNLT6HyZac7Dhveo4E9Usd4+U6Vx21XyuGzDU9LpkUZmJeOeQW1Ie/qYPuaFkSMZeXhfeuz1KLmADhCjxg9yVLaiXwHv0ms0LrXwph5sX7DYvxmAQfuHkNIX6z5WywELJtFIDU2GRAJWG/a4yK3UfDJiWY1AeZT/5wgBsJIkDkVMTqSo0bKE24RCr1YVroyNQ4vYlIFjJUrJkJvyhX8BoErK79/EHHvbXfk8Y2VDG+8HsqlYL5I4Bqs1qUWh95mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:39 +0000
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
Subject: [PATCH v2 09/10] iommu: Complete the locking for dev->iommu_group
Date: Mon, 31 Jul 2023 14:50:32 -0300
Message-ID: <9-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7a23c6-3802-4c48-f15d-08db91eea4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9wDEBdukX5jtVQV3mPcGunXxOJBLAenAVUwkC43Qdmf1UBP+CBBpvnyv1k4Tam+KqnFCTLTNGL0yGjl75SLAYJdWuURtrEKnoS4EJydZkTifRpwzOB3/cXH/DUU3rir/v95tdJtIPnVMrQSINq2ZTw38Qa8kZmnfVsVMCaQPz1QuV7fZMm+CsGJlqQCA66l3k8WhKj0QTJXOxpHrWzAY+O/JSBJ3gwLtrCemuR7/vFGUsUlzeoPBo4xf8DUhQkGmIYvjVEcdyWTnpRc7vPERdbdLyqAj/4Ts6z4iVFRmE5rf76d+dQ4o4VhSppsVoMh2OI1SwqSqPZNXOPFCqYBXB5BEkU+vStoZeVVltM5Qs9nnpJvGsdbozUckhE1oIDzNkZc50O5g2R6wWk01addWfNniw9Hhb9AKZaejLxI1ua18bYydqx7rPFIZIjOTgRXFuyyIU5YQa7B+7QRU8OnqDzJuhUAjRvkBokvZaTHn7Esd5iJlPmgD1wfgtKDeo8kZv8pudB4PTWCLyUKFLmE5aen6Aiw66SHW5tBi9go4zjgHgZrredEv7EMBVDYoqklUIjfsPHWTi7zPohvsD89HgDZkAOIB88x6TShC8ZPCXnEMUMahoeN6i0Xcq7T4sfpr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(478600001)(38100700002)(921005)(86362001)(6512007)(36756003)(6486002)(6666004)(2616005)(186003)(8676002)(26005)(8936002)(6506007)(5660300002)(4326008)(2906002)(66476007)(66946007)(66556008)(41300700001)(54906003)(110136005)(316002)(7416002)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?to8OFne8zeVOfOtcKLMm8Z0aXjCkU1s+F8FkvF5npNUDezqdxvskjqzUSIKQ?=
 =?us-ascii?Q?fUl8Hce1cWRFlWkWhOVamOWK+u+R6FWv0SGwbeTYcGB7N1ukHKx1zLZ0LvW4?=
 =?us-ascii?Q?re8CRM2TTMQfUE4J2AgrqIDb18wjVQsrX3YmmokXOZwF91Z4ivhSzCrlCB+b?=
 =?us-ascii?Q?sSEMBoveCl42GIV7/+3FQ+OpRM04/B3fya19TgEmO1hUxHyf+agxv7fGZykk?=
 =?us-ascii?Q?cuqZ8BFq13zbsGSn9zA+hZkaSB+pIUfbkAdWJ4caci3KsutQofyCyOG05RiM?=
 =?us-ascii?Q?Tv9tL3WV0UuszGPn+FwpOFyk3eCjRP0pZY6N9mVJV2m70i6UvHQtotYqLeG5?=
 =?us-ascii?Q?N3UwnEmUVEpqRg/PKX7ncr/2xgBcQNg+5j5pbeYU+FG4Vu/e9GHGTxF946hF?=
 =?us-ascii?Q?nVpAZLWUMX2HroknJtNMIG9Os+2FDO+hpwq7832L6RznCgw+1oTu1XpZ2MW7?=
 =?us-ascii?Q?NIIHPGtmb5ZX1yKSeZL0IjxHZ/XtuP7LSW6IsR7MWnPjLF3mLqUqrrc+DeBf?=
 =?us-ascii?Q?JCYxqTLm0/N4PQqSkbEJ5Y+gqeMRUSvWCVTX6wwra6atiCA+g9MiCyJPPCxd?=
 =?us-ascii?Q?yO9CyjUJAM61KyI3qCY15EDsNQPooruQl5oYQsiO40gf5uGbgs8bZB9lw0B2?=
 =?us-ascii?Q?xT8U/Q1FwxrCmxQI/Sa+KIYKX6gWoeVcScIy+KODHVjywmoY6peLLvaE3MZ6?=
 =?us-ascii?Q?A2E6zoO5attJ/Wgm2kbfB7Fan6QWvDblIVsT/LC9ns0oqtzI+IzdKfAWFhLN?=
 =?us-ascii?Q?0jYo+Vjj+vDGZBsR2QT/kO4wJgbJMsmHAJg/iar3xDlQUXqRZsebUJB9end8?=
 =?us-ascii?Q?EP2Wb5SiJgM57UiBs9WwcIcMqafcFpWusUAFU8VFIoralCPQZCFGfqyK4CS2?=
 =?us-ascii?Q?A/5Bx7B8SKDdkfnd9yZpd2AbUKaBfyE/8wq9CEPh8doLyriA7buSK92xIcx0?=
 =?us-ascii?Q?eFSyZJ4gQa51keeXawyTt9rGT+jHzUtOzYq8yczgJ2yrfPZkCoCRGqkxNcuV?=
 =?us-ascii?Q?SaLAGLH8oxDP6Ay87TVMzBi142D4tqr76uiUMUGZTZy1tsQBVemJSOiAnwgK?=
 =?us-ascii?Q?mnYj9XtpcSvTyyKjX6upv8pRSeTvj+nOldGXmX4ImbtxtIsRl/WbQ1MWwNmx?=
 =?us-ascii?Q?FFJ5fTX7hveFjB57lVepKmOlwSYBJnJKajlDkDPRVmH+G7eBQXhdhxPrqxHO?=
 =?us-ascii?Q?J37QHOqCt6g8oxt9ewIortZRo7d2kOPG0Jsu26IYv7ZXKwcitLFs6D14rcIj?=
 =?us-ascii?Q?UA+QQ+UHskc4DB951uxhI/dTFN7VltMHr0uZrpvMvWS5R/659hvgfzgN1z8e?=
 =?us-ascii?Q?DHx74xyBAtQVPer6p2e6trx9eaYccHaRDuJCm08Swce5+dAwFxhp1pO8tzsV?=
 =?us-ascii?Q?x5gdXhI5A4Xuf1EVrvjcN3tuoief90Hb+XJm48wZiEggqP2aWgOyhactXhKT?=
 =?us-ascii?Q?HN/AzE8WQIR/M3UjX24mfxd6cZcD6npxoR3rPaY7Tv49z2j0zGM2j+EmRA//?=
 =?us-ascii?Q?pm8DSmWxFlvqA5VL+49NhWK54J0RulkbMuCl/zKSKNGRq7u6anVYyCuLE1f8?=
 =?us-ascii?Q?9Kif3RZOuxDyuWWDiuFHBYRAlApC/9w7MgXChNFw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7a23c6-3802-4c48-f15d-08db91eea4b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:35.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyCMO4SFyqgVyr/FiCsnAuf9EIjuk1vjoMyGLFkOEEw8wggo7KdZshhdQ07txvEV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320

Revise the locking for dev->iommu_group so that it has three safe ways to
access it:

 - It is read by a probe'd device driver. So long as a device driver is
   probed the dev->iommu_group will be guaranteed stable without further
   locking.

 - Read under the device_lock(), this primarily protects against
   parallel probe of the same device, and parallel probe/remove

 - Read/Write under the global dev_iommu_group_lock. This is used during
   probe time discovery of groups. Device drivers will scan unlocked
   portions of the device tree to locate an already existing group. These
   scans can access the dev->iommu_group under the global lock to single
   thread determining and installing the group. This ensures that groups
   are reliably formed.

Narrow the scope of the global dev_iommu_group_lock to be only during the
dev->iommu_group setup, and not for the entire probing.

Prior patches removed the various races inherent to the probe process by
consolidating all the work under the group->mutex. In this configuration
it is fine if two devices race to the group_device step of a new
iommu_group, the group->mutex locking will ensure the group_device and
domain setup part remains properly ordered.

Add the missing locking on the remove paths. For iommu_deinit_device() it
is necessary to hold the dev_iommu_group_lock due to possible races during
probe error unwind.

Fully lock the iommu_group_add/remove_device() path so we can use lockdep
assertions. Other than lockdep this is redundant, VFIO no-iommu doesn't
use group clustering.

For iommu_release_device() it is redundant, as we expect no external
references to the struct device by this point, but it is harmless so
add the missing lock to allow lockdep assertions to work.

This resolves the remarks of the comment in __iommu_probe_device().

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 54 +++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c673d021d367e4..7dbbcffac21930 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -370,14 +370,17 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	if (ret)
 		goto err_release;
 
+	mutex_lock(&dev_iommu_group_lock);
 	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		group = ERR_PTR(-EINVAL);
 	if (IS_ERR(group)) {
+		mutex_unlock(&dev_iommu_group_lock);
 		ret = PTR_ERR(group);
 		goto err_unlink;
 	}
 	dev->iommu_group = group;
+	mutex_unlock(&dev_iommu_group_lock);
 
 	dev->iommu->iommu_dev = iommu_dev;
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
@@ -435,7 +438,9 @@ static void iommu_deinit_device(struct device *dev)
 	}
 
 	/* Caller must put iommu_group */
+	mutex_lock(&dev_iommu_group_lock);
 	dev->iommu_group = NULL;
+	mutex_unlock(&dev_iommu_group_lock);
 	module_put(ops->owner);
 	dev_iommu_free(dev);
 }
@@ -450,13 +455,11 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (!ops)
 		return -ENODEV;
 	/*
-	 * Serialise to avoid races between IOMMU drivers registering in
-	 * parallel and/or the "replay" calls from ACPI/OF code via client
-	 * driver probe. Once the latter have been cleaned up we should
-	 * probably be able to use device_lock() here to minimise the scope,
-	 * but for now enforcing a simple global ordering is fine.
+	 * Allow __iommu_probe_device() to be safely called in parallel,
+	 * both dev->iommu_group and the initial setup of dev->iommu are
+	 * protected this way.
 	 */
-	mutex_lock(&dev_iommu_group_lock);
+	device_lock(dev);
 
 	/* Device is probed already if in a group */
 	if (dev->iommu_group) {
@@ -502,7 +505,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 			list_add_tail(&group->entry, group_list);
 	}
 	mutex_unlock(&group->mutex);
-	mutex_unlock(&dev_iommu_group_lock);
+	device_unlock(dev);
 
 	if (dev_is_pci(dev))
 		iommu_dma_set_pci_32bit_workaround(dev);
@@ -517,8 +520,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 out_unlock:
-	mutex_unlock(&dev_iommu_group_lock);
-
+	device_unlock(dev);
 	return ret;
 }
 
@@ -567,6 +569,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 
+	device_lock_assert(dev);
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
@@ -591,14 +594,23 @@ static void __iommu_group_remove_device(struct device *dev)
 
 static void iommu_release_device(struct device *dev)
 {
-	struct iommu_group *group = dev->iommu_group;
+	struct iommu_group *group;
 
+	/*
+	 * This locking for dev->iommu_group is overkill when this is called
+	 * from the BUS_NOTIFY_REMOVED_DEVICE, as we don't expect any other
+	 * threads to have a reference to the device at that point. Keep it
+	 * because this isn't a performance path and helps lockdep analysis.
+	 */
+	device_lock(dev);
+	group = dev->iommu_group;
 	if (group)
 		__iommu_group_remove_device(dev);
 
 	/* Free any fwspec if no iommu_driver was ever attached */
 	if (dev->iommu)
 		dev_iommu_free(dev);
+	device_unlock(dev);
 }
 
 static int __init iommu_set_def_domain_type(char *str)
@@ -1081,6 +1093,8 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 	int ret, i = 0;
 	struct group_device *device;
 
+	device_lock_assert(dev);
+
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
 		return ERR_PTR(-ENOMEM);
@@ -1142,9 +1156,12 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 {
 	struct group_device *gdev;
 
+	device_lock(dev);
 	gdev = iommu_group_alloc_device(group, dev);
-	if (IS_ERR(gdev))
+	if (IS_ERR(gdev)) {
+		device_unlock(dev);
 		return PTR_ERR(gdev);
+	}
 
 	iommu_group_ref_get(group);
 	dev->iommu_group = group;
@@ -1152,6 +1169,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_lock(&group->mutex);
 	list_add_tail(&gdev->list, &group->devices);
 	mutex_unlock(&group->mutex);
+	device_unlock(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
@@ -1165,14 +1183,16 @@ EXPORT_SYMBOL_GPL(iommu_group_add_device);
  */
 void iommu_group_remove_device(struct device *dev)
 {
-	struct iommu_group *group = dev->iommu_group;
+	struct iommu_group *group;
 
-	if (!group)
-		return;
+	device_lock(dev);
+	group = dev->iommu_group;
+	if (group) {
+		dev_info(dev, "Removing from iommu group %d\n", group->id);
+		__iommu_group_remove_device(dev);
+	}
+	device_unlock(dev);
 
-	dev_info(dev, "Removing from iommu group %d\n", group->id);
-
-	__iommu_group_remove_device(dev);
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-- 
2.41.0

