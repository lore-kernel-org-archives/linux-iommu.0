From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/06] iommu/ipmmu-vmsa: Break out 32-bit ARM mapping code
Date: Tue, 15 Dec 2015 21:02:58 +0900
Message-ID: <20151215120258.26216.81905.sendpatchset@little-apple>
References: <20151215120212.26216.61530.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151215120212.26216.61530.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Make the driver compile on more than just 32-bit ARM
by breaking out and wrapping ARM specific functions
in #ifdefs. Needed to be able to use the driver on
other architectures.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/iommu/ipmmu-vmsa.c |   94 +++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 32 deletions(-)

--- 0007/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 13:20:26.580513000 +0900
@@ -22,8 +22,10 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
+#ifdef CONFIG_ARM
 #include <asm/dma-iommu.h>
 #include <asm/pgalloc.h>
+#endif
 
 #include "io-pgtable.h"
 
@@ -38,7 +40,9 @@ struct ipmmu_vmsa_device {
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
 	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
 
+#ifdef CONFIG_ARM
 	struct dma_iommu_mapping *mapping;
+#endif
 };
 
 struct ipmmu_vmsa_domain {
@@ -621,6 +625,60 @@ static int ipmmu_find_utlbs(struct ipmmu
 	return 0;
 }
 
+#ifdef CONFIG_ARM
+static int ipmmu_map_attach(struct device *dev, struct ipmmu_vmsa_device *mmu)
+{
+	int ret;
+
+	/*
+	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
+	 * VAs. This will allocate a corresponding IOMMU domain.
+	 *
+	 * TODO:
+	 * - Create one mapping per context (TLB).
+	 * - Make the mapping size configurable ? We currently use a 2GB mapping
+	 *   at a 1GB offset to ensure that NULL VAs will fault.
+	 */
+	if (!mmu->mapping) {
+		struct dma_iommu_mapping *mapping;
+
+		mapping = arm_iommu_create_mapping(&platform_bus_type,
+						   SZ_1G, SZ_2G);
+		if (IS_ERR(mapping)) {
+			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
+			return PTR_ERR(mapping);
+		}
+
+		mmu->mapping = mapping;
+	}
+
+	/* Attach the ARM VA mapping to the device. */
+	ret = arm_iommu_attach_device(dev, mmu->mapping);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach device to VA mapping\n");
+		arm_iommu_release_mapping(mmu->mapping);
+	}
+
+	return ret;
+}
+static inline void ipmmu_detach(struct device *dev)
+{
+	arm_iommu_detach_device(dev);
+}
+static inline void ipmmu_release_mapping(struct ipmmu_vmsa_device *mmu)
+{
+	arm_iommu_release_mapping(mmu->mapping);
+}
+#else
+static inline int ipmmu_map_attach(struct device *dev,
+				   struct ipmmu_vmsa_device *mmu)
+{
+	return 0;
+}
+static inline void ipmmu_detach(struct device *dev) {}
+static inline void ipmmu_release_mapping(struct ipmmu_vmsa_device *mmu) {}
+#endif
+
 static int ipmmu_add_device(struct device *dev)
 {
 	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
@@ -701,41 +759,13 @@ static int ipmmu_add_device(struct devic
 	dev_data->num_utlbs = num_utlbs;
 	set_dev_data(dev, dev_data);
 
-	/*
-	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
-	 * VAs. This will allocate a corresponding IOMMU domain.
-	 *
-	 * TODO:
-	 * - Create one mapping per context (TLB).
-	 * - Make the mapping size configurable ? We currently use a 2GB mapping
-	 *   at a 1GB offset to ensure that NULL VAs will fault.
-	 */
-	if (!mmu->mapping) {
-		struct dma_iommu_mapping *mapping;
-
-		mapping = arm_iommu_create_mapping(&platform_bus_type,
-						   SZ_1G, SZ_2G);
-		if (IS_ERR(mapping)) {
-			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			ret = PTR_ERR(mapping);
-			goto error;
-		}
-
-		mmu->mapping = mapping;
-	}
-
-	/* Attach the ARM VA mapping to the device. */
-	ret = arm_iommu_attach_device(dev, mmu->mapping);
-	if (ret < 0) {
-		dev_err(dev, "Failed to attach device to VA mapping\n");
+	ret = ipmmu_map_attach(dev, mmu);
+	if (ret < 0)
 		goto error;
-	}
 
 	return 0;
 
 error:
-	arm_iommu_release_mapping(mmu->mapping);
-
 	kfree(dev_data);
 	kfree(utlbs);
 
@@ -751,7 +781,7 @@ static void ipmmu_remove_device(struct d
 {
 	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
 
-	arm_iommu_detach_device(dev);
+	ipmmu_detach(dev);
 	iommu_group_remove_device(dev);
 
 	kfree(dev_data->utlbs);
@@ -862,7 +892,7 @@ static int ipmmu_remove(struct platform_
 	list_del(&mmu->list);
 	spin_unlock(&ipmmu_devices_lock);
 
-	arm_iommu_release_mapping(mmu->mapping);
+	ipmmu_release_mapping(mmu);
 
 	ipmmu_device_reset(mmu);
 
