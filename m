From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 6/7] iommu/rockchip: use DMA API to map, to flush cache
Date: Wed,  8 Jun 2016 21:26:31 +0800
Message-ID: <1465392392-2003-7-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465392392-2003-1-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use DMA API instead of architecture internal functions like
__cpuc_flush_dcache_area() etc.

To support the virtual device like DRM the virtual slave iommu
added in the previous patch, attaching to which the DRM can use
it own domain->dev for dma_map_*(), dma_sync_*() even VOP is disabled.

With this patch, this driver is available for ARM64 like RK3399.

Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 113 ++++++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index d6c3051..aafea6e 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -4,8 +4,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <asm/cacheflush.h>
-#include <asm/pgtable.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -61,8 +59,7 @@
 #define RK_MMU_IRQ_BUS_ERROR     0x02  /* bus read error */
 #define RK_MMU_IRQ_MASK          (RK_MMU_IRQ_PAGE_FAULT | RK_MMU_IRQ_BUS_ERROR)
 
-#define NUM_DT_ENTRIES 1024
-#define NUM_PT_ENTRIES 1024
+#define NUM_TLB_ENTRIES 1024 /* for both DT and PT */
 
 #define SPAGE_ORDER 12
 #define SPAGE_SIZE (1 << SPAGE_ORDER)
@@ -82,7 +79,9 @@
 
 struct rk_iommu_domain {
 	struct list_head iommus;
+	struct device *dev;
 	u32 *dt; /* page directory table */
+	dma_addr_t dt_dma;
 	spinlock_t iommus_lock; /* lock for iommus list */
 	spinlock_t dt_lock; /* lock for modifying page directory table */
 
@@ -98,14 +97,12 @@ struct rk_iommu {
 	struct iommu_domain *domain; /* domain to which iommu is attached */
 };
 
-static inline void rk_table_flush(u32 *va, unsigned int count)
+static inline void rk_table_flush(struct device *dev, dma_addr_t dma,
+				  unsigned int count)
 {
-	phys_addr_t pa_start = virt_to_phys(va);
-	phys_addr_t pa_end = virt_to_phys(va + count);
-	size_t size = pa_end - pa_start;
+	size_t size = count * 4;
 
-	__cpuc_flush_dcache_area(va, size);
-	outer_flush_range(pa_start, pa_end);
+	dma_sync_single_range_for_device(dev, dma, 0, size, DMA_TO_DEVICE);
 }
 
 static struct rk_iommu_domain *to_rk_domain(struct iommu_domain *dom)
@@ -188,10 +185,9 @@ static inline bool rk_dte_is_pt_valid(u32 dte)
 	return dte & RK_DTE_PT_VALID;
 }
 
