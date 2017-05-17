From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 05/08] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Wed, 17 May 2017 19:07:10 +0900
Message-ID: <149501563010.21593.2577334360194191792.sendpatchset@little-apple>
References: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce an alternative set of iommu_ops suitable for 64-bit ARM
as well as 32-bit ARM when CONFIG_IOMMU_DMA=y. Also adjust the
Kconfig to depend on ARM or IOMMU_DMA. Initialize the device
from ->xlate() when CONFIG_IOMMU_DMA=y.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V7:
 - None

 drivers/iommu/Kconfig      |    1 
 drivers/iommu/ipmmu-vmsa.c |  164 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 156 insertions(+), 9 deletions(-)

--- 0001/drivers/iommu/Kconfig
+++ work/drivers/iommu/Kconfig	2017-05-17 16:41:43.030607110 +0900
@@ -274,6 +274,7 @@ config EXYNOS_IOMMU_DEBUG
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
+	depends on ARM || IOMMU_DMA
 	depends on ARM_LPAE
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select IOMMU_API
--- 0009/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-05-17 16:42:02.730607110 +0900
@@ -10,6 +10,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/delay.h>
+#include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -22,8 +23,10 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
+#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
 #include <asm/pgalloc.h>
+#endif
 
 #include "io-pgtable.h"
 
@@ -57,6 +60,8 @@ struct ipmmu_vmsa_archdata {
 	struct ipmmu_vmsa_device *mmu;
 	unsigned int *utlbs;
 	unsigned int num_utlbs;
+	struct device *dev;
+	struct list_head list;
 };
 
 static DEFINE_SPINLOCK(ipmmu_devices_lock);
@@ -522,14 +527,6 @@ static struct iommu_domain *__ipmmu_doma
 	return &domain->io_domain;
 }
 
-static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
-{
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-
-	return __ipmmu_domain_alloc(type);
-}
-
 static void ipmmu_domain_free(struct iommu_domain *io_domain)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
@@ -572,7 +569,8 @@ static int ipmmu_attach_device(struct io
 		dev_err(dev, "Can't attach IPMMU %s to domain on IPMMU %s\n",
 			dev_name(mmu->dev), dev_name(domain->mmu->dev));
 		ret = -EINVAL;
-	}
+	} else
+		dev_info(dev, "Reusing IPMMU context %u\n", domain->context_id);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 
@@ -708,6 +706,7 @@ static int ipmmu_init_platform_device(st
 	archdata->mmu = mmu;
 	archdata->utlbs = utlbs;
 	archdata->num_utlbs = num_utlbs;
+	archdata->dev = dev;
 	dev->archdata.iommu = archdata;
 	return 0;
 
@@ -716,6 +715,16 @@ error:
 	return ret;
 }
 
+#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
+
+static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
+{
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	return __ipmmu_domain_alloc(type);
+}
+
 static int ipmmu_add_device(struct device *dev)
 {
 	struct ipmmu_vmsa_archdata *archdata;
@@ -825,6 +834,141 @@ static const struct iommu_ops ipmmu_ops
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 };
 
+#endif /* !CONFIG_ARM && CONFIG_IOMMU_DMA */
+
+#ifdef CONFIG_IOMMU_DMA
+
+static DEFINE_SPINLOCK(ipmmu_slave_devices_lock);
+static LIST_HEAD(ipmmu_slave_devices);
+
+static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)
+{
+	struct iommu_domain *io_domain = NULL;
+
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		io_domain = __ipmmu_domain_alloc(type);
+		break;
+
+	case IOMMU_DOMAIN_DMA:
+		io_domain = __ipmmu_domain_alloc(type);
+		if (io_domain)
+			iommu_get_dma_cookie(io_domain);
+		break;
+	}
+
+	return io_domain;
+}
+
+static void ipmmu_domain_free_dma(struct iommu_domain *io_domain)
+{
+	switch (io_domain->type) {
+	case IOMMU_DOMAIN_DMA:
+		iommu_put_dma_cookie(io_domain);
+		/* fall-through */
+	default:
+		ipmmu_domain_free(io_domain);
+		break;
+	}
+}
+
+static int ipmmu_add_device_dma(struct device *dev)
+{
+	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct iommu_group *group;
+
+	/* The device has been verified in xlate() */
+	if (!archdata)
+		return -ENODEV;
+
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	spin_lock(&ipmmu_slave_devices_lock);
+	list_add(&archdata->list, &ipmmu_slave_devices);
+	spin_unlock(&ipmmu_slave_devices_lock);
+	return 0;
+}
+
+static void ipmmu_remove_device_dma(struct device *dev)
+{
+	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+
+	spin_lock(&ipmmu_slave_devices_lock);
+	list_del(&archdata->list);
+	spin_unlock(&ipmmu_slave_devices_lock);
+
+	iommu_group_remove_device(dev);
+}
+
+static struct device *ipmmu_find_sibling_device(struct device *dev)
+{
+	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_archdata *sibling_archdata = NULL;
+	bool found = false;
+
+	spin_lock(&ipmmu_slave_devices_lock);
+
+	list_for_each_entry(sibling_archdata, &ipmmu_slave_devices, list) {
+		if (archdata == sibling_archdata)
+			continue;
+		if (sibling_archdata->mmu == archdata->mmu) {
+			found = true;
+			break;
+		}
+	}
+
+	spin_unlock(&ipmmu_slave_devices_lock);
+
+	return found ? sibling_archdata->dev : NULL;
+}
+
+static struct iommu_group *ipmmu_find_group_dma(struct device *dev)
+{
+	struct iommu_group *group;
+	struct device *sibling;
+
+	sibling = ipmmu_find_sibling_device(dev);
+	if (sibling)
+		group = iommu_group_get(sibling);
+	if (!sibling || IS_ERR(group))
+		group = generic_device_group(dev);
+
+	return group;
+}
+
+static int ipmmu_of_xlate_dma(struct device *dev,
+			      struct of_phandle_args *spec)
+{
+	/* If the IPMMU device is disabled in DT then return error
+	 * to make sure the of_iommu code does not install ops
+	 * even though the iommu device is disabled
+	 */
+	if (!of_device_is_available(spec->np))
+		return -ENODEV;
+
+	return ipmmu_init_platform_device(dev);
+}
+
+static const struct iommu_ops ipmmu_ops = {
+	.domain_alloc = ipmmu_domain_alloc_dma,
+	.domain_free = ipmmu_domain_free_dma,
+	.attach_dev = ipmmu_attach_device,
+	.detach_dev = ipmmu_detach_device,
+	.map = ipmmu_map,
+	.unmap = ipmmu_unmap,
+	.map_sg = default_iommu_map_sg,
+	.iova_to_phys = ipmmu_iova_to_phys,
+	.add_device = ipmmu_add_device_dma,
+	.remove_device = ipmmu_remove_device_dma,
+	.device_group = ipmmu_find_group_dma,
+	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
+	.of_xlate = ipmmu_of_xlate_dma,
+};
+
+#endif /* CONFIG_IOMMU_DMA */
+
 /* -----------------------------------------------------------------------------
  * Probe/remove and init
  */
@@ -914,7 +1058,9 @@ static int ipmmu_remove(struct platform_
 	list_del(&mmu->list);
 	spin_unlock(&ipmmu_devices_lock);
 
+#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 	arm_iommu_release_mapping(mmu->mapping);
+#endif
 
 	ipmmu_device_reset(mmu);
 
