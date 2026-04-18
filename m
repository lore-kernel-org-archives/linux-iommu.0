Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF43A4524
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776555721; cv=fail; b=gVE3xDvzGYJs0+D2o7ONeRAukFKoCqM8HfiGb2jGwK1PVHPGGPo78NLnn9GdUYgZULrABYp6yT/c/t4ydcmFY4XkR06bsxcfD2PgK74+KDsP89c6tOQYMgmU7gYAh6MM+EgUGx54oWY8E5AysndRcKalP/u5EOaGlcP/7nQcFU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776555721; c=relaxed/simple;
	bh=QPx0nPf8nL/aoup1/h5nV9v6V+ufUNTXd/QTm7Dc8hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hE5b2Coka2GRIX4ie8luflP2CA6fAL/k+YBtMaj0ZN8rQTyKGAqkdoj8vyo8wy6iZORHbwwY9Vj/CgOa5FAQGlq7R3xVcuKwi0Qp3871hgiuwhMBptlyuCCNDO7/Vduk1a2p0mzPS5498JgR/7pX9/ybqT+2uWVIdB9Cu9DD87Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GRipB9zO; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GRipB9zO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/96Ql+HMENbcJI/bxhxVC1/XNhehLUS0I2mwp8k56oBr7Acp4STXGi2M1mGAHZonpXfw+M3Q4GMqCDOcTlv27QW8Yh2u38GlI5fa2KuqXK/rywsb4plYCCquo7oITiHY1BT4xUCB0Fh46u3t2t+0mKAWtDAAPWZBhL2bJP9I24Jibl+cK9ftTCLIribg0BRqijOrAyrEAEbyvKRG0paeTFnAIN3isqON7x/ovF+Cy1L40XOW9FzDLxrVxY+DtQYC3gub2WFeW+++zmVnaOjUMv5D2VX092cWO1VPZh4d07uoRFzf/s9VS1RrHUDPz7aVjnzD+zj/TTFTrFEQqE+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dfTMu4K5T4pxipueaarI91WfscDbe+AdXqarepfdD4=;
 b=cnPIPZULttUCvVtkiILg2b+/+uakJnO+jdFMDCbw7k98tnYq5GQ71BCpDZZMhEsV6ZH8tqh6QombowXLUlQkLXEeIlzRuMB9Tr0vbiiepfKz9+c0jhwNk3EohBzGvsShe+mJG2Mv7fDRsrWOwXhPLhZEWM6OieHNhBAH5rYvUBlHrw1IPik/4kzRWnNrbju+k3vN/e6lEgBiUZ81l1jsEPh+hi10yuIUL3jFu2G4aG2bH5yQAnvfcuv/nzFhLnpl/NdHZvtKRRXZrRtwizb98yz5LtvcIS9quzLoO6z/Z6Zm4O1m1EsAWzBrrUFgkhDv+AU/Jeg0phnQeX7DYJ1C4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dfTMu4K5T4pxipueaarI91WfscDbe+AdXqarepfdD4=;
 b=GRipB9zO3tCBfnbG6geHCBdQjq0FuAFmeVk/MhnIJXuqr/0Twhxh/X/aWQ9kHjAgdtztDwuIwx2HuDdQthAVPDNINozJGtf/DR+4iLrMjGVFvMuFH/nxsrK2+qshYYLxjYsWJGFLQeU50f9YM7TxKl1qMIyefJNvzUCg59h2xJDfNcWGzCNraCVqF9XThCjTgn1rDv/fzKWzWGCJzhH3BV952hEUfXQLNyOfuhYpfG9peNFx81djmnjcpASe/5cTn5wV3+VWjuGEIAxzniwh+1mn4hoJojTdcpUtOkKGOpfd63QKwf+4f7jxWKCFp7+e1GgK6fhGAm+fHryOWT9zCg==
Received: from BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sat, 18 Apr
 2026 23:41:53 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::c5) by BYAPR03CA0004.outlook.office365.com
 (2603:10b6:a02:a8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.55 via Frontend Transport; Sat,
 18 Apr 2026 23:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 18 Apr 2026 23:41:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 18 Apr
 2026 16:41:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 18 Apr 2026 16:41:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 18 Apr 2026 16:41:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v7 2/6] iommu: Replace per-group resetting_domain with per-gdev blocked flag
