Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CFD37F007
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140005; cv=none; b=SNex9zFhfnGi7Sz9wIB+mqMOuAAEHB4e6EYGN34FVKedcywN3/AMtO/0G/mWFW9SHZ4bZOyeStF5iWWhdCqwG7/AjeHDUqgSI7yT7wZBKa5qMiO2o4rYE2SAJyc6gLYgRzP7wuzKIs5dQRGL1H6t6Zvwx1AzCpG0Efas7VLV/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140005; c=relaxed/simple;
	bh=/31mc99XaPpetfpipAU2jQAXCy4Of4rbwwcZL8VjzF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9kDBN2dROhmeAj2jkYwUcJJOV7qJYY8oP02Gzg0lnc6iZxtx+0iPKnT9vSGYspgZRXx+e++rRzNWAMu53XlIDwyQ6MBntC7gq0xPrDX18a0ocbmK3/lxTrOoK2gxY/IaUzvTEXCHmjeNbadHBGdwSTTtbd0f7a17j/T5DRRaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WbJpVVU2; arc=none smtp.client-ip=45.254.49.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WbJpVVU2"
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36686f76e;
	Tue, 10 Mar 2026 18:53:12 +0800 (GMT+08:00)
From: Simon Xue <xxm@rock-chips.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Simon Xue <xxm@rock-chips.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/rockchip: Drop global rk_ops in favor of per-device ops
Date: Tue, 10 Mar 2026 18:53:03 +0800
Message-Id: <20260310105303.128859-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310084812.126082-1-xxm@rock-chips.com>
References: <20260310084812.126082-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cd7611f0e03ackunm5db21e7c28839d7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9PSlZISh1LTh5KS05KGUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WbJpVVU2o52k5gZrvtQtGAcU1KO+CRrqCrEmQOHJfQ+DpBswyDZIGE17QMjWr/ALVRnQ4WQa/SANX5CBGSr5ES0lFw6JCfeowljdJKfO10ZAd4/t5oTum25LK0HWEhahbbWgHXiEyQ7l3j10QzFtPaVUoiGXvlEzHOqS216S/8E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=gwQYeeSnsqW3zhCs/e1OF97BC/ko+v34AjyPZXvnGWo=;
	h=date:mime-version:subject:message-id:from;

The driver currently uses a global rk_ops pointer, forcing all IOMMU
instances to share the same operations. This restricts the driver from
supporting SoCs that might integrate different versions of IOMMU hardware.

Since the IOMMU framework passes the master device information to
iommu_paging_domain_alloc(), the global variable is no longer needed.

Fix this by moving rk_ops into struct rk_iommu and struct rk_iommu_domain.
Initialize it per-device during probe via of_device_get_match_data(),
and replace all global references with the instance-specific pointers.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
v2:
 - Remove the one-time-used 'ops' variable in rk_iommu_probe()

 drivers/iommu/rockchip-iommu.c | 71 ++++++++++++++++------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0013cf196c57..4da80136933c 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -82,6 +82,14 @@
   */
 #define RK_IOMMU_PGSIZE_BITMAP 0x007ff000
 
