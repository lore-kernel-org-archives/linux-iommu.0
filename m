From: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 2/3] iommu/dma: Add HW MSI(GICv3 ITS) address regions reservation
Date: Thu, 14 Dec 2017 16:09:56 +0000
Message-ID: <20171214160957.13716-3-shameerali.kolothum.thodi@huawei.com>
References: <20171214160957.13716-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214160957.13716-1-shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Modified iommu_dma_get_resv_regions() to include GICv3 ITS
region on ACPI based ARM platfiorms which may require HW MSI
reservations.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 25914d3..f05f3cf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/gfp.h>
@@ -167,13 +168,18 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  *
  * IOMMU drivers can use this to implement their .get_resv_regions callback
  * for general non-IOMMU-specific reservations. Currently, this covers host
- * bridge windows for PCI devices.
+ * bridge windows for PCI devices and GICv3 ITS region reservation on ACPI
+ * based ARM platforms that may require HW MSI reservation.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;
 
+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
+		iort_iommu_msi_get_resv_regions(dev, list) < 0)
+		return;
+
 	if (!dev_is_pci(dev))
 		return;
 
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
