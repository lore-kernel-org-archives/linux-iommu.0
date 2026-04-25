Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327F1F3B8A
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079765; cv=fail; b=HODURhol+WLiggfHbaWThtj9forGeryeeCsqDwbktMBwCHIdVMvu4KYPrHGEN+sgCSGO0cJ5Rp0mPcfQAQc6Ezt5NXIvpMJhTJdtP1QhEdk6v0LVMIiNy2q90GVf80x1IBiAWBPGPDD+J/SDAQtlf2/YXVOwh0QYd9Qqq9JCloU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079765; c=relaxed/simple;
	bh=NFYNyntI3XX98NrNPz/8vRwuAeAM1CZcnix6w7C74J0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EF1g1kM1GYMRqOZGJDxGKQ1JmHJguXMfBgVEiAmf/W6jK69CIhKvtOXXcUOqUYu9XdlubXIqJuKCv5T2ZLJkwn+58Lxf6TkDcZeEL9e0BSWlNMx33AAtf7WHb22Cvk38HrKs1R03c4a6dfoMQYxkXOUMHhlvZbJ1kNQWPpR9jMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O8pqXJLv; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O8pqXJLv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAdmu66+A8LGVwOPq0tJCKLTyLN6AJhULA8xW/grNLTSmK0xTQXifOnMBxa09tDUJVEHpyLzhdLPbcGWKO9kJbHIxSPm3fIoTRtx+vihnwk7hiqnqs8AyaD4sKiyFXVLWq7rJe4xfYI04pbu3IKqRqGghFy+mD6eOdBFkoDDWRRU6rPjANpivb8dLQmMhpMCDRLeaELbk9YStyjs18QDahltKVMRIukxFfP0VaGq/PiNRDLqbSEcCb74mYk0Fv1lscYR0KUKH/MFCBUMbfLmoE80a+j2q4clFN/sMoJTiovEhaUqNBfbRH6nR6bDj2cerQW0ZsOVbL+cKO9OFAKB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDLzoTilpUgwVHEwu3Qi3SOflwdIfLAiRjiKNU0rq/k=;
 b=cs2a5yOOF0uWMr+dhk+uK2a22SmiDbRrY/N0FWRbTXYPX3wcxyd0ajcwGtPUXPGQVeZmRG9vFuxmJ3T89hSyG2a7WFtonjWxoTO+9rUUTDSBH4ZsoIYuNKPJA2zCQ59SVT5+YcpUl2vbv/qs4LeDzsWE/gPjpB+z6F1tC9L+qyOMWea+oq7lA4/2iJPpIQxSmZPzYA3+ELdASddsuxcTehgaXl1ftMhzQFSUfPbulQIeBl8Ny2n82GrKWnIDaDM3j6TzISG07RA3nE2brbhvdXzr3rOBGyfQRm23LG808dfrzjtvFm/9dBDRZt2BWPPGDI0dAYqkIucvZ5WHWWWQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDLzoTilpUgwVHEwu3Qi3SOflwdIfLAiRjiKNU0rq/k=;
 b=O8pqXJLvO/bNfT9DXcP1Kq0zhDKVAfyVcFrqBjohPXVzRsaUK/VRa+E84lkHGyNw8Hlee+1JbYGtdLr1VPLmHr2H09yWTF1CU0gGlG0G/dbYvhUfhHpbpaLjU5JxgtH2dQMoeFiDsKzMc0JOvdElMlBUHY3RGQ3MgbrR8lyGI6QgjUJpHJuZUvN2Io63wv2SsCl1xVvvNkqYI7hDI33bBkUtFjl1gFAiCkzaTNliKCqqBhsIwTXtCgW01UpyV6fUjvbJqHbnyj6poNdfYRsCET/5e+TJVe3dEvmHG2XO7PYyLaxACZvxiY8/cg/d67rKa9OOFCITjSfcjUr8M7HYxA==
Received: from CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::27)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 01:15:54 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::3e) by CH5P222CA0006.outlook.office365.com
 (2603:10b6:610:1ee::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 01:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 01:15:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 3/8] iommu: Replace per-group resetting_domain with per-gdev blocked flag