+struct rk_iommu_ops {
+	phys_addr_t (*pt_address)(u32 dte);
+	u32 (*mk_dtentries)(dma_addr_t pt_dma);
+	u32 (*mk_ptentries)(phys_addr_t page, int prot);
+	u64 dma_bit_mask;
+	gfp_t gfp_flags;
+};
+
 struct rk_iommu_domain {
 	struct list_head iommus;
 	u32 *dt; /* page directory table */
@@ -89,6 +97,7 @@ struct rk_iommu_domain {
 	spinlock_t iommus_lock; /* lock for iommus list */
 	spinlock_t dt_lock; /* lock for modifying page directory table */
 	struct device *dma_dev;
+	const struct rk_iommu_ops *rk_ops;
 
 	struct iommu_domain domain;
 };
@@ -98,14 +107,6 @@ static const char * const rk_iommu_clocks[] = {
 	"aclk", "iface",
 };
 
-struct rk_iommu_ops {
-	phys_addr_t (*pt_address)(u32 dte);
-	u32 (*mk_dtentries)(dma_addr_t pt_dma);
-	u32 (*mk_ptentries)(phys_addr_t page, int prot);
-	u64 dma_bit_mask;
-	gfp_t gfp_flags;
-};
-
 struct rk_iommu {
 	struct device *dev;
 	void __iomem **bases;
@@ -117,6 +118,7 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	const struct rk_iommu_ops *rk_ops;
 };
 
 struct rk_iommudata {
@@ -124,7 +126,6 @@ struct rk_iommudata {
 	struct rk_iommu *iommu;
 };
 
-static const struct rk_iommu_ops *rk_ops;
 static struct iommu_domain rk_identity_domain;
 
 static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
@@ -510,7 +511,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	 * and verifying that upper 5 (v1) or 7 (v2) nybbles are read back.
 	 */
 	for (i = 0; i < iommu->num_mmu; i++) {
-		dte_addr = rk_ops->pt_address(DTE_ADDR_DUMMY);
+		dte_addr = iommu->rk_ops->pt_address(DTE_ADDR_DUMMY);
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, dte_addr);
 
 		if (dte_addr != rk_iommu_read(iommu->bases[i], RK_MMU_DTE_ADDR)) {
@@ -551,7 +552,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	page_offset = rk_iova_page_offset(iova);
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
-	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
+	mmu_dte_addr_phys = iommu->rk_ops->pt_address(mmu_dte_addr);
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -560,14 +561,14 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	if (!rk_dte_is_pt_valid(dte))
 		goto print_it;
 
-	pte_addr_phys = rk_ops->pt_address(dte) + (pte_index * 4);
+	pte_addr_phys = iommu->rk_ops->pt_address(dte) + (pte_index * 4);
 	pte_addr = phys_to_virt(pte_addr_phys);
 	pte = *pte_addr;
 
 	if (!rk_pte_is_page_valid(pte))
 		goto print_it;
 
-	page_addr_phys = rk_ops->pt_address(pte) + page_offset;
+	page_addr_phys = iommu->rk_ops->pt_address(pte) + page_offset;
 	page_flags = pte & RK_PTE_PAGE_FLAGS_MASK;
 
 print_it:
@@ -663,13 +664,13 @@ static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
 	if (!rk_dte_is_pt_valid(dte))
 		goto out;
 
-	pt_phys = rk_ops->pt_address(dte);
+	pt_phys = rk_domain->rk_ops->pt_address(dte);
 	page_table = (u32 *)phys_to_virt(pt_phys);
 	pte = page_table[rk_iova_pte_index(iova)];
 	if (!rk_pte_is_page_valid(pte))
 		goto out;
 
-	phys = rk_ops->pt_address(pte) + rk_iova_page_offset(iova);
+	phys = rk_domain->rk_ops->pt_address(pte) + rk_iova_page_offset(iova);
 out:
 	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
 
@@ -730,7 +731,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
-	page_table = iommu_alloc_pages_sz(GFP_ATOMIC | rk_ops->gfp_flags,
+	page_table = iommu_alloc_pages_sz(GFP_ATOMIC | rk_domain->rk_ops->gfp_flags,
 					  SPAGE_SIZE);
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
@@ -742,13 +743,13 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	dte = rk_ops->mk_dtentries(pt_dma);
+	dte = rk_domain->rk_ops->mk_dtentries(pt_dma);
 	*dte_addr = dte;
 
 	rk_table_flush(rk_domain,
 		       rk_domain->dt_dma + dte_index * sizeof(u32), 1);
 done:
-	pt_phys = rk_ops->pt_address(dte);
+	pt_phys = rk_domain->rk_ops->pt_address(dte);
 	return (u32 *)phys_to_virt(pt_phys);
 }
 
@@ -790,7 +791,7 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 		if (rk_pte_is_page_valid(pte))
 			goto unwind;
 
-		pte_addr[pte_count] = rk_ops->mk_ptentries(paddr, prot);
+		pte_addr[pte_count] = rk_domain->rk_ops->mk_ptentries(paddr, prot);
 
 		paddr += SPAGE_SIZE;
 	}
@@ -812,7 +813,7 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 			    pte_count * SPAGE_SIZE);
 
 	iova += pte_count * SPAGE_SIZE;
-	page_phys = rk_ops->pt_address(pte_addr[pte_count]);
+	page_phys = rk_domain->rk_ops->pt_address(pte_addr[pte_count]);
 	pr_err("iova: %pad already mapped to %pa cannot remap to phys: %pa prot: %#x\n",
 	       &iova, &page_phys, &paddr, prot);
 
@@ -849,7 +850,7 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 	pte_index = rk_iova_pte_index(iova);
 	pte_addr = &page_table[pte_index];
 
-	pte_dma = rk_ops->pt_address(dte_index) + pte_index * sizeof(u32);
+	pte_dma = rk_domain->rk_ops->pt_address(dte_index) + pte_index * sizeof(u32);
 	ret = rk_iommu_map_iova(rk_domain, pte_addr, pte_dma, iova,
 				paddr, size, prot);
 
@@ -887,7 +888,7 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 		return 0;
 	}
 
