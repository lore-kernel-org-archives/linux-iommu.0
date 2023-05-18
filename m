Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C37182B8
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 17:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FCDC433A7;
	Thu, 18 May 2023 17:34:09 +0000 (UTC)
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
Subject: [PATCH v4 01/15] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
Date: Thu, 18 May 2023 18:33:49 +0100
Message-Id: <20230518173403.1150549-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518173403.1150549-1-catalin.marinas@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for supporting a kmalloc() minimum alignment smaller than
the arch DMA alignment, decouple the two definitions. This requires that
either the kmalloc() caches are aligned to a (run-time) cache-line size
or the DMA API bounces unaligned kmalloc() allocations. Subsequent
patches will implement both options.

After this patch, ARCH_DMA_MINALIGN is expected to be used in static
alignment annotations and defined by an architecture to be the maximum
alignment for all supported configurations/SoCs in a single Image.
Architectures opting in to a smaller ARCH_KMALLOC_MINALIGN will need to
define its value in the arch headers.

Since ARCH_DMA_MINALIGN is now always defined, adjust the #ifdef in
dma_get_cache_alignment() so that there is no change for architectures
not requiring a minimum DMA alignment.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-mapping.h |  2 +-
 include/linux/slab.h        | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0ee20b764000..3288a1339271 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -545,7 +545,7 @@ static inline int dma_set_min_align_mask(struct device *dev,
 
 static inline int dma_get_cache_alignment(void)
 {
-#ifdef ARCH_DMA_MINALIGN
+#ifdef ARCH_HAS_DMA_MINALIGN
 	return ARCH_DMA_MINALIGN;
 #endif
 	return 1;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6b3e155b70bf..3f76e7c53ada 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -235,14 +235,24 @@ void kmem_dump_obj(void *object);
  * alignment larger than the alignment of a 64-bit integer.
  * Setting ARCH_DMA_MINALIGN in arch headers allows that.
  */
-#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
+#ifdef ARCH_DMA_MINALIGN
+#define ARCH_HAS_DMA_MINALIGN
+#if ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
 #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
-#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
-#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
+#endif
 #else
+#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
+#endif
+
+#ifndef ARCH_KMALLOC_MINALIGN
 #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
 #endif
 
+#if ARCH_KMALLOC_MINALIGN > 8
+#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
+#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
+#endif
+
 /*
  * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
  * Intended for arches that get misalignment faults even for 64 bit integer
