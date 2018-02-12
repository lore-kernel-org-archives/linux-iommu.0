From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 19/37] iommu/arm-smmu-v3: Add second level of context descriptor table
Date: Mon, 12 Feb 2018 18:33:34 +0000
Message-ID: <20180212183352.22730-20-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jonathan.cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org, nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The SMMU can support up to 20 bits of SSID. Add a second level of page
tables to accommodate this. Devices that support more than 1024 SSIDs now
have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
descriptors (64kB), allocated on demand.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3-context.c | 137 ++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index 3b0bb9475dea..aaffc2071966 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -14,6 +14,19 @@
 
 #include "iommu-pasid.h"
 
+/*
+ * Linear: when less than 1024 SSIDs are supported
+ * 2lvl: at most 1024 L1 entrie,
+ *	 1024 lazy entries per table.
+ */
+#define CTXDESC_SPLIT			10
+#define CTXDESC_NUM_L2_ENTRIES		(1 << CTXDESC_SPLIT)
+
+#define CTXDESC_L1_DESC_DWORD		1
+#define CTXDESC_L1_DESC_VALID		1
+#define CTXDESC_L1_DESC_L2PTR_SHIFT	12
+#define CTXDESC_L1_DESC_L2PTR_MASK	0xfffffffffUL
+
 #define CTXDESC_CD_DWORDS		8
 #define CTXDESC_CD_0_TCR_T0SZ_SHIFT	0
 #define ARM64_TCR_T0SZ_SHIFT		0
