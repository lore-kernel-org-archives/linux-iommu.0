From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 3/6] iommu/rockchip: support virtual iommu slave device
Date: Wed, 15 Jun 2016 20:04:42 +0800
Message-ID: <1465992285-16187-4-git-send-email-zhengsq@rock-chips.com>
References: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465992285-16187-1-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

An virtual master device like DRM need to attach to iommu
domain to share the mapping with VOPs(the one with actual
iommu slaves).
DRM attaches to iommu and allocates buffers before VOPs enabled,
which means there may have not real iommu devices can be used
to do dma mapping.

This patch creates a iommu when virtual master(group is NULL)
attaching, so it can use this iommu even the real iommus disabled.

Changes of V3:
- Instead of registering virtual iommu in DTS, this patch
  creates a iommu when attaching.

Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Suggested-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 133 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 122 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 3c16ec3..82ecc99 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dma-iommu.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -93,6 +94,14 @@ struct rk_iommu {
 	struct iommu_domain *domain; /* domain to which iommu is attached */
 };
 
+/* A virtual iommu registered without resource or
+ * interrupts when DRM attaching.
+ */
+static inline bool rk_iommu_is_virtual(struct rk_iommu *iommu)
+{
+	return iommu->num_mmu == 0;
+}
+
 static inline void rk_table_flush(u32 *va, unsigned int count)
 {
 	phys_addr_t pa_start = virt_to_phys(va);
@@ -780,6 +789,85 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 	return rk_iommu;
 }
 
+static struct rk_iommu *rk_iommu_add_virtual_iommu(struct device *dev,
+					struct rk_iommu_domain *rk_domain)
+{
+	struct rk_iommu *iommu;
+	struct iommu_group *group;
+	struct platform_device *pdev;
+	struct device *iommu_dev;
+	int ret;
+
+	pdev = platform_device_register_simple("rk_iommu", PLATFORM_DEVID_AUTO,
+					       NULL, 0);
+	if (IS_ERR(pdev)) {
+		dev_err(dev, "Failed to register simple rk_iommu device\n");
+		return NULL;
+	}
+
+	iommu_dev = &pdev->dev;
+	iommu_dev->dma_parms = devm_kzalloc(iommu_dev,
+				sizeof(*iommu_dev->dma_parms), GFP_KERNEL);
+	if (!iommu_dev->dma_parms)
+		goto err_unreg_pdev;
+
+	/* Set dma_ops for virtual iommu, otherwise it would be dummy_dma_ops */
+	arch_setup_dma_ops(iommu_dev, 0, DMA_BIT_MASK(32), NULL, false);
+
+	dma_set_max_seg_size(iommu_dev, DMA_BIT_MASK(32));
+	dma_coerce_mask_and_coherent(iommu_dev, DMA_BIT_MASK(32));
+
+	iommu = devm_kzalloc(iommu_dev, sizeof(*iommu), GFP_KERNEL);
+	if (!iommu)
+		goto err_unreg_pdev;
+
+	iommu->dev = iommu_dev;
+	iommu->num_mmu = 0;
+	platform_set_drvdata(pdev, iommu);
+
+	group = iommu_group_alloc();
+	if (IS_ERR(group)) {
+		dev_err(iommu_dev, "Failed to allocate IOMMU group\n");
+		goto err_unreg_pdev;
+	}
+
+	ret = iommu_group_add_device(group, dev);
+	if (ret) {
+		dev_err(iommu_dev, "Failed to add device to group\n");
+		goto err_put_group;
+	}
+
+	iommu_group_set_iommudata(group, iommu_dev, NULL);
+
+	ret = iommu_attach_group(&rk_domain->domain, group);
+	if (ret) {
+		dev_err(iommu_dev, "Failed to attach group\n");
+		goto err_remove_device;
+	}
+
+	iommu_group_put(group);
+
+	return iommu;
+
+err_remove_device:
+	iommu_group_remove_device(dev);
+err_put_group:
+	iommu_group_put(group);
+err_unreg_pdev:
+	platform_device_unregister(pdev);
+
+	return NULL;
+}
+
+static void rk_iommu_remove_virtual_iommu(struct device *dev)
+{
+	struct rk_iommu *iommu = rk_iommu_from_dev(dev);
+	struct platform_device *pdev = to_platform_device(iommu->dev);
+
+	iommu_group_remove_device(dev);
+	platform_device_unregister(pdev);
+}
+
 static int rk_iommu_attach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
@@ -789,13 +877,20 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	int ret, i;
 	phys_addr_t dte_addr;
 
-	/*
-	 * Allow 'virtual devices' (e.g., drm) to attach to domain.
-	 * Such a device does not belong to an iommu group.
-	 */
 	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
+
+	/* Register iommu for virtual master(like DRM) */
+	if (!iommu) {
+		iommu = rk_iommu_add_virtual_iommu(dev, rk_domain);
+		if (!iommu)
+			return -ENOMEM;
+	}
+
+	iommu->domain = domain;
+	if (rk_iommu_is_virtual(iommu)) {
+		dev_dbg(dev, "Attach virtual device to iommu domain\n");
 		return 0;
+	}
 
 	ret = rk_iommu_enable_stall(iommu);
 	if (ret)
@@ -805,7 +900,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	iommu->domain = domain;
 
 	ret = devm_request_irq(iommu->dev, iommu->irq, rk_iommu_irq,
 			       IRQF_SHARED, dev_name(dev), iommu);
@@ -842,10 +936,14 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	unsigned long flags;
 	int i;
 
-	/* Allow 'virtual devices' (eg drm) to detach from domain */
 	iommu = rk_iommu_from_dev(dev);
-	if (!iommu)
+
+	if (rk_iommu_is_virtual(iommu)) {
+		rk_iommu_remove_virtual_iommu(dev);
+		iommu->domain = NULL;
+		dev_dbg(dev, "Master with virtual iommu detached\n");
 		return;
+	}
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_del_init(&iommu->node);
@@ -861,7 +959,6 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	rk_iommu_disable_stall(iommu);
 
 	devm_free_irq(iommu->dev, iommu->irq, iommu);
-
 	iommu->domain = NULL;
 
 	dev_dbg(dev, "Detached from iommu domain\n");
@@ -878,6 +975,9 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	if (!rk_domain)
 		return NULL;
 
+	if (iommu_get_dma_cookie(&rk_domain->domain))
+		goto err_dt;
+
 	/*
 	 * rk32xx iommus use a 2 level pagetable.
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
@@ -917,6 +1017,9 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 	}
 
 	free_page((unsigned long)rk_domain->dt);
+
+	iommu_put_dma_cookie(&rk_domain->domain);
+
 	kfree(rk_domain);
 }
 
@@ -1034,8 +1137,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rk_iommu *iommu;
 	struct resource *res;
+	int num_res = pdev->num_resources;
 	int i;
 
+	/* This is iommu register in rk_iommu_add_virtual_iommu()
+	 * when virtual device attaching.
+	 */
+	if (num_res == 0)
+		return 0;
+
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
 		return -ENOMEM;
@@ -1043,12 +1153,13 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, iommu);
 	iommu->dev = dev;
 	iommu->num_mmu = 0;
-	iommu->bases = devm_kzalloc(dev, sizeof(*iommu->bases) * iommu->num_mmu,
+
+	iommu->bases = devm_kzalloc(dev, sizeof(*iommu->bases) * num_res,
 				    GFP_KERNEL);
 	if (!iommu->bases)
 		return -ENOMEM;
 
-	for (i = 0; i < pdev->num_resources; i++) {
+	for (i = 0; i < num_res; i++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		if (!res)
 			continue;
-- 
1.9.1
