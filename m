From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v4 2/2] iommu/dma: Add HW MSI address regions reservation for IOMMU drivers
Date: Tue, 25 Jul 2017 12:17:32 +0100
Message-ID: <20170725111732.41792-3-shameerali.kolothum.thodi@huawei.com>
References: <20170725111732.41792-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170725111732.41792-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Modified iommu_dma_get_resv_regions() to include HW MSI (ARM GICv3 ITS MSI)
specific reservations if available.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe..3b6fde7 100644
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
+ * bridge windows for PCI devices and HW MSI(ARM GICv3 ITS MSI) region
+ * reservations if avialable.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;
 
+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
+		iort_iommu_its_get_resv_regions(dev, list) < 0)
+		return;
+
 	if (!dev_is_pci(dev))
 		return;
 
-- 
1.9.1


