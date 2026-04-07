Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8A33BBC6
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591294; cv=fail; b=AXR8ZpdvbRzvS0D0fX9v7U46fv5tq78zR6rQjiBSe24HaBEMFhdcxdQ5m9RJkCC7WqK46KdYwuiAZH9F5hVbG8vlaw5SOkXybbfDL4aWPaxjYcMpsJGKOcewK+M+i75CQOVQvzufGGSfXC2f0BkUKvEnP551RyQRQnA81HBY8/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591294; c=relaxed/simple;
	bh=Yh27H9VznCa2bdpbJypzHfDBFigbeoR1RZx5xzyQTOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bM+N5UMftmR+tjWxQzaEvwjKgPqt9EZWVrZKbDGgPQMubht0OYcI8ZfWT3BPg+ANrVHFs1yA8gV81H+p4/1zR6NTNyQ+3+f7DOvDiuZhoCK+AxNRqLq2ptg/8HN64YZMoULR1cT7hQdCmFqznLkKIfds61mbKAgpJ0G2fjXZdl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HXJ8k6sL; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HXJ8k6sL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAqlIC3zhgGtjCQ3XMsuLdzluPpzFjxhRbGAsevML0uD9wjfkJLpGAIsdE3g0nLBax2mAo/fYhZ/5b4MZ2k1y6GvyNFTZYVvisnEJqnAV/793m6NTDR+3LkDUd98GJOtDBg3/5kddO9FFT6sdYDVl7B/B8/aFnCaAlXFuBM4JZK2T0+WFRoDD0DLOSWBuxRpeXCX8S1MJkHCK6yMheQ5hXVwnyy4afWZXpcpgUslKC3NHjt+h87CyQunl4Ngue/J3P1vC5G8nmqFu6x1djNB2PhZ2CNVfDhjVBsFuIm38QXHZT6JVZxotMF2E64+msbYcgLQMIFgglvrCKHfj1gLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JFKZg46UL6WEpidRR5cp0pulEAuZ+B45WV/J0Kg4CE=;
 b=fLMRhQu5cbh1Si5xYj+1XrjFIZKxSmQonT0P203RmlbksNGvWKRf0ZrwEFyxtulE7kZHDRoQGAYchOPsGgcWLePiQiqzR+i3wkdFrJYCwfLkgpeBIUX6FXd4ab2EKzgbcn0Gaj9VtiUj55myLvlnh3ebtz2BGzoeauTHEnvjq5efV9zLmEZ81msLXwd/I5RiQzOHck5AN+1THfxk8CzWdl0xdS8jx9RNGUVZuArETR1reWwiAm9M/ZnE8ouOkX7cYqw8CBiMme5q9m948r1NDUdfy+ifD/MkH2ji+srp4LLop0OktVqCTeKS3fbhzVz7rfriOi8ADX8e2BEXn+nyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JFKZg46UL6WEpidRR5cp0pulEAuZ+B45WV/J0Kg4CE=;
 b=HXJ8k6sLwv/sVGzF805ny42a9s/H5FxZCPXu0hxSkuYh23+Bvn/Jx82qXw7+49Fbs1j7lOjXNUldKyKzt75CNhH1gi+283KupmC37mg1l0/b47HboqPb7DPYJB59ynl5/3JuGf28k2B/zCWN6BnQCtdu0Cpdnm3DLGU46+O9SkU+uzgCOYQ25r+vk62Kaxkct8Gj6u6N4TWz5fFgVFl7I7xQdYtfVPbw5+AgfdMBgoPYLACUkydH7d1nYU+sD/YtAASmTeZN8GjwlLlQcpAmPkkOCaf7UEvXQi4f2ZjGhL+hu7UMj8plHvc1LGJ6lijOwTqkUyvDi7xiF8yjtFioCw==
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 19:48:00 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::60) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 19:48:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:47:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Apr 2026 12:47:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Apr 2026 12:47:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v6] iommu: Fix nested pci_dev_reset_iommu_prepare/done()
Date: Tue, 7 Apr 2026 12:46:44 -0700
Message-ID: <20260407194644.171304-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f58d47-eae1-4b53-4f2d-08de94de931b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5yJ2c5sVYWXMEecMdJIlPL8JHH22zE5bQQcXX/B6cVRQxgJOR7vHOM9TAPE1QO9qNHUXIuK7KzGbORjtPv45a5xqFMf/ZI8yQWpNGO0U+PPndUD9DTEifgrBaZhL0OhKG1nwRfuNJm3ZKR34wizaRXcFQkxIekB0PX0eb7WGVKaGGpGqBzP57ebH5dt5phRHpxfQhIrf2ukNY1nfWj5AZcmr6thpOX9TWcK+Kyi3Rb5Ge1BhuAfBSTwjcy8VBxjwYR2lBli2LmZA02HBuZnnGaFpjGRSLY+AO84vZgwIf9teSWGYY/3kNDZQzCDn8tPR08qHNfRDWqCB19JJWL12Ns8wXb41c+wVX01YNYHoECRF8+U4rLxHoi16iUkt3+QMMbn4B7yXjcfMZ9JadJPcisrem2KpWM23iyEzTlUYtTxhsdtDN1W1GcEwxdvCc5u9mYAcrE3wD9KBeIbmP1fjbGS5DJgublm/Yecr+7f5Xyz0OsTHhcJnLlDADQXUQdDIYorjDu3Nb6TigvtADBjXxsSLWkZ4+lCi7uhfoyWZvWCcKRLAfMAei4ZCD32VRYD1fRhYZ0kgBHjgK2F+x3cin0KjlY+2k1I22Wpyo2gLVWZz09DMkz30VP/SREkiedntsdUaY1zMmoXNoOXlIzfkzV/iSddmIpLSIYBpLHSJP0ja4dVAhLUvf6xWZoqDSJ9nxho6g0uXld5EHa9z6qFSp6WueAkvWzatJ+9CW74vnO9JPuHk02p8n7suQ9PG5ITBasPW3HUHPAdyR55zZJ9/IQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l86ATr0sxFpVD3iHGvChqlAtL0NhBB0aEb0QXb91LdiAXPNMMhCkm7sqm849fgPZySC3ZhcC1wZpXYhKkcoN7Xr8A3eLCa4PJ5Sh3W6zzN4p88j/NYL8pVh8nRQNOdR/wr547uytkXFPrzacd8uIgwtWd9LvhhmXQpTWicEuArUPvqJvKuJNdPaJMbIxIoGYwpAmHyhk7zodkFzsK1YpIF+qmPed3Fyf2YPhCnMHIPkbEp4BZJIpHYa/4VV2hDhJ95pn+Hp6xVd1ag2IwM1T9slwDc8kJc9usvxVnSdPDN0kPB/fodbDptBsypziS859LXJ3n236pEqS5CHtKiIi7nutI4EB5A/nTeVGE3BzbHNouUqdL8Js16djaeGgPVsLhd0gc8o9u7Qt/wnSBoa5ycxjS0/N+2rhXYqcmunJPeRujaeNW+UqTx5i4KUIDXNE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:48:00.4607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f58d47-eae1-4b53-4f2d-08de94de931b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
internally while both are calling pci_dev_reset_iommu_prepare/done().

