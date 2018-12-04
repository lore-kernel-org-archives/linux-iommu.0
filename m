From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/9] ACPI/IORT: Use helper functions to access
	dev->iommu_fwspec
Date: Tue,  4 Dec 2018 17:29:55 +0100
Message-ID: <20181204163002.15800-3-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181204163002.15800-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/acpi/arm64/iort.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..754a67ba49e5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -779,7 +779,7 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 {
 	struct acpi_iort_node *iommu;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
 
@@ -824,6 +824,7 @@ static inline int iort_add_device_replay(const struct iommu_ops *ops,
  */
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct acpi_iort_its_group *its;
 	struct acpi_iort_node *iommu_node, *its_node = NULL;
 	int i, resv = 0;
@@ -841,9 +842,9 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	 * a given PCI or named component may map IDs to.
 	 */
 
-	for (i = 0; i < dev->iommu_fwspec->num_ids; i++) {
+	for (i = 0; i < fwspec->num_ids; i++) {
 		its_node = iort_node_map_id(iommu_node,
-					dev->iommu_fwspec->ids[i],
+					fwspec->ids[i],
 					NULL, IORT_MSI_TYPE);
 		if (its_node)
 			break;
@@ -1036,6 +1037,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
  */
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct acpi_iort_node *node, *parent;
 	const struct iommu_ops *ops;
 	u32 streamid = 0;
@@ -1045,7 +1047,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * If we already translated the fwspec there
 	 * is nothing left to do, return the iommu_ops.
 	 */
-	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+	ops = iort_fwspec_iommu_ops(fwspec);
 	if (ops)
 		return ops;
 
@@ -1084,7 +1086,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * add_device callback for dev, replay it to get things in order.
 	 */
 	if (!err) {
-		ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+		ops = iort_fwspec_iommu_ops(fwspec);
 		err = iort_add_device_replay(ops, dev);
 	}
 
-- 
2.17.1
