Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1561313E3B
	for <iommu@lists.linux.dev>; Sat,  4 Apr 2026 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775278999; cv=fail; b=uV/ioaqazzy56JrIO+0KN9h+h9VSK3r8IwSfXrdHPuRQfOs6wMCDJwzWIYKWUYAiJV96Z240T0a+8tb/isDc9qoujXwTBrjw8JsZZiNYgTVkh57ncea1ZH7yMsIZekwkC9yOP6VTVpnymgkOhN6maZQzKZtZ08Yg6YvTfUwqni0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775278999; c=relaxed/simple;
	bh=On3E2fysZ3o8ni4JUZbZllKE1rgGjoPpwgDw75BP2Gs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nu3BQP/nOve0Z33P6scU1YOEQ1Fqf1wgz9TeTBo/G9osg7yfSg0Hr4hKbRLPeLmuoxY88le8cySatQritgZsq4yyX8e6/3rAF6S3yKYgcXtsgXaoGAXJLEOvt+6QOee/SLstI+sBwjpWRt7MDx4oJPt4CX6UzyLllpLimd4TP44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTg6ZaPy; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTg6ZaPy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEPoeznYGmVytreesQs4JsO8Z64Pauel8E85rm0djGdZoAPBgQ0SgAyCAX26cxVaKf5l4qTUXtOQv50f4trHI7g0nMCFxlC5u7f/p2xVJGMKDyP+qaOGFb5dkV1veRy+a7jPwmpADU7vxzfzNO8QG2eqC9F+DUtYz42p28PG7YxGOHBEzMgC+923yQhLfkCIzU7f1t3pfsrYV7j3xhtIHEYxh1y7JtjKqpjSq+tdQuw0PKb84uxWEsrtP2aEjdNzK4ixZIFnuAVnK5xS4hjjPV8TrJAAaDbDanjEe4gd2V3pYDg04Y/smPUZiSO4zeKOrhKf7taVyavKzU8zaMKMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o97f7GBZhfNW+KEGp7+ObPdpDZsOQX1vpJLvp0+h8gE=;
 b=QoVb/6qPDWqoImVQwxJB3m2RWFGCQtvEhM9HponQFVEPwJ/vk8gduNhltwluNtzP/7hN6BJyMLompWJJHXm9sJhsQVCzmUi9vquN+c0cN8gqvHnYpU3rOtTUewyWemQj5jBORW40UWDtO2HPencRC3f6fG47TTDmdemlSiepdNrS9S9SM24W7aZWg0Nja45ECJfQZPHfRAPaPDhwifW6AhhWK4i9fJ1Len5PtMPeZUtcEk2byrTQyfcWYPMTNv8Uj1NVXyzksS75pXle+ul0egvtjon7LVnj8MDQnAWNTd6WzpmldjmA2yNfAX4FUpgNDXg2SltjXg2CiUzEL0Jt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o97f7GBZhfNW+KEGp7+ObPdpDZsOQX1vpJLvp0+h8gE=;
 b=jTg6ZaPyLudeoE3IMRcpd56+tPanxmhXKAx2ZwHkeLiYaBPTZI/usxqV9SdRNLxdrUlD2UnqkH+i46lMXp2RJNVt1O0MGsRkJdnDhMk9xIQqZmSHo+tkl36jMuofXaK8PqGtSCA+72rbT61WzpOcLxOoc/7FbrL6KvksslAEXKKQGoZRIWMMEqR0LJo96j14tHKKRzcAv1pv1r2Ic/KSK95IDBLGJtzPILYPgHMD0fEJ4xCgWeNvc+VbsGuAg3Jtay9Tsg+d7p2+FBwwSnh3fsoMtCIDdfccYHKkXbgB6KpVr+EkapGoHj+2KIRYz8N26+XPrabpWKJ5WFEyv0dXcQ==
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Sat, 4 Apr
 2026 05:03:10 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::7b) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.24 via Frontend Transport; Sat,
 4 Apr 2026 05:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sat, 4 Apr 2026 05:03:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 22:03:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 22:02:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Apr 2026 22:02:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v5] iommu: Fix nested pci_dev_reset_iommu_prepare/done()
