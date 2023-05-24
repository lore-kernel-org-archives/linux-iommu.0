Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9C118AFF
	for <iommu@lists.linux.dev>; Wed, 24 May 2023 17:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627E8C433D2;
	Wed, 24 May 2023 17:19:06 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
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
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 00/15] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
Date: Wed, 24 May 2023 18:18:49 +0100
Message-Id: <20230524171904.3967031-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Another version of the series reducing the kmalloc() minimum alignment
on arm64 to 8 (from 128). Other architectures can easily opt in by
defining ARCH_KMALLOC_MINALIGN as 8 and selecting
DMA_BOUNCE_UNALIGNED_KMALLOC.

The first 10 patches decouple ARCH_KMALLOC_MINALIGN from
ARCH_DMA_MINALIGN and, for arm64, limit the kmalloc() caches to those
aligned to the run-time probed cache_line_size(). On arm64 we gain the
kmalloc-{64,192} caches.

The subsequent patches (11 to 15) further reduce the kmalloc() caches to
kmalloc-{8,16,32,96} if the default swiotlb is present by bouncing small
buffers in the DMA API.

Changes since v4:

- Following Robin's suggestions, reworked the iommu handling so that the
  buffer size checks are done in the dev_use_swiotlb() and
  dev_use_sg_swiotlb() functions (together with dev_is_untrusted()). The
  sync operations can now check for the SG_DMA_USE_SWIOTLB flag. Since
  this flag is no longer specific to kmalloc() bouncing (covers
  dev_is_untrusted() as well), the sg_is_dma_use_swiotlb() and
  sg_dma_mark_use_swiotlb() functions are always defined if
  CONFIG_SWIOTLB.

- Dropped ARCH_WANT_KMALLOC_DMA_BOUNCE, only left the
  DMA_BOUNCE_UNALIGNED_KMALLOC option, selectable by the arch code. The
  NEED_SG_DMA_FLAGS is now selected by IOMMU_DMA if SWIOTLB.

- Rather than adding another config option, allow
  dma_get_cache_alignment() to be overridden by the arch code
  (Christoph's suggestion).

- Added a comment to the dma_kmalloc_needs_bounce() function on the
  heuristics behind the bouncing.

- Added acked-by/reviewed-by tags (not adding Ard's tested-by yet as
  there were some changes).

The updated patches are also available on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/kmalloc-minalign

Thanks.

Catalin Marinas (14):
  mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
  dma: Allow dma_get_cache_alignment() to be overridden by the arch code
  mm/slab: Simplify create_kmalloc_cache() args and make it static
  mm/slab: Limit kmalloc() minimum alignment to
    dma_get_cache_alignment()
  drivers/base: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/gpu: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/usb: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/spi: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/md: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  arm64: Allow kmalloc() caches aligned to the smaller cache_line_size()
  dma-mapping: Force bouncing if the kmalloc() size is not
    cache-line-aligned
  iommu/dma: Force bouncing if the size is not cacheline-aligned
  mm: slab: Reduce the kmalloc() minimum alignment if DMA bouncing
    possible
  arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64

Robin Murphy (1):
  scatterlist: Add dedicated config for DMA flags

 arch/arm64/Kconfig             |  1 +
 arch/arm64/include/asm/cache.h |  3 ++
 arch/arm64/mm/init.c           |  7 +++-
 drivers/base/devres.c          |  6 ++--
 drivers/gpu/drm/drm_managed.c  |  6 ++--
 drivers/iommu/Kconfig          |  1 +
 drivers/iommu/dma-iommu.c      | 50 +++++++++++++++++++++++-----
 drivers/md/dm-crypt.c          |  2 +-
 drivers/pci/Kconfig            |  1 +
 drivers/spi/spidev.c           |  2 +-
 drivers/usb/core/buffer.c      |  8 ++---
 include/linux/dma-map-ops.h    | 61 ++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h    |  4 ++-
 include/linux/scatterlist.h    | 29 +++++++++++++---
 include/linux/slab.h           | 14 ++++++--
 kernel/dma/Kconfig             |  7 ++++
 kernel/dma/direct.h            |  3 +-
 mm/slab.c                      |  6 +---
 mm/slab.h                      |  5 ++-
 mm/slab_common.c               | 46 +++++++++++++++++++------
 20 files changed, 213 insertions(+), 49 deletions(-)