As pci_dev_reset_iommu_prepare() doesn't support re-entry, the inner call
will trigger a WARN_ON and return -EBUSY, resulting in failing the entire
device reset.

On the other hand, removing the outer calls in the PCI callers is unsafe.
As pointed out by Kevin, device-specific quirks like reset_hinic_vf_dev()
execute custom firmware waits after their inner pcie_flr() completes. If
the IOMMU protection relies solely on the inner reset, the IOMMU will be
unblocked prematurely while the device is still resetting.

Instead, fix this by making pci_dev_reset_iommu_prepare/done() reentrant.

Given the IOMMU core tracks the resetting state per iommu_group while the
reset is per device, this has to track at the group_device level as well.

Introduce a 'reset_depth' and a 'blocked' flag to struct group_device, to
handle the re-entries on the same device. This allows multi-device groups
to isolate concurrent device resets independently.

Note that iommu_deferred_attach() and iommu_driver_get_domain_for_dev()
both now check the per-device 'gdev->blocked' flag instead of a per-group
flag like 'group->resetting_domain'. This is actually more precise. Also,
this 'gdev->blocked' will be useful in the future work to flag the device
blocked by an ongoing/failed reset or quarantine.

As the reset routine is per gdev, it cannot clear group->resetting_domain
without iterating over the device list to ensure no other device is being
reset. Simplify it by replacing the resetting_domain with a 'recovery_cnt'
in the struct iommu_group.

