From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 05/15] PCI: Quirk pci_for_each_dma_alias() for bridges
Date: Fri, 09 May 2014 09:28:55 -0600
Message-ID: <20140509152855.8321.78358.stgit@bling.home>
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

Several PCIe-to-PCI bridges fail to provide a PCIe capability, causing
us to handle them as conventional PCI devices.  In some cases, this
may be correct, in others it's not.  Add a dev_flag bit to identify
devices to be handled as standard PCIe-to-PCI bridges.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/search.c |   10 ++++++++--
 include/linux/pci.h  |    2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index ad698b2..dab4561 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -98,8 +98,14 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 				continue;
 			}
 		} else {
-			ret = fn(tmp, PCI_DEVID(tmp->bus->number, tmp->devfn),
-				 data);
+			if (tmp->dev_flags & PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS)
+				ret = fn(tmp,
+					 PCI_DEVID(tmp->subordinate->number,
+						   PCI_DEVFN(0, 0)), data);
+			else
+				ret = fn(tmp,
+					 PCI_DEVID(tmp->bus->number,
+						   tmp->devfn), data);
 			if (ret)
 				return ret;
 		}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b4c97d2..31d9a90 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -171,6 +171,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) 4,
 	/* Flag for quirk use to store if quirk-specific ACS is enabled */
 	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) 8,
+	/* DMA alias the device as if it was a PCIe-to-PCI bridge */
+	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) 16,
 };
 
 enum pci_irq_reroute_variant {
