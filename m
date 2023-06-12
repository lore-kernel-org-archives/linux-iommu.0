Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3801DDC6
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 15:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0019C433D2;
	Mon, 12 Jun 2023 15:32:03 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
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
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
Date: Mon, 12 Jun 2023 16:31:44 +0100
Message-Id: <20230612153201.554742-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

That's v7 of the series reducing the kmalloc() minimum alignment on
arm64 to 8 (from 128). There's no new/different functionality, mostly
cosmetic changes and acks/tested-bys.

Andrew, if there are no further comments or objections to this version,
are you ok to take the series through the mm tree? The arm64 changes are
fairly small. Alternatively, I can push it into linux-next now to give
it some wider exposure and decide whether to upstream it when the
merging window opens. Thanks.

The updated patches are also available on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/kmalloc-minalign

Changes since v6
(https://lore.kernel.org/r/20230531154836.1366225-1-catalin.marinas@arm.com):

- Moved ARCH_DMA_MINALIGN to include/linux/cache.h from slab.h (it
  matches the asm/cache.h where most architectures defining this macro
  place it).

- Single body for __kmalloc_minalign() with an #ifdef.

- Renamed the sg_dma_use_swiotlb() to sg_dma_is_swiotlb() (Robin's
  suggestion).

- Added acks/tested-by.

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
 include/linux/cache.h          |  6 ++++
 include/linux/dma-map-ops.h    | 61 ++++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h    |  5 ++-
 include/linux/iio/iio.h        |  2 +-
 include/linux/scatterlist.h    | 60 ++++++++++++++++++++++++++-------
 include/linux/slab.h           | 14 +++++---
 kernel/dma/Kconfig             |  7 ++++
 kernel/dma/direct.c            |  2 +-
 kernel/dma/direct.h            |  3 +-
 mm/slab.c                      |  6 +---
 mm/slab.h                      |  5 ++-
 mm/slab_common.c               | 41 +++++++++++++++++------
 24 files changed, 244 insertions(+), 65 deletions(-)