Date: Sat, 18 Apr 2026 16:41:33 -0700
Message-ID: <bc444d02c1aee02c59c8972ccc588f28dc93e059.1776551790.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776551790.git.nicolinc@nvidia.com>
References: <cover.1776551790.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: b0700a68-95ba-4adf-e540-08de9da411f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007|56012099003|18096099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CcMa7aQDVLoSGOR68codT4RN8qqD43pHBQ2FY6brChTM4Fs7xd/D83VIeT21rHFeEkoAFVD8baHZpiaL4g/nxItXbzKV/JLM3fabv0DRCxOvXvNNNug80rozc6HUvJNtfmk0azNDCoaL7EWWBcqqDADv1fLYymbartz7Xi/fyr9n2Xcs8zPM7EUIDj2BUL+iH5IMbyqKGMoI2I0H5XUxl08tK30Lnxzp8QSiFDiu9mNp8JlfXAKamyc0CSzQBF/7FmS4V4kdw2zAPJHiuv2OfjfZhFPmXqzl7HYo3vEoig6bpxJwbBDwsmsMjIWffvFL+YBBPU/G1sDvmVk2vMfh1fgXBny0mARrKajhnKFf+tE2uo7LPSBHzZtKQmkJ0VeEabAzU/fXLJqxqbxMVJjyXozCPwpHN4w4uUHVhjbtkvE1COYjMoo0txywaDS8zheevIfym9kxc9ISwBj3bpB72/FRZlm8rzz3A7i6yAV2ethZQa9sImewcA0DrgWv/36XmvRn/ymA5jjYVWF4MgbgQH6zej+G1BSplKB/EGKY7qfuBXYg1KIXE9PVcRMoz/akg/8YXP88UhhlSVZefogiwmvlrk/I9Qg1dkgsemUjOwNpMELKfqNvOWcjW4m2gnKfiAvHN8Ui+5abKynJr7UOeyE48s8YO7O46yJkxLF+TPkzw/FxbaCq4H/p/nQn+iymrhX8OhcUX8ESnD28JFQd1tMXbt9WBUWPv+0glYDrtVGHsQzrReIBQPYW4/8yg2UElIQj0wiNnBjuDnLnd4J/bQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(56012099003)(18096099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	arP9wwnn5dN9lOvkTu5E8cw6/k4Q+WJEMOAqlyKNsp8EE8rarMje3KBP2HHnAU7OLQyI1bJuev2k9I1yqdw+LS6ZP4HvDOHlEVDh55ewmqY9MfPzDCb3IselPotxdhYvvUgDKqJy1pnMzCP7P2YFpF5EDSIcWUzBkwxFctdEt4m+qTQAe364unbDs1X001YTbJsgMhq4DLeDLTa00AfltsbJ9oNx1t/kjsaQMGQ82XkQSQTZvpa6x4okMTMPPg48Vv+5qfDdPIBzSLg37e+xWIyNxVlU3pMAez56UwISKRtF/Ud0/XlZOMDsuGd0axCgV7LSnufnfs7uZ0sA+UMT94EwEF2tGYOxrCJAHvIYpQ2MXtdkGQ8o1F5E5LbX+ea1rSeQ2Lw47QfiIUu7ggiR+cdKsYPbBAUGNYeLzPFlI1il5LmBQoqAjXKkvBlH4zPR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 23:41:53.3455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0700a68-95ba-4adf-e540-08de9da411f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365

The core tracks device resetting states with a per-group resetting_domain,
while a reset is actually per group-device. Such a mismatch might lead to
confusion and even difficulty to untangle per-gdev handling requirement.

Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
internally while both are calling pci_dev_reset_iommu_prepare/done(). And
the solution requires the core to track at the group_device level as well.

Introduce a 'blocked' flag to struct group_device, to allow a multi-device
group to isolate concurrent device resets independently.

As the reset routine is per gdev, it cannot clear group->resetting_domain
without iterating over the device list to ensure no other device is being
reset. Simplify it by replacing the resetting_domain with a 'recovery_cnt'
in the struct iommu_group.

No functional change. But this is essential to apply following bug fixes.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Cc: stable@vger.kernel.org
Reported-by: Shuai Xue <xueshuai@linux.alibaba.com>
Closes: https://lore.kernel.org/all/absKsk7qQOwzhpzv@Asurada-Nvidia/
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b950e7be1a3ed..d5d9102b9d750 100644
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
 
@@ -76,12 +76,32 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
+	/*
+	 * Device is blocked for a pending recovery while its group->domain is
+	 * retained. This can happen when:
+	 *  - Device is undergoing a reset
+	 */
+	bool blocked;
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
@@ -2191,6 +2211,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
+	struct group_device *gdev;
+
 	/*
 	 * This is called on the dma mapping fast path so avoid locking. This is
 	 * racy, but we have an expectation that the driver will setup its DMAs
@@ -2201,14 +2223,18 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
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
@@ -2265,19 +2291,24 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
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
@@ -2436,10 +2467,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
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
@@ -3567,10 +3598,10 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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
@@ -3660,10 +3691,10 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
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
@@ -3934,12 +3965,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
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
@@ -3952,6 +3983,7 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 	int ret;
@@ -3961,8 +3993,12 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	guard(mutex)(&group->mutex);
 
-	/* Re-entry is not allowed */
-	if (WARN_ON(group->resetting_domain))
+	gdev = __dev_to_gdev(&pdev->dev);
+	if (WARN_ON(!gdev))
+		return -ENODEV;
+
+	/* Re-entry is not allowed (will be fixed in a following patch) */
+	if (WARN_ON(gdev->blocked))
 		return -EBUSY;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
@@ -3977,6 +4013,13 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 			return ret;
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
@@ -3987,7 +4030,7 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 		iommu_remove_dev_pasid(&pdev->dev, pasid,
 				       pasid_array_entry_to_domain(entry));
 
-	group->resetting_domain = group->blocking_domain;
+	group->recovery_cnt++;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
@@ -4009,6 +4052,7 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 
@@ -4017,11 +4061,13 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
 	guard(mutex)(&group->mutex);
 
-	/* pci_dev_reset_iommu_prepare() was bypassed for the device */
-	if (!group->resetting_domain)
+	gdev = __dev_to_gdev(&pdev->dev);
+	if (WARN_ON(!gdev))
+		return;
+
+	if (!gdev->blocked)
 		return;
 
-	/* pci_dev_reset_iommu_prepare() was not successfully called */
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
@@ -4031,6 +4077,13 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
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
@@ -4042,7 +4095,8 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 			pasid_array_entry_to_domain(entry), group, pasid,
 			group->blocking_domain));
 
-	group->resetting_domain = NULL;
+	if (!WARN_ON(group->recovery_cnt == 0))
+		group->recovery_cnt--;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
-- 
2.43.0

