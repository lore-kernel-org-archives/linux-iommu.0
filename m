From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 07/10] iommu/ipmmu-vmsa: Support multiple micro TLBs per device
Date: Tue, 16 Dec 2014 15:44:14 +0200
Message-ID: <1418737457-22042-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Devices such as the system DMA controller are connected to multiple
micro TLBs of the same IOMMU. Support this.

Selective enabling of micro TLBs based on runtime device usage isn't
possible at the moment due to lack of support in the IOMMU and DMA
mapping APIs. Support for devices connected to different IOMMUs is also
unsupported for the same reason.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 115 +++++++++++++++++++++++++++++++++------------
 1 file changed, 86 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8d9b3e79f05c..b6a11f82259f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -47,7 +47,8 @@ struct ipmmu_vmsa_domain {
 
 struct ipmmu_vmsa_archdata {
 	struct ipmmu_vmsa_device *mmu;
-	unsigned int utlb;
+	unsigned int *utlbs;
+	unsigned int num_utlbs;
 };
 
 static DEFINE_SPINLOCK(ipmmu_devices_lock);
@@ -900,6 +901,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	struct ipmmu_vmsa_device *mmu = archdata->mmu;
 	struct ipmmu_vmsa_domain *domain = io_domain->priv;
 	unsigned long flags;
+	unsigned int i;
 	int ret = 0;
 
 	if (!mmu) {
@@ -928,7 +930,8 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	if (ret < 0)
 		return ret;
 
-	ipmmu_utlb_enable(domain, archdata->utlb);
+	for (i = 0; i < archdata->num_utlbs; ++i)
+		ipmmu_utlb_enable(domain, archdata->utlbs[i]);
 
 	return 0;
 }
@@ -938,8 +941,10 @@ static void ipmmu_detach_device(struct iommu_domain *io_domain,
 {
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 	struct ipmmu_vmsa_domain *domain = io_domain->priv;
+	unsigned int i;
 
-	ipmmu_utlb_disable(domain, archdata->utlb);
+	for (i = 0; i < archdata->num_utlbs; ++i)
+		ipmmu_utlb_disable(domain, archdata->utlbs[i]);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -1003,10 +1008,12 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
 }
 
-static int ipmmu_find_utlb(struct ipmmu_vmsa_device *mmu, struct device *dev)
+static int ipmmu_find_utlbs(struct ipmmu_vmsa_device *mmu, struct device *dev,
+			    unsigned int **_utlbs)
 {
-	struct of_phandle_args args;
-	int ret;
+	unsigned int *utlbs;
+	unsigned int i;
+	int count;
 
 	if (mmu->pdata) {
 		const struct ipmmu_vmsa_master *master = mmu->pdata->masters;
@@ -1014,32 +1021,64 @@ static int ipmmu_find_utlb(struct ipmmu_vmsa_device *mmu, struct device *dev)
 		unsigned int i;
 
 		for (i = 0; i < mmu->pdata->num_masters; ++i, ++master) {
-			if (strcmp(master->name, devname) == 0)
-				return master->utlb;
+			if (strcmp(master->name, devname) == 0) {
+				utlbs = kmalloc(sizeof(*utlbs), GFP_KERNEL);
+				if (!utlbs)
+					return -ENOMEM;
+
+				utlbs[0] = master->utlb;
+
+				*_utlbs = utlbs;
+				return 1;
+			}
 		}
 
-		return -1;
+		return -EINVAL;
 	}
 
-	ret = of_parse_phandle_with_args(dev->of_node, "iommus",
-					 "#iommu-cells", 0, &args);
-	if (ret < 0)
-		return -1;
+	count = of_count_phandle_with_args(dev->of_node, "iommus",
+					   "#iommu-cells");
+	if (count < 0)
+		return -EINVAL;
+
+	utlbs = kcalloc(count, sizeof(*utlbs), GFP_KERNEL);
+	if (!utlbs)
+		return -ENOMEM;
+
+	for (i = 0; i < count; ++i) {
+		struct of_phandle_args args;
+		int ret;
+
+		ret = of_parse_phandle_with_args(dev->of_node, "iommus",
+						 "#iommu-cells", i, &args);
+		if (ret < 0)
+			goto error;
+
+		of_node_put(args.np);
+
+		if (args.np != mmu->dev->of_node || args.args_count != 1)
+			goto error;
+
+		utlbs[i] = args.args[0];
+	}
 
-	of_node_put(args.np);
+	*_utlbs = utlbs;
 
-	if (args.np != mmu->dev->of_node || args.args_count != 1)
-		return -1;
+	return count;
 
-	return args.args[0];
+error:
+	kfree(utlbs);
+	return -EINVAL;
 }
 
 static int ipmmu_add_device(struct device *dev)
 {
 	struct ipmmu_vmsa_archdata *archdata;
 	struct ipmmu_vmsa_device *mmu;
-	struct iommu_group *group;
-	int utlb = -1;
+	struct iommu_group *group = NULL;
+	unsigned int *utlbs = NULL;
+	unsigned int i;
+	int num_utlbs = 0;
 	int ret;
 
 	if (dev->archdata.iommu) {
@@ -1052,8 +1091,8 @@ static int ipmmu_add_device(struct device *dev)
 	spin_lock(&ipmmu_devices_lock);
 
 	list_for_each_entry(mmu, &ipmmu_devices, list) {
-		utlb = ipmmu_find_utlb(mmu, dev);
-		if (utlb >= 0) {
+		num_utlbs = ipmmu_find_utlbs(mmu, dev, &utlbs);
+		if (num_utlbs) {
 			/*
 			 * TODO Take a reference to the MMU to protect
 			 * against device removal.
@@ -1064,17 +1103,22 @@ static int ipmmu_add_device(struct device *dev)
 
 	spin_unlock(&ipmmu_devices_lock);
 
-	if (utlb < 0)
+	if (num_utlbs <= 0)
 		return -ENODEV;
 
-	if (utlb >= mmu->num_utlbs)
-		return -EINVAL;
+	for (i = 0; i < num_utlbs; ++i) {
+		if (utlbs[i] >= mmu->num_utlbs) {
+			ret = -EINVAL;
+			goto error;
+		}
+	}
 
 	/* Create a device group and add the device to it. */
 	group = iommu_group_alloc();
 	if (IS_ERR(group)) {
 		dev_err(dev, "Failed to allocate IOMMU group\n");
-		return PTR_ERR(group);
+		ret = PTR_ERR(group);
+		goto error;
 	}
 
 	ret = iommu_group_add_device(group, dev);
@@ -1082,7 +1126,8 @@ static int ipmmu_add_device(struct device *dev)
 
 	if (ret < 0) {
 		dev_err(dev, "Failed to add device to IPMMU group\n");
-		return ret;
+		group = NULL;
+		goto error;
 	}
 
 	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
@@ -1092,7 +1137,8 @@ static int ipmmu_add_device(struct device *dev)
 	}
 
 	archdata->mmu = mmu;
-	archdata->utlb = utlb;
+	archdata->utlbs = utlbs;
+	archdata->num_utlbs = num_utlbs;
 	dev->archdata.iommu = archdata;
 
 	/*
@@ -1129,17 +1175,28 @@ static int ipmmu_add_device(struct device *dev)
 
 error:
 	arm_iommu_release_mapping(mmu->mapping);
+
 	kfree(dev->archdata.iommu);
+	kfree(utlbs);
+
 	dev->archdata.iommu = NULL;
-	iommu_group_remove_device(dev);
+
+	if (!IS_ERR_OR_NULL(group))
+		iommu_group_remove_device(dev);
+
 	return ret;
 }
 
 static void ipmmu_remove_device(struct device *dev)
 {
+	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
-	kfree(dev->archdata.iommu);
+
+	kfree(archdata->utlbs);
+	kfree(archdata);
+
 	dev->archdata.iommu = NULL;
 }
 
-- 
2.0.4

