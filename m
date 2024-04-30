Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08C171E64
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484727; cv=none; b=adbhIlChScJ0sddWlXfUVIO3ec7XMxO9PpyZeGh0CLZS2S8DiFMDdH4lwVcAWADMhA0IJK6BSl0e6LZgH7j9an7KVtdwrOWauz3qocPKWmDkd0wQiTgI8P5RQQLRqNDkYvpTtIj7vBYJkmF84yfR+2AEI5u4RS9wcilKjt+mK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484727; c=relaxed/simple;
	bh=EMhcd1QknnvmbVpoUb+faPHdKH9a/kCkVl+TgqkXF9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ1/bkFxNVU5X7XhGoCcgpLjypOd2uynt44W+a7LtmJlWHuLjVoyi21omtk+Ui10naLZTRXGAf4y9HdB9kxX7N6lbfLxsgk4SzhJ3MsqSeu8pSKUlNkpvvRF9CcUYqa+E6HlQK1yG44xdJCCGHqcVBr/1R8sp+ZZIjYZFgMp7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTLwz2G97z6J7DX;
	Tue, 30 Apr 2024 21:42:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 06475140A86;
	Tue, 30 Apr 2024 21:45:24 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.126.175.159) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 14:45:14 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <eric.auger@redhat.com>,
	<joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty() support
Date: Tue, 30 Apr 2024 14:43:06 +0100
Message-ID: <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

.read_and_clear_dirty() IOMMU domain op takes care of reading the dirty
bits (i.e. PTE has DBM set and AP[2] clear) and marshalling into a
bitmap of a given page size.

While reading the dirty bits we also set the PTE AP[2] bit to mark it
as writable-clean depending on read_and_clear_dirty() flags.

PTE states with respect to DBM bit:

                       DBM bit        AP[2]("RDONLY" bit)
1. writable_clean        1                 1
2. writable_dirty        1                 0
3. read-only             0                 1

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 105 ++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f7828a7aad41..da6cc52859ba 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -75,6 +75,7 @@
 
 #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
 #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
+#define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
 #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
 #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
 #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
@@ -84,7 +85,7 @@
 
 #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
 /* Ignore the contiguous bit for block splitting */
-#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)6) << 52)
+#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
 #define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
 					 ARM_LPAE_PTE_ATTR_HI_MASK)
 /* Software bit for solving coherency races */
@@ -92,7 +93,11 @@
 
 /* Stage-1 PTE */
 #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
-#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
+#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
+#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)1) << \
+					   ARM_LPAE_PTE_AP_RDONLY_BIT)
+#define ARM_LPAE_PTE_AP_WRITABLE_CLEAN	(ARM_LPAE_PTE_AP_RDONLY | \
+					 ARM_LPAE_PTE_DBM)
 #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
 #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
 
@@ -138,6 +143,9 @@
 
 #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
 
+#define iopte_hw_dirty(pte)	(((pte) & ARM_LPAE_PTE_AP_WRITABLE_CLEAN) == \
+				   ARM_LPAE_PTE_DBM)
+
 struct arm_lpae_io_pgtable {
 	struct io_pgtable	iop;
 
@@ -729,6 +737,98 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
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
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	if (iopte_leaf(pte, lvl, iop->fmt)) {
+		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+		if (iopte_hw_dirty(pte)) {
+			iommu_dirty_bitmap_record(walk_data->dirty,
+						  walk_data->addr, size);
+			if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
+				set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT,
+					(unsigned long *)ptep);
+		}
+		walk_data->addr += size;
+		return 0;
+	}
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
@@ -807,6 +907,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 	};
 
 	return data;
-- 
2.34.1

