From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [RFC PATCH 3/5] iommu: Export non-static functions to use in modules
Date: Wed,  5 Jul 2017 16:12:13 +0900
Message-ID: <20170705071215.17603-4-tfiga@chromium.org>
References: <20170705071215.17603-1-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170705071215.17603-1-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
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
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There are some non-static functions potentially useful in IOMMU drivers
that do not have their symbols exported. Export them too, so that
loadable modules can benefit from them. Use EXPORT_SYMBOL_GPL() for
consistency with other exports in the file.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/iommu/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f6ea160afed..41dd6b435ae3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -96,6 +96,7 @@ int iommu_device_register(struct iommu_device *iommu)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iommu_device_register);
 
 void iommu_device_unregister(struct iommu_device *iommu)
 {
@@ -103,6 +104,7 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	list_del(&iommu->list);
 	spin_unlock(&iommu_device_lock);
 }
+EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
@@ -744,6 +746,7 @@ struct iommu_group *iommu_group_ref_get(struct iommu_group *group)
 	kobject_get(group->devices_kobj);
 	return group;
 }
+EXPORT_SYMBOL_GPL(iommu_group_ref_get);
 
 /**
  * iommu_group_put - Decrement group reference
@@ -917,6 +920,7 @@ struct iommu_group *generic_device_group(struct device *dev)
 {
 	return iommu_group_alloc();
 }
+EXPORT_SYMBOL_GPL(generic_device_group);
 
 /*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
@@ -984,6 +988,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 	/* No shared group found, allocate new */
 	return iommu_group_alloc();
 }
+EXPORT_SYMBOL_GPL(pci_device_group);
 
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
@@ -1044,11 +1049,13 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 	return group;
 }
+EXPORT_SYMBOL_GPL(iommu_group_get_for_dev);
 
 struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {
 	return group->default_domain;
 }
+EXPORT_SYMBOL_GPL(iommu_group_default_domain);
 
 static int add_iommu_group(struct device *dev, void *data)
 {
@@ -1795,6 +1802,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 	if (ops && ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
+EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
@@ -1803,6 +1811,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 	if (ops && ops->put_resv_regions)
 		ops->put_resv_regions(dev, list);
 }
+EXPORT_SYMBOL_GPL(iommu_put_resv_regions);
 
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
@@ -1821,6 +1830,7 @@ struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 	region->type = type;
 	return region;
 }
+EXPORT_SYMBOL_GPL(iommu_alloc_resv_region);
 
 /* Request that a device is direct mapped by the IOMMU */
 int iommu_request_dm_for_dev(struct device *dev)
@@ -1874,6 +1884,7 @@ int iommu_request_dm_for_dev(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_request_dm_for_dev);
 
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
@@ -1889,6 +1900,7 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	spin_unlock(&iommu_device_lock);
 	return ops;
 }
+EXPORT_SYMBOL_GPL(iommu_ops_from_fwnode);
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
-- 
2.13.2.725.g09c95d1e9-goog
