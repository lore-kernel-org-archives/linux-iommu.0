Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216403E49FD
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468030; cv=none; b=oQBUuSeCLMVZ8cH6q7rIIL0vDL6GH8NcCJKelPf7IsFn2k63cml6FJ05vbU681HcgV9EQR/1wglw7ngKXK0GLXnK6q47faIA/IAK5s5KDY1vAlMGOiGrJ5WeOQRCdnXMu4oh4WKQPr/msB6mKnFZhrY/SV9lxgA1nHkQu/usl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468030; c=relaxed/simple;
	bh=kqoKfbRIzrThWrSIDSos43QWzar7POfE2OCl+OI2leo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wnk/+YMviomIS1AQYU0Cq4HB44opp7cZfk32SuBao8++Y5b2wMLkCZ9JTLqG2crHiJ1EL3t1hxWFSIOr/SmUK6m6XS0SdSzZ7yDSxrnl/g/53DMwFDoWkhzXsCCSlCUdldm0eJddsA5rj/uZb9Sc5IeGyHSdFp4yLe7V3u/mqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xvx1tic4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xvx1tic4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791468023; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZdsybsZg4gWBHS9NoCP952HDoUG/uyGaTz5zYAijfYM=;
	b=Xvx1tic4v9CqoIOByaiK+c3+B1h44FeHOpfoQ6UqSe3JE0Z1/2wppTot6andVq87WlQFSrvb+ilkSnztdb7dygJdhZQkuvXTxWd50+aKDTQfVh7TrFb4LedOyS9CLe8VAu+VIqMu9WCb5B5e4QAWFyViXa0sjOImfXdW+lwo8oY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XCQTvlx_1791468021;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XCQTvlx_1791468021 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 22:00:22 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com,
	jgg@nvidia.com,
	jgg@ziepe.ca
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH 1/3] iommu/riscv: Add guest IMSIC GPA mapping helpers
Date: Thu,  8 Oct 2026 21:59:59 +0800
Message-Id: <20261008140001.94508-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261008140001.94508-1-fangyu.yu@linux.alibaba.com>
References: <20261008140001.94508-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

IOMMU implementations without the MSI_FLAT capability translate MSI
writes through the second-stage page table, so IRQ forwarding on them
will need guest IMSIC pages mapped into the second-stage domain.

Add an xarray to the MSI table that tracks the HPA installed for each
mapped guest IMSIC GPA, and two helpers for use with the MSI table lock
held: riscv_iommu_msi_table_map_gpa() installs the initial 4 KiB
mapping, and riscv_iommu_msi_table_replace_gpa_leaf() atomically swaps
the leaf PTE's PFN when a vCPU's VS-file host page moves, rejecting
leaves that do not map the expected old HPA.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 94 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h | 12 +++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e2e77469ea3c..48fc57d6409c 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -24,6 +24,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pgtable.h>
 #include <linux/generic_pt/iommu.h>
 
 #include "../dma-iommu.h"
@@ -1217,6 +1218,92 @@ void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
 	riscv_iommu_iotlb_inval(domain, &gather);
 }
 
