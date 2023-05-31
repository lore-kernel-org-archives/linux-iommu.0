Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9F171D5
	for <iommu@lists.linux.dev>; Wed, 31 May 2023 15:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550CEC433D2;
	Wed, 31 May 2023 15:48:38 +0000 (UTC)
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
	Jonathan Cameron <jic23@kernel.org>,
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
Date: Wed, 31 May 2023 16:48:19 +0100
Message-Id: <20230531154836.1366225-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here's version 6 of the series reducing the kmalloc() minimum alignment
on arm64 to 8 (from 128). There are patches already to do the same for
riscv (pretty straight-forward after this series).

The first 11 patches decouple ARCH_KMALLOC_MINALIGN from
ARCH_DMA_MINALIGN and, for arm64, limit the kmalloc() caches to those
aligned to the run-time probed cache_line_size(). On arm64 we gain the
kmalloc-{64,192} caches.

The subsequent patches (11 to 17) further reduce the kmalloc() caches to
kmalloc-{8,16,32,96} if the default swiotlb is present by bouncing small
buffers in the DMA API.

Changes since v5:

- Renaming of the sg_* accessors for consistency.

- IIO_DMA_MINALIGN defined to ARCH_DMA_MINALIGN (missed it in previous
  versions).

- Modified Robin's patch 11 to use #ifdef CONFIG_NEED_SG_DMA_FLAGS
  instead of CONFIG_PCI_P2PDMA in scatterlist.h.

- Added the new sg_dma_*_swiotlb() under the same #ifdef as above.

The updated patches are also available on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/kmalloc-minalign

Thanks.

Catalin Marinas (15):
  mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
  dma: Allow dma_get_cache_alignment() to be overridden by the arch code
  mm/slab: Simplify create_kmalloc_cache() args and make it static
  mm/slab: Limit kmalloc() minimum alignment to
    dma_get_cache_alignment()
  drivers/base: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/gpu: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/usb: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/spi: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  dm-crypt: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  iio: core: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  arm64: Allow kmalloc() caches aligned to the smaller cache_line_size()
  dma-mapping: Force bouncing if the kmalloc() size is not
    cache-line-aligned
  iommu/dma: Force bouncing if the size is not cacheline-aligned
  mm: slab: Reduce the kmalloc() minimum alignment if DMA bouncing
    possible
  arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64

Robin Murphy (2):
  scatterlist: Add dedicated config for DMA flags
  dma-mapping: Name SG DMA flag helpers consistently

 arch/arm64/Kconfig             |  1 +
 arch/arm64/include/asm/cache.h |  3 ++
 arch/arm64/mm/init.c           |  7 +++-
 drivers/base/devres.c          |  6 ++--
 drivers/gpu/drm/drm_managed.c  |  6 ++--
 drivers/iommu/Kconfig          |  1 +
 drivers/iommu/dma-iommu.c      | 58 ++++++++++++++++++++++++--------
 drivers/iommu/iommu.c          |  2 +-
 drivers/md/dm-crypt.c          |  2 +-
 drivers/pci/Kconfig            |  1 +
 drivers/spi/spidev.c           |  2 +-
 drivers/usb/core/buffer.c      |  8 ++---
 include/linux/dma-map-ops.h    | 61 ++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h    |  4 ++-
 include/linux/iio/iio.h        |  2 +-
 include/linux/scatterlist.h    | 60 ++++++++++++++++++++++++++-------
 include/linux/slab.h           | 14 ++++++--
 kernel/dma/Kconfig             |  7 ++++
 kernel/dma/direct.c            |  2 +-
 kernel/dma/direct.h            |  3 +-
 mm/slab.c                      |  6 +---
 mm/slab.h                      |  5 ++-
 mm/slab_common.c               | 46 +++++++++++++++++++------
 23 files changed, 243 insertions(+), 64 deletions(-)

