From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH/RFC] iommu/ipmmu-vmsa: Use DT-based instantiation
Date: Mon, 15 Dec 2014 02:24:02 +0200
Message-ID: <1418603042-12627-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417453034-21379-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 243 +++++++++++++++++----------------------------
 1 file changed, 93 insertions(+), 150 deletions(-)

Hi Will,

This patch is a proof of concept of the Renesas IPMMU-VMSA driver integration
with the DMA mapping core. The code is based on your "[PATCH v6 0/8] Introduce
automatic DMA configuration for IOMMU masters" series.

I'm not totally happy with the result, especially with the platform device
instantiation in the init function, and the ill-defined relationship of the
add_device and of_xlate callbacks.

Comments are welcome.

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 0e7a70e3a3d3..1bb3ba1e68b0 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -17,6 +17,8 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -27,7 +29,6 @@
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
-	struct list_head list;
 
 	unsigned int num_utlbs;
 
@@ -49,9 +50,6 @@ struct ipmmu_vmsa_archdata {
 	unsigned int num_utlbs;
 };
 
-static DEFINE_SPINLOCK(ipmmu_devices_lock);
-static LIST_HEAD(ipmmu_devices);
-
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
 
 /* -----------------------------------------------------------------------------
@@ -1004,117 +1002,16 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
 }
 
-static int ipmmu_find_utlbs(struct ipmmu_vmsa_device *mmu, struct device *dev,
-			    unsigned int **_utlbs)
-{
-	unsigned int *utlbs;
-	unsigned int i;
-	int count;
-
-	count = of_count_phandle_with_args(dev->of_node, "iommus",
-					   "#iommu-cells");
-	if (count < 0)
-		return -EINVAL;
-
-	utlbs = kcalloc(count, sizeof(*utlbs), GFP_KERNEL);
-	if (!utlbs)
-		return -ENOMEM;
-
-	for (i = 0; i < count; ++i) {
-		struct of_phandle_args args;
-		int ret;
-
-		ret = of_parse_phandle_with_args(dev->of_node, "iommus",
-						 "#iommu-cells", i, &args);
-		if (ret < 0)
-			goto error;
-
-		of_node_put(args.np);
-
-		if (args.np != mmu->dev->of_node || args.args_count != 1)
-			goto error;
-
-		utlbs[i] = args.args[0];
-	}
-
-	*_utlbs = utlbs;
-
-	return count;
-
-error:
-	kfree(utlbs);
-	return -EINVAL;
-}
-
 static int ipmmu_add_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata;
+	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 	struct ipmmu_vmsa_device *mmu;
-	struct iommu_group *group = NULL;
-	unsigned int *utlbs = NULL;
-	unsigned int i;
-	int num_utlbs = 0;
 	int ret;
 
-	if (dev->archdata.iommu) {
-		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
-			 dev_name(dev));
-		return -EINVAL;
-	}
-
-	/* Find the master corresponding to the device. */
-	spin_lock(&ipmmu_devices_lock);
-
-	list_for_each_entry(mmu, &ipmmu_devices, list) {
-		num_utlbs = ipmmu_find_utlbs(mmu, dev, &utlbs);
-		if (num_utlbs) {
-			/*
-			 * TODO Take a reference to the MMU to protect
-			 * against device removal.
-			 */
-			break;
-		}
-	}
-
-	spin_unlock(&ipmmu_devices_lock);
-
-	if (num_utlbs <= 0)
+	if (!archdata)
 		return -ENODEV;
 
-	for (i = 0; i < num_utlbs; ++i) {
-		if (utlbs[i] >= mmu->num_utlbs) {
-			ret = -EINVAL;
-			goto error;
-		}
-	}
-
-	/* Create a device group and add the device to it. */
-	group = iommu_group_alloc();
-	if (IS_ERR(group)) {
-		dev_err(dev, "Failed to allocate IOMMU group\n");
-		ret = PTR_ERR(group);
-		goto error;
-	}
-
-	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
-
-	if (ret < 0) {
-		dev_err(dev, "Failed to add device to IPMMU group\n");
-		group = NULL;
-		goto error;
-	}
-
-	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
-	if (!archdata) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	archdata->mmu = mmu;
-	archdata->utlbs = utlbs;
-	archdata->num_utlbs = num_utlbs;
-	dev->archdata.iommu = archdata;
+	mmu = archdata->mmu;
 
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
@@ -1132,34 +1029,24 @@ static int ipmmu_add_device(struct device *dev)
 						   SZ_1G, SZ_2G);
 		if (IS_ERR(mapping)) {
 			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			ret = PTR_ERR(mapping);
-			goto error;
+			return PTR_ERR(mapping);
 		}
 
 		mmu->mapping = mapping;
 	}
 
-	/* Attach the ARM VA mapping to the device. */
+	/*
+	 * Detach the device from the default ARM VA mapping and attach it to
+	 * our private mapping.
+	 */
+	arm_iommu_detach_device(dev);
 	ret = arm_iommu_attach_device(dev, mmu->mapping);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach device to VA mapping\n");
-		goto error;
+		return ret;
 	}
 
 	return 0;