@@ -86,7 +99,17 @@ struct arm_smmu_cd_table {
 
 struct arm_smmu_cd_tables {
 	struct iommu_pasid_table	pasid;
-	struct arm_smmu_cd_table	table;
+	bool				linear;
+	union {
+		struct arm_smmu_cd_table table;
+		struct {
+			__le64		*ptr;
+			dma_addr_t	ptr_dma;
+			size_t		num_entries;
+
+			struct arm_smmu_cd_table *tables;
+		} l1;
+	};
 };
 
 #define pasid_to_cd_tables(pasid_table) \
@@ -122,9 +145,44 @@ static void arm_smmu_free_cd_leaf_table(struct device *dev,
 	dmam_free_coherent(dev, size, desc->ptr, desc->ptr_dma);
 }
 
+static void arm_smmu_write_cd_l1_desc(__le64 *dst,
+				      struct arm_smmu_cd_table *desc)
+{
+	u64 val = (desc->ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK <<
+		   CTXDESC_L1_DESC_L2PTR_SHIFT) | CTXDESC_L1_DESC_VALID;
+
+	*dst = cpu_to_le64(val);
+}
+
 static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_cd_tables *tbl, u32 ssid)
 {
-	return tbl->table.ptr + ssid * CTXDESC_CD_DWORDS;
+	unsigned long idx;
+	struct arm_smmu_cd_table *l1_desc;
+	struct iommu_pasid_table_cfg *cfg = &tbl->pasid.cfg;
+
+	if (tbl->linear)
+		return tbl->table.ptr + ssid * CTXDESC_CD_DWORDS;
+
+	idx = ssid >> CTXDESC_SPLIT;
+	if (idx >= tbl->l1.num_entries)
+		return NULL;
+
+	l1_desc = &tbl->l1.tables[idx];
+	if (!l1_desc->ptr) {
+		__le64 *l1ptr = tbl->l1.ptr + idx * CTXDESC_L1_DESC_DWORD;
+
+		if (arm_smmu_alloc_cd_leaf_table(cfg->iommu_dev, l1_desc,
+						 CTXDESC_NUM_L2_ENTRIES))
+			return NULL;
+
+		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
+		/* An invalid L1 entry is allowed to be cached */
+		iommu_pasid_flush(&tbl->pasid, idx << CTXDESC_SPLIT, false);
+	}
+
+	idx = ssid & (CTXDESC_NUM_L2_ENTRIES - 1);
+
+	return l1_desc->ptr + idx * CTXDESC_CD_DWORDS;
 }
 
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
@@ -307,16 +365,51 @@ static struct iommu_pasid_table *
 arm_smmu_alloc_cd_tables(struct iommu_pasid_table_cfg *cfg, void *cookie)
 {
 	int ret;
+	size_t size = 0;
 	struct arm_smmu_cd_tables *tbl;
 	struct device *dev = cfg->iommu_dev;
+	struct arm_smmu_cd_table *leaf_table;
+	size_t num_contexts, num_leaf_entries;
 
 	tbl = devm_kzalloc(dev, sizeof(*tbl), GFP_KERNEL);
 	if (!tbl)
 		return NULL;
 
-	ret = arm_smmu_alloc_cd_leaf_table(dev, &tbl->table, 1 << cfg->order);
+	num_contexts = 1 << cfg->order;
+	if (num_contexts <= CTXDESC_NUM_L2_ENTRIES) {
+		/* Fits in a single table */
+		tbl->linear = true;
+		num_leaf_entries = num_contexts;
+		leaf_table = &tbl->table;
+	} else {
+		/*
+		 * SSID[S1CDmax-1:10] indexes 1st-level table, SSID[9:0] indexes
+		 * 2nd-level
+		 */
+		tbl->l1.num_entries = num_contexts / CTXDESC_NUM_L2_ENTRIES;
+
+		tbl->l1.tables = devm_kzalloc(dev,
+					      sizeof(struct arm_smmu_cd_table) *
+					      tbl->l1.num_entries, GFP_KERNEL);
+		if (!tbl->l1.tables)
+			goto err_free_tbl;
+
+		size = tbl->l1.num_entries * (CTXDESC_L1_DESC_DWORD << 3);
+		tbl->l1.ptr = dmam_alloc_coherent(dev, size, &tbl->l1.ptr_dma,
+						  GFP_KERNEL | __GFP_ZERO);
+		if (!tbl->l1.ptr) {
+			dev_warn(dev, "failed to allocate L1 context table\n");
+			devm_kfree(dev, tbl->l1.tables);
+			goto err_free_tbl;
+		}
+
+		num_leaf_entries = CTXDESC_NUM_L2_ENTRIES;
+		leaf_table = tbl->l1.tables;
+	}
+
+	ret = arm_smmu_alloc_cd_leaf_table(dev, leaf_table, num_leaf_entries);
 	if (ret)
-		goto err_free_tbl;
+		goto err_free_l1;
 
 	tbl->pasid.ops = (struct iommu_pasid_table_ops) {
 		.alloc_priv_entry	= arm_smmu_alloc_priv_cd,
@@ -326,11 +419,22 @@ arm_smmu_alloc_cd_tables(struct iommu_pasid_table_cfg *cfg, void *cookie)
 		.clear_entry		= arm_smmu_clear_cd,
 	};
 
-	cfg->base		= tbl->table.ptr_dma;
-	cfg->arm_smmu.s1fmt	= ARM_SMMU_S1FMT_LINEAR;
+	if (tbl->linear) {
+		cfg->base		= leaf_table->ptr_dma;
+		cfg->arm_smmu.s1fmt	= ARM_SMMU_S1FMT_LINEAR;
+	} else {
+		cfg->base		= tbl->l1.ptr_dma;
+		cfg->arm_smmu.s1fmt	= ARM_SMMU_S1FMT_64K_L2;
+		arm_smmu_write_cd_l1_desc(tbl->l1.ptr, leaf_table);
+	}
 
 	return &tbl->pasid;
 
+err_free_l1:
+	if (!tbl->linear) {
+		dmam_free_coherent(dev, size, tbl->l1.ptr, tbl->l1.ptr_dma);
+		devm_kfree(dev, tbl->l1.tables);
+	}
 err_free_tbl:
 	devm_kfree(dev, tbl);
 
@@ -343,7 +447,26 @@ static void arm_smmu_free_cd_tables(struct iommu_pasid_table *pasid_table)
 	struct device *dev = cfg->iommu_dev;
 	struct arm_smmu_cd_tables *tbl = pasid_to_cd_tables(pasid_table);
 
-	arm_smmu_free_cd_leaf_table(dev, &tbl->table, 1 << cfg->order);
+	if (tbl->linear) {
+		arm_smmu_free_cd_leaf_table(dev, &tbl->table, 1 << cfg->order);
+	} else {
+		size_t i, size;
+
+		for (i = 0; i < tbl->l1.num_entries; i++) {
+			struct arm_smmu_cd_table *table = &tbl->l1.tables[i];
+
+			if (!table->ptr)
+				continue;
+
+			arm_smmu_free_cd_leaf_table(dev, table,
+						    CTXDESC_NUM_L2_ENTRIES);
+		}
+
+		size = tbl->l1.num_entries * (CTXDESC_L1_DESC_DWORD << 3);
+		dmam_free_coherent(dev, size, tbl->l1.ptr, tbl->l1.ptr_dma);
+		devm_kfree(dev, tbl->l1.tables);
+	}
+
 	devm_kfree(dev, tbl);
 }
 
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
