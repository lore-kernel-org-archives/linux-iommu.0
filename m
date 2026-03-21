Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2530EF95
	for <iommu@lists.linux.dev>; Sat, 21 Mar 2026 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132819; cv=fail; b=BqfT9rXpTyla4dLKLpjyPXcI8U9qbKVM0SQxM3d5L64t2JU/HMx6q6v2ZJ1yVKLN+2i4dSTLAVmN2EBi+DOH0fWdMccJTWA+21wytwIzE8m3Uv0nmie3rSauMxjJewu7HZ8rGd2hHP3gPFIEziLfuEnZEAP4EZPZpl+a8e0lnSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132819; c=relaxed/simple;
	bh=2N2AvEiij2w4qUwcRt05wzZx3WQilcjYH3+lfFuo90w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOMhIAsXSrZhZuDVBFOQm2L5VX4ZI+oqKavnM4ROzxfIdA3f8ajkoEPyUDtMhaTnIjFPgCVq2ly0w2W9r7zqYYgnJOKmsQzfz+/ISYkG4+OVEbHJ0FodHe0uG2B5I7lHASnS8ufmxPY1cpfCvLM/Clb2uRp+O7U4xaivPHUT96s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Skn6thjN; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Skn6thjN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHYiACDFPnJK3QJXGiSHY5Qb7WCWd7ZteZQ4auaV0tn7/8SeuMx9mFpNp1DaPAQ8YtOQChiULD1/aEH1nhGHezYNvVJHcdsHLZF7NVtbYVU/EnOkc6e7wrzVPMb58KQRTzHavUw4hf72ZYBtADGPMkOC0cGhlYZTbmcZdqucinym62LnD2WCjth8CsoON1bna92LxQ1vi3engW3ESSKNF72tVG4w3fhHUWI2poqmMyX+abeidBQ7Fx5pg+JWAhNk5os4xtypRutdq5SJ/MAWzMEO5yTswnjDcnQYnDty/CJBdVLssH22nUDzFXVP/rO7slzHkHJzaEKan/AzrzYXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckeqHA8lWFtBapQRtYF3Mmecnr399zmfko4XujfXtuQ=;
 b=HYqNbQNTgpIiqIY1X7cqKPF6fIR4Gxq/STidm/Rtx5HtNKq324LM4BjoxOXRYAu9XKTZCYPSzi0cNs4Onb/PWBn1SZJ9bFVcP0JV+Y/O6TwvIJHvjfiT6pimsjD1EuNTPUG+4LAUCGpCotZVxFg6i57E0ggoSoKcagQOBqeWgqU1S/rAmE/VOZlcLxlhMameR9NBkeDxvqqwxw708X0Mratnh3FhDsSLW8p64abVrsRz06YrluoBUqTu5vt5d4hSTR5ywTyvycfJDHoBJfptUC0NWdcwEj0bfhsJrcbUnhKShwfWp8PoQzSnNvqVfDxBXNFMyrH+jlIXdQO3tgZ4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckeqHA8lWFtBapQRtYF3Mmecnr399zmfko4XujfXtuQ=;
 b=Skn6thjN5dPbZ9DAOQdDvsW13xv+CnjtI2Dd+crl3QYmaYUYKAvyqm79ecYvWE8471RtVsxbmCH1P9vULoHW0zfbt82bd9Exic2a+D0imcF7VQmxx3zakKiq4u/0mFN3u19cajtYeNolzOcuJYdrT+nhiaJadkuguJ4IPRk1Sn3e5UEJEyv0Kq/TpBJxzV6cK0t6WMRS3cZORGh4nPVUs8AgkcmihGipwDisL1hw36DUV5rmxDfCHvQMVg4f1k56gf2syHmxVB/2NF26g6oDKceiBD+OVflHVzx28tG+GwkrY0ca2KS8KyOWIDbmnMEQfJDf0kziszcJP3c8wUkGYg==
Received: from MN2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:208:15e::19)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 22:40:10 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::b4) by MN2PR17CA0006.outlook.office365.com
 (2603:10b6:208:15e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Sat,
 21 Mar 2026 22:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sat, 21 Mar 2026 22:40:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 21 Mar
 2026 15:40:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 21 Mar
 2026 15:40:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 21 Mar 2026 15:40:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<jgg@nvidia.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v3] iommu: Fix nested pci_dev_reset_iommu_prepare/done()
