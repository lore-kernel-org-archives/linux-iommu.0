Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA8376490
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316481; cv=fail; b=OiUOcfobfXEOVjjWqH8dkdMfB9NOcszZT5+DuJtzo0s7JClKs4uV4KuBNBvvB33gLf7+Zw0CJj1eVo3hA6qS6n4uFt+XVoiIhH2Wjhm0M9yoCABgT4F05eP3jIgNXmKAcdEmxL1gCZizUHz4/1/cce+zD9YnlXOhb8KaeoxeJ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316481; c=relaxed/simple;
	bh=evPjTnc4xOhr6wVGS+O8iJdl9cnSgUWim3LMdThcB2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=chEJgC1XOmossrpMPp3JTgenDnoPRKkxIAVDc63bhXyHVHBJAmdWV3xugA61aLbHLvtm2HAwky8TvByEKLtaqjzQXT8q/Zr/RiN+cCX5MMwoxFla77iinOAm61r6c0rsJUplEmbO0sZKGgtdDR6LejEW0bQtjvdXNk5n8gsVUM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=diUdDlld; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="diUdDlld"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw0IHj3VnhTr9EL4piim4JWyerUEIS0H95MX7Bs+Np+TGM6q5VGt4jPu07ko3OdXiLzglwrrEFVOUOfCOcSVxFNuM5xcHmHaUK03d0muVPVmgqrx1ujXBrqLAhQ2aykOtf26kJRYFr42roW96/YSPGNRUFBjA+4ug7fYoiWrjZ4S/ph4ApL/vNVc+3Rez6oyBySQhMQsLMN6wL0eSPyWE4jvYOpWU3PIXc7N0FsEHnWBLQs5j3jPqj0XFQFUARPvaC7KDRBymndDAauN6RH9qapdr/jl6LPBpwCKV6EQB/NExO6klQXqv0/mXaV/G4Hv20FbPzeapr/XSVN2QWQkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT9TsVcK1ms5uoI6Mbq4FO0ywB0h7Kn4nnjFNjRsPBI=;
 b=UyWQM93MsBj66fhEEBKhid2i7Xin3eVfmHXYdaa31fSC88E3nY8tOL46/a+RFxGTqdnPFYgkybDybdbsk0EIl12bHHUFetmsqCG5L00RMXYjr934ZjoirAThA19uI58YSjG1JMroh53EFIK1cSuy94PXr3bpa73KT76yLVlVqleVgK5EYCslyMgNep2FTIeNKDqX5yyH24hXNKnHejdBCZMR1oEN7XAsnA+lkvxnbG15ecK4CjHeoodq/hgpDBlPR1MaeYBnRiEgP0ddHiYnbccIwjjAamg1B/cmf6QKvX64UTXPQTbxPWjY/OaC+/K9BtEJWSNh/LVXzZ7wtUtMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT9TsVcK1ms5uoI6Mbq4FO0ywB0h7Kn4nnjFNjRsPBI=;
 b=diUdDlldUzdHDilLngksFlx1luXZ2HI2kIIa4QIYn8FiWKa9PZV5vSsr79gJc4jGzIDQaocIM9UJYuLoUr4YvF72UWMFsuUD4gDZ00Lj4lGjNYwUKVFotbFC9GRHiXgoAezMBzRqSSwYZg7kx7kvx3lX03NoDYvt5zlBbUX+Jq14ngRL7lJ8tYVaGxxRG9IfL4u0iyc+CxatOLqq0N7B6YCAqRM8zLiYJQGJzha1gCnIhEy4bpRVMhqLhyNm9Ej0a7v9otaW8RKatGzMDsT72a8c2yE9PU4fUysv7GL6rW+efTwNtXeCmECcRMh1uXomGYv+ZU1p9C+QOotVjFnVDg==
Received: from SA0PR11CA0178.namprd11.prod.outlook.com (2603:10b6:806:1bb::33)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:41:10 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::ad) by SA0PR11CA0178.outlook.office365.com
 (2603:10b6:806:1bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:41:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:41:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 18:41:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 18:41:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<jgg@nvidia.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v4] iommu: Fix nested pci_dev_reset_iommu_prepare/done()
