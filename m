From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/32] powerpc/powernv: remove pnv_npu_dma_set_mask
Date: Wed, 13 Feb 2019 08:01:13 +0100
Message-ID: <20190213070133.11259-13-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

These devices are not PCIe devices and do not have associated dma map
ops, so this is just dead code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d9060a0f4c8e..23ffbc71589a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3646,14 +3646,6 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
-static int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
-{
-	dev_err_once(&npdev->dev,
-			"%s operation unsupported for NVLink devices\n",
-			__func__);
-	return -EPERM;
-}
-
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 	.setup_msi_irqs		= pnv_setup_msi_irqs,
@@ -3661,7 +3653,6 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.enable_device_hook	= pnv_pci_enable_device_hook,
 	.window_alignment	= pnv_pci_window_alignment,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
-	.dma_set_mask		= pnv_npu_dma_set_mask,
 	.shutdown		= pnv_pci_ioda_shutdown,
 	.disable_device		= pnv_npu_disable_device,
 };
-- 
2.20.1
