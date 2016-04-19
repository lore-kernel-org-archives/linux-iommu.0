From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 08/10] iommu/dma-reserved_iommu:
	iommu_msi_mapping_desc_to_domain
Date: Tue, 19 Apr 2016 16:56:32 +0000
Message-ID: <1461084994-2355-9-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461084994-2355-1-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-qxv4g6HH51o@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This function checks whether
- the device emitting the MSI belongs to a non default iommu domain
- the iommu domain requires the MSI address to be mapped.

If those conditions are met, the function returns the iommu domain
to be used for mapping the MSI doorbell; else it returns NULL.

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/dma-reserved-iommu.c | 19 +++++++++++++++++++
 include/linux/dma-reserved-iommu.h | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
index 2522235..907a17f 100644
--- a/drivers/iommu/dma-reserved-iommu.c
+++ b/drivers/iommu/dma-reserved-iommu.c
@@ -17,6 +17,7 @@
 
 #include <linux/iommu.h>
 #include <linux/iova.h>
+#include <linux/msi.h>
 
 struct reserved_iova_domain {
 	struct iova_domain *iovad;
@@ -332,3 +333,21 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(iommu_put_reserved_iova);
 
+struct iommu_domain *iommu_msi_mapping_desc_to_domain(struct msi_desc *desc)
+{
+	struct device *dev;
+	struct iommu_domain *d;
+
+	dev = msi_desc_to_dev(desc);
+
+	d = iommu_get_domain_for_dev(dev);
+
+	if (!d || (d->type == IOMMU_DOMAIN_DMA))
+		return NULL;
+
+	if (iommu_domain_get_attr(d, DOMAIN_ATTR_MSI_MAPPING, NULL))
+		return NULL;
+
+	return d;
+}
+EXPORT_SYMBOL_GPL(iommu_msi_mapping_desc_to_domain);
diff --git a/include/linux/dma-reserved-iommu.h b/include/linux/dma-reserved-iommu.h
index 8722131..8373929 100644
--- a/include/linux/dma-reserved-iommu.h
+++ b/include/linux/dma-reserved-iommu.h
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 
 struct iommu_domain;
+struct msi_desc;
 
 #ifdef CONFIG_IOMMU_DMA_RESERVED
 
@@ -70,6 +71,17 @@ int iommu_get_reserved_iova(struct iommu_domain *domain,
  * if the binding ref count is null, destroy the reserved mapping
  */
 void iommu_put_reserved_iova(struct iommu_domain *domain, phys_addr_t addr);
+
+/**
+ * iommu_msi_mapping_desc_to_domain: in case the MSI originates from a device
+ * upstream to an IOMMU and this IOMMU translates the MSI transaction,
+ * this function returns the iommu domain the MSI doorbell address must be
+ * mapped in. Else it returns NULL.
+ *
+ * @desc: msi desc handle
+ */
+struct iommu_domain *iommu_msi_mapping_desc_to_domain(struct msi_desc *desc);
+
 #else
 
 static inline int
@@ -93,5 +105,11 @@ static inline int iommu_get_reserved_iova(struct iommu_domain *domain,
 static inline void iommu_put_reserved_iova(struct iommu_domain *domain,
 					   phys_addr_t addr) {}
 
+static inline struct iommu_domain *
+iommu_msi_mapping_desc_to_domain(struct msi_desc *desc)
+{
+	return NULL;
+}
+
 #endif	/* CONFIG_IOMMU_DMA_RESERVED */
 #endif	/* __DMA_RESERVED_IOMMU_H */
-- 
1.9.1
