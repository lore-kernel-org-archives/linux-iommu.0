From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/2] iommu: Favour per-instance IOMMU ops
Date: Mon, 17 Oct 2016 12:40:09 +0100
Message-ID: <17c608b6bb857c409ef9236f768b5ef8cd7e0f50.1476702439.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On systems with multiple IOMMUs, bus-level granularity can be too
coarse, particularly on the platform "bus", where the hardware may
actually warrant multiple different iommu_ops, which we currently have
no way at all to accommodate. As an initial step towards the necessary
flexibility, allow the device-focused API calls to use the ops provided
by the device-specific IOMMU instance data (when present) in preference
to the bus ops.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu.c | 56 +++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9a2f1960873b..eab883e6c5a9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -37,10 +37,6 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
-struct iommu_callback_data {
-	const struct iommu_ops *ops;
-};
-
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -77,7 +73,7 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 #define to_iommu_group(_kobj)		\
 	container_of(_kobj, struct iommu_group, kobj)
 
-static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
@@ -801,6 +797,14 @@ struct iommu_group *pci_device_group(struct device *dev)
 	return group;
 }
 
+static const struct iommu_ops *dev_iommu_ops(struct device *dev)
+{
+	if (dev->iommu_fwspec && dev->iommu_fwspec->ops)
+		return dev->iommu_fwspec->ops;
+
+	return dev->bus->iommu_ops;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -813,7 +817,7 @@ struct iommu_group *pci_device_group(struct device *dev)
  */
 struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group;
 	int ret;
 
@@ -834,7 +838,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	 * IOMMU driver.
 	 */
 	if (!group->default_domain) {
-		group->default_domain = __iommu_domain_alloc(dev->bus,
+		group->default_domain = __iommu_domain_alloc(ops,
 							     IOMMU_DOMAIN_DMA);
 		if (!group->domain)
 			group->domain = group->default_domain;
@@ -856,8 +860,7 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 
 static int add_iommu_group(struct device *dev, void *data)
 {
-	struct iommu_callback_data *cb = data;
-	const struct iommu_ops *ops = cb->ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	int ret;
 
 	if (!ops->add_device)
@@ -880,8 +883,7 @@ static int add_iommu_group(struct device *dev, void *data)
 
 static int remove_iommu_group(struct device *dev, void *data)
 {
-	struct iommu_callback_data *cb = data;
-	const struct iommu_ops *ops = cb->ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->remove_device && dev->iommu_group)
 		ops->remove_device(dev);
@@ -893,7 +895,7 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
 	struct device *dev = data;
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group;
 	unsigned long group_action = 0;
 
@@ -946,9 +948,6 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 {
 	int err;
 	struct notifier_block *nb;
-	struct iommu_callback_data cb = {
-		.ops = ops,
-	};
 
 	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
 	if (!nb)
@@ -960,7 +959,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_free;
 
-	err = bus_for_each_dev(bus, NULL, &cb, add_iommu_group);
+	err = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
 	if (err)
 		goto out_err;
 
@@ -969,7 +968,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 
 out_err:
 	/* Clean up */
-	bus_for_each_dev(bus, NULL, &cb, remove_iommu_group);
+	bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
 	bus_unregister_notifier(bus, nb);
 
 out_free:
@@ -1047,29 +1046,29 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
-static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 						 unsigned type)
 {
 	struct iommu_domain *domain;
 
-	if (bus == NULL || bus->iommu_ops == NULL)
-		return NULL;
-
-	domain = bus->iommu_ops->domain_alloc(type);
+	domain = ops->domain_alloc(type);
 	if (!domain)
 		return NULL;
 
-	domain->ops  = bus->iommu_ops;
+	domain->ops  = ops;
 	domain->type = type;
 	/* Assume all sizes by default; the driver may override this later */
-	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
+	domain->pgsize_bitmap  = ops->pgsize_bitmap;
 
 	return domain;
 }
 
 struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 {
-	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
+	if (bus == NULL || bus->iommu_ops == NULL)
+		return NULL;
+
+	return __iommu_domain_alloc(bus->iommu_ops, IOMMU_DOMAIN_UNMANAGED);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
@@ -1548,7 +1547,7 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 
 void iommu_get_dm_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops && ops->get_dm_regions)
 		ops->get_dm_regions(dev, list);
@@ -1556,7 +1555,7 @@ void iommu_get_dm_regions(struct device *dev, struct list_head *list)
 
 void iommu_put_dm_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops && ops->put_dm_regions)
 		ops->put_dm_regions(dev, list);
@@ -1565,6 +1564,7 @@ void iommu_put_dm_regions(struct device *dev, struct list_head *list)
 /* Request that a device is direct mapped by the IOMMU */
 int iommu_request_dm_for_dev(struct device *dev)
 {
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *dm_domain;
 	struct iommu_group *group;
 	int ret;
@@ -1589,7 +1589,7 @@ int iommu_request_dm_for_dev(struct device *dev)
 
 	/* Allocate a direct mapped domain */
 	ret = -ENOMEM;
-	dm_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_IDENTITY);
+	dm_domain = __iommu_domain_alloc(ops, IOMMU_DOMAIN_IDENTITY);
 	if (!dm_domain)
 		goto out;
 
-- 
1.9.1
