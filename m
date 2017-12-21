From: <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 1/2] PCI: mediatek: Clear IRQ status after IRQ dispatched to avoid reentry
Date: Thu, 21 Dec 2017 10:08:49 +0800
Message-ID: <1513822130-18213-2-git-send-email-honghui.zhang@mediatek.com>
References: <1513822130-18213-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513822130-18213-1-git-send-email-honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

There maybe a same IRQ reentry scenario after IRQ received in current
IRQ handle flow:
	EP device		PCIe host driver	EP driver
1. issue an IRQ
			2. received IRQ
			3. clear IRQ status
			4. dispatch IRQ
						5. clear IRQ source
The IRQ status was not successfully cleared at step 2 since the IRQ
source was not cleared yet. So the PCIe host driver may receive the
same IRQ after step 5. Then there's an IRQ reentry occurred.
Even worse, if the reentry IRQ was not an IRQ that EP driver expected,
it may not handle the IRQ. Then we may run into the infinite loop from
step 2 to step 4.
Clear the IRQ status after IRQ have been dispatched to avoid the IRQ
reentry.

Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Acked-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/pci/host/pcie-mediatek.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index db93efd..3248771 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -605,11 +605,11 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
 
 	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
 		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
-			/* Clear the INTx */
-			writel(1 << bit, port->base + PCIE_INT_STATUS);
 			virq = irq_find_mapping(port->irq_domain,
 						bit - INTX_SHIFT);
 			generic_handle_irq(virq);
+			/* Clear the INTx */
+			writel(1 << bit, port->base + PCIE_INT_STATUS);
 		}
 	}
 
@@ -619,10 +619,10 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
 
 			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
 				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
-					/* Clear the MSI */
-					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
 					virq = irq_find_mapping(port->msi_domain, bit);
 					generic_handle_irq(virq);
+					/* Clear the MSI */
+					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
 				}
 			}
 			/* Clear MSI interrupt status */
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
