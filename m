From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/8] iommu: Add ops entry for supported default domain type
Date: Mon, 29 Apr 2019 10:09:18 +0800
Message-ID: <20190429020925.18136-2-baolu.lu@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, jamessewart@arista.com, tmurphy@arista.com, dima@arista.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds an optional ops entry to query the default domain
types supported by the iommu driver for  a specific device.
This is necessary in cases where the iommu driver can only
support a specific type of default domain for a device. In
normal cases, this ops will return IOMMU_DOMAIN_ANY which
indicates that the iommu driver supports both IOMMU_DOMAIN_DMA
and IOMMU_DOMAIN_IDENTITY, hence the static default domain
type will be used.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 13 ++++++++++---
 include/linux/iommu.h | 11 +++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index acd6830e6e9b..1ad9a1f2e078 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1097,15 +1097,22 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	 * IOMMU driver.
 	 */
 	if (!group->default_domain) {
+		unsigned int domain_type = IOMMU_DOMAIN_ANY;
 		struct iommu_domain *dom;
 
-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
-		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
+		if (ops->def_domain_type)
+			domain_type = ops->def_domain_type(dev);
+
+		if (domain_type == IOMMU_DOMAIN_ANY)
+			domain_type = iommu_def_domain_type;
+
+		dom = __iommu_domain_alloc(dev->bus, domain_type);
+		if (!dom && domain_type != IOMMU_DOMAIN_DMA) {
 			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
 			if (dom) {
 				dev_warn(dev,
 					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-					 iommu_def_domain_type);
+					 domain_type);
 			}
 		}
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8239ece9fdfc..ba9a5b996a63 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -79,12 +79,16 @@ struct iommu_domain_geometry {
  *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
  *				  This flag allows IOMMU drivers to implement
  *				  certain optimizations for these domains
+ *	IOMMU_DOMAIN_ANY	- All domain types defined here
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)
+#define IOMMU_DOMAIN_ANY	(IOMMU_DOMAIN_IDENTITY |	\
+				 IOMMU_DOMAIN_UNMANAGED |	\
+				 IOMMU_DOMAIN_DMA)
 
 struct iommu_domain {
 	unsigned type;
@@ -196,6 +200,11 @@ enum iommu_dev_features {
  * @dev_feat_enabled: check enabled feature
  * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
  * @aux_get_pasid: get the pasid given an aux-domain
+ * @def_domain_type: get per-device default domain type that the IOMMU
+ *		driver is able to support. Valid returns values:
+ *		- IOMMU_DOMAIN_DMA: only suports non-identity domain
+ *		- IOMMU_DOMAIN_IDENTITY: only supports identity domain
+ *		- IOMMU_DOMAIN_ANY: supports all
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -251,6 +260,8 @@ struct iommu_ops {
 	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
+	int (*def_domain_type)(struct device *dev);
+
 	unsigned long pgsize_bitmap;
 };
 
-- 
2.17.1
