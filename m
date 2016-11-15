From: Eric Auger <eric.auger@redhat.com>
Subject: [RFC v3 04/10] iommu: iommu_alloc_resv_region
Date: Tue, 15 Nov 2016 13:09:17 +0000
Message-ID: <1479215363-2898-5-git-send-email-eric.auger@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

Introduce a new helper serving the purpose to allocate a reserved
region.  This will be used in iommu driver implementing reserved
region callbacks.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/iommu.c | 16 ++++++++++++++++
 include/linux/iommu.h |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c7ed334..6ee529f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1562,6 +1562,22 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 		ops->put_resv_regions(dev, list);
 }
 
+struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
+						  size_t length,
+						  unsigned int prot)
+{
+	struct iommu_resv_region *region;
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return NULL;
+
+	region->start = start;
+	region->length = length;
+	region->prot = prot;
+	return region;
+}
+
 /* Request that a device is direct mapped by the IOMMU */
 int iommu_request_dm_for_dev(struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 02cf565..0aea877 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -241,6 +241,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
+extern struct iommu_resv_region *
+iommu_alloc_resv_region(phys_addr_t start, size_t length, unsigned int prot);
 
 extern int iommu_attach_group(struct iommu_domain *domain,
 			      struct iommu_group *group);
@@ -454,6 +456,12 @@ static inline void iommu_put_resv_regions(struct device *dev,
 {
 }
 
+static inline struct iommu_resv_region *
+iommu_alloc_resv_region(phys_addr_t start, size_t length, unsigned int prot)
+{
+	return NULL;
+}
+
 static inline int iommu_request_dm_for_dev(struct device *dev)
 {
 	return -ENODEV;
-- 
1.9.1