-static u32 rk_mk_dte(u32 *pt)
+static inline u32 rk_mk_dte(dma_addr_t pt_dma)
 {
-	phys_addr_t pt_phys = virt_to_phys(pt);
-	return (pt_phys & RK_DTE_PT_ADDRESS_MASK) | RK_DTE_PT_VALID;
+	return (pt_dma & RK_DTE_PT_ADDRESS_MASK) | RK_DTE_PT_VALID;
 }
 
 /*
@@ -609,12 +605,14 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 				  dma_addr_t iova)
 {
 	u32 *page_table, *dte_addr;
+	u32 dte_index = rk_iova_dte_index(iova);
 	u32 dte;
 	phys_addr_t pt_phys;
+	dma_addr_t pt_dma;
 
 	assert_spin_locked(&rk_domain->dt_lock);
 
-	dte_addr = &rk_domain->dt[rk_iova_dte_index(iova)];
+	dte_addr = &rk_domain->dt[dte_index];
 	dte = *dte_addr;
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
@@ -623,19 +621,27 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
-	dte = rk_mk_dte(page_table);
-	*dte_addr = dte;
+	pt_dma = dma_map_single(rk_domain->dev, page_table,
+				SPAGE_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(rk_domain->dev, pt_dma)) {
+		dev_err(rk_domain->dev, "dma mapping error\n");
+		free_page((unsigned long)page_table);
+		return ERR_PTR(-ENOMEM);
+	}
 
-	rk_table_flush(page_table, NUM_PT_ENTRIES);
-	rk_table_flush(dte_addr, 1);
+	dte = rk_mk_dte(pt_dma);
+	*dte_addr = dte;
 
+	rk_table_flush(rk_domain->dev, pt_dma, NUM_TLB_ENTRIES);
+	rk_table_flush(rk_domain->dev, rk_domain->dt_dma + dte_index * 4, 1);
 done:
 	pt_phys = rk_dte_pt_address(dte);
 	return (u32 *)phys_to_virt(pt_phys);
 }
 
 static size_t rk_iommu_unmap_iova(struct rk_iommu_domain *rk_domain,
-				  u32 *pte_addr, dma_addr_t iova, size_t size)
+				  u32 *pte_addr, dma_addr_t pte_dma,
+				  size_t size)
 {
 	unsigned int pte_count;
 	unsigned int pte_total = size / SPAGE_SIZE;
@@ -650,14 +656,14 @@ static size_t rk_iommu_unmap_iova(struct rk_iommu_domain *rk_domain,
 		pte_addr[pte_count] = rk_mk_pte_invalid(pte);
 	}
 
-	rk_table_flush(pte_addr, pte_count);
+	rk_table_flush(rk_domain->dev, pte_dma, pte_count);
 
 	return pte_count * SPAGE_SIZE;
 }
 
 static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
-			     dma_addr_t iova, phys_addr_t paddr, size_t size,
-			     int prot)
+			     dma_addr_t pte_dma, dma_addr_t iova,
+			     phys_addr_t paddr, size_t size, int prot)
 {
 	unsigned int pte_count;
 	unsigned int pte_total = size / SPAGE_SIZE;
@@ -676,7 +682,7 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 		paddr += SPAGE_SIZE;
 	}
 
-	rk_table_flush(pte_addr, pte_count);
+	rk_table_flush(rk_domain->dev, pte_dma, pte_total);
 
 	/*
 	 * Zap the first and last iova to evict from iotlb any previously
@@ -689,7 +695,8 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 	return 0;
 unwind:
 	/* Unmap the range of iovas that we just mapped */
-	rk_iommu_unmap_iova(rk_domain, pte_addr, iova, pte_count * SPAGE_SIZE);
+	rk_iommu_unmap_iova(rk_domain, pte_addr, pte_dma,
+			    pte_count * SPAGE_SIZE);
 
 	iova += pte_count * SPAGE_SIZE;
 	page_phys = rk_pte_page_address(pte_addr[pte_count]);
@@ -704,8 +711,9 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 {
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
-	dma_addr_t iova = (dma_addr_t)_iova;
+	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
 	u32 *page_table, *pte_addr;
+	u32 dte_index, pte_index;
 	int ret;
 
 	spin_lock_irqsave(&rk_domain->dt_lock, flags);
@@ -723,8 +731,13 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 		return PTR_ERR(page_table);
 	}
 
-	pte_addr = &page_table[rk_iova_pte_index(iova)];
-	ret = rk_iommu_map_iova(rk_domain, pte_addr, iova, paddr, size, prot);
+	dte_index = rk_domain->dt[rk_iova_dte_index(iova)];
+	pte_index = rk_iova_pte_index(iova);
+	pte_addr = &page_table[pte_index];
+	pte_dma = rk_dte_pt_address(dte_index) + pte_index * 4;
+	ret = rk_iommu_map_iova(rk_domain, pte_addr, pte_dma, iova,
+				paddr, size, prot);
+
 	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
 
 	return ret;
