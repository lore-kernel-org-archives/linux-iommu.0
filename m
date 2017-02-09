From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/11] iommu: Add sysfs bindings for struct iommu_device
Date: Thu,  9 Feb 2017 12:32:53 +0100
Message-ID: <1486639981-32368-5-git-send-email-joro@8bytes.org>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486639981-32368-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

There is currently support for iommu sysfs bindings, but
those need to be implemented in the IOMMU drivers. Add a
more generic version of this by adding a struct device to
struct iommu_device and use that for the sysfs bindings.

Also convert the AMD and Intel IOMMU driver to make use of
it.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 14 ++++++++-----
 drivers/iommu/amd_iommu_init.c  |  6 ++----
 drivers/iommu/amd_iommu_types.h |  3 ---
 drivers/iommu/dmar.c            | 13 +++++-------
 drivers/iommu/intel-iommu.c     | 15 ++++++++------
 drivers/iommu/iommu-sysfs.c     | 45 +++++++++++++++++------------------------
 include/linux/intel-iommu.h     |  1 -
 include/linux/iommu.h           | 23 +++++++++++++++++----
 8 files changed, 62 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7c11c36..a584ac2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -445,6 +445,7 @@ static void init_iommu_group(struct device *dev)
 static int iommu_init_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu;
 	int devid;
 
 	if (dev->archdata.iommu)
@@ -454,6 +455,8 @@ static int iommu_init_device(struct device *dev)
 	if (devid < 0)
 		return devid;
 
+	iommu = amd_iommu_rlookup_table[devid];
+
 	dev_data = find_dev_data(devid);
 	if (!dev_data)
 		return -ENOMEM;
@@ -469,8 +472,7 @@ static int iommu_init_device(struct device *dev)
 
 	dev->archdata.iommu = dev_data;
 
-	iommu_device_link(amd_iommu_rlookup_table[dev_data->devid]->iommu_dev,
-			  dev);
+	iommu_device_link(&iommu->iommu.dev, dev);
 
 	return 0;
 }
