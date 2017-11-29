From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v10 2/3] iommu/dma: Add HW MSI(GICv3 ITS) address regions
 reservation
Date: Wed, 29 Nov 2017 14:14:48 +0000
Message-ID: <20171129141449.120316-3-shameerali.kolothum.thodi@huawei.com>
References: <20171129141449.120316-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171129141449.120316-1-shameerali.kolothum.thodi@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lorenzo.pieralisi@arm.com, will.deacon@arm.com, robin.murphy@arm.com, marc.zyngier@arm.com, joro@8bytes.org
Cc: devicetree@vger.kernel.org, john.garry@huawei.com, linuxarm@huawei.com, xuwei5@hisilicon.com, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Modified iommu_dma_get_resv_regions() to include GICv3 ITS
region on ACPI based ARM platfiorms which may require HW MSI
reservations.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
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
