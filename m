From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 04/05] iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids
Date: Mon, 17 Jul 2017 22:05:41 +0900
Message-ID: <150029674139.22030.9234811024185570759.sendpatchset@little-apple>
References: <150029669967.22030.8059216113725566341.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150029669967.22030.8059216113725566341.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, sricharan@codeaurora.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Now when both 32-bit and 64-bit code inside the driver is using
fwspec it is possible to replace the utlb handling with fwspec ids
that get populated from ->of_xlate().

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Rebased to apply on top of earlier changes in series

 drivers/iommu/ipmmu-vmsa.c |  104 ++++++++------------------------------------
 1 file changed, 19 insertions(+), 85 deletions(-)

--- 0006/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-07-17 21:12:11.650607110 +0900
@@ -19,6 +19,7 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -59,8 +60,6 @@ struct ipmmu_vmsa_domain {
 
 struct ipmmu_vmsa_iommu_priv {
 	struct ipmmu_vmsa_device *mmu;
-	unsigned int *utlbs;
-	unsigned int num_utlbs;
 	struct device *dev;
 	struct list_head list;
 };
@@ -550,13 +549,14 @@ static int ipmmu_attach_device(struct io
 			       struct device *dev)
 {
 	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct ipmmu_vmsa_device *mmu = priv->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
 
-	if (!mmu) {
+	if (!priv || !priv->mmu) {
 		dev_err(dev, "Cannot attach to IPMMU\n");
 		return -ENXIO;
 	}
@@ -583,8 +583,8 @@ static int ipmmu_attach_device(struct io
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < priv->num_utlbs; ++i)
-		ipmmu_utlb_enable(domain, priv->utlbs[i]);
+	for (i = 0; i < fwspec->num_ids; ++i)
+		ipmmu_utlb_enable(domain, fwspec->ids[i]);
 
 	return 0;
 }
@@ -592,12 +592,12 @@ static int ipmmu_attach_device(struct io
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
-	struct ipmmu_vmsa_iommu_priv *priv = to_priv(dev);
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
 
-	for (i = 0; i < priv->num_utlbs; ++i)
-		ipmmu_utlb_disable(domain, priv->utlbs[i]);
+	for (i = 0; i < fwspec->num_ids; ++i)
+		ipmmu_utlb_disable(domain, fwspec->ids[i]);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -633,102 +633,36 @@ static phys_addr_t ipmmu_iova_to_phys(st
 	return domain->iop->iova_to_phys(domain->iop, iova);
 }
 
-static int ipmmu_find_utlbs(struct ipmmu_vmsa_device *mmu, struct device *dev,
-			    unsigned int *utlbs, unsigned int num_utlbs)
-{
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
-
-		of_node_put(args.np);
-
-		if (args.np != mmu->dev->of_node || args.args_count != 1)
-			return -EINVAL;
-
-		utlbs[i] = args.args[0];
-	}
-
-	return 0;
-}
-
-static int ipmmu_init_platform_device(struct device *dev)
+static int ipmmu_init_platform_device(struct device *dev,
+				      struct of_phandle_args *args)
 {
+	struct platform_device *ipmmu_pdev;
 	struct ipmmu_vmsa_iommu_priv *priv;
-	struct ipmmu_vmsa_device *mmu;
-	unsigned int *utlbs;
-	unsigned int i;
-	int num_utlbs;
-	int ret = -ENODEV;
-
-	/* Find the master corresponding to the device. */
 
-	num_utlbs = of_count_phandle_with_args(dev->of_node, "iommus",
-					       "#iommu-cells");
-	if (num_utlbs < 0)
+	ipmmu_pdev = of_find_device_by_node(args->np);
+	if (!ipmmu_pdev)
 		return -ENODEV;
 
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
-	}
-
-	spin_unlock(&ipmmu_devices_lock);
-
-	if (ret < 0)
-		goto error;
-
-	for (i = 0; i < num_utlbs; ++i) {
-		if (utlbs[i] >= mmu->num_utlbs) {
-			ret = -EINVAL;
-			goto error;
-		}
-	}
-
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto error;
-	}
+	if (!priv)
+		return -ENOMEM;
 
-	priv->mmu = mmu;
-	priv->utlbs = utlbs;
-	priv->num_utlbs = num_utlbs;
+	priv->mmu = platform_get_drvdata(ipmmu_pdev);
 	priv->dev = dev;
 	dev->iommu_fwspec->iommu_priv = priv;
 	return 0;
-
-error:
-	kfree(utlbs);
-	return ret;
 }
 
 static int ipmmu_of_xlate(struct device *dev,
 			  struct of_phandle_args *spec)
 {
+	iommu_fwspec_add_ids(dev, spec->args, 1);
+
 	/* Initialize once - xlate() will call multiple times */
 	if (to_priv(dev))
 		return 0;
 
-	return ipmmu_init_platform_device(dev);
+	return ipmmu_init_platform_device(dev, spec);
 }
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
