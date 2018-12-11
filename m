From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/4] iommu: Consolitate ->add/remove_device() calls
Date: Tue, 11 Dec 2018 16:05:11 +0100
Message-ID: <20181211150513.15161-3-joro@8bytes.org>
References: <20181211150513.15161-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211150513.15161-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Put them into separate functions and call those where the
plain ops have been called before.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 51 +++++++++++++++++++++----------------------
 include/linux/iommu.h |  3 +++
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index edbdf5d6962c..1e8f4e0c9198 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -110,6 +110,23 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	spin_unlock(&iommu_device_lock);
 }
 
+int iommu_probe_device(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	WARN_ON(dev->iommu_group);
+
+	return ops->add_device(dev);
+}
+
+void iommu_release_device(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (dev->iommu_group)
+		ops->remove_device(dev);
+}
+
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -1117,16 +1134,7 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 
 static int add_iommu_group(struct device *dev, void *data)
 {
-	struct iommu_callback_data *cb = data;
-	const struct iommu_ops *ops = cb->ops;
-	int ret;
-
-	if (!ops->add_device)
-		return 0;
-
-	WARN_ON(dev->iommu_group);
-
-	ret = ops->add_device(dev);
+	int ret = iommu_probe_device(dev);
 
 	/*
 	 * We ignore -ENODEV errors for now, as they just mean that the
@@ -1141,11 +1149,7 @@ static int add_iommu_group(struct device *dev, void *data)
 
 static int remove_iommu_group(struct device *dev, void *data)
 {
-	struct iommu_callback_data *cb = data;
-	const struct iommu_ops *ops = cb->ops;
-
-	if (ops->remove_device && dev->iommu_group)
-		ops->remove_device(dev);
+	iommu_release_device(dev);
 
 	return 0;
 }
@@ -1153,27 +1157,22 @@ static int remove_iommu_group(struct device *dev, void *data)
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
+	unsigned long group_action = 0;
 	struct device *dev = data;
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
-	unsigned long group_action = 0;
 
 	/*
 	 * ADD/DEL call into iommu driver ops if provided, which may
 	 * result in ADD/DEL notifiers to group->notifier
 	 */
 	if (action == BUS_NOTIFY_ADD_DEVICE) {
-		if (ops->add_device) {
-			int ret;
+		int ret;
 
-			ret = ops->add_device(dev);
-			return (ret) ? NOTIFY_DONE : NOTIFY_OK;
-		}
+		ret = iommu_probe_device(dev);
+		return (ret) ? NOTIFY_DONE : NOTIFY_OK;
 	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
-		if (ops->remove_device && dev->iommu_group) {
-			ops->remove_device(dev);
-			return 0;
-		}
+		iommu_release_device(dev);
+		return NOTIFY_OK;
 	}
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..cb36f32cd3c2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -398,6 +398,9 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+int iommu_probe_device(struct device *dev);
+void iommu_release_device(struct device *dev);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
-- 
2.17.1
