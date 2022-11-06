Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C94BA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F350C43143;
	Sun,  6 Nov 2022 22:01:50 +0000 (UTC)
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
Subject: [PATCH v3 01/13] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
Date: Sun,  6 Nov 2022 22:01:31 +0000
Message-Id: <20221106220143.2129263-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106220143.2129263-1-catalin.marinas@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for supporting a kmalloc() minimum alignment smaller than
the arch DMA alignment, decouple the two definitions. This requires that
the DMA API bounces smaller kmalloc() allocations, hence the smaller
ARCH_KMALLOC_MINALIGN is only enabled if a new
CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC option is enabled (to be introduced
in a subsequent patch).

After this patch, ARCH_DMA_MINALIGN is expected to be used in static
alignment annotations and defined by an architecture to be the maximum
alignment for all supported configurations/SoCs in a single Image.
ARCH_KMALLOC_MINALIGN becomes the default sizeof(unsigned long long).

Since ARCH_DMA_MINALIGN is now always defined, adjust the #ifdef in
dma_get_cache_alignment() so that there is no change for architectures
not requiring a minimum DMA alignment.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-mapping.h |  2 +-
 include/linux/slab.h        | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

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
index 90877fcde70b..b104d63e5456 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -221,12 +221,20 @@ void kmem_dump_obj(void *object);
  * alignment larger than the alignment of a 64-bit integer.
  * Setting ARCH_DMA_MINALIGN in arch headers allows that.
  */
-#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
+#ifdef ARCH_DMA_MINALIGN
+#define ARCH_HAS_DMA_MINALIGN
+#if ARCH_DMA_MINALIGN > 8 && !defined(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC)
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
+#else
+#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
+#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
 #endif
 
 /*