Date: Sat, 21 Mar 2026 15:39:30 -0700
Message-ID: <20260321223930.10836-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c002138-abcd-4c68-5db6-08de879acf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	di9TOd/j/3f4qsjYRdmci3TEVcXrkQZJ+IJeAXM+flYlyt87U/kTtv0bPbU4s5uSQv/m2jhJAIEtNbgj29dZnldssYV7Xq1ab6mps3UfsJO5Af+KhomZTtzYOBrR+GMzFlT6zfCgxSGD8CCdHsr95P40WEV3hdyq5hrXCwHvmJC4X+gHDD1IsvjOcI5jg1/LZMgcnt0TWNyPOqAVhU6JiQMvoKRZGFPJLwyKxO/u0tXclXMyTSnN41hcyE/M6lIeuZx4DOQh+I54IecXu2kWQvqbPn4j/vcEQa8TWmCGVQB3Lu5RXLjU1cIMj1nKO0/JJ9Cr5QAqjV9p7sqlBYasfUHY+0CWtUYcWTiVOLuaNI0Lb+R8N+eDwtJH6MfAcZz+R5mtR3xFbwiYEpCuMv7h6IlunfLZ9wH+T6l8qPPW4sP2R2NSgUGGDQq0CoKG6UGKlFXz6Yq4xrKI95xDJHVfdn/8I9Kl+oVS9+FpXEI4XDc1VMPWAb63OV+6AjTkU7RsyWPJO6k2gHT6LAFY9K9zu2CxhPNxFE3+Hp/7ud35hpuFouScfSOQdqAnmeqmA5yikVdByHEzh4xfhMd/JcEHzD0+vBt6XROgLQJdbDKnu5q0vy9Band0ibd9Y1GCtVvkwzp+swRkR86inhVrKtRTlU0qz5XOiublKg0B5/g7N91jJo9JQ4Ir+isgSY8qNCofD2VX60Iy9Ch2axqsoMQ0rlW8zwRz9wKkTbha6rXxbjhfoZvXIazVLs9W06qslV3hUyvnO11G2XEwMGIMv97YaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GBmWTCmXbAglOd2RN+FPqFcqiY7EX8AsGxU4lk18BSoPpM8AsMolAbB6rY7H1iH4PRST8+TzMJg598WsPZQTnKdDCWozmmF1aBlIJfVkshDBbqjkcXLzLhomI01jEXZ6btamEwaNbKN0yXWW6kJkbto79+9cUFeiiLH8C3JWGxg0St8fSREG/gqKeehsSWKv0gItfSgPTVT5dbZNV3fgDOC/Qqa6yUnTzM2sIXrLPfiWmEPEfNVqx9PHAu5YJS3P4/2IGkpQpk7CRbD0u45TA4AqHmWjeTrThZg6SfMLCccBE8CD/5O5zY8VWHCFdclM3mrnrwcNUhFnHm/4S0INsxN3oef4y788Zy+wb68Eui3fgjNphlk8CLgdYnm42hP/Uh9zAQZ5m6eIY0xnz+sjrMVAZq4rJ1IOIHHYCTOqYTqkKC0e9q1sYJM1SJcLCt4H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 22:40:10.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c002138-abcd-4c68-5db6-08de879acf30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305

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

As the reset routine is per gdev, it cannot clear group->resetting_domain
without iterating over the device list to ensure no other device is being
reset. Simplify this by replacing the resetting_domain with a 'reset_cnt'
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
 v3:
  * Turn prepare()/done() to be per-gdev
  * Use reset_depth to track nested re-entries
  * Replace group->resetting_domain with a reset_cnt
 v2:
  https://lore.kernel.org/all/20260319043135.1153534-1-nicolinc@nvidia.com/
  * Fix in the helpers by allowing re-entry
 v1:
 https://lore.kernel.org/all/20260318220028.1146905-1-nicolinc@nvidia.com/

 drivers/iommu/iommu.c | 124 ++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db517809540..b11836dd56dd5 100644
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
+	 * During a group device reset, @group is attached to @blocking_domain,
+	 * while its @domain points to the attached domain before the reset.
+	 */
+	unsigned int reset_cnt;
 	void *owner;
 };
 
