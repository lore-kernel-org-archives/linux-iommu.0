From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/06] iommu/ipmmu-vmsa: Convert to dev_data
Date: Tue, 15 Dec 2015 21:02:30 +0900
Message-ID: <20151215120230.26216.8126.sendpatchset@little-apple>
References: <20151215120212.26216.61530.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215120212.26216.61530.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Rename ipmmu_vmsa_archdata to ipmmu_vmsa_dev_data to avoid
confusion when using the driver on multiple architectures.

The data now stored in ipmmu_vmsa_dev_data is used to point
various on-chip devices to the actual IPMMU instances.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |   58 +++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 22 deletions(-)

--- 0003/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 13:16:27.160513000 +0900
@@ -47,7 +47,7 @@ struct ipmmu_vmsa_domain {
 	spinlock_t lock;			/* Protects mappings */
 };
 
-struct ipmmu_vmsa_archdata {
+struct ipmmu_vmsa_dev_data {
 	struct ipmmu_vmsa_device *mmu;
 	unsigned int *utlbs;
 	unsigned int num_utlbs;
@@ -182,6 +182,20 @@ static struct ipmmu_vmsa_domain *to_vmsa
 #define IMUASID_ASID0_SHIFT		0
 
 /* -----------------------------------------------------------------------------
+ * Consumer device side private data handling
+ */
+
+static struct ipmmu_vmsa_dev_data *get_dev_data(struct device *dev)
+{
+	return dev->archdata.iommu;
+}
+
+static void set_dev_data(struct device *dev, struct ipmmu_vmsa_dev_data *data)
+{
+	dev->archdata.iommu = data;
+}
+
+/* -----------------------------------------------------------------------------
  * Read/Write Access
  */
 
@@ -485,8 +499,8 @@ static void ipmmu_domain_free(struct iom
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
-	struct ipmmu_vmsa_device *mmu = archdata->mmu;
+	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
+	struct ipmmu_vmsa_device *mmu = dev_data->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
 	unsigned int i;
@@ -518,8 +532,8 @@ static int ipmmu_attach_device(struct io
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < archdata->num_utlbs; ++i)
-		ipmmu_utlb_enable(domain, archdata->utlbs[i]);
+	for (i = 0; i < dev_data->num_utlbs; ++i)
+		ipmmu_utlb_enable(domain, dev_data->utlbs[i]);
 
 	return 0;
 }
@@ -527,12 +541,12 @@ static int ipmmu_attach_device(struct io
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
 
-	for (i = 0; i < archdata->num_utlbs; ++i)
-		ipmmu_utlb_disable(domain, archdata->utlbs[i]);
+	for (i = 0; i < dev_data->num_utlbs; ++i)
+		ipmmu_utlb_disable(domain, dev_data->utlbs[i]);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -595,7 +609,7 @@ static int ipmmu_find_utlbs(struct ipmmu
 
 static int ipmmu_add_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata;
+	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
 	struct ipmmu_vmsa_device *mmu;
 	struct iommu_group *group = NULL;
 	unsigned int *utlbs;
@@ -603,7 +617,7 @@ static int ipmmu_add_device(struct devic
 	int num_utlbs;
 	int ret = -ENODEV;
 
-	if (dev->archdata.iommu) {
+	if (dev_data) {
 		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
 			 dev_name(dev));
 		return -EINVAL;
@@ -662,16 +676,16 @@ static int ipmmu_add_device(struct devic
 		goto error;
 	}
 
-	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
-	if (!archdata) {
+	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	archdata->mmu = mmu;
-	archdata->utlbs = utlbs;
-	archdata->num_utlbs = num_utlbs;
-	dev->archdata.iommu = archdata;
+	dev_data->mmu = mmu;
+	dev_data->utlbs = utlbs;
+	dev_data->num_utlbs = num_utlbs;
+	set_dev_data(dev, dev_data);
 
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
@@ -708,10 +722,10 @@ static int ipmmu_add_device(struct devic
 error:
 	arm_iommu_release_mapping(mmu->mapping);
 
-	kfree(dev->archdata.iommu);
+	kfree(dev_data);
 	kfree(utlbs);
 
-	dev->archdata.iommu = NULL;
+	set_dev_data(dev, NULL);
 
 	if (!IS_ERR_OR_NULL(group))
 		iommu_group_remove_device(dev);
@@ -721,15 +735,15 @@ error:
 
 static void ipmmu_remove_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
 
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
 
-	kfree(archdata->utlbs);
-	kfree(archdata);
+	kfree(dev_data->utlbs);
+	kfree(dev_data);
 
-	dev->archdata.iommu = NULL;
+	set_dev_data(dev, NULL);
 }
 
 static const struct iommu_ops ipmmu_ops = {
