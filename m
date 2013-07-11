From: Alex Williamson <alex.williamson@redhat.com>
Subject: [RFC PATCH v2 0/2] pci/iommu: PCIe requester ID interface
Date: Thu, 11 Jul 2013 15:03:18 -0600
Message-ID: <20130711204439.1701.90503.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, acooks@gmail.com, ddutile@redhat.com, dwmw2@infradead.org
List-Id: iommu@lists.linux-foundation.org

v2: second pass at refining the interface.  Rolled pci_requester_id
into pci_get_visible_pcie_requester.  Fixed some bus walk issues.

Another obscure issue that I forgot to mention that this should fix
is gaps in requester IDs.  If you had:

 ---pcie--->[pcie2pci]---pci--->[pci2pcie]---pcie--->[endpoint]

I think the current code would try to use the endpoint requester id and
fail.  This code will use the pcie2pci->secondary as the requester id.
This may not even be that obscure of a bug if a PCIe ASIC is soldered
to a pci2pcie bridge to make a compatible conventional PCI card.

The diffstat for pci improves a bit when we remove:
pci_find_upstream_pci_bridge:

 drivers/iommu/intel-iommu.c         |  164 ++++++++++-----------------
 drivers/iommu/intel_irq_remapping.c |    2 
 drivers/pci/search.c                |  215 +++++++++++++++++++++++++++++++-----
 include/linux/pci.h                 |   16 +-
 4 files changed, 260 insertions(+), 137 deletions(-)

Comments?  Thanks,

Alex

---

Alex Williamson (2):
      pci: Create PCIe requester ID interface
      iommu/intel: Make use of PCIe requester ID interface


 drivers/iommu/intel-iommu.c         |  164 +++++++++++------------------
 drivers/iommu/intel_irq_remapping.c |    2 
 drivers/pci/search.c                |  198 +++++++++++++++++++++++++++++++++++
 include/linux/pci.h                 |    7 +
 4 files changed, 270 insertions(+), 101 deletions(-)