@@ -735,7 +748,7 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 {
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
-	dma_addr_t iova = (dma_addr_t)_iova;
+	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
 	phys_addr_t pt_phys;
 	u32 dte;
 	u32 *pte_addr;
@@ -759,7 +772,8 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 
 	pt_phys = rk_dte_pt_address(dte);
 	pte_addr = (u32 *)phys_to_virt(pt_phys) + rk_iova_pte_index(iova);
-	unmap_size = rk_iommu_unmap_iova(rk_domain, pte_addr, iova, size);
+	pte_dma = pt_phys + rk_iova_pte_index(iova) * 4;
+	unmap_size = rk_iommu_unmap_iova(rk_domain, pte_addr, pte_dma, size);
 
 	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
 
@@ -776,8 +790,6 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 	struct rk_iommu *rk_iommu;
 
 	group = iommu_group_get(dev);
-	if (!group)
-		return NULL;
 	iommu_dev = iommu_group_get_iommudata(group);
 	rk_iommu = dev_get_drvdata(iommu_dev);
 	iommu_group_put(group);
@@ -792,9 +804,21 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
 	int ret, i;
-	phys_addr_t dte_addr;
 
 	iommu = rk_iommu_from_dev(dev);
+	/* Set the domain dev to virtual one if exist */
+	if (RK_IOMMU_IS_VIRTUAL(iommu) || !rk_domain->dev)
+		rk_domain->dev = iommu->dev;
+
+	if (!rk_domain->dt_dma) {
+		rk_domain->dt_dma = dma_map_single(rk_domain->dev, rk_domain->dt,
+						   SPAGE_SIZE, DMA_TO_DEVICE);
+		if (dma_mapping_error(rk_domain->dev, rk_domain->dt_dma))
+			return -ENOMEM;
+
+		rk_table_flush(rk_domain->dev, rk_domain->dt_dma,
+			       NUM_TLB_ENTRIES);
+	}
 
 	iommu->domain = domain;
 	if (RK_IOMMU_IS_VIRTUAL(iommu)) {
@@ -804,28 +828,27 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	ret = rk_iommu_enable_stall(iommu);
 	if (ret)
-		return ret;
+		goto unmap;
 
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
-		return ret;
+		goto unmap;
 
 
 	ret = devm_request_irq(iommu->dev, iommu->irq, rk_iommu_irq,
 			       IRQF_SHARED, dev_name(dev), iommu);
 	if (ret)
-		return ret;
+		goto unmap;
 
-	dte_addr = virt_to_phys(rk_domain->dt);
 	for (i = 0; i < iommu->num_mmu; i++) {
-		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, dte_addr);
+		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, rk_domain->dt_dma);
 		rk_iommu_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
 
 	ret = rk_iommu_enable_paging(iommu);
 	if (ret)
-		return ret;
+		goto unmap;
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_add_tail(&iommu->node, &rk_domain->iommus);
@@ -836,6 +859,10 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	rk_iommu_disable_stall(iommu);
 
 	return 0;
+unmap:
+	dma_unmap_single(rk_domain->dev, rk_domain->dt_dma, SPAGE_SIZE,
+			 DMA_TO_DEVICE);
+	return ret;
 }
 
 static void rk_iommu_detach_device(struct iommu_domain *domain,
@@ -846,8 +873,10 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	unsigned long flags;
 	int i;
 
-	iommu = rk_iommu_from_dev(dev);
+	rk_domain->dev = NULL;
 
+	/* Allow 'virtual devices' (eg drm) to detach from domain */
+	iommu = rk_iommu_from_dev(dev);
 	iommu->domain = NULL;
 	if (RK_IOMMU_IS_VIRTUAL(iommu)) {
 		dev_dbg(dev, "Master with virtual iommu detached from domain\n");
@@ -883,6 +912,8 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	if (!rk_domain)
 		return NULL;
 
+	rk_domain->dev = NULL;
+	rk_domain->dt_dma = 0;
 	/*
 	 * rk32xx iommus use a 2 level pagetable.
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
@@ -892,8 +923,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	if (!rk_domain->dt)
 		goto err_dt;
 
-	rk_table_flush(rk_domain->dt, NUM_DT_ENTRIES);
-
 	spin_lock_init(&rk_domain->iommus_lock);
 	spin_lock_init(&rk_domain->dt_lock);
 	INIT_LIST_HEAD(&rk_domain->iommus);
@@ -912,7 +941,7 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 
 	WARN_ON(!list_empty(&rk_domain->iommus));
 
-	for (i = 0; i < NUM_DT_ENTRIES; i++) {
+	for (i = 0; i < NUM_TLB_ENTRIES; i++) {
 		u32 dte = rk_domain->dt[i];
 		if (rk_dte_is_pt_valid(dte)) {
 			phys_addr_t pt_phys = rk_dte_pt_address(dte);
-- 
1.9.1
