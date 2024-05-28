Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFD4F201
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880842; cv=none; b=Cvlw0uCADe1A29CZkye1gUa8mlq0gaOrLrYIwm0DhbBf4gHa5rF6Hj6qmkDAeWXH5/jBNopPFK5SQ01zzeM4xUlo1KH3LMLuGG4gtyz4ug8InivKDafv7+6toTxJkzv8u2b55eL+KLZipe8/maPS6POp5rSY88prAEiDoSovMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880842; c=relaxed/simple;
	bh=f0N8rAlX9/7QidEqOE7uhg0tCToxFa1d18KZnOQWuP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6jQP0Q0iuqKDKx1doHkGnUAZ27iJr1rcGQjA3u3neSmfq9esfuJExV8ZiDG1n/LoVDLCyy7kVr2uzhQ1FMidtXrv3P7mjdjj/KKoVmvrjSr4//HJ436C78dQTXV+X3+6BkCavIR/lP6R+l/XhwsPnH/L2Gb9k47STnibKGoNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VpP2f1Knpz6JB6q;
	Tue, 28 May 2024 15:16:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B6A49140A87;
	Tue, 28 May 2024 15:20:37 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.126.170.13) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 08:20:28 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <eric.auger@redhat.com>,
	<joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 6/7] iommu/arm-smmu-v3: Add support for dirty tracking in domain alloc
Date: Tue, 28 May 2024 08:18:30 +0100
Message-ID: <20240528071831.17560-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240528071831.17560-1-shameerali.kolothum.thodi@huawei.com>
References: <20240528071831.17560-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Joao Martins <joao.m.martins@oracle.com>

This provides all the infrastructure to enable dirty tracking if the
hardware has the capability and domain alloc request for it.

Also, add a device_iommu_capable() check in iommufd core for
IOMMU_CAP_DIRTY_TRACKING before we request a user domain with dirty
tracking support.

Please note, we still report no support for IOMMU_CAP_DIRTY_TRACKING
as it will finally be enabled in a subsequent patch.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++++++++------
 drivers/iommu/iommufd/hw_pagetable.c        |  3 +
 include/linux/io-pgtable.h                  |  4 +
 3 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 392e7e3601ea..b91c995cf9ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -27,6 +27,7 @@
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 #include <kunit/visibility.h>
+#include <uapi/linux/iommufd.h>
 
 #include "arm-smmu-v3.h"
 #include "../../dma-iommu.h"
@@ -37,6 +38,7 @@ MODULE_PARM_DESC(disable_msipolling,
 	"Disable MSI-based polling for CMD_SYNC completion.");
 
 static struct iommu_ops arm_smmu_ops;
+static struct iommu_dirty_ops arm_smmu_dirty_ops;
 
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
@@ -82,7 +84,7 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 };
 
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
-				    struct arm_smmu_device *smmu);
+				    struct arm_smmu_device *smmu, u32 flags);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -2272,7 +2274,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 		int ret;
 
-		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
+		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, 0);
 		if (ret) {
 			kfree(smmu_domain);
 			return ERR_PTR(ret);
@@ -2338,15 +2340,15 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
 }
 
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
-				    struct arm_smmu_device *smmu)
+				    struct arm_smmu_device *smmu, u32 flags)
 {
 	int ret;
-	unsigned long ias, oas;
 	enum io_pgtable_fmt fmt;
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_device *smmu,
 				 struct arm_smmu_domain *smmu_domain);
