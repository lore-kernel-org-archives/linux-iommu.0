Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DD182C8
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 15:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589BBC433A0;
	Mon, 12 Jun 2023 15:32:08 +0000 (UTC)
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
Subject: [PATCH v7 01/17] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
Date: Mon, 12 Jun 2023 16:31:45 +0100
Message-Id: <20230612153201.554742-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612153201.554742-1-catalin.marinas@arm.com>
References: <20230612153201.554742-1-catalin.marinas@arm.com>
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
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/linux/cache.h       |  6 ++++++
 include/linux/dma-mapping.h |  3 ++-
 include/linux/slab.h        | 14 ++++++++++----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 5da1bbd96154..9900d20b76c2 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -98,4 +98,10 @@ struct cacheline_padding {
 #define CACHELINE_PADDING(name)
 #endif
 
+#ifdef ARCH_DMA_MINALIGN
+#define ARCH_HAS_DMA_MINALIGN
+#else
+#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
+#endif
+
 #endif /* __LINUX_CACHE_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0ee20b764000..a50375331eac 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_DMA_MAPPING_H
 #define _LINUX_DMA_MAPPING_H
 
+#include <linux/cache.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/device.h>
@@ -545,7 +546,7 @@ static inline int dma_set_min_align_mask(struct device *dev,
 
 static inline int dma_get_cache_alignment(void)
 {
-#ifdef ARCH_DMA_MINALIGN
+#ifdef ARCH_HAS_DMA_MINALIGN
 	return ARCH_DMA_MINALIGN;
 #endif
 	return 1;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6b3e155b70bf..ca53425e9b32 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_SLAB_H
 #define	_LINUX_SLAB_H
 
+#include <linux/cache.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
@@ -235,12 +236,17 @@ void kmem_dump_obj(void *object);
  * alignment larger than the alignment of a 64-bit integer.
  * Setting ARCH_DMA_MINALIGN in arch headers allows that.
  */
-#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
+#ifdef ARCH_HAS_DMA_MINALIGN
+#if ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
 #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
-#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
-#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
-#else
+#endif
+#endif
+
+#ifndef ARCH_KMALLOC_MINALIGN
 #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
+#elif ARCH_KMALLOC_MINALIGN > 8
+#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
+#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
 #endif
 
 /*