+int riscv_iommu_msi_table_map_gpa(struct riscv_iommu_msi_table *msi_table,
+				  dma_addr_t gpa, phys_addr_t hpa)
+{
+	struct riscv_iommu_domain *domain =
+		container_of(msi_table, struct riscv_iommu_domain, msi_table);
+	const int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+
+	/* Guest IMSIC GPA mapping only exists in second-stage translations. */
+	if (!domain->gscid)
+		return -EOPNOTSUPP;
+
+	return iommu_map(&domain->domain, gpa, hpa, IMSIC_MMIO_PAGE_SZ, prot,
+			 GFP_ATOMIC);
+}
+
+int riscv_iommu_msi_table_replace_gpa_leaf(struct riscv_iommu_msi_table *msi_table,
+					   dma_addr_t gpa, phys_addr_t old_hpa,
+					   phys_addr_t new_hpa)
+{
+	struct riscv_iommu_domain *domain =
+		container_of(msi_table, struct riscv_iommu_domain, msi_table);
+	struct pt_iommu_riscv_64_hw_info pt_info;
+	u64 *root, *table, *ptep;
+	u64 old, new;
+	int top_level, level;
+
+	if (!IS_ALIGNED(gpa | old_hpa | new_hpa, PAGE_SIZE))
+		return -EINVAL;
+	if (!domain->gscid)
+		return -EOPNOTSUPP;
+
+	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
+	switch (pt_info.iohgatp_mode) {
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
+		top_level = 2;
+		break;
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
+		top_level = 3;
+		break;
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
+		top_level = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	root = phys_to_virt(pt_info.ppn << PAGE_SHIFT);
+	for (;;) {
+		table = root;
+		for (level = top_level; level >= 0; level--) {
+			unsigned int shift = PAGE_SHIFT + level * 9;
+			unsigned int index = gpa >> shift;
+
+			if (level == top_level)
+				index &= GENMASK(10, 0);
+			else
+				index &= GENMASK(8, 0);
+			ptep = &table[index];
+			old = READ_ONCE(*ptep);
+
+			if (level) {
+				/* A valid non-leaf PTE has R/W/X clear. */
+				if ((old & (_PAGE_PRESENT | _PAGE_LEAF)) !=
+				    _PAGE_PRESENT)
+					return -EADDRINUSE;
+				table = phys_to_virt(FIELD_GET(_PAGE_PFN_MASK,
+							       old) << PAGE_SHIFT);
+				continue;
+			}
+
+			/* Replace only the L0 leaf previously installed for this GPA. */
+			if (!(old & _PAGE_PRESENT) || !(old & _PAGE_LEAF) ||
+			    FIELD_GET(_PAGE_PFN_MASK, old) !=
+			    old_hpa >> PAGE_SHIFT)
+				return -EADDRINUSE;
+
+			new = (old & ~_PAGE_PFN_MASK) |
+			      FIELD_PREP(_PAGE_PFN_MASK,
+					 new_hpa >> PAGE_SHIFT);
+			if (cmpxchg64(ptep, old, new) == old)
+				return 0;
+			break;
+		}
+	}
+}
+
 #define RISCV_IOMMU_FSC_BARE 0
 /*
  * This function sends IOTINVAL commands as required by the RISC-V
@@ -1425,6 +1512,8 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
 static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_noflat_imsic *imsic;
+	unsigned long index;
 
 	WARN_ON(!list_empty(&domain->bonds));
 
@@ -1435,6 +1524,10 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	if (domain->gscid > 0)
 		ida_free(&riscv_iommu_gscids, domain->gscid);
 
+	xa_for_each(&domain->msi_table.noflat_imsics, index, imsic)
+		kfree(imsic);
+	xa_destroy(&domain->msi_table.noflat_imsics);
+
 	pt_iommu_deinit(&domain->riscvpt.iommu);
 	iommu_free_pages(domain->msi_table.root);
 	kfree(domain);
@@ -1676,6 +1769,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	raw_spin_lock_init(&domain->lock);
 	raw_spin_lock_init(&domain->msi_table.lock);
+	xa_init(&domain->msi_table.noflat_imsics);
 	mutex_init(&domain->mutex);
 	iommu = dev_to_iommu(dev);
 	cfg.common.hw_max_oasz_lg2 = 56;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 9852962e245b..53a368fbbdf2 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -18,6 +18,7 @@
 #include <linux/irqdomain.h>
 #include <linux/rcupdate.h>
 #include <linux/sizes.h>
+#include <linux/xarray.h>
 
 #include "iommu-bits.h"
 
@@ -74,6 +75,11 @@ struct riscv_iommu_device {
 	struct irq_domain *irqdomain;
 };
 
+/* Tracks a guest IMSIC GPA mapped into an S2 domain on IOMMUs without MSI_FLAT. */
+struct riscv_iommu_noflat_imsic {
+	phys_addr_t hpa;
+};
+
 struct riscv_iommu_msi_table {
 	/* Protects attachment, interrupt forwarding state, and MSI PTE updates. */
 	raw_spinlock_t lock;
@@ -84,6 +90,7 @@ struct riscv_iommu_msi_table {
 	u64 msi_addr_pattern;
 	const void *owner;
 	u64 required_caps; /* RISCV_IOMMU_CAPABILITIES_* required by active MSI PTEs */
+	struct xarray noflat_imsics;
 };
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
@@ -109,6 +116,11 @@ bool riscv_iommu_msi_table_check_caps(struct riscv_iommu_msi_table *msi_table, u
 void riscv_iommu_msi_table_inval(struct riscv_iommu_msi_table *msi_table, unsigned long addr);
 void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table);
 void riscv_iommu_msi_table_update(struct riscv_iommu_msi_table *msi_table, bool activate);
+int riscv_iommu_msi_table_map_gpa(struct riscv_iommu_msi_table *msi_table,
+				  dma_addr_t gpa, phys_addr_t hpa);
+int riscv_iommu_msi_table_replace_gpa_leaf(struct riscv_iommu_msi_table *msi_table,
+					   dma_addr_t gpa, phys_addr_t old_hpa,
+					   phys_addr_t new_hpa);
 
 #ifdef CONFIG_RISCV_IMSIC
 void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_device *iommu);
-- 
2.50.1

