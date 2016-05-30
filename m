From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v2] Change dma_attrs from bitfield to unsigned long
Date: Mon, 30 May 2016 13:54:05 +0200
Message-ID: <1464609246-6948-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: hch@infradead.org, sstabellini@kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi,


This is second attempt to bring some safeness to dma_attrs.
In v1 [0] I added const to data pointed by attrs. However Christoph
Hellwig suggested getting rid of struct dma_attrs in favor of
some simpler data type.


Benefits of unsigned long for dma_attrs:
1. This is just simpler.  Both in terms of reading the code and setting
   attributes.  Instead of initializing local attributes on the stack and
   passing pointer to it to dma_set_attr(), just set the bits.

2. It brings safeness and checking for const correctness because the
   attributes are passed by value.


The problem is that the patch touches the dma-mapping API so all
the users have to be converted (ARM and ARM64 as of now).

Any ideas to split it per smaller patches?

The work is not finished yet, I would rather get some feedback before
progressing further.


Best regards,
Krzysztof


Krzysztof Kozlowski (1):
  dma-mapping: Use unsigned long for dma_attrs

 Documentation/DMA-API.txt                 |   2 +-
 Documentation/DMA-attributes.txt          |   2 +-
 arch/arm/include/asm/dma-mapping.h        |  13 ++--
 arch/arm/include/asm/xen/page-coherent.h  |  16 ++---
 arch/arm/mm/dma-mapping.c                 |  82 +++++++++++------------
 arch/arm/xen/mm.c                         |   4 +-
 arch/arm64/mm/dma-mapping.c               |  57 ++++++++--------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c   |   1 -
 drivers/gpu/drm/exynos/exynos_drm_gem.c   |  20 +++---
 drivers/gpu/drm/exynos/exynos_drm_gem.h   |   2 +-
 drivers/iommu/dma-iommu.c                 |   6 +-
 drivers/xen/swiotlb-xen.c                 |  14 ++--
 include/linux/dma-attrs.h                 |  71 --------------------
 include/linux/dma-iommu.h                 |   6 +-
 include/linux/dma-mapping.h               | 105 +++++++++++++++++-------------
 include/linux/swiotlb.h                   |  10 +--
 include/xen/swiotlb-xen.h                 |  12 ++--
 lib/dma-noop.c                            |   9 +--
 lib/swiotlb.c                             |  13 ++--
 20 files changed, 195 insertions(+), 252 deletions(-)
 delete mode 100644 include/linux/dma-attrs.h

-- 
1.9.1