Date: Fri, 3 Apr 2026 22:02:43 -0700
Message-ID: <20260404050243.141366-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c04bd8-4431-4d2e-2092-08de9207779a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ho6rt4QG+UlTg81beoXn+66Q9/ok+FwNuXrdEkBnsnCmdEuU6BTS5rDt7HnIx7gkl/yGyTNuCpGdmehdyBYlGnba7F9I1AF7xdBAA6LgEx5QK+D9h5/e7qGXFwl7ekMSl/fCvmkeyivmIWbs2E0SGmNu0sEX0OX0BTX4YJmHNrFzYomdbS7RSCJLiwgwiz9EX+oNSK6Xuu4uZ5I4buJePnVZNlb6+ojgWtIcbIDbmAjGbzkY33OfCG2WXkLZhBQlEx1sb9GRO/RfY9kEyVvSjegKT47etWSLj/ZSKz4gFOpoHBwpaj9UNtWhnMFYOq9BtHTEiy/SAchl+5leMyQ7MZc1joomlRI7wi8ck1JEPne223sbkEaNK2yT9ZqoigslBegXMWaJqjtbZN9XuhgHi4W4AsnwIOQWTsPds/4i53N34lEV7XkXkB3kWOp1cIsw0bBXKA4XVzzvroPBseBUc+TdLIMjtN9Tnq36H5U8/3li1wZXqvUBZroWRzJ25PhEBtRA8KvwzT34icKvpYT8GApJ3cyaN2Fjwf/3oUvrxp2/Yimg6RDF5TWa210dUMWx1AOWJURkGU5W1sbX+f1pMhhgHrtEhQIgW42OtvN8bPkD9wtx7Vwqaew1eUMrF3ssy6Grt9JSnvqCGxDvBH0gTEbR+ZtxeJajsjg6sJbk86S0zGV0EdDTCr5ZhDBiCt1qmmmC5XGNAoxu+lnjKt3nv6mrmmLPzSUWt496Ikz5bvxJ3WJ4l0gzTiB4F7TO/yXC7h+/UdtmqL4WAvgK2WYKnA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6DwpaGmO5a6va3NodpA1qubNhdaIISKvDaQp+GGif9mOs8op3O4qt92RkHWumZDcHWFnxWh9lWn31BYFDeR56d2soCMy4347Z6xoS231yLN+KCqM7dkcKSkrb6rNHNEIauY3WyXpkN8P+AbOqc+/4EH0Zh4L/5UVBz/BpXgko/f1+5bc5X1nt634n0KRgX9JdjN8v+1J2ywtONQNg9wiPSSvOk4WVOBJRL/qqpDPGM+pf/TEJl3qwKcb5YzNVQahYDJSffsWzUIrZsDyAXU8/4qw2NMYvgCBUcxCtVc3B4kRNcjiMfFIDwrov8i/9huWXfEOyvyuL/eNlamQ78BnH9fNH3+DK4hduGIRcmDypm9VlqQj2oLdkOW447wNQw8Z30I/0QZB2FuAkc5ZmpoOXIcxlvlOpzseehgrFpMOrYBLVqOHon+v+wppUV13p9Dt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 05:03:10.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c04bd8-4431-4d2e-2092-08de9207779a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

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

Introduce a 'reset_depth' to struct group_device to handle the re-entries
on the same device. This allows multi-device groups to isolate concurrent
device resets independently.

Note that iommu_deferred_attach() and iommu_driver_get_domain_for_dev()
both now check gdev->reset_depth (per-device) instead of a per-group flag
like "group->resetting_domain". This is actually more precise.

As the reset routine is per gdev, it cannot clear group->resetting_domain
without iterating over the device list to ensure no other device is being
reset. Simplify it by replacing the resetting_domain with a 'recovery_cnt'
in the struct iommu_group.

Since both helpers are now per gdev, call the per-device set_dev_pasid op
to recover PASID domains.

While fixing the bug, also fix the kdoc for pci_dev_reset_iommu_done().

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
 v5:
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

 drivers/iommu/iommu.c | 116 +++++++++++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db517809540..4bd7a4afc9881 100644
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
 
@@ -76,12 +76,28 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
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
@@ -2191,6 +2207,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
+	struct group_device *gdev;
+
 	/*
 	 * This is called on the dma mapping fast path so avoid locking. This is
 	 * racy, but we have an expectation that the driver will setup its DMAs
@@ -2201,6 +2219,9 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 	guard(mutex)(&dev->iommu_group->mutex);
 
+	gdev = __dev_to_gdev(dev);
+	if (WARN_ON(!gdev))
+		return -ENODEV;
 	/*
 	 * This is a concurrent attach during a device reset. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
@@ -2208,7 +2229,7 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	 * Note that this might fail the iommu_dma_map(). But there's nothing
 	 * more we can do here.
 	 */
-	if (dev->iommu_group->resetting_domain)
+	if (gdev->blocked)
 		return -EBUSY;
 	return __iommu_attach_device(domain, dev, NULL);
 }
@@ -2265,19 +2286,23 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
 struct iommu_domain *iommu_driver_get_domain_for_dev(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
+	struct group_device *gdev;
 
 	lockdep_assert_held(&group->mutex);
+	gdev = __dev_to_gdev(dev);
+	if (WARN_ON(!gdev))
+		return NULL;
 
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
@@ -2436,10 +2461,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
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
@@ -3567,10 +3592,10 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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
@@ -3660,10 +3685,10 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
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
@@ -3934,12 +3959,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
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
@@ -3952,6 +3977,7 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 	int ret;
@@ -3961,21 +3987,25 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
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
+	gdev->blocked = true;
 
 	/*
 	 * Stage PASID domains at blocking_domain while retaining pasid_array.
@@ -3987,7 +4017,11 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 		iommu_remove_dev_pasid(&pdev->dev, pasid,
 				       pasid_array_entry_to_domain(entry));
 
-	group->resetting_domain = group->blocking_domain;
+	group->recovery_cnt++;
+	return ret;
+
+err_depth:
+	gdev->reset_depth--;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
@@ -3997,9 +4031,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
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
@@ -4009,6 +4043,7 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 
@@ -4017,11 +4052,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
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
 
@@ -4030,6 +4070,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 		WARN_ON(__iommu_attach_device(group->domain, &pdev->dev,
 					      group->blocking_domain));
 	}
+	gdev->blocked = false;
 
 	/*
 	 * Re-attach PASID domains back to the domains retained in pasid_array.
@@ -4037,12 +4078,19 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
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

