From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 8/8] iommu: Move default domain allocation to
	iommu_group_get_for_dev()
Date: Wed, 21 Oct 2015 23:51:43 +0200
Message-ID: <1445464303-18206-9-git-send-email-joro@8bytes.org>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445464303-18206-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Now that the iommu core support for iommu groups is not
pci-centric anymore, we can move default domain allocation
to the bus independent iommu_group_get_for_dev() function.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e2b5526..abae363 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -810,14 +810,6 @@ struct iommu_group *pci_device_group(struct device *dev)
 	if (IS_ERR(group))
 		return NULL;
 
-	/*
-	 * Try to allocate a default domain - needs support from the
-	 * IOMMU driver.
-	 */
-	group->default_domain = __iommu_domain_alloc(pdev->dev.bus,
-						     IOMMU_DOMAIN_DMA);
-	group->domain = group->default_domain;
-
 	return group;
 }
 
@@ -849,6 +841,16 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (IS_ERR(group))
 		return group;
 
+	/*
+	 * Try to allocate a default domain - needs support from the
+	 * IOMMU driver.
+	 */
+	if (!group->default_domain) {
+		group->default_domain = __iommu_domain_alloc(dev->bus,
+							     IOMMU_DOMAIN_DMA);
+		group->domain = group->default_domain;
+	}
+
 	ret = iommu_group_add_device(group, dev);
 	if (ret) {
 		iommu_group_put(group);
-- 
1.9.1