-	pt_phys = rk_ops->pt_address(dte);
+	pt_phys = rk_domain->rk_ops->pt_address(dte);
 	pte_addr = (u32 *)phys_to_virt(pt_phys) + rk_iova_pte_index(iova);
 	pte_dma = pt_phys + rk_iova_pte_index(iova) * sizeof(u32);
 	unmap_size = rk_iommu_unmap_iova(rk_domain, pte_addr, pte_dma, size);
@@ -945,7 +946,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
-			       rk_ops->mk_dtentries(rk_domain->dt_dma));
+			       iommu->rk_ops->mk_dtentries(rk_domain->dt_dma));
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
@@ -1068,17 +1069,19 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	if (!rk_domain)
 		return NULL;
 
+	iommu = rk_iommu_from_dev(dev);
+	rk_domain->rk_ops = iommu->rk_ops;
+
 	/*
 	 * rk32xx iommus use a 2 level pagetable.
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
 	 * Allocate one 4 KiB page for each table.
 	 */
-	rk_domain->dt = iommu_alloc_pages_sz(GFP_KERNEL | rk_ops->gfp_flags,
+	rk_domain->dt = iommu_alloc_pages_sz(GFP_KERNEL | rk_domain->rk_ops->gfp_flags,
 					     SPAGE_SIZE);
 	if (!rk_domain->dt)
 		goto err_free_domain;
 
-	iommu = rk_iommu_from_dev(dev);
 	rk_domain->dma_dev = iommu->dev;
 	rk_domain->dt_dma = dma_map_single(rk_domain->dma_dev, rk_domain->dt,
 					   SPAGE_SIZE, DMA_TO_DEVICE);
@@ -1117,7 +1120,7 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 	for (i = 0; i < NUM_DT_ENTRIES; i++) {
 		u32 dte = rk_domain->dt[i];
 		if (rk_dte_is_pt_valid(dte)) {
-			phys_addr_t pt_phys = rk_ops->pt_address(dte);
+			phys_addr_t pt_phys = rk_domain->rk_ops->pt_address(dte);
 			u32 *page_table = phys_to_virt(pt_phys);
 			dma_unmap_single(rk_domain->dma_dev, pt_phys,
 					 SPAGE_SIZE, DMA_TO_DEVICE);
@@ -1197,7 +1200,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rk_iommu *iommu;
 	struct resource *res;
-	const struct rk_iommu_ops *ops;
 	int num_res = pdev->num_resources;
 	int err, i;
 
@@ -1211,16 +1213,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	iommu->dev = dev;
 	iommu->num_mmu = 0;
 
-	ops = of_device_get_match_data(dev);
-	if (!rk_ops)
-		rk_ops = ops;
-
-	/*
-	 * That should not happen unless different versions of the
-	 * hardware block are embedded the same SoC
-	 */
-	if (WARN_ON(rk_ops != ops))
-		return -EINVAL;
+	iommu->rk_ops = of_device_get_match_data(dev);
+	if (!iommu->rk_ops)
+		return -ENOENT;
 
 	iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
 				    GFP_KERNEL);
@@ -1286,7 +1281,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
+	dma_set_mask_and_coherent(dev, iommu->rk_ops->dma_bit_mask);
 
 	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
 	if (err)
-- 
2.34.1

