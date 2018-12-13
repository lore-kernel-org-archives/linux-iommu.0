From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/3] PCIe Host request to reserve IOVA
Date: Thu, 13 Dec 2018 16:02:51 +0530
Message-ID: <1544697174-6029-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ray Jui <rjui@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges.
Allowed inbound address ranges are listed in dma-ranges DT property and
this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list all address ranges which have
to reserve their IOVA address into PCIe host bridge resource entry list.
IOMMU framework will reserve these IOVAs while initializing IOMMU domain.

This patch set is based on Linux-4.19-rc1.

Changes from v1:
  - Addressed Oza review comments.

Srinath Mannam (3):
  PCI: Add dma-resv window list
  iommu/dma: IOVA reserve for PCI host reserve address list
  PCI: iproc: Add dma reserve resources to host

 drivers/iommu/dma-iommu.c           |  8 ++++++
 drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)

-- 
2.7.4