Date: Mon, 23 Mar 2026 18:40:56 -0700
Message-ID: <20260324014056.36103-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: f447c0c6-98e8-4888-97ce-08de89466d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HCc5YPUEqHKT/9nK81ko43zCdvsm//VAvjmBsETqAmnfp6JkzPPZdZDOCEDySoVfYTEk9+dQoXZpx2ttIoEqwaPecfUmVKHXXwqEqCwRSRBF2kMsvdVSRkRAu6hBg0xbv7EA9GFRImWEkT9XBIC20Zhf9bncigRcg95kCtRJGN4W8z0qxiyui7uMXd5IuH2Dc6ye2UhRCMKn5rXTVDFFohP/KTDzzf82HKryaujvKTPCK9CCBoYSvd0vePdbhR+C6ZOKpSMVKCXxMfcxrUXWdJJUbx0eif+7+G3CbNBQneakaw58V51OefemRIJ3xxPTrYm7jrSg0BSdXv9F5xeP8mzRycX/V4zrnJtIuYoS7LgC/fxUKf67AqNU6WQXPiDiNjTd/W3Y+h1s67lOMATE/LgUli9O6LX920yltIAuIIR89HEua2Ngxy9VwyUKxnjB2J5Y82LefjFaC/dB/kDpl2kuP6/NuUb6R/Kz9NmA5pG7r5FpNLlvGcdsCfy07hTFue9qCys5jkDoCcwqm5zpO31zAqBp01Dfx0OCkm7YsqBQsrzmbV1N28uxj7zqTqopsTu3ys/knkBW2RS5Nw8kLyIo2o2Rnki6UZj+hWl71Vp3aZDjZPQKHOL2N+5pybb2PWax1i124R4NpL/GJnYpQHJE3dbRjhJ74e7H8UOOUo5c23JmOWhcHQtdXhd5cZDiNKA1ThfXvLodYmQDiiPsQq+P8xcCzQF4RifqUCaQn1suYmDiGYDnA6nQqgMrzjnrUyGdt/3YY5viF4gACq0ACg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mu/EP3o9iKSeYkPtjObF6eyPsGsTL9Gan5XPhCsootRGZkrUP9/JuRk+BvLAAdXPPLVaZT6qWlcZvoXlGWEmMMm2HdCPipf/jhZCQZX+7dOY8FzfWBFEaUgGMHzz+lYVduo+nh30zbEH4TlyN0QFvomjJB8PuEspXXvMoVQso9K7nGHQvfmw5KN+Ql+AJU/Mel+se30kM//0oWBgZsAqx56TLaC2t6OnQr89mDqPta/zVlwG3cHUzkZ4TOR1zU5VGV37WJRo9FnLDmFoR2ft0z2KP0mcLNBb45R/+QGtH57QI/gjBEXLByCSufsk0Eei3xy1av5nrPULHlzriFomOGFlO54CwixYxfsa6BznaXvuayNxliDPJAmnyOHLkld7cmOlYsxaaVqjaO7UouZvHyOpeB9eTzSDIneaRKVpPnoHN78+YgyK6cF257GN6mTl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:41:10.3767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f447c0c6-98e8-4888-97ce-08de89466d1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843

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
 v4:
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

 drivers/iommu/iommu.c | 125 ++++++++++++++++++++++++++++++------------
 1 file changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db517809540..fbaf4fdd570a7 100644
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
+	 * This is a concurrent attach during device recovery. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
-	if (group->resetting_domain)
+	if (group->recovery_cnt)
 		return -EBUSY;
 
 	/*
@@ -3567,10 +3591,10 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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
@@ -3660,10 +3684,10 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
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
@@ -3934,12 +3958,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
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
+	group->recovery_cnt++;
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
 
@@ -4017,11 +4050,27 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
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
+	 * This is an unrecoverable state - the device remains blocked.
+	 */
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
@@ -4037,12 +4086,20 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
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
+	gdev->reset_depth = 0;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
-- 
2.43.0

