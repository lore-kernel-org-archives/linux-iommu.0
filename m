Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB3195F10
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680893; cv=none; b=C/GKbFIMTvwyXtt5vx0m46C6t9AMTignhSQVQA9PnBQ+EEoeGExH115WESvE+fb8Qdk5XpOV8HHHwaPCnFPWYi4vRS4JqyDFbxsyCPMJvmI3z9rvSOGFMwgCZyjNAO++p4s3nusk7h4Cs0WgqX/78QKndzBpJsLPoljOweYhV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680893; c=relaxed/simple;
	bh=3OH5Uze+xxXLhMg/11++dpeEyErYMwmV71IKyOyRLa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XS4vrlkSNyIr2Yn9gkT4ghzPATH0uUvhHGjhkEX0FbWcEfeFKZBpaklMgPvy6EpO4fYKQsDVrI0hsTYpwMo1i7cb5ArUNRZYeuMk43Lx23ur0EGgw41zdxev7bQ0PPGSGk4NQl4U6a7A5sFQry3JQFA028z/YzoJPajmCPm39Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw4vm0dt0z6HJbL;
	Thu,  6 Jun 2024 21:30:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 680541400E7;
	Thu,  6 Jun 2024 21:34:49 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 14:34:40 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <eric.auger@redhat.com>,
	<joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v5 4/6] iommu/io-pgtable-arm: Add read_and_clear_dirty() support
Date: Thu, 6 Jun 2024 14:33:00 +0100
Message-ID: <20240606133302.17540-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

.read_and_clear_dirty() IOMMU domain op takes care of reading the dirty
bits (i.e. PTE has DBM set and AP[2] clear) and marshalling into a
bitmap of a given page size.

While reading the dirty bits we also set the PTE AP[2] bit to mark it
as writeable-clean depending on read_and_clear_dirty() flags.

PTE states with respect to DBM bit:

                       DBM bit        AP[2]("RDONLY" bit)
1. writable_clean        1                 1
2. writable_dirty        1                 0
3. read-only             0                 1

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 114 ++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 3d23b924cec1..2e57e8616387 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -76,6 +76,7 @@
 
 #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
 #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
+#define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
 #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
 #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
 #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
@@ -85,7 +86,7 @@
 
 #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
 /* Ignore the contiguous bit for block splitting */
-#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)6) << 52)
+#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
 #define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
 					 ARM_LPAE_PTE_ATTR_HI_MASK)
 /* Software bit for solving coherency races */
@@ -93,7 +94,11 @@
 
 /* Stage-1 PTE */
 #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
-#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
+#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
+#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)1) << \
+					   ARM_LPAE_PTE_AP_RDONLY_BIT)
+#define ARM_LPAE_PTE_AP_WR_CLEAN_MASK	(ARM_LPAE_PTE_AP_RDONLY | \
+					 ARM_LPAE_PTE_DBM)
 #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
 #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
 
@@ -139,6 +144,12 @@
 
 #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
 
+#define iopte_writeable_dirty(pte)				\
+	(((pte) & ARM_LPAE_PTE_AP_WR_CLEAN_MASK) == ARM_LPAE_PTE_DBM)
+
+#define iopte_set_writeable_clean(ptep)				\
+	set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT, (unsigned long *)(ptep))
+
 struct arm_lpae_io_pgtable {
 	struct io_pgtable	iop;
 
@@ -160,6 +171,13 @@ static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
 	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_BLOCK;
 }
 
+static inline bool iopte_table(arm_lpae_iopte pte, int lvl)
+{
+	if (lvl == (ARM_LPAE_MAX_LEVELS - 1))
+		return false;
+	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE;
+}
+
 static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 				     struct arm_lpae_io_pgtable *data)
 {
@@ -726,6 +744,97 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(pte, data) | iova;
 }
 
+struct io_pgtable_walk_data {
+	struct iommu_dirty_bitmap	*dirty;
+	unsigned long			flags;
+	u64				addr;
+	const u64			end;
+};
+
+static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
+				       struct io_pgtable_walk_data *walk_data,
+				       arm_lpae_iopte *ptep,
+				       int lvl);
+
+static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
+				  struct io_pgtable_walk_data *walk_data,
+				  arm_lpae_iopte *ptep, int lvl)
+{
+	struct io_pgtable *iop = &data->iop;
+	arm_lpae_iopte pte = READ_ONCE(*ptep);
+
+	if (iopte_leaf(pte, lvl, iop->fmt)) {
+		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+		if (iopte_writeable_dirty(pte)) {
+			iommu_dirty_bitmap_record(walk_data->dirty,
+						  walk_data->addr, size);
+			if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
+				iopte_set_writeable_clean(ptep);
+		}
+		walk_data->addr += size;
+		return 0;
+	}
+
+	if (WARN_ON(!iopte_table(pte, lvl)))
+		return -EINVAL;
+
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_iopte_walk_dirty(data, walk_data, ptep, lvl + 1);
+}
+
+static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
+				       struct io_pgtable_walk_data *walk_data,
+				       arm_lpae_iopte *ptep,
+				       int lvl)
+{
+	u32 idx;
+	int max_entries, ret;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return -EINVAL;
+
+	if (lvl == data->start_level)
+		max_entries = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
+	else
+		max_entries = ARM_LPAE_PTES_PER_TABLE(data);
+
+	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
+	     (idx < max_entries) && (walk_data->addr < walk_data->end); ++idx) {
+		ret = io_pgtable_visit_dirty(data, walk_data, ptep + idx, lvl);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
+					 unsigned long iova, size_t size,
+					 unsigned long flags,
+					 struct iommu_dirty_bitmap *dirty)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	struct io_pgtable_walk_data walk_data = {
+		.dirty = dirty,
+		.flags = flags,
+		.addr = iova,
+		.end = iova + size,
+	};
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+
+	if (WARN_ON(!size))
+		return -EINVAL;
+	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
+		return -EINVAL;
+	if (data->iop.fmt != ARM_64_LPAE_S1)
+		return -EINVAL;
+
+	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -804,6 +913,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 	};
 
 	return data;
-- 
2.34.1

