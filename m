From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 0/6] PCI: Support multiple DMA aliases
Date: Wed, 24 Feb 2016 13:43:32 -0600
Message-ID: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Cc: linux-pci@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

This is a revision of Jacek's v3 posting:
http://lkml.kernel.org/r/1454152012-46337-1-git-send-email-jacek.lawrynowicz@intel.com

The changes from v3 are:

  - Split into smaller patches for reviewability
  - Move printk when adding DMA alias
  - Change dma_alias_is_enabled() interface to take two pci_devs
  - Rename dma_alias_is_enabled() to indicate PCI context

The only remaining thing I want to sort out is the dma_alias_is_enabled()
vs pci_for_each_dma_alias() question Alex raised.  I'll respond to the
relevant part of the patch in this series with my specific questions.

---

Bjorn Helgaas (1):
      PCI: Rename dma_alias_is_enabled() to pci_devs_are_dma_aliases()

Jacek Lawrynowicz (5):
      PCI: Add pci_add_dma_alias() to abstract implementation
      PCI: Move informational printk to pci_add_dma_alias()
      PCI: Add support for multiple DMA aliases
      pci: Add DMA alias quirk for mic_x200_dma
      PCI: Squash pci_dev_flags to remove holes


 drivers/iommu/iommu.c |   18 +++++++++++-------
 drivers/pci/pci.c     |   23 +++++++++++++++++++++++
 drivers/pci/pci.h     |    2 ++
 drivers/pci/probe.c   |    1 +
 drivers/pci/quirks.c  |   34 +++++++++++++++++++---------------
 drivers/pci/search.c  |   14 +++++++++-----
 include/linux/pci.h   |   12 +++++-------
 7 files changed, 70 insertions(+), 34 deletions(-)
