From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 03/15] PCI: quirk dma_func_alias for Ricoh devices
Date: Sat, 10 May 2014 09:02:41 -0600
Message-ID: <20140510150241.2997.38099.stgit@bling.home>
References: <20140510145619.2997.429.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140510145619.2997.429.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The existing quirk for these devices doesn't really solve the problem,
re-implement it using the DMA alias iterator.  We'll come back later
and remove the existing quirk and dma_source interface.  Note that
device ID 0xe822 is typically function 0 and 0xe230 has been tested
to not need the quirk and are therefore removed versus the equivalent
dma_source quirk.  If the exist in other configurations we can re-add
them.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/quirks.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e729206..ea2cb9f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3333,6 +3333,20 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 	return -ENOTTY;
 }
 
+static void quirk_dma_func0_alias(struct pci_dev *dev)
+{
+	if (PCI_FUNC(dev->devfn) != 0)
+		dev->dma_func_alias |= (1 << 0);
+}
+
+/*
+ * https://bugzilla.redhat.com/show_bug.cgi?id=605888
+ *
+ * Some Ricoh devices use function 0 as the PCIe requester ID for DMA.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
+
 static struct pci_dev *pci_func_0_dma_source(struct pci_dev *dev)
 {
 	if (!PCI_FUNC(dev->devfn))
