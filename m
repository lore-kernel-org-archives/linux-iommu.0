From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 06/15] PCI: Add quirks for ASMedia and Tundra bridges
Date: Fri, 09 May 2014 09:29:01 -0600
Message-ID: <20140509152901.8321.66435.stgit@bling.home>
References: <20140509151735.8321.22017.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140509151735.8321.22017.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The quirk is intended to be extremely generic, but we only apply it
to known offending devices.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/quirks.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 63b8245..a10a685 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3356,6 +3356,29 @@ static void quirk_dma_func1_alias(struct pci_dev *dev)
 }
 
 /*
+ * A few PCIe-to-PCI bridges fail to expose a PCIe capability, resulting in
+ * using the wrong DMA alias for the device.  Some of these devices can be
+ * used as either forward or reverse bridges, so we need to test whether the
+ * device is operating in the correct mode.  We could probably apply this
+ * quirk to PCI_ANY_ID, but for now we'll just use known offenders.  The test
+ * is for a non-root, non-PCIe bridge where the upstream device is PCIe and
+ * is not a PCIe-to-PCI bridge, then @pdev is actually a PCIe-to-PCI bridge.
+ */
+static void quirk_use_pcie_bridge_dma_alias(struct pci_dev *pdev)
+{
+	if (!pci_is_root_bus(pdev->bus) &&
+	    pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
+	    !pci_is_pcie(pdev) && pci_is_pcie(pdev->bus->self) &&
+	    pci_pcie_type(pdev->bus->self) != PCI_EXP_TYPE_PCI_BRIDGE)
+		pdev->dev_flags |= PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS;
+}
+/* ASM1083/1085, https://bugzilla.kernel.org/show_bug.cgi?id=44881#c46 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1080,
+			 quirk_use_pcie_bridge_dma_alias);
+/* Tundra 8113, https://bugzilla.kernel.org/show_bug.cgi?id=44881#c43 */
+DECLARE_PCI_FIXUP_HEADER(0x10e3, 0x8113, quirk_use_pcie_bridge_dma_alias);
+
+/*
  * Marvell 88SE9123 uses function 1 as the requester ID for DMA.  In some
  * SKUs function 1 is present and is a legacy IDE controller, in other
  * SKUs this function is not present, making this a ghost requester.
