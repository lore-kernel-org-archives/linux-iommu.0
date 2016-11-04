From: Eric Auger <eric.auger@redhat.com>
Subject: [RFC v2 6/8] iommu: Handle the list of reserved regions
Date: Fri,  4 Nov 2016 11:24:04 +0000
Message-ID: <1478258646-3117-7-git-send-email-eric.auger@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

A new callback is introduced, add_reserved_regions. This function
aims at populating the iommu domain reserved region list with
regions associated with the device. The function is called on
device attachment. The list is freed on iommu_domain_free().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
 include/linux/iommu.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0af07492..300af44 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1077,6 +1077,10 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
+	struct iommu_reserved_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, &domain->reserved_regions, list)
+		kfree(entry);
 	domain->ops->domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
@@ -1089,6 +1093,15 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->attach_dev(domain, dev);
+	if (ret)
+		return ret;
+
+	if (domain->type == IOMMU_DOMAIN_UNMANAGED) {
+		mutex_lock(&domain->resv_mutex);
+		ret = iommu_add_reserved_regions(domain, dev);
+		mutex_unlock(&domain->resv_mutex);
+	}
+
 	if (!ret)
 		trace_attach_device_to_domain(dev);
 	return ret;
@@ -1548,6 +1561,16 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+int iommu_add_reserved_regions(struct iommu_domain *domain, struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->add_reserved_regions)
+		return ops->add_reserved_regions(domain, dev);
+	else
+		return 0;
+}
+
 void iommu_get_dm_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0f2eb64..7748a1b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -170,6 +170,7 @@ struct iommu_reserved_region {
  * @get_dm_regions: Request list of direct mapping requirements for a device
  * @put_dm_regions: Free list of direct mapping requirements for a device
  * @apply_dm_region: Temporary helper call-back for iova reserved ranges
+ * @add_reserved_regions: Populate reserved regions for a device
  * @domain_window_enable: Configure and enable a particular window for a domain
  * @domain_window_disable: Disable a particular window for a domain
  * @domain_set_windows: Set the number of windows for a domain
@@ -207,6 +208,10 @@ struct iommu_ops {
 	void (*apply_dm_region)(struct device *dev, struct iommu_domain *domain,
 				struct iommu_dm_region *region);
 
+	/* Add reserved regions for a device */
+	int (*add_reserved_regions)(struct iommu_domain *domain,
+				     struct device *device);
+
 	/* Window handling functions */
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
 				    phys_addr_t paddr, u64 size, int prot);
@@ -289,6 +294,7 @@ struct device *iommu_device_create(struct device *parent, void *drvdata,
 void iommu_device_destroy(struct device *dev);
 int iommu_device_link(struct device *dev, struct device *link);
 void iommu_device_unlink(struct device *dev, struct device *link);
+int iommu_add_reserved_regions(struct iommu_domain *domain, struct device *dev);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-- 
1.9.1
