From: Jayachandran C <jnair@caviumnetworks.com>
Subject: [PATCH v5 0/2] Handle Cavium ThunderX2 PCI topology quirk
Date: Thu, 13 Apr 2017 20:30:43 +0000
Message-ID: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jayachandran C <jnair@caviumnetworks.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

Here's v5 of the patchset with an updated commit message based on your
suggestion. I have added a paragraph at the end about MSI-X as well.

This is the newest in the series based on the discussion here:
https://www.spinics.net/lists/arm-kernel/msg575581.html

Previous discussions and patches:
http://www.spinics.net/lists/linux-pci/msg51001.html
https://patchwork.ozlabs.org/patch/582633/ and
https://lists.linuxfoundation.org/pipermail/iommu/2016-June/017681.html

Let me know if I missed anything, Thanks,
JC.

v4->v5:
 - updated commit message for patch 2/2

v3->v4:
 - new address of author

v2>v3:
 - changed device flag name from PCI_DEV_FLAGS_DMA_ALIAS_ROOT to
   PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
 - updated commit message to make the quirk clearer.
 
Jayachandran C (2):
  PCI: Add device flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
  PCI: quirks: Fix ThunderX2 dma alias handling

 drivers/pci/quirks.c | 14 ++++++++++++++
 drivers/pci/search.c |  4 ++++
 include/linux/pci.h  |  2 ++
 3 files changed, 20 insertions(+)

-- 
2.7.4
