From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] of: iommu: Silence misleading warning
Date: Wed, 22 Jul 2015 18:47:00 +0100
Message-ID: <12584a8f40b08b9a12e12dbd3baa9e3d2a513d1b.1437586703.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, m-karicheri2-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Printing "IOMMU is currently not supported for PCI" for every PCI device
probed on a DT-based system proves to be both irritatingly noisy and
confusing to users who have misinterpreted it to mean they can no longer
use VFIO device assignment.

Since configuring DMA masks for PCI devices via of_dma_configure() has
not in fact changed anything with regard to IOMMUs there really is nothing
to warn about here; shut it up.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/of_iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 43429ab..60ba238 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -141,10 +141,12 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
 	struct iommu_ops *ops = NULL;
 	int idx = 0;
 
-	if (dev_is_pci(dev)) {
-		dev_err(dev, "IOMMU is currently not supported for PCI\n");
+	/*
+	 * We can't do much for PCI devices without knowing how
+	 * device IDs are wired up from the PCI bus to the IOMMU.
+	 */
+	if (dev_is_pci(dev))
 		return NULL;
-	}
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
-- 
1.9.1
