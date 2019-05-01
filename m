From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 0/3] PCIe Host request to reserve IOVA
Date: Wed,  1 May 2019 23:06:23 +0530
Message-ID: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Eric Auger <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges. Allowed inbound address ranges are listed in dma-ranges
DT property and this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list resource entries of allowed
address ranges given in dma-ranges DT property in sorted order. This
sorted list of resources will be processed and reserve IOVA address for
inaccessible address holes while initializing IOMMU domain.

This patch set is based on Linux-5.1-rc3.

Changes from v4:
  - Addressed Bjorn, Robin Murphy and Auger Eric review comments.
    - Commit message modification.
    - Change DMA_BIT_MASK to "~(dma_addr_t)0".

Changes from v3:
  - Addressed Robin Murphy review comments.
    - pcie-iproc: parse dma-ranges and make sorted resource list.
    - dma-iommu: process list and reserve gaps between entries

Changes from v2:
  - Patch set rebased to Linux-5.0-rc2

Changes from v1:
  - Addressed Oza review comments.

Srinath Mannam (3):
  PCI: Add dma_ranges window list
  iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
  PCI: iproc: Add sorted dma ranges resource entries to host bridge

 drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.7.4
