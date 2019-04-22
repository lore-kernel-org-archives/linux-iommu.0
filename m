From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 02/10] PCI/switchtec: Add module parameter to request more
	interrupts
Date: Mon, 22 Apr 2019 15:05:20 -0600
Message-ID: <20190422210528.15289-3-logang@deltatee.com>
References: <20190422210528.15289-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190422210528.15289-1-logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ntb-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mason <jdmason-zqedIHPRSYI@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Allen Hubbe <allenbh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Seeing the we want to use more interrupts in the NTB MSI code
we need to be able allocate more (sometimes virtual) interrupts
in the switchtec driver. Therefore add a module parameter to
request to allocate additional interrupts.

This puts virtually no limit on the number of MSI interrupts available
to NTB clients.

Signed-off-by: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/switch/switchtec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e22766c79fe9..8b1db78197d9 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -30,6 +30,10 @@ module_param(use_dma_mrpc, bool, 0644);
 MODULE_PARM_DESC(use_dma_mrpc,
 		 "Enable the use of the DMA MRPC feature");
 
+static int nirqs = 32;
+module_param(nirqs, int, 0644);
+MODULE_PARM_DESC(nirqs, "number of interrupts to allocate (more may be useful for NTB applications)");
+
 static dev_t switchtec_devt;
 static DEFINE_IDA(switchtec_minor_ida);
 
@@ -1247,8 +1251,12 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 	int dma_mrpc_irq;
 	int rc;
 
-	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, 4,
-				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (nirqs < 4)
+		nirqs = 4;
+
+	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, nirqs,
+				      PCI_IRQ_MSIX | PCI_IRQ_MSI |
+				      PCI_IRQ_VIRTUAL);
 	if (nvecs < 0)
 		return nvecs;
 
-- 
2.20.1
