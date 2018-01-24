From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v5 09/13] iommu/rockchip: Use IOMMU device for dma mapping operations
Date: Wed, 24 Jan 2018 18:35:12 +0800
Message-ID: <20180124103516.2571-10-jeffy.chen@rock-chips.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Use the first registered IOMMU device for dma mapping operations, and
drop the domain platform device.

This is similar to exynos iommu driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 85 ++++++++++++------------------------------
 1 file changed, 24 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 8a5e2a659b67..e545b3f252a6 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -79,7 +79,6 @@
 
 struct rk_iommu_domain {
 	struct list_head iommus;
-	struct platform_device *pdev;
 	u32 *dt; /* page directory table */
 	dma_addr_t dt_dma;
 	spinlock_t iommus_lock; /* lock for iommus list */
@@ -100,12 +99,14 @@ struct rk_iommu {
 	struct iommu_domain *domain; /* domain to which iommu is attached */
 };
 
+static struct device *dma_dev;
+
 static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
 				  unsigned int count)
 {
 	size_t size = count * sizeof(u32); /* count of u32 entry */
 
-	dma_sync_single_for_device(&dom->pdev->dev, dma, size, DMA_TO_DEVICE);
+	dma_sync_single_for_device(dma_dev, dma, size, DMA_TO_DEVICE);
 }
 
 static struct rk_iommu_domain *to_rk_domain(struct iommu_domain *dom)
@@ -652,7 +653,6 @@ static void rk_iommu_zap_iova_first_last(struct rk_iommu_domain *rk_domain,
 static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 				  dma_addr_t iova)
 {
-	struct device *dev = &rk_domain->pdev->dev;
 	u32 *page_table, *dte_addr;
 	u32 dte_index, dte;
 	phys_addr_t pt_phys;
@@ -670,9 +670,9 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
-	pt_dma = dma_map_single(dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, pt_dma)) {
-		dev_err(dev, "DMA mapping error while allocating page table\n");
+	pt_dma = dma_map_single(dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev, pt_dma)) {
+		dev_err(dma_dev, "DMA mapping error while allocating page table\n");
 		free_page((unsigned long)page_table);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -938,29 +938,20 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 {
 	struct rk_iommu_domain *rk_domain;
-	struct platform_device *pdev;
-	struct device *iommu_dev;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
-	/* Register a pdev per domain, so DMA API can base on this *dev
-	 * even some virtual master doesn't have an iommu slave
-	 */
-	pdev = platform_device_register_simple("rk_iommu_domain",
-					       PLATFORM_DEVID_AUTO, NULL, 0);
-	if (IS_ERR(pdev))
+	if (!dma_dev)
 		return NULL;
 
-	rk_domain = devm_kzalloc(&pdev->dev, sizeof(*rk_domain), GFP_KERNEL);
+	rk_domain = devm_kzalloc(dma_dev, sizeof(*rk_domain), GFP_KERNEL);
 	if (!rk_domain)
-		goto err_unreg_pdev;
-
-	rk_domain->pdev = pdev;
+		return NULL;
 
 	if (type == IOMMU_DOMAIN_DMA &&
 	    iommu_get_dma_cookie(&rk_domain->domain))
-		goto err_unreg_pdev;
+		return NULL;
 
 	/*
 	 * rk32xx iommus use a 2 level pagetable.
@@ -971,11 +962,10 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	if (!rk_domain->dt)
 		goto err_put_cookie;
 
-	iommu_dev = &pdev->dev;
-	rk_domain->dt_dma = dma_map_single(iommu_dev, rk_domain->dt,
+	rk_domain->dt_dma = dma_map_single(dma_dev, rk_domain->dt,
 					   SPAGE_SIZE, DMA_TO_DEVICE);
-	if (dma_mapping_error(iommu_dev, rk_domain->dt_dma)) {
-		dev_err(iommu_dev, "DMA map error for DT\n");
+	if (dma_mapping_error(dma_dev, rk_domain->dt_dma)) {
+		dev_err(dma_dev, "DMA map error for DT\n");
 		goto err_free_dt;
 	}
 
@@ -996,8 +986,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 err_put_cookie:
 	if (type == IOMMU_DOMAIN_DMA)
 		iommu_put_dma_cookie(&rk_domain->domain);
-err_unreg_pdev:
-	platform_device_unregister(pdev);
 
 	return NULL;
 }
@@ -1014,20 +1002,18 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 		if (rk_dte_is_pt_valid(dte)) {
 			phys_addr_t pt_phys = rk_dte_pt_address(dte);
 			u32 *page_table = phys_to_virt(pt_phys);
-			dma_unmap_single(&rk_domain->pdev->dev, pt_phys,
+			dma_unmap_single(dma_dev, pt_phys,
 					 SPAGE_SIZE, DMA_TO_DEVICE);
 			free_page((unsigned long)page_table);
 		}
 	}
 
-	dma_unmap_single(&rk_domain->pdev->dev, rk_domain->dt_dma,
+	dma_unmap_single(dma_dev, rk_domain->dt_dma,
 			 SPAGE_SIZE, DMA_TO_DEVICE);
 	free_page((unsigned long)rk_domain->dt);
 
 	if (domain->type == IOMMU_DOMAIN_DMA)
 		iommu_put_dma_cookie(&rk_domain->domain);
-
-	platform_device_unregister(rk_domain->pdev);
 }
 
 static bool rk_iommu_is_dev_iommu_master(struct device *dev)
@@ -1150,30 +1136,6 @@ static const struct iommu_ops rk_iommu_ops = {
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 };
 
-static int rk_iommu_domain_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-
-	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL);
-	if (!dev->dma_parms)
-		return -ENOMEM;
-
-	/* Set dma_ops for dev, otherwise it would be dummy_dma_ops */
-	arch_setup_dma_ops(dev, 0, DMA_BIT_MASK(32), NULL, false);
-
-	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
-	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
-
-	return 0;
-}
-
-static struct platform_driver rk_iommu_domain_driver = {
-	.probe = rk_iommu_domain_probe,
-	.driver = {
-		   .name = "rk_iommu_domain",
-	},
-};
-
 static int rk_iommu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1238,6 +1200,14 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		goto err_remove_sysfs;
 
+	/*
+	 * Use the first registered IOMMU device for domain to use with DMA
+	 * API, since a domain might not physically correspond to a single
+	 * IOMMU device..
+	 */
+	if (!dma_dev)
+		dma_dev = &pdev->dev;
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
@@ -1278,14 +1248,7 @@ static int __init rk_iommu_init(void)
 	if (ret)
 		return ret;
 
-	ret = platform_driver_register(&rk_iommu_domain_driver);
-	if (ret)
-		return ret;
-
-	ret = platform_driver_register(&rk_iommu_driver);
-	if (ret)
-		platform_driver_unregister(&rk_iommu_domain_driver);
-	return ret;
+	return platform_driver_register(&rk_iommu_driver);
 }
 subsys_initcall(rk_iommu_init);
 
-- 
2.11.0
