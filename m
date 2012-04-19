From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] iommu/amd: Check for the right TLP prefix bit
Date: Thu, 19 Apr 2012 15:39:36 +0200
Message-ID: <1334842777-23214-1-git-send-email-joerg.roedel@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Unfortunatly the PRI spec changed and moved the
TLP-prefix-required bit to a different location. This patch
makes the necessary change in the AMD IOMMU driver.
Regressions are not expected because all hardware
implementing the PRI capability sets this bit to zero
anyway.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v3.3
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a5bee8e..08f3eec 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2035,20 +2035,20 @@ out_err:
 }
 
 /* FIXME: Move this to PCI code */
-#define PCI_PRI_TLP_OFF		(1 << 2)
+#define PCI_PRI_TLP_OFF		(1 << 15)
 
 bool pci_pri_tlp_required(struct pci_dev *pdev)
 {
-	u16 control;
+	u16 status;
 	int pos;
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return false;
 
-	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
+	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
 
-	return (control & PCI_PRI_TLP_OFF) ? true : false;
+	return (status & PCI_PRI_TLP_OFF) ? true : false;
 }
 
 /*
-- 
1.7.5.4
