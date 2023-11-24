Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D402D035
	for <iommu@lists.linux.dev>; Fri, 24 Nov 2023 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LFdLm9mc"
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 280FB66073BB;
	Fri, 24 Nov 2023 14:24:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700835880;
	bh=xUfGrP0l3NLXr5ukPH28WnVyEX/DTDIQfPyuJDs8edM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFdLm9mc62c+EOGWbBQNtxF1XtPErSeJ+H+8vsZqqkdUP0xcM9Qk83eepYO1pTZSR
	 9HxGkyfkWlQrDdV+NATCk3bnzbPHUnEp93GqHtu10wYkdhvl+wybAIicsOHz6sl0x/
	 OwqEKegjo/GxPgXiluUnE9hen3xTPz95B1d6BGbSVryE7aymMlUYQlmXjCpp6uEcMu
	 iKFhgGa2a6+CEMz/1OF8mkmWPPgI99tmVfCpvIWRtd0DnHOfdDCXuAhn6oIE2oZZV1
	 DmgPAz57lxRmKu8yBAtqYi2guTgQ9FWo0ChmDtbiZX0H05Eb8fMpIVM61BylQnKPBr
	 QWk1tbmdhC3cQ==
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	kernel@collabora.com,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 2/2] iommu: Extend LPAE page table format to support custom allocators
Date: Fri, 24 Nov 2023 15:24:34 +0100
Message-ID: <20231124142434.1577550-3-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124142434.1577550-1-boris.brezillon@collabora.com>
References: <20231124142434.1577550-1-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need that in order to implement the VM_BIND ioctl in the GPU driver
targeting new Mali GPUs.

VM_BIND is about executing MMU map/unmap requests asynchronously,
possibly after waiting for external dependencies encoded as dma_fences.
We intend to use the drm_sched framework to automate the dependency
tracking and VM job dequeuing logic, but this comes with its own set
of constraints, one of them being the fact we are not allowed to
allocate memory in the drm_gpu_scheduler_ops::run_job() to avoid this
sort of deadlocks:

- VM_BIND map job needs to allocate a page table to map some memory
  to the VM. No memory available, so kswapd is kicked
- GPU driver shrinker backend ends up waiting on the fence attached to
  the VM map job or any other job fence depending on this VM operation.

With custom allocators, we will be able to pre-reserve enough pages to
guarantee the map/unmap operations we queued will take place without
going through the system allocator. But we can also optimize
allocation/reservation by not free-ing pages immediately, so any
upcoming page table allocation requests can be serviced by some free
page table pool kept at the driver level.

I might also be valuable for other aspects of GPU and similar
use-cases, like fine-grained memory accounting and resource limiting.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
v3:
- Don't pass __GFP_ZERO to the custom ->alloc() hook. Returning zeroed
  mem is partof the agreement between the io-pgtable and its user
- Add Robin R-b
v2:
- Add Steven R-b
- Expand on possible use-cases for custom allocators
---
 drivers/iommu/io-pgtable-arm.c | 55 ++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 72dcdd468cf3..f7828a7aad41 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -188,20 +188,28 @@ static dma_addr_t __arm_lpae_dma_addr(void *pages)
 }
 
 static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
-				    struct io_pgtable_cfg *cfg)
+				    struct io_pgtable_cfg *cfg,
+				    void *cookie)
 {
 	struct device *dev = cfg->iommu_dev;
 	int order = get_order(size);
-	struct page *p;
 	dma_addr_t dma;
 	void *pages;
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
-	if (!p)
+
+	if (cfg->alloc) {
+		pages = cfg->alloc(cookie, size, gfp);
+	} else {
+		struct page *p;
+
+		p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
+		pages = p ? page_address(p) : NULL;
+	}
+
+	if (!pages)
 		return NULL;
 
-	pages = page_address(p);
 	if (!cfg->coherent_walk) {
 		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
@@ -220,18 +228,28 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 out_unmap:
 	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
 	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
+
 out_free:
-	__free_pages(p, order);
+	if (cfg->free)
+		cfg->free(cookie, pages, size);
+	else
+		free_pages((unsigned long)pages, order);
+
 	return NULL;
 }
 
 static void __arm_lpae_free_pages(void *pages, size_t size,
-				  struct io_pgtable_cfg *cfg)
+				  struct io_pgtable_cfg *cfg,
+				  void *cookie)
 {
 	if (!cfg->coherent_walk)
 		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
 				 size, DMA_TO_DEVICE);
-	free_pages((unsigned long)pages, get_order(size));
+
+	if (cfg->free)
+		cfg->free(cookie, pages, size);
+	else
+		free_pages((unsigned long)pages, get_order(size));
 }
 
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
@@ -373,13 +391,13 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 	/* Grab a pointer to the next level */
 	pte = READ_ONCE(*ptep);
 	if (!pte) {
-		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg);
+		cptep = __arm_lpae_alloc_pages(tblsz, gfp, cfg, data->iop.cookie);
 		if (!cptep)
 			return -ENOMEM;
 
 		pte = arm_lpae_install_table(cptep, ptep, 0, data);
 		if (pte)
-			__arm_lpae_free_pages(cptep, tblsz, cfg);
+			__arm_lpae_free_pages(cptep, tblsz, cfg, data->iop.cookie);
 	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
 		__arm_lpae_sync_pte(ptep, 1, cfg);
 	}
@@ -524,7 +542,7 @@ static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
 	}
 
-	__arm_lpae_free_pages(start, table_size, &data->iop.cfg);
+	__arm_lpae_free_pages(start, table_size, &data->iop.cfg, data->iop.cookie);
 }
 
 static void arm_lpae_free_pgtable(struct io_pgtable *iop)
@@ -552,7 +570,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
 		return 0;
 
-	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg);
+	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg, data->iop.cookie);
 	if (!tablep)
 		return 0; /* Bytes unmapped */
 
@@ -575,7 +593,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 
 	pte = arm_lpae_install_table(tablep, ptep, blk_pte, data);
 	if (pte != blk_pte) {
-		__arm_lpae_free_pages(tablep, tablesz, cfg);
+		__arm_lpae_free_pages(tablep, tablesz, cfg, data->iop.cookie);
 		/*
 		 * We may race against someone unmapping another part of this
 		 * block, but anything else is invalid. We can't misinterpret
@@ -882,7 +900,7 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 
 	/* Looking good; allocate a pgd */
 	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
-					   GFP_KERNEL, cfg);
+					   GFP_KERNEL, cfg, cookie);
 	if (!data->pgd)
 		goto out_free_data;
 
@@ -984,7 +1002,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 
 	/* Allocate pgd pages */
 	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
-					   GFP_KERNEL, cfg);
+					   GFP_KERNEL, cfg, cookie);
 	if (!data->pgd)
 		goto out_free_data;
 
@@ -1059,7 +1077,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 		 << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));
 
 	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
-					   cfg);
+					   cfg, cookie);
 	if (!data->pgd)
 		goto out_free_data;
 
@@ -1080,26 +1098,31 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 }
 
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
+	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
 };
 
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
+	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
 	.alloc	= arm_64_lpae_alloc_pgtable_s2,
 	.free	= arm_lpae_free_pgtable,
 };
 
 struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
+	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
 	.alloc	= arm_32_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
 };
 
 struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
+	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
 	.alloc	= arm_32_lpae_alloc_pgtable_s2,
 	.free	= arm_lpae_free_pgtable,
 };
 
 struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
+	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
 	.alloc	= arm_mali_lpae_alloc_pgtable,
 	.free	= arm_lpae_free_pgtable,
 };
-- 
2.42.0

