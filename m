From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Fri, 12 Sep 2014 17:34:53 +0100
Message-ID: <1410539695-29128-6-git-send-email-will.deacon@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410539695-29128-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch extends of_dma_configure so that it sets up the IOMMU for a
device, as well as the coherent/non-coherent DMA mapping ops.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h |  4 +++-
 drivers/of/platform.c              | 24 +++++++++++++++++-------
 include/linux/dma-mapping.h        |  8 +++++++-
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 7e9ac4f604c3..a8bb0c494bb3 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -121,7 +121,9 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
-static inline void arch_setup_dma_ops(struct device *dev, bool coherent)
+static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
+				      u64 size, struct iommu_dma_mapping *iommu,
+				      bool coherent)
 {
 	if (coherent)
 		set_dma_ops(dev, &arm_coherent_dma_ops);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 946dd7ae0394..95ebd38db545 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -166,6 +167,7 @@ static void of_dma_configure(struct platform_device *pdev)
 	int ret;
 	bool coherent;
 	unsigned long offset;
+	struct iommu_dma_mapping *iommu;
 	struct device *dev = &pdev->dev;
 
 	/*
@@ -195,7 +197,19 @@ static void of_dma_configure(struct platform_device *pdev)
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	arch_setup_dma_ops(dev, coherent);
+	iommu = of_iommu_configure(dev);
+	dev_dbg(dev, "device is%sbehind an iommu\n",
+		iommu ? " " : " not ");
+
+	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+
+	if (iommu)
+		kref_put(&iommu->kref, of_iommu_deconfigure);
+}
+
+static void of_dma_deconfigure(struct platform_device *pdev)
+{
+	arch_teardown_dma_ops(&pdev->dev);
 }
 
 /**
@@ -224,16 +238,12 @@ static struct platform_device *of_platform_device_create_pdata(
 	if (!dev)
 		goto err_clear_flag;
 
-	of_dma_configure(dev);
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
-
-	/* We do not fill the DMA ops for platform devices by default.
-	 * This is currently the responsibility of the platform code
-	 * to do such, possibly using a device notifier
-	 */
+	of_dma_configure(dev);
 
 	if (of_device_add(dev) != 0) {
+		of_dma_deconfigure(dev);
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e60e52d82db9..47e1ac30e300 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,7 +138,13 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 extern u64 dma_get_required_mask(struct device *dev);
 
 #ifndef arch_setup_dma_ops
-static inline void arch_setup_dma_ops(struct device *dev, bool coherent) { }
+static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
+				      u64 size, struct iommu_dma_mapping *iommu,
+				      bool coherent) { }
+#endif
+
+#ifndef arch_teardown_dma_ops
+static inline void arch_teardown_dma_ops(struct device *dev) { }
 #endif
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
-- 
2.1.0