Since both helpers are now per gdev, call the per-device set_dev_pasid op
to recover PASID domains. And add 'max_pasids > 0' checks in both helpers.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
 v6:
  * Update inline comments and commit message
  * Add "max_pasids > 0" condition in both helpers
 v5:
  https://lore.kernel.org/all/20260404050243.141366-1-nicolinc@nvidia.com/
  * Add 'blocked' to fix iommu_driver_get_domain_for_dev() return.
 v4:
  https://lore.kernel.org/all/20260324014056.36103-1-nicolinc@nvidia.com/
  * Rename 'reset_cnt' to 'recovery_cnt'
 v3:
  https://lore.kernel.org/all/20260321223930.10836-1-nicolinc@nvidia.com/
  * Turn prepare()/done() to be per-gdev
  * Use reset_depth to track nested re-entries
  * Replace group->resetting_domain with a reset_cnt
 v2:
  https://lore.kernel.org/all/20260319043135.1153534-1-nicolinc@nvidia.com/
  * Fix in the helpers by allowing re-entry
 v1:
  https://lore.kernel.org/all/20260318220028.1146905-1-nicolinc@nvidia.com/

 drivers/iommu/iommu.c | 148 +++++++++++++++++++++++++++++++-----------
 1 file changed, 110 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db517809540..ff181db687bbf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -61,14 +61,14 @@ struct iommu_group {
 	int id;
 	struct iommu_domain *default_domain;
 	struct iommu_domain *blocking_domain;
-	/*
-	 * During a group device reset, @resetting_domain points to the physical
-	 * domain, while @domain points to the attached domain before the reset.
-	 */
-	struct iommu_domain *resetting_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
 	unsigned int owner_cnt;
+	/*
+	 * Number of devices in the group undergoing or awaiting recovery.
+	 * If non-zero, concurrent domain attachments are rejected.
+	 */
+	unsigned int recovery_cnt;
 	void *owner;
 };
 
@@ -76,12 +76,33 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
+	/*
+	 * Device is blocked for a pending recovery while its group->domain is
+	 * retained. This can happen when:
+	 *  - Device is undergoing a reset
+	 */
+	bool blocked;
+	unsigned int reset_depth;
 };
 
 /* Iterate over each struct group_device in a struct iommu_group */
 #define for_each_group_device(group, pos) \
 	list_for_each_entry(pos, &(group)->devices, list)
 
+static struct group_device *__dev_to_gdev(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *gdev;
+
+	lockdep_assert_held(&group->mutex);
+
+	for_each_group_device(group, gdev) {
+		if (gdev->dev == dev)
+			return gdev;
+	}
+	return NULL;
+}
+
 struct iommu_group_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct iommu_group *group, char *buf);
@@ -2191,6 +2212,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
+	struct group_device *gdev;
+
 	/*
 	 * This is called on the dma mapping fast path so avoid locking. This is
 	 * racy, but we have an expectation that the driver will setup its DMAs
@@ -2201,14 +2224,18 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 	guard(mutex)(&dev->iommu_group->mutex);
 
+	gdev = __dev_to_gdev(dev);
+	if (WARN_ON(!gdev))
+		return -ENODEV;
+
 	/*
-	 * This is a concurrent attach during a device reset. Reject it until
+	 * This is a concurrent attach during device recovery. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 *
 	 * Note that this might fail the iommu_dma_map(). But there's nothing
 	 * more we can do here.
 	 */
-	if (dev->iommu_group->resetting_domain)
+	if (gdev->blocked)
 		return -EBUSY;
 	return __iommu_attach_device(domain, dev, NULL);
 }
@@ -2265,19 +2292,24 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
 struct iommu_domain *iommu_driver_get_domain_for_dev(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
+	struct group_device *gdev;
 
 	lockdep_assert_held(&group->mutex);
 
+	gdev = __dev_to_gdev(dev);
+	if (WARN_ON(!gdev))
+		return NULL;
+
 	/*
 	 * Driver handles the low-level __iommu_attach_device(), including the
 	 * one invoked by pci_dev_reset_iommu_done() re-attaching the device to
 	 * the cached group->domain. In this case, the driver must get the old
-	 * domain from group->resetting_domain rather than group->domain. This
+	 * domain from group->blocking_domain rather than group->domain. This
 	 * prevents it from re-attaching the device from group->domain (old) to
 	 * group->domain (new).
 	 */
-	if (group->resetting_domain)
-		return group->resetting_domain;
+	if (gdev->blocked)
+		return group->blocking_domain;
 
 	return group->domain;
 }
