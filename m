From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 0/2] Refactor dummy DMA ops
Date: Fri,  7 Dec 2018 16:31:33 +0000
Message-ID: <cover.1544199754.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: iommu@lists.linux-foundation.org, m.szyprowski@samsung.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Tangential to Christoph's RFC for mitigating indirect call overhead in
common DMA mapping scenarios[1], this is a little reshuffle to prevent the
CONFIG_ACPI_CCA_REQUIRED case from getting in the way. This would best go
via the dma-mapping tree, so reviews and acks welcome.

Robin.

[1] https://lore.kernel.org/lkml/20181206153720.10702-1-hch@lst.de/

Robin Murphy (2):
  dma-mapping: Factor out dummy DMA ops
  ACPI / scan: Refactor _CCA enforcement

 arch/arm64/include/asm/dma-mapping.h |  4 +-
 arch/arm64/mm/dma-mapping.c          | 92 ----------------------------
 drivers/acpi/scan.c                  |  5 ++
 drivers/base/platform.c              |  3 +-
 drivers/pci/pci-driver.c             |  3 +-
 include/linux/dma-mapping.h          |  1 +
 kernel/dma/mapping.c                 | 54 ++++++++++++++++
 7 files changed, 63 insertions(+), 99 deletions(-)

-- 
2.19.1.dirty
