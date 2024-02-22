Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9C6FD0
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595452; cv=none; b=k0y2RATp9BJPd2bmXKwNhyWt5X35F+ofZ3oWnLVcnUYJCpej/KXxy3VYNZiE9/Sa2VsqP2UnWt6d2NQC7CktavvwxkGymGHLmN7FNEbrb1Q/YpgFSxe97RYc9f27U93KdpPrsDMbkWvW64GS4bbj0915F71Amnw8pMr6+09++n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595452; c=relaxed/simple;
	bh=+iddYdMYp85LKBtr9tvGoRpDUs3JpUhUycr/v9aegLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeq5CFHzyU1PV1u3W6927U4z6cYBCcWRTTVWg55Ethh07gkiR9cZ28FnEvoVeQQD44yUhsTSfZ0jHPP5cfe7eD7g1wjn9HJDsOEQkFi7wczohIYFfHH8MbFKixv6YUWBuR84/xnzhOfRDES2ZYTh23AJNkIJzsxqVySToyiH/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TgSvj3tWvz6HJg1;
	Thu, 22 Feb 2024 17:46:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C4246141A74;
	Thu, 22 Feb 2024 17:50:47 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:50:41 +0000
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v2 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty() support
Date: Thu, 22 Feb 2024 09:49:21 +0000
Message-ID: <20240222094923.33104-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

.read_and_clear_dirty() IOMMU domain op takes care of reading the dirty
bits (i.e. PTE has both DBM and AP[2] set) and marshalling into a bitmap of
a given page size.

While reading the dirty bits we also clear the PTE AP[2] bit to mark it as
writable-clean depending on read_and_clear_dirty() flags.

Structure it in a way that the IOPTE walker is generic, and so we pass a
function pointer over what to do on a per-PTE basis.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 128 ++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f7828a7aad41..1ce7b7a3c1e8 100644
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
+#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)0xd) << 51)
 #define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
 					 ARM_LPAE_PTE_ATTR_HI_MASK)
 /* Software bit for solving coherency races */
@@ -93,6 +94,9 @@
 /* Stage-1 PTE */
 #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
 #define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
+#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
+#define ARM_LPAE_PTE_AP_WRITABLE	(ARM_LPAE_PTE_AP_RDONLY | \
+					 ARM_LPAE_PTE_DBM)
 #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
 #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
 
@@ -729,6 +733,127 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(pte, data) | iova;
 }
 
+struct arm_lpae_iopte_read_dirty {
+	unsigned long flags;
+	struct iommu_dirty_bitmap *dirty;
+};
+
+typedef int (*io_pgtable_visit_fn_t)(unsigned long iova, size_t size,
+				     arm_lpae_iopte *ptep, void *opaque);
+struct io_pgtable_walk_data {
+	const io_pgtable_visit_fn_t	fn;
+	void				*opaque;
+	u64				addr;
+	const u64			end;
+};
+
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 struct io_pgtable_walk_data *walk_data,
+				 arm_lpae_iopte *ptep,
+				 int lvl);
+
+static int __arm_lpae_read_and_clear_dirty(unsigned long iova, size_t size,
+					   arm_lpae_iopte *ptep, void *opaque)
+{
+	struct arm_lpae_iopte_read_dirty *arg = opaque;
+	struct iommu_dirty_bitmap *dirty = arg->dirty;
+	arm_lpae_iopte pte;
+
+	pte = READ_ONCE(*ptep);
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	if ((pte & ARM_LPAE_PTE_AP_WRITABLE) == ARM_LPAE_PTE_AP_WRITABLE)
+		return 0;
+
+	iommu_dirty_bitmap_record(dirty, iova, size);
+	if (!(arg->flags & IOMMU_DIRTY_NO_CLEAR))
+		set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT, (unsigned long *)ptep);
+	return 0;
+}
+
+static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
+			    struct io_pgtable_walk_data *walk_data,
+			    arm_lpae_iopte *ptep, int lvl)
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
+		walk_data->fn(walk_data->addr, size, ptep, walk_data->opaque);
+		walk_data->addr += size;
+		return 0;
+	}
+
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
+}
+
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 struct io_pgtable_walk_data *walk_data,
+				 arm_lpae_iopte *ptep,
+				 int lvl)
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
+		arm_lpae_iopte *pteref = &ptep[idx];
+
+		ret = io_pgtable_visit(data, walk_data, pteref, lvl);
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
+	struct arm_lpae_iopte_read_dirty arg = {
+		.flags = flags, .dirty = dirty,
+	};
+	struct io_pgtable_walk_data walk_data = {
+		.fn = __arm_lpae_read_and_clear_dirty,
+		.opaque = &arg,
+		.addr = iova,
+		.end = iova + size - 1,
+	};
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!size))
+		return -EINVAL;
+
+	if (WARN_ON(iaext))
+		return -EINVAL;
+
+	if (data->iop.fmt != ARM_64_LPAE_S1)
+		return -EINVAL;
+
+	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -807,6 +932,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 	};
 
 	return data;
-- 
2.34.1