@@ -2436,10 +2468,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 		return -EINVAL;
 
 	/*
-	 * This is a concurrent attach during a device reset. Reject it until
+	 * This is a concurrent attach during device recovery. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
-	if (group->resetting_domain)
+	if (group->recovery_cnt)
 		return -EBUSY;
 
 	/*
@@ -3567,10 +3599,10 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	mutex_lock(&group->mutex);
 
 	/*
-	 * This is a concurrent attach during a device reset. Reject it until
+	 * This is a concurrent attach during device recovery. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
-	if (group->resetting_domain) {
+	if (group->recovery_cnt) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
@@ -3660,10 +3692,10 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	mutex_lock(&group->mutex);
 
 	/*
-	 * This is a concurrent attach during a device reset. Reject it until
+	 * This is a concurrent attach during device recovery. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
-	if (group->resetting_domain) {
+	if (group->recovery_cnt) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
@@ -3934,12 +3966,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
  * routine wants to block any IOMMU activity: translation and ATS invalidation.
  *
  * This function attaches the device's RID/PASID(s) the group->blocking_domain,
- * setting the group->resetting_domain. This allows the IOMMU driver pausing any
+ * incrementing the group->recovery_cnt, to allow the IOMMU driver pausing any
  * IOMMU activity while leaving the group->domain pointer intact. Later when the
  * reset is finished, pci_dev_reset_iommu_done() can restore everything.
  *
  * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
- * before/after the core-level reset routine, to unset the resetting_domain.
+ * before/after the core-level reset routine, to decrement the recovery_cnt.
  *
  * Return: 0 on success or negative error code if the preparation failed.
  *
@@ -3952,6 +3984,7 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 	int ret;
@@ -3961,33 +3994,52 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	guard(mutex)(&group->mutex);
 
-	/* Re-entry is not allowed */
-	if (WARN_ON(group->resetting_domain))
-		return -EBUSY;
+	gdev = __dev_to_gdev(&pdev->dev);
+	if (WARN_ON(!gdev))
+		return -ENODEV;
+
+	if (gdev->reset_depth++)
+		return 0;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret)
-		return ret;
+		goto err_depth;
 
 	/* Stage RID domain at blocking_domain while retaining group->domain */
 	if (group->domain != group->blocking_domain) {
 		ret = __iommu_attach_device(group->blocking_domain, &pdev->dev,
 					    group->domain);
 		if (ret)
-			return ret;
+			goto err_depth;
 	}
 
+	/*
+	 * Update gdev->blocked upon the domain change, as it is used to return
+	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
+	 * called in a set_dev_pasid callback function.
+	 */
+	gdev->blocked = true;
+
 	/*
 	 * Stage PASID domains at blocking_domain while retaining pasid_array.
 	 *
 	 * The pasid_array is mostly fenced by group->mutex, except one reader
 	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
 	 */
-	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
-		iommu_remove_dev_pasid(&pdev->dev, pasid,
-				       pasid_array_entry_to_domain(entry));
+	if (pdev->dev.iommu->max_pasids > 0) {
+		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
+			struct iommu_domain *pasid_dom =
+				pasid_array_entry_to_domain(entry);
+
+			iommu_remove_dev_pasid(&pdev->dev, pasid, pasid_dom);
+		}
+	}
+
+	group->recovery_cnt++;
+	return ret;
 
-	group->resetting_domain = group->blocking_domain;
+err_depth:
+	gdev->reset_depth--;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
@@ -3997,9 +4049,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
  * @pdev: PCI device that has finished a reset routine
  *
  * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
- * IOMMU activity, including new translation as well as cache invalidation, by
- * re-attaching all RID/PASID of the device's back to the domains retained in
- * the core-level structure.
+ * activity, including new translation and cache invalidation, by re-attaching
+ * all RID/PASID of the device back to the domains retained in the core-level
+ * structure.
  *
  * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
  *
@@ -4009,6 +4061,7 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 
@@ -4017,11 +4070,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
 	guard(mutex)(&group->mutex);
 
-	/* pci_dev_reset_iommu_prepare() was bypassed for the device */
-	if (!group->resetting_domain)
+	gdev = __dev_to_gdev(&pdev->dev);
+	if (WARN_ON(!gdev))
+		return;
+
+	/* Unbalanced done() calls would underflow the counter */
+	if (WARN_ON(gdev->reset_depth == 0))
+		return;
+	if (--gdev->reset_depth)
 		return;
 
-	/* pci_dev_reset_iommu_prepare() was not successfully called */
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
@@ -4031,18 +4089,32 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 					      group->blocking_domain));
 	}
 
+	/*
+	 * Update gdev->blocked upon the domain change, as it is used to return
+	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
+	 * called in a set_dev_pasid callback function.
+	 */
+	gdev->blocked = false;
+
 	/*
 	 * Re-attach PASID domains back to the domains retained in pasid_array.
 	 *
 	 * The pasid_array is mostly fenced by group->mutex, except one reader
 	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
 	 */
-	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
-		WARN_ON(__iommu_set_group_pasid(
-			pasid_array_entry_to_domain(entry), group, pasid,
-			group->blocking_domain));
+	if (pdev->dev.iommu->max_pasids > 0) {
+		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
+			struct iommu_domain *pasid_dom =
+				pasid_array_entry_to_domain(entry);
+
+			WARN_ON(pasid_dom->ops->set_dev_pasid(
+				pasid_dom, &pdev->dev, pasid,
+				group->blocking_domain));
+		}
+	}
 
-	group->resetting_domain = NULL;
+	if (!WARN_ON(group->recovery_cnt == 0))
+		group->recovery_cnt--;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
-- 
2.43.0