@@ -495,13 +497,16 @@ static void iommu_ignore_device(struct device *dev)
 
 static void iommu_uninit_device(struct device *dev)
 {
-	int devid;
 	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu;
+	int devid;
 
 	devid = get_device_id(dev);
 	if (devid < 0)
 		return;
 
+	iommu = amd_iommu_rlookup_table[devid];
+
 	dev_data = search_dev_data(devid);
 	if (!dev_data)
 		return;
@@ -509,8 +514,7 @@ static void iommu_uninit_device(struct device *dev)
 	if (dev_data->domain)
 		detach_device(dev);
 
-	iommu_device_unlink(amd_iommu_rlookup_table[dev_data->devid]->iommu_dev,
-			    dev);
+	iommu_device_unlink(&iommu->iommu.dev, dev);
 
 	iommu_group_remove_device(dev);
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index b7ccfb2..6b9e661 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1637,10 +1637,8 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	amd_iommu_erratum_746_workaround(iommu);
 	amd_iommu_ats_write_check_workaround(iommu);
 
-	iommu->iommu_dev = iommu_device_create(&iommu->dev->dev, iommu,
-					       amd_iommu_groups, "ivhd%d",
-					       iommu->index);
-
+	iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
+			       amd_iommu_groups, "ivhd%d", iommu->index);
 	iommu_device_set_ops(&iommu->iommu, &amd_iommu_ops);
 	iommu_device_register(&iommu->iommu);
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 0683505..af00f38 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -535,9 +535,6 @@ struct amd_iommu {
 	/* if one, we need to send a completion wait command */
 	bool need_sync;
 
-	/* IOMMU sysfs device */
-	struct device *iommu_dev;
-
 	/* Handle for IOMMU core code */
 	struct iommu_device iommu;
 
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8e8a48e..d9c0dec 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1080,14 +1080,11 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	raw_spin_lock_init(&iommu->register_lock);
 
 	if (intel_iommu_enabled) {
-		iommu->iommu_dev = iommu_device_create(NULL, iommu,
-						       intel_iommu_groups,
-						       "%s", iommu->name);
-
-		if (IS_ERR(iommu->iommu_dev)) {
-			err = PTR_ERR(iommu->iommu_dev);
+		err = iommu_device_sysfs_add(&iommu->iommu, NULL,
+					     intel_iommu_groups,
+					     "%s", iommu->name);
+		if (err)
 			goto err_unmap;
-		}
 
 		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
 
@@ -1111,7 +1108,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 static void free_iommu(struct intel_iommu *iommu)
 {
-	iommu_device_destroy(iommu->iommu_dev);
+	iommu_device_sysfs_remove(&iommu->iommu);
 	iommu_device_unregister(&iommu->iommu);
 
 	if (iommu->irq) {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ca22872..0e52086 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4853,10 +4853,13 @@ int __init intel_iommu_init(void)
 
 	init_iommu_pm_ops();
 
-	for_each_active_iommu(iommu, drhd)
-		iommu->iommu_dev = iommu_device_create(NULL, iommu,
-						       intel_iommu_groups,
-						       "%s", iommu->name);
+	for_each_active_iommu(iommu, drhd) {
+		iommu_device_sysfs_add(&iommu->iommu, NULL,
+				       intel_iommu_groups,
+				       "%s", iommu->name);
+		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
+		iommu_device_register(&iommu->iommu);
+	}
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	bus_register_notifier(&pci_bus_type, &device_nb);
@@ -5178,7 +5181,7 @@ static int intel_iommu_add_device(struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	iommu_device_link(iommu->iommu_dev, dev);
+	iommu_device_link(&iommu->iommu.dev, dev);
 
 	group = iommu_group_get_for_dev(dev);
 
@@ -5200,7 +5203,7 @@ static void intel_iommu_remove_device(struct device *dev)
 
 	iommu_group_remove_device(dev);
 
-	iommu_device_unlink(iommu->iommu_dev, dev);
+	iommu_device_unlink(&iommu->iommu.dev, dev);
 }
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index 39b2d91..bb87d35 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -50,54 +50,45 @@ static int __init iommu_dev_init(void)
 postcore_initcall(iommu_dev_init);
 
 /*
- * Create an IOMMU device and return a pointer to it.  IOMMU specific
- * attributes can be provided as an attribute group, allowing a unique
- * namespace per IOMMU type.
+ * Init the struct device for the IOMMU. IOMMU specific attributes can
+ * be provided as an attribute group, allowing a unique namespace per
+ * IOMMU type.
  */
-struct device *iommu_device_create(struct device *parent, void *drvdata,
-				   const struct attribute_group **groups,
-				   const char *fmt, ...)
+int iommu_device_sysfs_add(struct iommu_device *iommu,
+			   struct device *parent,
+			   const struct attribute_group **groups,
+			   const char *fmt, ...)
 {
-	struct device *dev;
 	va_list vargs;
 	int ret;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
+	device_initialize(&iommu->dev);
 
-	device_initialize(dev);
-
-	dev->class = &iommu_class;
-	dev->parent = parent;
-	dev->groups = groups;
-	dev_set_drvdata(dev, drvdata);
+	iommu->dev.class = &iommu_class;
+	iommu->dev.parent = parent;
+	iommu->dev.groups = groups;
 
 	va_start(vargs, fmt);
-	ret = kobject_set_name_vargs(&dev->kobj, fmt, vargs);
+	ret = kobject_set_name_vargs(&iommu->dev.kobj, fmt, vargs);
 	va_end(vargs);
 	if (ret)
 		goto error;
 
-	ret = device_add(dev);
+	ret = device_add(&iommu->dev);
 	if (ret)
 		goto error;
 
-	return dev;
+	return 0;
 
 error:
-	put_device(dev);
-	return ERR_PTR(ret);
+	put_device(&iommu->dev);
+	return ret;
 }
 
-void iommu_device_destroy(struct device *dev)
+void iommu_device_sysfs_remove(struct iommu_device *iommu)
 {
-	if (!dev || IS_ERR(dev))
-		return;
-
-	device_unregister(dev);
+	device_unregister(&iommu->dev);
 }
-
 /*
  * IOMMU drivers can indicate a device is managed by a given IOMMU using
  * this interface.  A link to the device will be created in the "devices"
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 99a65a3..3ba9b53 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -440,7 +440,6 @@ struct intel_iommu {
 	struct irq_domain *ir_domain;
 	struct irq_domain *ir_msi_domain;
 #endif
-	struct device	*iommu_dev; /* IOMMU-sysfs device */
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
 	u32		flags;      /* Software defined flags */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5803c1a..c578ca1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -209,14 +209,21 @@ struct iommu_ops {
  *			 instance
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
+ * @dev: struct device for sysfs handling
  */
 struct iommu_device {
 	struct list_head list;
 	const struct iommu_ops *ops;
+	struct device dev;
 };
 
 int  iommu_device_register(struct iommu_device *iommu);
 void iommu_device_unregister(struct iommu_device *iommu);
+int  iommu_device_sysfs_add(struct iommu_device *iommu,
+			    struct device *parent,
+			    const struct attribute_group **groups,
+			    const char *fmt, ...) __printf(4, 5);
+void iommu_device_sysfs_remove(struct iommu_device *iommu);
 
 static inline void iommu_device_set_ops(struct iommu_device *iommu,
 					const struct iommu_ops *ops)
@@ -287,10 +294,6 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
-struct device *iommu_device_create(struct device *parent, void *drvdata,
-				   const struct attribute_group **groups,
-				   const char *fmt, ...) __printf(4, 5);
-void iommu_device_destroy(struct device *dev);
 int iommu_device_link(struct device *dev, struct device *link);
 void iommu_device_unlink(struct device *dev, struct device *link);
 
@@ -581,6 +584,18 @@ static inline void iommu_device_unregister(struct iommu_device *iommu)
 {
 }
 
+static inline int  iommu_device_sysfs_add(struct iommu_device *iommu,
+					  struct device *parent,
+					  const struct attribute_group **groups,
+					  const char *fmt, ...)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_device_sysfs_remove(struct iommu_device *iommu)
+{
+}
+
 static inline int iommu_device_link(struct device *dev, struct device *link)
 {
 	return -EINVAL;
-- 
1.9.1
