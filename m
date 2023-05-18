Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D2182B8
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 17:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785F2C433D2;
	Thu, 18 May 2023 17:34:05 +0000 (UTC)
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
Subject: [PATCH v4 00/15] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
Date: Thu, 18 May 2023 18:33:48 +0100
Message-Id: <20230518173403.1150549-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

That's the fourth version of the series reducing the kmalloc() minimum
alignment on arm64 to 8 (from 128).

The first 10 patches decouple ARCH_KMALLOC_MINALIGN from
ARCH_DMA_MINALIGN and, for arm64, it limits the kmalloc() caches to
those aligned to the run-time probed cache_line_size(). The advantage on
arm64 is that we gain the kmalloc-{64,192} caches.

The subsequent patches (11 to 15) further reduce the kmalloc() caches to
kmalloc-{8,16,32,96} if the default swiotlb is present by bouncing small
buffers in the DMA API. For iommu, following discussions with Robin, we
concluded that it's still simpler to walk the sg list if the device is
non-coherent and follow the bouncing path when any of the elements may
originate from a small kmalloc() allocation.

Main changes since v3:

- Reorganise the series so that the first 10 patches could be applied
  before the DMA bouncing. They are still useful on arm64 reducing the
  kmalloc() alignment to 64.

- There is no dma_sg_kmalloc_needs_bounce() function, it has been
  unrolled in the iommu_dma_sync_sg_for_device() function.

- No crypto changes needed following Herbert's reworking of the crypto
  code (thanks!).

The patches are also available on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/kmalloc-minalign

Thanks.

Catalin Marinas (14):
  mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
  dma: Allow dma_get_cache_alignment() to return the smaller
    cache_line_size()
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

 arch/arm64/Kconfig             |  2 ++
 arch/arm64/include/asm/cache.h |  1 +
 arch/arm64/mm/init.c           |  7 ++++-
 drivers/base/devres.c          |  6 ++---
 drivers/gpu/drm/drm_managed.c  |  6 ++---
 drivers/iommu/dma-iommu.c      | 25 ++++++++++++++----
 drivers/md/dm-crypt.c          |  2 +-
 drivers/pci/Kconfig            |  1 +
 drivers/spi/spidev.c           |  2 +-
 drivers/usb/core/buffer.c      |  8 +++---
 include/linux/dma-map-ops.h    | 48 ++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h    |  4 ++-
 include/linux/scatterlist.h    | 29 +++++++++++++++++---
 include/linux/slab.h           | 16 +++++++++---
 kernel/dma/Kconfig             | 19 ++++++++++++++
 kernel/dma/direct.h            |  3 ++-
 mm/slab.c                      |  6 +----
 mm/slab.h                      |  5 ++--
 mm/slab_common.c               | 43 +++++++++++++++++++++++-------
 19 files changed, 188 insertions(+), 45 deletions(-)

