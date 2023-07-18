Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD5101E9;
	Tue, 18 Jul 2023 19:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE7qBc+pZFTnpxQcCU/pzJitqL+1bvj89cc/ECqunQfhIVSmMd4QlEWuWvP0fUbMix3ynUaq/Cw0GkpA3ZSYRWfFWPJ78F4rCETEbI0ikjMGVvTFTCz5jEMg7DWqg9blgTaQ/3QBBaV8PHgeADBkXytA/6v+aK5n9Uyo6qXFjJvG4R9iOfuqjyFFKRRmzTcOu+MnLQyDuIGmOwIZcCDOEhIj4H/S8QHfxbzfk5LBDi+ohuGMjA8hMTWGr2aWVnSsvONvh7atZfuF/ujeiVIijfeTj0jSvsrJFKHEH0XOgpXSN/KEPGIFFB4yr3XpOsfpp1emlSWkJFC/VLDZQs+67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnwYqHQtS893OX10weEJL48b3I9U2VW+JlRaCdx6dOk=;
 b=LaMGKjbqC01hprs1khKOL7upk9pl8+K6RNh6kn+DqjWdpVrabtXfG11pSA3h13CcFkvsKUSwK2WfkNHDqwRxjya4vc8OV4CgvQo7gNj8ioALW6B2NQY5wfuO3IVkwb4OrtOrCH1W5ht/yZsaoR4B3XYqODzAjZx7HXV2Oo/wlSPc8dHqhjG+WYgVbRCTCFjX80NL6ilm3Ax/SrAB/ym+1Pe2tKidKzAELXfRfZEjyqnw6mFb/5WTaJ4dvzGoYydgu5OrHD2Zm17uphUGD+r0JCtTREMhVjRAG5elHiQ+RuIWx9Z+xzBPr5fPJnmf1LVoxbW3OagXnnfoHD6XG3ec/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnwYqHQtS893OX10weEJL48b3I9U2VW+JlRaCdx6dOk=;
 b=Zv3BZa7Xkn5LJIqF+1Qk8ERxCHaaVzA3DlGA3PBIUXgerp8f8ctOQ1A190+/e8pEvcaNXlZ0Isn0i+mY/OTMxAiQUFoeThZ26HKYkIPJYAjqPP6Uy01qUvwjNRmNEr0bqJwzLzMx56qhF6h3FF9FICYSyvmUqLuzLNmwx6Zqa96w79zxg4DXQ7ZBRqXYOuYiHZHgBnleubXrsNHyVCRYKTysAgcjfn8MWowp9n7qFxfEfC1GSdctAdFuMJPRnAR5A6PTVP4WcKCDuTiIftPTuZTsBj8Qd5JMIuBTHyc0+LRHl9S1QYnpCSJfmABxzqqg4esS/dRMGYpai/8aGaSUpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:03 +0000
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
Subject: [PATCH 09/10] iommu: Complete the locking for dev->iommu_group
Date: Tue, 18 Jul 2023 16:05:57 -0300
Message-ID: <9-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:610:cd::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b9e5d0-6402-4a50-65c1-08db87c2074f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pD9oTZASGwKy+XBLE9NEQEN3yBsA+eTg0B/wAlEso30Qwbl276wABvwqMTJOidm/YsxtEcI5r0nOXyM/wMk6hyL+7b19AtwZhf8oaLd9lHo53aHM0Oip/122zzVE4Mb3yVBnfmrYsMNRwvIJv9U56XvgwT4mVQUPjmHegvpo/E7dVa0ar4scfu9Es5HiurTZe+R1o/vN+KWOgOjsL7jBki26vn+EkAojAVhCREloZEOYL7IKaYU3YRLF5tt6jduBgB6M/22Oshy2lG0angpL0jf0r3LbuVrYoSim2979QuT39BrVHyKtvZVGThr9u3lDyOozCH03sjyXITxzBtR37zFREF2hL98TMbGZ3LOgM4j8pYgvNUtR9d2ooX7TkObmk4BEvTYrY7/6DBLLbpFHuq/au0pcsLib6alVbZB20E4d6LTHO1gr1Ihk4h8xMD6LCXKBAgZK+WTj9UagpdW0rGYbbdhW/aEe3sZ9VT6mdpW89cScLPTYvPbML4ptkorJEj4VOxgiEIAty2VzIFIqfyBAZCg8nxfUECqgQNHjAuwkdur0NCeiSzwRvXLaW9iw8C4arGKHsD9AgJ8Py7LtIPXxZQn1eCcQ/0zZyp/hvMM+8t1mHw2/ndkDWB0PqMD9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(6506007)(26005)(38100700002)(66946007)(110136005)(36756003)(66476007)(66556008)(7416002)(5660300002)(2906002)(316002)(41300700001)(4326008)(8676002)(8936002)(86362001)(6486002)(6666004)(478600001)(921005)(6512007)(2616005)(83380400001)(186003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kXvsD+HILAXmbaJ3s1pg/KdDBZ7myaefnles81JlYlAaeUyedSuMQH1+J1bS?=
 =?us-ascii?Q?QB4V7PoWwQi+DJ5TXuK+6MsgB8IV5YVdWmC/JlXuccHZiM9UiX5kRPl7pkd7?=
 =?us-ascii?Q?8PAy7AHTdobKwpIxoez3TuLKUfH1KR2tlzO2/Gwi5Ec4EjWQfwLyIXkWQ/Iv?=
 =?us-ascii?Q?+ljbSgaYzHSXKwmXxpP/N3WdA7DvR9yyMMqzlPHqg431mmmP00sXdoQImLPX?=
 =?us-ascii?Q?k8KDhLIHtGrxCjY3ebH9uakrZC/qw3m3ZAlg+qREtlXKXm9g+M/yWF6K0KpF?=
 =?us-ascii?Q?tBvqbf6Ty5YNBDVSA0MPqaV237eY1jIk2nM4CJoR9IqfD8FtEcwduDVuOh6N?=
 =?us-ascii?Q?TiDWP6GXDUd9/BNq25UMs4J0TxqCy8LLarCoKiBNhksDJo1duJZU9lIQoYVL?=
 =?us-ascii?Q?By6oY8iH5OOttM9fWJ0p1Lk3vRuJkNm+ku/wqYU36N7CRWtlQdh2h95ERA2Y?=
 =?us-ascii?Q?pgh2y17ENIEjuBujK3OexU07pU3bkA4hCkxhPkgiTm+rSVqVD5sPSqOGH33S?=
 =?us-ascii?Q?h56+24BjH1KW0pYXjDaglw6Ce/GcfkeWWdkUM+jZtsT2qSBAzTqyrT/cAxrQ?=
 =?us-ascii?Q?rNV0YhAYgmYgMsi2/357UyksOCntslKB8dKXVXEeTs9bUEgdu+adhLt8fLfd?=
 =?us-ascii?Q?sQSwCQHrLzAWc7K4UUc6A9sSJX6dmVN0k+GM/MECMPCXkVekAU4KQwgGvw2t?=
 =?us-ascii?Q?n0XXZ/MpxjgzlsAyLmETlEmlAo7CUqx/gX2VG+IzRm74wFHiMgBKV6IdGIsL?=
 =?us-ascii?Q?3mmL+XYDrX5RDfH81M9L3Nhcmi+XCsZPRhDgdrnO4+ExaBfMk1o6rXjwKVw8?=
 =?us-ascii?Q?fy+4/2C4P8l5ZgxCL0+u2SN7tGcmUR7R2tB4RjXNaZSvXqazHuCR4M7XOGwB?=
 =?us-ascii?Q?ZKjFhSB8yytHdOjDVDd1gwN1j2qdXhoWmx+5hxZE93MrOQcSO6TQ3y6SzkO0?=
 =?us-ascii?Q?ItfesPp9WSRnWkxKKeTpu6CtnFCFhy2fhF/cISQwUelM/Ewt2XL88GzQ6Y/G?=
 =?us-ascii?Q?DeghraWMc6WEi+W9OOSAHYMoUa5ISWSuxPjIFj6/OWGqQa8dKE5nhiZDMGHv?=
 =?us-ascii?Q?elfhtJT9zkqmirEhpH2VSOjB/FjLC9pe8wpLl6t4BzGGgg++dhG2D3HSTPki?=
 =?us-ascii?Q?GFkYbJkKHN+TokZFMYToE9WnKVtjESQKs4Ao6jhAAb1KWDcc3eHi5bWwAQW9?=
 =?us-ascii?Q?sBPVUwKyMjeKwU+mzLac6RKOXX/azOUohZ+5yiO29npSB/VaYA66LK4pfW8r?=
 =?us-ascii?Q?gmr+QJI0toq2rlROnUphjN9MsWNq0qGbi0S7/a4lzDNnICYKiuu2TUDKjrnl?=
 =?us-ascii?Q?58pKhOjhrktxICDm4m+tnF6aHY5OHfZ/uaQYAK9jqzisfFq5/wmB/wZqD8mv?=
 =?us-ascii?Q?nO6q4dHoech0Md89+Nc4f4WeT8SHxPL4bTYOkOrS47BrN5F/HxbFpFEQgVuS?=
 =?us-ascii?Q?N95frhH6L6IGHX0vKe0breINO/oUrWnyrOtSHTdRXkObebuREyyYyiK7Uw3A?=
 =?us-ascii?Q?4I/4Y5Bs+OCvKXSPXe3uizu+WXdR9nMx6I2fw+mwIhX+tawvDIDTFAfEaYyO?=
 =?us-ascii?Q?HZivCFnqlorlzowanne+k5VaGxf1Pm07dG95vSSD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b9e5d0-6402-4a50-65c1-08db87c2074f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:02.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScNM6QsVh8gTMTY4e0TSWHU3qHLmqkAz4FgTvceTvPMuT+D3yKiGI217E6WxOlI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 54 +++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1e0c5d9a0370fb..0f75428be79d4d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -369,14 +369,17 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
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
@@ -434,7 +437,9 @@ static void iommu_deinit_device(struct device *dev)
 	}
 
 	/* Caller must put iommu_group */
