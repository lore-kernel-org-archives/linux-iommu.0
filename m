From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5] iommu/amd: Allow non-IOMMUv2 devices in IOMMUv2 domains
Date: Tue, 28 Jul 2015 16:58:49 +0200
Message-ID: <1438095531-26777-4-git-send-email-joro@8bytes.org>
References: <1438095531-26777-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438095531-26777-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Since devices with IOMMUv2 functionality might be in the
same group as devices without it, allow those devices in
IOMMUv2 domains too.
Otherwise attaching the group with the IOMMUv2 device to the
domain will fail.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 89e6d4b..6d3dae9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2164,15 +2164,17 @@ static int attach_device(struct device *dev,
 	dev_data = get_dev_data(dev);
 
 	if (domain->flags & PD_IOMMUV2_MASK) {
-		if (!dev_data->iommu_v2 || !dev_data->passthrough)
+		if (!dev_data->passthrough)
 			return -EINVAL;
 
-		if (pdev_iommuv2_enable(pdev) != 0)
-			return -EINVAL;
+		if (dev_data->iommu_v2) {
+			if (pdev_iommuv2_enable(pdev) != 0)
+				return -EINVAL;
 
-		dev_data->ats.enabled = true;
-		dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
-		dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
+			dev_data->ats.enabled = true;
+			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
+			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
+		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
 		dev_data->ats.enabled = true;
@@ -2237,7 +2239,7 @@ static void detach_device(struct device *dev)
 	__detach_device(dev_data);
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
+	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
 		pdev_iommuv2_disable(to_pci_dev(dev));
 	else if (dev_data->ats.enabled)
 		pci_disable_ats(to_pci_dev(dev));
-- 
1.9.1
