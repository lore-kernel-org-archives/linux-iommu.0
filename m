From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [RFC/PATCH 9/9] iommu/ipmmu-vmsa: Use DT-based instantiation
Date: Fri, 15 May 2015 02:00:10 +0300
Message-ID: <1431644410-2997-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 189 ++++++++++++++-------------------------------
 1 file changed, 60 insertions(+), 129 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 24a950091458..7fa2afb5d7d1 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -18,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -30,7 +32,6 @@
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
-	struct list_head list;
 
 	unsigned int num_utlbs;
 
@@ -54,9 +55,6 @@ struct ipmmu_vmsa_archdata {
 	unsigned int num_utlbs;
 };
 
-static DEFINE_SPINLOCK(ipmmu_devices_lock);
-static LIST_HEAD(ipmmu_devices);
-
 static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
@@ -578,110 +576,81 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 	return domain->iop->iova_to_phys(domain->iop, iova);
 }
 
-static int ipmmu_find_utlbs(struct ipmmu_vmsa_device *mmu, struct device *dev,
-			    unsigned int *utlbs, unsigned int num_utlbs)
+static void ipmmu_remove_device(struct device *dev)
 {
-	unsigned int i;
-
-	for (i = 0; i < num_utlbs; ++i) {
-		struct of_phandle_args args;
-		int ret;
-
-		ret = of_parse_phandle_with_args(dev->of_node, "iommus",
-						 "#iommu-cells", i, &args);
-		if (ret < 0)
-			return ret;
+	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 
-		of_node_put(args.np);
+	if (!archdata)
+		return;
 
-		if (args.np != mmu->dev->of_node || args.args_count != 1)
-			return -EINVAL;
+	arm_iommu_detach_device(dev);
+	iommu_group_remove_device(dev);
 
-		utlbs[i] = args.args[0];
-	}
+	kfree(archdata->utlbs);
+	kfree(archdata);
 
-	return 0;
+	dev->archdata.iommu = NULL;
 }
 
-static int ipmmu_add_device(struct device *dev)
+static int ipmmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	struct ipmmu_vmsa_archdata *archdata;
 	struct ipmmu_vmsa_device *mmu;
-	struct iommu_group *group = NULL;
+	struct platform_device *pdev;
+	unsigned int num_utlbs;
 	unsigned int *utlbs;
-	unsigned int i;
-	int num_utlbs;
-	int ret = -ENODEV;
-
-	if (dev->archdata.iommu) {
-		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
-			 dev_name(dev));
-		return -EINVAL;
-	}
+	unsigned int utlb;
+	int ret;
 
 	/* Find the master corresponding to the device. */
