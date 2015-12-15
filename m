From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC 07/10] iommu/ipmmu-vmsa: Break out utlb parsing code
Date: Tue, 15 Dec 2015 22:06:14 +0900
Message-ID: <20151215130614.13535.5206.sendpatchset@little-apple>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Break out the utlb parsing code and dev_data allocation into a
separate function. This is preparation for future code sharing.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |  126 ++++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 56 deletions(-)

--- 0012/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-14 18:56:47.020513000 +0900
@@ -607,6 +607,69 @@ static int ipmmu_find_utlbs(struct ipmmu
 	return 0;
 }
 
+static int ipmmu_init_platform_device(struct device *dev,
+				      struct iommu_group *group)
+{
+	struct ipmmu_vmsa_dev_data *dev_data;
+	struct ipmmu_vmsa_device *mmu;
+	unsigned int *utlbs;
+	unsigned int i;
+	int num_utlbs;
+	int ret = -ENODEV;
+
+	/* Find the master corresponding to the device. */
+
+	num_utlbs = of_count_phandle_with_args(dev->of_node, "iommus",
+					       "#iommu-cells");
+	if (num_utlbs < 0)
+		return -ENODEV;
+
+	utlbs = kcalloc(num_utlbs, sizeof(*utlbs), GFP_KERNEL);
+	if (!utlbs)
+		return -ENOMEM;
+
+	spin_lock(&ipmmu_devices_lock);
+
+	list_for_each_entry(mmu, &ipmmu_devices, list) {
+		ret = ipmmu_find_utlbs(mmu, dev, utlbs, num_utlbs);
+		if (!ret) {
+			/*
+			 * TODO Take a reference to the MMU to protect
+			 * against device removal.
+			 */
+			break;
+		}
+	}
+
+	spin_unlock(&ipmmu_devices_lock);
+
+	if (ret < 0)
+		goto error;
+
+	for (i = 0; i < num_utlbs; ++i) {
+		if (utlbs[i] >= mmu->num_utlbs) {
+			ret = -EINVAL;
+			goto error;
+		}
+	}
+
+	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	dev_data->mmu = mmu;
+	dev_data->utlbs = utlbs;
+	dev_data->num_utlbs = num_utlbs;
+	set_dev_data(dev, dev_data);
+	return 0;
+
+error:
+	kfree(utlbs);
+	return ret;
+}
+
 #ifdef CONFIG_ARM
 static int ipmmu_map_attach(struct device *dev, struct ipmmu_vmsa_device *mmu)
 {
@@ -663,56 +726,15 @@ static inline void ipmmu_release_mapping
 
 static int ipmmu_add_device(struct device *dev)
 {
-	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
-	struct ipmmu_vmsa_device *mmu;
-	struct iommu_group *group = NULL;
-	unsigned int *utlbs;
-	unsigned int i;
-	int num_utlbs;
-	int ret = -ENODEV;
+	struct iommu_group *group;
+	int ret;
 
-	if (dev_data) {
+	if (get_dev_data(dev)) {
 		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
 			 dev_name(dev));
 		return -EINVAL;
 	}
 
-	/* Find the master corresponding to the device. */
-
-	num_utlbs = of_count_phandle_with_args(dev->of_node, "iommus",
-					       "#iommu-cells");
-	if (num_utlbs < 0)
-		return -ENODEV;
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
-	}
-
-	spin_unlock(&ipmmu_devices_lock);
-
-	if (ret < 0)
-		return -ENODEV;
-
-	for (i = 0; i < num_utlbs; ++i) {
-		if (utlbs[i] >= mmu->num_utlbs) {
-			ret = -EINVAL;
-			goto error;
-		}
-	}
-
 	/* Create a device group and add the device to it. */
 	group = iommu_group_alloc();
 	if (IS_ERR(group)) {
@@ -730,27 +752,19 @@ static int ipmmu_add_device(struct devic
 		goto error;
 	}
 
-	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
-	if (!dev_data) {
-		ret = -ENOMEM;
+	ret = ipmmu_init_platform_device(dev, group);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init platform device\n");
 		goto error;
 	}
 
-	dev_data->mmu = mmu;
-	dev_data->utlbs = utlbs;
-	dev_data->num_utlbs = num_utlbs;
-	set_dev_data(dev, dev_data);
-
-	ret = ipmmu_map_attach(dev, mmu);
+	ret = ipmmu_map_attach(dev, get_dev_data(dev)->mmu);
 	if (ret < 0)
 		goto error;
 
 	return 0;
 
 error:
-	kfree(dev_data);
-	kfree(utlbs);
-
 	set_dev_data(dev, NULL);
 
 	if (!IS_ERR_OR_NULL(group))
