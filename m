From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v13 2/2] iommu/dma: Add HW MSI(GICv3 ITS) address regions reservation
Date: Tue, 13 Feb 2018 15:20:51 +0000
Message-ID: <20180213152051.10296-3-shameerali.kolothum.thodi@huawei.com>
References: <20180213152051.10296-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180213152051.10296-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, robin.murphy@arm.com, marc.zyngier@arm.com, will.deacon@arm.com
Cc: joro@8bytes.org, john.garry@huawei.com, xuwei5@hisilicon.com, guohanjun@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Modified iommu_dma_get_resv_regions() to include GICv3 ITS
region on ACPI based ARM platfiorms which may require HW MSI
reservations.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
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
@@ -167,13 +168,18 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
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
2.7.4


