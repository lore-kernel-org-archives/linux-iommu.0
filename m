Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8653FD54
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987113; cv=none; b=cf+ktMNO/EeDakwSmwthgdhIEHnXWOSosdTDUGxAEaIev65QWDruXG73W45kpAwvM8sydOu9uuXDj7OPX/WdqvdkY9PWrZE9Edx4HdpimbQ8MgSCH0lHL7T1C6q5TLG1eMPvfcI54+OLNJ6ooacTDzrrODNkl9SXfAJkmsK2t/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987113; c=relaxed/simple;
	bh=EDVcaV0WNqaqU31GeopChaWSKHO4coQmvq3ODLQu8GY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPYVe9yPIyQbihzbxG+m7r/Lu9nRcdGXZoa/ebCUAX4upwm0eCIkHn5EkDwWC7WNnWPQ0Ty+OuoZ2P7YEh5pjArm1uJL17v/W+2889prH6PdQuY/nQML1aPsGuItIkCFZzeLCEh2xLm8rY1rTwgXkIvxd11SLmta37cf+dMBu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rrrOVB/Y; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rrrOVB/Y"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791987101; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WMi+Mbcr4YFWc7b54ioO0gfFc35PTsSr6VOsGv6IvoY=;
	b=rrrOVB/Y1dlz05kgXKjfdQR49tvArzoUuvRpK27Wr8xoqo4XI3hj3bLWlvvBJ88/NHzX/2Jd30aF6Ifdoy1OdrHvTXVOeDls+cM9LqbFEKsqTre7jINQ4Ito6ciWx5Xauil1ilSXIb1LxyuzN9PiNcMfPZqM+OUQjVKqmCXIvO8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XCp410D_1791987098;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XCp410D_1791987098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 22:11:39 +0800
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
	jgg@ziepe.ca,
	gsh517025@gmail.com
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH v2 3/4] iommu/riscv: Add guest IMSIC GPA mapping helpers
Date: Wed, 14 Oct 2026 22:11:23 +0800
Message-Id: <20261014141124.48569-4-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261014141124.48569-1-fangyu.yu@linux.alibaba.com>
References: <20261014141124.48569-1-fangyu.yu@linux.alibaba.com>
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
mapping, and riscv_iommu_msi_table_replace_gpa() repoints the leaf PTE
when a vCPU's VS-file host page moves, using the generic page table
replace_leaf op instead of walking the table in the driver.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 43 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h | 12 +++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e2e77469ea3c..88e131ce96c1 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1217,6 +1217,42 @@ void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
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
+int riscv_iommu_msi_table_replace_gpa(struct riscv_iommu_msi_table *msi_table,
+				      dma_addr_t gpa, phys_addr_t old_hpa,
+				      phys_addr_t new_hpa)
+{
+	struct riscv_iommu_domain *domain =
+		container_of(msi_table, struct riscv_iommu_domain, msi_table);
+	int ret;
+
+	/* Guest IMSIC GPA mapping only exists in second-stage translations. */
+	if (!domain->gscid)
+		return -EOPNOTSUPP;
+
+	ret = pt_iommu_riscv_64_replace_leaf(&domain->domain, gpa, old_hpa,
+					     new_hpa);
+	if (ret == -EAGAIN) {
+		/* The leaf changed concurrently; the caller revalidates. */
+		return -EADDRINUSE;
+	}
+	return ret;
+}
+
 #define RISCV_IOMMU_FSC_BARE 0
 /*
  * This function sends IOTINVAL commands as required by the RISC-V
@@ -1425,6 +1461,8 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
 static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_noflat_imsic *imsic;
+	unsigned long index;
 
 	WARN_ON(!list_empty(&domain->bonds));
 
@@ -1435,6 +1473,10 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	if (domain->gscid > 0)
 		ida_free(&riscv_iommu_gscids, domain->gscid);
 
+	xa_for_each(&domain->msi_table.noflat_imsics, index, imsic)
+		kfree(imsic);
+	xa_destroy(&domain->msi_table.noflat_imsics);
+
 	pt_iommu_deinit(&domain->riscvpt.iommu);
 	iommu_free_pages(domain->msi_table.root);
 	kfree(domain);
@@ -1676,6 +1718,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	raw_spin_lock_init(&domain->lock);
 	raw_spin_lock_init(&domain->msi_table.lock);
+	xa_init(&domain->msi_table.noflat_imsics);
 	mutex_init(&domain->mutex);
 	iommu = dev_to_iommu(dev);
 	cfg.common.hw_max_oasz_lg2 = 56;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 9852962e245b..8d5f44de2688 100644
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
+int riscv_iommu_msi_table_replace_gpa(struct riscv_iommu_msi_table *msi_table,
+				      dma_addr_t gpa, phys_addr_t old_hpa,
+				      phys_addr_t new_hpa);
 
 #ifdef CONFIG_RISCV_IMSIC
 void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_device *iommu);
-- 
2.50.1