Date: Fri, 24 Apr 2026 18:15:22 -0700
Message-ID: <a18db385f149242ae2f654b4ae243115bcdaa75c.1777074513.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777074513.git.nicolinc@nvidia.com>
References: <cover.1777074513.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f1955d-3d15-4b4c-fcf4-08dea268327b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|18002099003|22082099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	RV1hPiKFXEFVZN0PGQFkZEeCRZZ8zshF/dLxHJYCWtEW0uLM7nG9j0p3qoqG0gp+5Ki27xJUybp3h++sjPoi/zt7j95zVhUSuGuCU4OGqUEmOMqULE+CZF4BRXTcIY5LddPjH+inMatIitRb8sSGKRsisKNL4HJNaPoXUTFUTgrZVkstqGYOUNd/cWK3fqFEYbK9gbDYh9+3nmjiHGUqQjD70pDvIzk3td66l5E2ljEFRjpkM/0rusUlDIwtwiGkyTdn3W6Pae7sz9rgFtnNB1uoMNNCf5HU/oJBaRl/XrpOYGNiYTTwWkXUvHJ84BCV2otvzq/2ym2zdPKgraCe6j8DfAmr+LtZCTrV6U4SB4kgQ8Cr/H/GpYDTsuvj9FncxATgz7ek95hLcMho7AcBlYy5X9vVJYA+LeUBFIwsDzex132FK7xSNZhEUokWNmAKQ80ixgiEhyJtYrYLXbPpowuc24Cci0bbVSLvqOjpET7e/mxoaBBwVjStGBlaYzNCFgaYB1G+zHQGclCKw3yKo2pnQzm/TyLToXIBr6KJuXA019I5d0WjkTr19j3RaRDXzYuHb8DNAh0cqSZCJyEVd80WnflmSfBhDoJG3pYXBII+CbrryWooGifzVTlMFuRkBNZLlgVGpxAfLAYloAM2Wh5x4mQMk1HG8F9c1BeGLLRHEfQCH33XW8MF4u4B/6vnREFRvRKE/k139NUIr42IcXYFf3syhJkiVVgAJLtXwAuBBw3QmxNBzrEQGggA7v8Vr1vlWO5Jc6KBZEXXQnqg2A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(22082099003)(56012099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N+dCIub4sYZNLLOEUiFSwTQ8Eb7b3MgWq82+/VCLs2Z3k7RWT4zZQ6SGa/kEBos3XkzNB+y1qlmT7gA/w97E2FTlal6j2YRGp6eIK7hckqqeZs4Ptkz5DEDOAW82O9K+pOhzVE0WyUnRnfqWfUdV1E2BM+rC6wgEi8kyY4GQi3nGKoSWQBNe45pA3mSSj0lpnyIDLSjpzL4eib3lBXqO9cmhcOXn3U5dhT8JzwKTYcso3WVee5OsTz9nJZBUJ1/IB9raO1ASEbyWWd91p0CiwMIYXEX8puaKa+AzHS/f/Qxy1R/MdBVFItcXYpejSnP2JJmkFXAz3tb9I4EbDdj6AzbDZKXYQXCI6ripj6R8utZ7IO4FXKMglSVoHDodg0Z8ps5ActBaBknMIO8JdFmXWwGkXPZBUrgM/+gO2hTaCK0AtOFAsJlqLGpV7W2SeKHA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:53.8853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f1955d-3d15-4b4c-fcf4-08dea268327b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

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
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 102 ++++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 82dd806e5e6a6..5b784e43ca592 100644
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
 
+	gdev = __dev_to_gdev(&pdev->dev);
+	if (WARN_ON(!gdev))
+		return -ENODEV;
+
 	/* Re-entry is not allowed */
-	if (WARN_ON(group->resetting_domain))
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
 
@@ -4036,6 +4082,13 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
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
@@ -4047,7 +4100,8 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 			pasid_array_entry_to_domain(entry), group, pasid,
 			group->blocking_domain));
 
-	group->resetting_domain = NULL;
+	if (!WARN_ON(group->recovery_cnt == 0))
+		group->recovery_cnt--;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
-- 
2.43.0

