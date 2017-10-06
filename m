From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: Do not disable SWIOTLB if SME is active
Date: Fri, 06 Oct 2017 16:35:40 -0500
Message-ID: <20171006213540.19038.84350.stgit@tlendack-t1.amdoffice.net>
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
Cc: Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When SME memory encryption is active it will rely on SWIOTLB to handle
DMA for devices that cannot support the addressing requirements of
having the encryption mask set in the physical address.  The IOMMU
currently disables SWIOTLB if it is not running in passthrough mode.
This is not desired as non-PCI devices attempting DMA may fail. Update
the code to check if SME is active and not disable SWIOTLB.

Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 51f8215..822679a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2773,14 +2773,16 @@ int __init amd_iommu_init_api(void)
 
 int __init amd_iommu_init_dma_ops(void)
 {
-	swiotlb        = iommu_pass_through ? 1 : 0;
+	swiotlb        = (iommu_pass_through || sme_me_mask) ? 1 : 0;
 	iommu_detected = 1;
 
 	/*
 	 * In case we don't initialize SWIOTLB (actually the common case
-	 * when AMD IOMMU is enabled), make sure there are global
-	 * dma_ops set as a fall-back for devices not handled by this
-	 * driver (for example non-PCI devices).
+	 * when AMD IOMMU is enabled and SME is not active), make sure there
+	 * are global dma_ops set as a fall-back for devices not handled by
+	 * this driver (for example non-PCI devices). When SME is active,
+	 * make sure that swiotlb variable remains set so the global dma_ops
+	 * continue to be SWIOTLB.
 	 */
 	if (!swiotlb)
 		dma_ops = &nommu_dma_ops;