+	mutex_lock(&dev_iommu_group_lock);
 	dev->iommu_group = NULL;
+	mutex_unlock(&dev_iommu_group_lock);
 	module_put(ops->owner);
 	dev_iommu_free(dev);
 }
@@ -449,13 +454,11 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
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
@@ -501,7 +504,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 			list_add_tail(&group->entry, group_list);
 	}
 	mutex_unlock(&group->mutex);
-	mutex_unlock(&dev_iommu_group_lock);
+	device_unlock(dev);
 
 	if (dev_is_pci(dev))
 		iommu_dma_set_pci_32bit_workaround(dev);
@@ -516,8 +519,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 out_unlock:
-	mutex_unlock(&dev_iommu_group_lock);
-
+	device_unlock(dev);
 	return ret;
 }
 
@@ -566,6 +568,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 
+	device_lock_assert(dev);
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
@@ -590,14 +593,23 @@ static void __iommu_group_remove_device(struct device *dev)
 
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
@@ -1080,6 +1092,8 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 	int ret, i = 0;
 	struct group_device *device;
 
+	device_lock_assert(dev);
+
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
 		return ERR_PTR(-ENOMEM);
@@ -1141,9 +1155,12 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
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
@@ -1151,6 +1168,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_lock(&group->mutex);
 	list_add_tail(&gdev->list, &group->devices);
 	mutex_unlock(&group->mutex);
+	device_unlock(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
@@ -1164,14 +1182,16 @@ EXPORT_SYMBOL_GPL(iommu_group_add_device);
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

