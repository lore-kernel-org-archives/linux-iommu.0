From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/9] ACPI/IORT: Use helper functions to access
	dev->iommu_fwspec
Date: Tue, 11 Dec 2018 13:19:03 +0100
Message-ID: <20181211121910.5604-3-joro@8bytes.org>
References: <20181211121910.5604-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181211121910.5604-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/acpi/arm64/iort.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..736381673638 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -779,7 +779,7 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 {
 	struct acpi_iort_node *iommu;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
 
@@ -794,9 +794,10 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 	return NULL;
 }
 
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(
-				struct iommu_fwspec *fwspec)
+static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
 	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
 }
 
@@ -824,6 +825,7 @@ static inline int iort_add_device_replay(const struct iommu_ops *ops,
  */
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct acpi_iort_its_group *its;
 	struct acpi_iort_node *iommu_node, *its_node = NULL;
 	int i, resv = 0;
@@ -841,9 +843,9 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
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
@@ -874,8 +876,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	return (resv == its->its_count) ? resv : -ENODEV;
 }
 #else
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(
-				struct iommu_fwspec *fwspec)
+static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
 { return NULL; }
 static inline int iort_add_device_replay(const struct iommu_ops *ops,
 					 struct device *dev)
@@ -1045,7 +1046,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * If we already translated the fwspec there
 	 * is nothing left to do, return the iommu_ops.
 	 */
-	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+	ops = iort_fwspec_iommu_ops(dev);
 	if (ops)
 		return ops;
 
@@ -1084,7 +1085,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * add_device callback for dev, replay it to get things in order.
 	 */
 	if (!err) {
-		ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+		ops = iort_fwspec_iommu_ops(dev);
 		err = iort_add_device_replay(ops, dev);
 	}
 
-- 
2.17.1