-
-error:
-	arm_iommu_release_mapping(mmu->mapping);
-
-	kfree(dev->archdata.iommu);
-	kfree(utlbs);
-
-	dev->archdata.iommu = NULL;
-
-	if (!IS_ERR_OR_NULL(group))
-		iommu_group_remove_device(dev);
-
-	return ret;
 }
 
 static void ipmmu_remove_device(struct device *dev)
@@ -1175,6 +1062,68 @@ static void ipmmu_remove_device(struct device *dev)
 	dev->archdata.iommu = NULL;
 }
 
+static int ipmmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	struct ipmmu_vmsa_archdata *archdata;
+	struct ipmmu_vmsa_device *mmu;
+	struct platform_device *pdev;
+	unsigned int num_utlbs;
+	unsigned int *utlbs;
+	unsigned int utlb;
+
+	/* Find the master corresponding to the device. */
+	pdev = of_find_device_by_node(args->np);
+	if (!pdev) {
+		dev_dbg(dev, "%s: ipmmu pdev not found\n", __func__);
+		return -ENODEV;
+	}
+
+	mmu = platform_get_drvdata(pdev);
+	if (!mmu) {
+		dev_dbg(dev, "%s: ipmmu not found\n", __func__);
+		return -ENODEV;
+	}
+
+	/* Allocate arch data if not already done. */
+	if (!dev->archdata.iommu) {
+		dev->archdata.iommu = kzalloc(sizeof(*archdata), GFP_KERNEL);
+		if (!dev->archdata.iommu)
+			return -ENOMEM;
+	}
+
+	archdata = dev->archdata.iommu;
+	archdata->mmu = mmu;
+
+	/*
+	 * We don't support handling a device through different IOMMU
+	 * instances.
+	 */
+	if (archdata->mmu && archdata->mmu != mmu) {
+		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
+			 dev_name(dev));
+		return -EINVAL;
+	}
+
+	/* Validate and store the microTLB number. */
+	utlb = args->args[0];
+	if (utlb >= mmu->num_utlbs) {
+		dev_dbg(dev, "%s: invalid utlb %u\n", __func__, utlb);
+		return -EINVAL;
+	}
+
+	num_utlbs = archdata->num_utlbs + 1;
+	utlbs = krealloc(archdata->utlbs, num_utlbs * sizeof(*utlbs),
+			 GFP_KERNEL);
+	if (utlbs == NULL)
+		return -ENOMEM;
+	utlbs[archdata->num_utlbs] = utlb;
+
+	archdata->utlbs = utlbs;
+	archdata->num_utlbs = num_utlbs;
+
+	return 0;
+}
+
 static const struct iommu_ops ipmmu_ops = {
 	.domain_init = ipmmu_domain_init,
 	.domain_destroy = ipmmu_domain_destroy,
@@ -1185,6 +1134,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
+	.of_xlate = ipmmu_of_xlate,
 	.pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K,
 };
 
@@ -1249,10 +1199,6 @@ static int ipmmu_probe(struct platform_device *pdev)
 	 * ipmmu_init() after the probe function returns.
 	 */
 
-	spin_lock(&ipmmu_devices_lock);
-	list_add(&mmu->list, &ipmmu_devices);
-	spin_unlock(&ipmmu_devices_lock);
-
 	platform_set_drvdata(pdev, mmu);
 
 	return 0;
@@ -1262,10 +1208,6 @@ static int ipmmu_remove(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu = platform_get_drvdata(pdev);
 
-	spin_lock(&ipmmu_devices_lock);
-	list_del(&mmu->list);
-	spin_unlock(&ipmmu_devices_lock);
-
 	arm_iommu_release_mapping(mmu->mapping);
 
 	ipmmu_device_reset(mmu);
@@ -1287,28 +1229,29 @@ static struct platform_driver ipmmu_driver = {
 	.remove	= ipmmu_remove,
 };
 
-static int __init ipmmu_init(void)
+static int __init ipmmu_of_setup(struct device_node *np)
 {
+	static bool init_done;
+	struct platform_device *pdev;
 	int ret;
 
-	ret = platform_driver_register(&ipmmu_driver);
-	if (ret < 0)
-		return ret;
+	if (!init_done) {
+		ret = platform_driver_register(&ipmmu_driver);
+		if (ret < 0)
+			return ret;
 
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
+		if (!iommu_present(&platform_bus_type))
+			bus_set_iommu(&platform_bus_type, &ipmmu_ops);
 
-	return 0;
-}
+		init_done = true;
+	}
 
-static void __exit ipmmu_exit(void)
-{
-	return platform_driver_unregister(&ipmmu_driver);
-}
+	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
 
-subsys_initcall(ipmmu_init);
-module_exit(ipmmu_exit);
+	of_iommu_set_ops(np, &ipmmu_ops);
+	return 0;
+}
 
-MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
-MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>");
-MODULE_LICENSE("GPL v2");
+IOMMU_OF_DECLARE(ipmmu_vmsa_of, "renesas,ipmmu-vmsa", ipmmu_of_setup);
-- 
Regards,

Laurent Pinchart
