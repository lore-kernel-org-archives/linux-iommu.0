Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB6101D1
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sfcyy1jz1z67Y1s;
	Tue, 28 Nov 2023 17:46:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BCD2A14025A;
	Tue, 28 Nov 2023 17:50:33 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 09:50:26 +0000
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH 3/5] iommu/arm-smmu-v3: Add read_and_clear_dirty() support
Date: Tue, 28 Nov 2023 09:49:38 +0000
Message-ID: <20231128094940.1344-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Keqian Zhu <zhukeqian1@huawei.com>

.read_and_clear_dirty() IOMMU domain op takes care of reading the dirty
bits (i.e. PTE has both DBM and AP[2] set) and marshalling into a bitmap of
a given page size.

While reading the dirty bits we also clear the PTE AP[2] bit to mark it as
writable-clean depending on read_and_clear_dirty() flags.

Structure it in a way that the IOPTE walker is generic, and so we pass a
function pointer over what to do on a per-PTE basis.

[Link below points to the original version that was based on]

Link: https://lore.kernel.org/lkml/20210413085457.25400-11-zhukeqian1@huawei.com/
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com> 
Co-developed-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
[joaomart: Massage commit message and code to the new IOMMU op and logic]
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
[Shameer: Changes to IOPTE walker function to handle size != iommu pgsize
 blk sizes]
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  27 +++++
 drivers/iommu/io-pgtable-arm.c              | 114 ++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index de4d07c4cc7f..8331a2c70a0c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -43,6 +43,7 @@ MODULE_PARM_DESC(disable_msipolling,
 	"Disable MSI-based polling for CMD_SYNC completion.");
 
 static struct iommu_ops arm_smmu_ops;
+static struct iommu_dirty_ops arm_smmu_dirty_ops;
 
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
@@ -3379,6 +3380,28 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	return group;
 }
 
+static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
+					 unsigned long iova, size_t size,
+					 unsigned long flags,
+					 struct iommu_dirty_bitmap *dirty)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	int ret;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (!ops || !ops->read_and_clear_dirty) {
+		pr_err_once("io-pgtable don't support dirty tracking\n");
+		return -ENODEV;
+	}
+
+	ret = ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
+
+	return ret;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -3504,6 +3527,10 @@ static struct iommu_ops arm_smmu_ops = {
 	}
 };
 
+static struct iommu_dirty_ops arm_smmu_dirty_ops = {
+	.read_and_clear_dirty	= arm_smmu_read_and_clear_dirty,
+};
+
 /* Probing and initialisation functions */
 static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 				   struct arm_smmu_queue *q,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index b2f470529459..66b04c8ec693 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -717,6 +717,119 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(pte, data) | iova;
 }
 
+struct arm_lpae_iopte_read_dirty {
+	unsigned long flags;
+	struct iommu_dirty_bitmap *dirty;
+};
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
+static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
+				 unsigned long iova, size_t size,
+				 int lvl, arm_lpae_iopte *ptep,
+				 int (*fn)(unsigned long iova, size_t size,
+					   arm_lpae_iopte *pte, void *opaque),
+				 void *opaque)
+{
+	struct io_pgtable *iop = &data->iop;
+	arm_lpae_iopte *base_ptep = ptep;
+	arm_lpae_iopte pte;
+	size_t base, next_size;
+	int ret;
+
+	if (WARN_ON_ONCE(!fn))
+		return -EINVAL;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return -EINVAL;
+
+	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	pte = READ_ONCE(*ptep);
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+		if (iopte_leaf(pte, lvl, iop->fmt))
+			return fn(iova, size, ptep, opaque);
+
+		/* Current level is table, traverse next level */
+		next_size = ARM_LPAE_BLOCK_SIZE(lvl + 1, data);
+		ptep = iopte_deref(pte, data);
+		for (base = 0; base < size; base += next_size) {
+			ret = __arm_lpae_iopte_walk(data, iova + base,
+						    next_size, lvl + 1, ptep,
+						    fn, opaque);
+			if (ret)
+				return ret;
+		}
+		return 0;
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		size_t blk_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+		for (base = 0; base < size; base += blk_size) {
+			ret = __arm_lpae_iopte_walk(data, iova + base,
+						    blk_size, lvl, base_ptep,
+						    fn, opaque);
+			if (ret)
+				return ret;
+		}
+		return 0;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_iopte_walk(data, iova, size, lvl + 1, ptep,
+				     fn, opaque);
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
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!size))
+		return -EINVAL;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext))
+		return -EINVAL;
+
+	if (data->iop.fmt != ARM_64_LPAE_S1 &&
+	    data->iop.fmt != ARM_32_LPAE_S1)
+		return -EINVAL;
+
+	return __arm_lpae_iopte_walk(data, iova, size, lvl, ptep,
+				     __arm_lpae_read_and_clear_dirty, &arg);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -795,6 +908,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 	};
 
 	return data;
-- 
2.34.1