-
-	num_utlbs = of_count_phandle_with_args(dev->of_node, "iommus",
-					       "#iommu-cells");
-	if (num_utlbs < 0)
+	pdev = of_find_device_by_node(args->np);
+	if (!pdev) {
+		dev_dbg(dev, "%s: ipmmu pdev not found\n", __func__);
 		return -ENODEV;
-
-	utlbs = kcalloc(num_utlbs, sizeof(*utlbs), GFP_KERNEL);
-	if (!utlbs)
-		return -ENOMEM;
-
-	spin_lock(&ipmmu_devices_lock);
-
-	list_for_each_entry(mmu, &ipmmu_devices, list) {
-		ret = ipmmu_find_utlbs(mmu, dev, utlbs, num_utlbs);
-		if (!ret) {
-			/*
-			 * TODO Take a reference to the MMU to protect
-			 * against device removal.
-			 */
-			break;
-		}
 	}
 
-	spin_unlock(&ipmmu_devices_lock);
-
-	if (ret < 0)
+	mmu = platform_get_drvdata(pdev);
+	if (!mmu) {
+		dev_dbg(dev, "%s: ipmmu not found\n", __func__);
 		return -ENODEV;
-
-	for (i = 0; i < num_utlbs; ++i) {
-		if (utlbs[i] >= mmu->num_utlbs) {
-			ret = -EINVAL;
-			goto error;
-		}
 	}
 
-	/* Create a device group and add the device to it. */
-	group = iommu_group_alloc();
-	if (IS_ERR(group)) {
-		dev_err(dev, "Failed to allocate IOMMU group\n");
-		ret = PTR_ERR(group);
-		goto error;
+	/* Allocate arch data if not already done. */
+	if (!dev->archdata.iommu) {
+		dev->archdata.iommu = kzalloc(sizeof(*archdata), GFP_KERNEL);
+		if (!dev->archdata.iommu)
+			return -ENOMEM;
 	}
 
-	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
+	archdata = dev->archdata.iommu;
+	archdata->mmu = mmu;
 
-	if (ret < 0) {
-		dev_err(dev, "Failed to add device to IPMMU group\n");
-		group = NULL;
-		goto error;
+	/*
+	 * We don't support handling a device through different IOMMU
+	 * instances.
+	 */
+	if (archdata->mmu && archdata->mmu != mmu) {
+		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
+			 dev_name(dev));
+		return -EINVAL;
 	}
 
-	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
-	if (!archdata) {
-		ret = -ENOMEM;
-		goto error;
+	/* Validate and store the microTLB number. */
+	utlb = args->args[0];
+	if (utlb >= mmu->num_utlbs) {
+		dev_dbg(dev, "%s: invalid utlb %u\n", __func__, utlb);
+		return -EINVAL;
 	}
 
-	archdata->mmu = mmu;
+	num_utlbs = archdata->num_utlbs + 1;
+	utlbs = krealloc(archdata->utlbs, num_utlbs * sizeof(*utlbs),
+			 GFP_KERNEL);
+	if (utlbs == NULL)
+		return -ENOMEM;
+	utlbs[archdata->num_utlbs] = utlb;
+
 	archdata->utlbs = utlbs;
 	archdata->num_utlbs = num_utlbs;
-	dev->archdata.iommu = archdata;
 
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
@@ -699,50 +668,27 @@ static int ipmmu_add_device(struct device *dev)
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
 
-static void ipmmu_remove_device(struct device *dev)
-{
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
-
-	arm_iommu_detach_device(dev);
-	iommu_group_remove_device(dev);
-
-	kfree(archdata->utlbs);
-	kfree(archdata);
-
-	dev->archdata.iommu = NULL;
-}
-
-static const struct iommu_ops ipmmu_ops = {
+static struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc,
 	.domain_free = ipmmu_domain_free,
 	.attach_dev = ipmmu_attach_device,
@@ -751,8 +697,8 @@ static const struct iommu_ops ipmmu_ops = {
 	.unmap = ipmmu_unmap,
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = ipmmu_iova_to_phys,
-	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
+	.of_xlate = ipmmu_of_xlate,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 };
 
@@ -831,10 +777,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	 * ipmmu_init() after the probe function returns.
 	 */
 
-	spin_lock(&ipmmu_devices_lock);
-	list_add(&mmu->list, &ipmmu_devices);
-	spin_unlock(&ipmmu_devices_lock);
-
+	of_iommu_set_ops(mmu->dev->of_node, &ipmmu_ops);
 	platform_set_drvdata(pdev, mmu);
 
 	return 0;
@@ -844,10 +787,6 @@ static int ipmmu_remove(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu = platform_get_drvdata(pdev);
 
-	spin_lock(&ipmmu_devices_lock);
-	list_del(&mmu->list);
-	spin_unlock(&ipmmu_devices_lock);
-
 	arm_iommu_release_mapping(mmu->mapping);
 
 	ipmmu_device_reset(mmu);
@@ -883,14 +822,6 @@ static int __init ipmmu_init(void)
 	return 0;
 }
 
-static void __exit ipmmu_exit(void)
-{
-	return platform_driver_unregister(&ipmmu_driver);
-}
-
 subsys_initcall(ipmmu_init);
-module_exit(ipmmu_exit);
 
-MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
-MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>");
-MODULE_LICENSE("GPL v2");
+IOMMU_OF_DECLARE(ipmmu_vmsa_of, "renesas,ipmmu-vmsa", NULL);
-- 
2.3.6
