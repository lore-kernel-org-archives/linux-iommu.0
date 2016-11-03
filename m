From: Eric Auger <eric.auger@redhat.com>
Subject: [RFC 4/8] iommu: Add a list of iommu_reserved_region in iommu_domain
Date: Thu,  3 Nov 2016 21:39:34 +0000
Message-ID: <1478209178-3009-5-git-send-email-eric.auger@redhat.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

Introduce a new iommu_reserved_region struct. This embodies
an IOVA reserved region that cannot be used along with the IOMMU
API. The list is protected by a dedicated mutex.

An iommu domain now owns a list of those.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 drivers/iommu/iommu.c |  2 ++
 include/linux/iommu.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9a2f196..0af07492 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1061,6 +1061,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 
 	domain->ops  = bus->iommu_ops;
 	domain->type = type;
+	INIT_LIST_HEAD(&domain->reserved_regions);
+	mutex_init(&domain->resv_mutex);
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21..0f2eb64 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -84,6 +84,8 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
+	struct list_head reserved_regions;
+	struct mutex resv_mutex; /* protects the reserved region list */
 };
 
 enum iommu_cap {
@@ -131,6 +133,21 @@ struct iommu_dm_region {
 	int			prot;
 };
 
+/**
+ * struct iommu_reserved_region - descriptor for a reserved iova region
+ * @list: Linked list pointers
+ * @start: IOVA base address of the region
+ * @length: Length of the region in bytes
+ */
+struct iommu_reserved_region {
+	struct list_head	list;
+	dma_addr_t		start;
+	size_t			length;
+};
+
+#define iommu_reserved_region_for_each(resv, d) \
+	list_for_each_entry(resv, &(d)->reserved_regions, list)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
-- 
1.9.1
