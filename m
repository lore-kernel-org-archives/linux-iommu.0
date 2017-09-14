From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v7 4/5] iommu/dma: Add a helper function to reserve HW MSI address regions for IOMMU drivers
Date: Thu, 14 Sep 2017 13:57:55 +0100
Message-ID: <20170914125756.14836-5-shameerali.kolothum.thodi@huawei.com>
References: <20170914125756.14836-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170914125756.14836-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, mark.rutland@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

IOMMU drivers can use this to implement their .get_resv_regions callback
for HW MSI specific reservations(e.g. ARM GICv3 ITS MSI region).

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
[John: added DT support]
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe..f8709a2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/gfp.h>
@@ -27,6 +28,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -198,6 +200,23 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
+/**
+ * iommu_dma_get_msi_resv_regions - Reserved region driver helper
+ * @dev: Device from iommu_get_resv_regions()
+ * @list: Reserved region list from iommu_get_resv_regions()
+ *
+ * IOMMU drivers can use this to implement their .get_resv_regions
+ * callback for HW MSI specific reservations.
+ */
+int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head *list)
+{
+	if (is_of_node(dev->iommu_fwspec->iommu_fwnode))
+		return of_iommu_msi_get_resv_regions(dev, list);
+
+	return iort_iommu_msi_get_resv_regions(dev, list);
+}
+EXPORT_SYMBOL(iommu_dma_get_msi_resv_regions);
+
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
 {
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 92f2083..6062ef0 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -74,6 +74,8 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head *list);
+
 #else
 
 struct iommu_domain;
@@ -107,6 +109,11 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head *list)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
1.9.1