@@ -76,12 +76,27 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
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
@@ -2191,6 +2206,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
+	struct group_device *gdev;
+
 	/*
 	 * This is called on the dma mapping fast path so avoid locking. This is
 	 * racy, but we have an expectation that the driver will setup its DMAs
@@ -2201,6 +2218,9 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 	guard(mutex)(&dev->iommu_group->mutex);
 
+	gdev = __dev_to_gdev(dev);
+	if (WARN_ON(!gdev))
+		return -ENODEV;
 	/*
 	 * This is a concurrent attach during a device reset. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
@@ -2208,7 +2228,7 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	 * Note that this might fail the iommu_dma_map(). But there's nothing
 	 * more we can do here.
 	 */
-	if (dev->iommu_group->resetting_domain)
+	if (gdev->reset_depth)
 		return -EBUSY;
 	return __iommu_attach_device(domain, dev, NULL);
 }
@@ -2265,19 +2285,23 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
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
+	if (gdev->reset_depth)
+		return group->blocking_domain;
 
 	return group->domain;
 }
@@ -2436,10 +2460,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 		return -EINVAL;
 
 	/*
-	 * This is a concurrent attach during a device reset. Reject it until
+	 * This is a concurrent attach during device reset(s). Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
-	if (group->resetting_domain)
+	if (group->reset_cnt)
 		return -EBUSY;
 
 	/*
@@ -3567,10 +3591,10 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	mutex_lock(&group->mutex);
 
 	/*
-	 * This is a concurrent attach during a device reset. Reject it until
+	 * This is a concurrent attach during device reset(s). Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
-	if (group->resetting_domain) {
+	if (group->reset_cnt) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
@@ -3660,10 +3684,10 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	mutex_lock(&group->mutex);
 
 	/*
-	 * This is a concurrent attach during a device reset. Reject it until
+	 * This is a concurrent attach during device reset(s). Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
-	if (group->resetting_domain) {
+	if (group->reset_cnt) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
@@ -3934,12 +3958,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
  * routine wants to block any IOMMU activity: translation and ATS invalidation.
  *
  * This function attaches the device's RID/PASID(s) the group->blocking_domain,
- * setting the group->resetting_domain. This allows the IOMMU driver pausing any
+ * incrementing the group->reset_cnt. This allows the IOMMU driver pausing any
  * IOMMU activity while leaving the group->domain pointer intact. Later when the
  * reset is finished, pci_dev_reset_iommu_done() can restore everything.
  *
  * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
- * before/after the core-level reset routine, to unset the resetting_domain.
+ * before/after the core-level reset routine, to decrement the reset_cnt.
  *
  * Return: 0 on success or negative error code if the preparation failed.
  *
@@ -3952,6 +3976,7 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 	int ret;
@@ -3961,20 +3986,23 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
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
 
 	/*
@@ -3987,7 +4015,11 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 		iommu_remove_dev_pasid(&pdev->dev, pasid,
 				       pasid_array_entry_to_domain(entry));
 
-	group->resetting_domain = group->blocking_domain;
+	group->reset_cnt++;
+	return ret;
+
+err_depth:
+	gdev->reset_depth--;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
@@ -3997,9 +4029,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
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
@@ -4009,6 +4041,7 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 
@@ -4017,11 +4050,26 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
 	guard(mutex)(&group->mutex);
 
-	/* pci_dev_reset_iommu_prepare() was bypassed for the device */
-	if (!group->resetting_domain)
+	gdev = __dev_to_gdev(&pdev->dev);
+	if (WARN_ON(!gdev))
 		return;
 
-	/* pci_dev_reset_iommu_prepare() was not successfully called */
+	/* Unbalanced done() calls would underflow the counter */
+	if (WARN_ON(gdev->reset_depth == 0))
+		return;
+	/*
+	 * Do not decrement reset_depth=1 because other functions can still rely
+	 * on it, e.g. iommu_driver_get_domain_for_dev().
+	 */
+	if (gdev->reset_depth > 1) {
+		gdev->reset_depth--;
+		return;
+	}
+
+	/*
+	 * Leave the counters intact to keep the core state aligned with the HW
+	 * state. iommu_driver_get_domain_for_dev() still picks blocking_domain.
+	 */
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
@@ -4037,12 +4085,20 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
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
+	if (!WARN_ON(group->reset_cnt == 0))
+		group->reset_cnt--;
+	gdev->reset_depth = 0;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
-- 
2.43.0

