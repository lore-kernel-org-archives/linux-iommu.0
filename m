Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1411BA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21614C433D6;
	Sun,  6 Nov 2022 22:01:45 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>,
	Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 00/13] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
Date: Sun,  6 Nov 2022 22:01:30 +0000
Message-Id: <20221106220143.2129263-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

That's the third attempt at reducing the kmalloc() minimum alignment on
arm64 below the ARCH_DMA_MINALIGN of 128. The first version was not
aggressive enough, limiting ARCH_KMALLOC_MINALIGN to 64 while the second
version added an explicit __GFP_PACKED flag.

This third version reduces ARCH_KMALLOC_MINALIGN to 8 while defining
ARCH_DMA_MINALIGN for all platforms and using it instead of the former
in places where we need a static alignment (structure or members align
attributes).

The first patch decouples the kmalloc() and DMA alignment, though this
only takes effect after the Kconfig entry is enabled by the last patch.

Patches 2 and 3 add bouncing via the swiotlb if any of the sizes are
small enough to have originated from an unaligned kmalloc() cache. Not
entirely sure whether my approach for iommu bouncing is correct, so open
to suggestions.

Patch 4 is a fallback in case there is no swiotlb buffer. Together with
patch 6, we can still get a smaller kmalloc() minalign of 64 (typical
cache line size) rather than 128 on arm64. If we improve the bouncing to
use the DMA coherent pool, this run-time __kmalloc_minalign() can go
away. Patch 5 is some cleanup following the refactoring in patch 4.

Patches 7-12 change some ARCH_KMALLOC_MINALIGN uses to
ARCH_DMA_MINALIGN. The crypto changes have been rejected by Herbert
previously but I still included them here until the crypto code is
refactored.

The last patch enables the bouncing for arm64.

Thanks.

Catalin Marinas (13):
  mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
  dma-mapping: Force bouncing if the kmalloc() size is not
    cacheline-aligned
  iommu/dma: Force bouncing of the size is not cacheline-aligned
  mm/slab: Allow kmalloc() minimum alignment fallback to
    dma_get_cache_alignment()
  mm/slab: Simplify create_kmalloc_cache() args and make it static
  dma: Allow the smaller cache_line_size() returned by
    dma_get_cache_alignment()
  drivers/base: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/gpu: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/usb: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/spi: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/md: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  dma: arm64: Add CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for
    arm64

 arch/arm64/Kconfig            |  2 ++
 drivers/base/devres.c         |  6 ++---
 drivers/gpu/drm/drm_managed.c |  6 ++---
 drivers/iommu/dma-iommu.c     | 12 ++++++---
 drivers/md/dm-crypt.c         |  2 +-
 drivers/spi/spidev.c          |  2 +-
 drivers/usb/core/buffer.c     |  8 +++---
 include/linux/crypto.h        |  2 +-
 include/linux/dma-map-ops.h   | 50 +++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h   |  4 ++-
 include/linux/scatterlist.h   | 27 ++++++++++++++++---
 include/linux/slab.h          | 14 +++++++---
 kernel/dma/Kconfig            | 14 ++++++++++
 kernel/dma/direct.h           |  3 ++-
 mm/slab.c                     |  6 +----
 mm/slab.h                     |  5 ++--
 mm/slab_common.c              | 49 +++++++++++++++++++++++++++-------
 17 files changed, 169 insertions(+), 43 deletions(-)

