From: Bjorn Helgaas via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH v4 5/6] pci: Add DMA alias quirk for mic_x200_dma
Date: Wed, 24 Feb 2016 13:44:23 -0600
Message-ID: <20160224194423.7585.46582.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Reply-To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160224193926.7585.10833.stgit-1RhO1Y9PlrlHTL0Zs8A6p/gx64E7kk8eUsxypvmhUTTZJqsBc5GL+g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
be added as aliases to the DMA device in order to allow buffer access
when IOMMU is enabled.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/pci/quirks.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index cf023ea..ac23a30 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3696,6 +3696,19 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
+ * be added as aliases to the DMA device in order to allow buffer access
+ * when IOMMU is enabled.
+ */
+static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
+{
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
