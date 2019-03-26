From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 RFC/RFT 0/5] Save single pages from CMA area
Date: Tue, 26 Mar 2019 16:01:26 -0700
Message-ID: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, robin.murphy@arm.com
Cc: vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

This series of patches try to save single pages from CMA area bypassing
all CMA single page alloctions and allocating normal pages instead, as
all addresses within one single page are contiguous.

We had once applied the PATCH-5 but reverted it as actually not all the
callers handled the fallback allocations. Per Robin's suggestion, let's
stuff alloc_pages()/free_page() fallbacks to those callers before having
PATCH-5.

Changlog
v1->v2:
 * PATCH-2: Initialized page pointer to NULL

Nicolin Chen (5):
  ARM: dma-mapping: Add fallback normal page allocations
  dma-remap: Run alloc_pages() on failure
  iommu: amd_iommu: Add fallback normal page allocations
  arm64: dma-mapping: Add fallback normal page allocations
  dma-contiguous: Do not allocate a single page from CMA area

 arch/arm/mm/dma-mapping.c   | 13 ++++++++++---
 arch/arm64/mm/dma-mapping.c | 19 ++++++++++++-------
 drivers/iommu/amd_iommu.c   |  3 +++
 kernel/dma/contiguous.c     | 22 +++++++++++++++++++---
 kernel/dma/remap.c          |  4 ++--
 5 files changed, 46 insertions(+), 15 deletions(-)

-- 
2.17.1
