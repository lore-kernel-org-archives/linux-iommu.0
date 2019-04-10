From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/amd: Use pci_prg_resp_pasid_required()
Date: Wed, 10 Apr 2019 16:21:08 +0100
Message-ID: <20190410152108.48037-1-jean-philippe.brucker@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Commit e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
interface.") added a common interface to check the PASID bit in the PRI
capability. Use it in the AMD driver.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..7a0de274934c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2122,23 +2122,6 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 	return ret;
 }
 
-/* FIXME: Move this to PCI code */
-#define PCI_PRI_TLP_OFF		(1 << 15)
-
-static bool pci_pri_tlp_required(struct pci_dev *pdev)
-{
-	u16 status;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return false;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
-
-	return (status & PCI_PRI_TLP_OFF) ? true : false;
-}
-
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -2167,7 +2150,7 @@ static int attach_device(struct device *dev,
 
 			dev_data->ats.enabled = true;
 			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
-			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
+			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
 		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
-- 
2.21.0
