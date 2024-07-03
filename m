Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BE155335
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001939; cv=none; b=H90xKE/olIN8W5efryFk/KRz3ycb1+FHE8t5KvfvKtQDF2WhVVsKXOnDoUg+0iVaXp04JnGlsWoEf9oaOa1wnN6nmrElsolvsBKSJmY4BbnW3O5B/KmmhDMVdnWq9o/XVuTiGlG+Y1m0ToKTdcPssfia/tbjIAeYyVeQCZojdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001939; c=relaxed/simple;
	bh=33zXYzUXFLkDhF3XLIVc1c6AXB9malk16INLUMr++eo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HymHB42Be4+Vc0z+/Pr9OizILibcaO3hVuXlTsHErZKRJCJjIQgZ/4ZC3AGg6OqEgXxOjf4CQHWcScfJaXqia6pNltgwcptzBLWiEenJwVX5YF/Kt0mP8eFuM8hj1NahZgfjoGH8ETE+6CNGknUrkico0qfJb0zJP3xtd71rDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WDbMX27S9z6JB0N;
	Wed,  3 Jul 2024 18:18:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 84953140A46;
	Wed,  3 Jul 2024 18:18:54 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 11:18:45 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<ryan.roberts@arm.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v7 4/5] iommu/arm-smmu-v3: Add support for dirty tracking in domain alloc
Date: Wed, 3 Jul 2024 11:16:03 +0100
Message-ID: <20240703101604.2576-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
References: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 84 +++++++++++++++------
 drivers/iommu/iommufd/hw_pagetable.c        |  3 +
 include/linux/io-pgtable.h                  |  3 +
 3 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6b35954940b8..c1e32a2ea3f8 100644
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
@@ -2282,7 +2284,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 		int ret;
 
-		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
+		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, 0);
 		if (ret) {
 			kfree(smmu_domain);
 			return ERR_PTR(ret);
@@ -2346,15 +2348,15 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
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
@@ -2362,17 +2364,31 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
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
@@ -2380,15 +2396,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
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
@@ -2396,6 +2403,8 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	smmu_domain->domain.geometry.force_aperture = true;
+	if (enable_dirty && smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		smmu_domain->domain.dirty_ops = &arm_smmu_dirty_ops;
 
 	ret = finalise_stage_fn(smmu, smmu_domain);
 	if (ret < 0) {
@@ -2745,7 +2754,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
-		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
+		ret = arm_smmu_domain_finalise(smmu_domain, smmu, 0);
 	} else if (smmu_domain->smmu != smmu)
 		ret = -EINVAL;
 
@@ -2810,7 +2819,7 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (!smmu_domain->smmu)
-		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
+		ret = arm_smmu_domain_finalise(smmu_domain, smmu, 0);
 	else if (smmu_domain->smmu != smmu)
 		ret = -EINVAL;
 	mutex_unlock(&smmu_domain->init_mutex);
@@ -3028,10 +3037,13 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
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
 		return ERR_PTR(-EOPNOTSUPP);
 
 	smmu_domain = arm_smmu_domain_alloc();
@@ -3040,7 +3052,7 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 
 	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
-	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
+	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, flags);
 	if (ret)
 		goto err_free;
 	return &smmu_domain->domain;
@@ -3295,6 +3307,27 @@ static void arm_smmu_release_device(struct device *dev)
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
@@ -3453,6 +3486,11 @@ static struct iommu_ops arm_smmu_ops = {
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
index 86cf1f7ae389..f9a81761bfce 100644
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
@@ -92,6 +94,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT	BIT(4)
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
 	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
+	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.34.1

