From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 0/2] pci/iommu: PCIe requester ID interface
Date: Wed, 10 Jul 2013 16:10:32 -0600
Message-ID: <20130710215954.3045.89568.stgit@bling.home>
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
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I took Bjorn's requester ID interface, or more appropriately my
interpretation of the interface, through a full (apparently) working
implementation.  This is the result.  It's quite a nice cleanup for
intel-iommu.  I think this kills two birds with one stone, we quirk
PCIe-to-PCI bridges that don't have a PCIe capability (bz44881) and we
also apply DMA quirks to all devices for dma_ops, which should fix
devices like Ricoh and Marvell chips that do DMA from the wrong
requester ID (still no ghost requester ID support, but that may be
easier to add now).

If this seems like the right direction I'll update other users of
pci_find_upstream_pcie_bridge() and abolish that function.  Thanks,

Alex

---

Alex Williamson (2):
      pci: Create PCIe requester ID interface
      iommu/intel: Make use of PCIe requester ID interface


 drivers/iommu/intel-iommu.c |  164 ++++++++++++++++-------------------------
 drivers/pci/search.c        |  170 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h         |    7 ++
