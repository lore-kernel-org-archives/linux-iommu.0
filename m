From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 0/3] Add IPROC PCIe new features
Date: Fri, 18 Jan 2019 09:53:20 +0530
Message-ID: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

Add changes related to IPROC PCIe RC IP new features.

This patch set is based on Linux-5.0-rc2.

Srinath Mannam (3):
  PCI: iproc: Add feature to set order mode
  PCI: iproc: CRS state check in config request
  PCI: iproc: Add PCIe 32bit outbound memory configuration

 drivers/pci/controller/pcie-iproc.c | 172 +++++++++++++++++++++++++++++++++++-
 drivers/pci/controller/pcie-iproc.h |  16 ++++
 2 files changed, 184 insertions(+), 4 deletions(-)

-- 
2.7.4