+	bool enable_dirty = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 
 	/* Restrict the stage to what we can actually support */
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
@@ -2354,17 +2356,31 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
+	pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= smmu->pgsize_bitmap,
+		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
+		.tlb		= &arm_smmu_flush_ops,
+		.iommu_dev	= smmu->dev,
+	};
+
 	switch (smmu_domain->stage) {
-	case ARM_SMMU_DOMAIN_S1:
-		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
-		ias = min_t(unsigned long, ias, VA_BITS);
-		oas = smmu->ias;
+	case ARM_SMMU_DOMAIN_S1: {
+		unsigned long ias = (smmu->features &
+				     ARM_SMMU_FEAT_VAX) ? 52 : 48;
+
+		pgtbl_cfg.ias = min_t(unsigned long, ias, VA_BITS);
+		pgtbl_cfg.oas = smmu->ias;
+		if (enable_dirty)
+			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
 		fmt = ARM_64_LPAE_S1;
 		finalise_stage_fn = arm_smmu_domain_finalise_s1;
 		break;
+	}
 	case ARM_SMMU_DOMAIN_S2:
-		ias = smmu->ias;
-		oas = smmu->oas;
+		if (enable_dirty)
+			return -EOPNOTSUPP;
+		pgtbl_cfg.ias = smmu->ias;
+		pgtbl_cfg.oas = smmu->oas;
 		fmt = ARM_64_LPAE_S2;
 		finalise_stage_fn = arm_smmu_domain_finalise_s2;
 		break;
@@ -2372,15 +2388,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 		return -EINVAL;
 	}
 
-	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= smmu->pgsize_bitmap,
-		.ias		= ias,
-		.oas		= oas,
-		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
-		.tlb		= &arm_smmu_flush_ops,
-		.iommu_dev	= smmu->dev,
-	};
-
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
@@ -2388,6 +2395,8 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	smmu_domain->domain.geometry.force_aperture = true;
+	if (enable_dirty && smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		smmu_domain->domain.dirty_ops = &arm_smmu_dirty_ops;
 
 	ret = finalise_stage_fn(smmu, smmu_domain);
 	if (ret < 0) {
@@ -2592,7 +2601,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
-		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
+		ret = arm_smmu_domain_finalise(smmu_domain, smmu, 0);
 	} else if (smmu_domain->smmu != smmu)
 		ret = -EINVAL;
 
@@ -2723,10 +2732,13 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 			   const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct arm_smmu_domain *smmu_domain;
 	int ret;
 
-	if (flags || parent || user_data)
+	if (flags & ~PAGING_FLAGS)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (parent || user_data)
 		return ERR_PTR(-EINVAL);
 
 	smmu_domain = arm_smmu_domain_alloc();
@@ -2735,7 +2747,7 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 
 	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
-	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
+	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, flags);
 	if (ret)
 		goto err_free;
 	return &smmu_domain->domain;
@@ -2992,6 +3004,27 @@ static void arm_smmu_release_device(struct device *dev)
 	kfree(master);
 }
 
+static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
+					 unsigned long iova, size_t size,
+					 unsigned long flags,
+					 struct iommu_dirty_bitmap *dirty)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+
+	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
+}
+
+static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
+				       bool enabled)
+{
+	/*
+	 * Always enabled and the dirty bitmap is cleared prior to
+	 * set_dirty_tracking().
+	 */
+	return 0;
+}
+
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
 	struct iommu_group *group;
@@ -3155,6 +3188,11 @@ static struct iommu_ops arm_smmu_ops = {
 	}
 };
 
+static struct iommu_dirty_ops arm_smmu_dirty_ops = {
+	.read_and_clear_dirty	= arm_smmu_read_and_clear_dirty,
+	.set_dirty_tracking     = arm_smmu_set_dirty_tracking,
+};
+
 /* Probing and initialisation functions */
 static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 				   struct arm_smmu_queue *q,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 33d142f8057d..6d5b2fffeea0 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -114,6 +114,9 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		return ERR_PTR(-EOPNOTSUPP);
 	if (flags & ~valid_flags)
 		return ERR_PTR(-EOPNOTSUPP);
+	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
+	    !device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
+		return ERR_PTR(-EOPNOTSUPP);
 
 	hwpt_paging = __iommufd_object_alloc(
 		ictx, hwpt_paging, IOMMUFD_OBJ_HWPT_PAGING, common.obj);
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86cf1f7ae389..8e75f944f07a 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -85,6 +85,8 @@ struct io_pgtable_cfg {
 	 *
 	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the outer-cacheability
 	 *	attributes set in the TCR for a non-coherent page-table walker.
+	 *
+	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
@@ -92,6 +94,8 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT	BIT(4)
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
 	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
+	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
+
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.34.1

