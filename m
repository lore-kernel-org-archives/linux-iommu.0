Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB0BA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D987C4314A;
	Sun,  6 Nov 2022 22:02:02 +0000 (UTC)
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
Subject: [PATCH v3 04/13] mm/slab: Allow kmalloc() minimum alignment fallback to dma_get_cache_alignment()
Date: Sun,  6 Nov 2022 22:01:34 +0000
Message-Id: <20221106220143.2129263-5-catalin.marinas@arm.com>
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

For architecture with ARCH_DMA_MINALIGN larger than
ARCH_KMALLOC_MINALIGN, if no default swiotlb buffer is available, fall
back to a kmalloc() minimum alignment which is safe for DMA.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

I'm not particularly fond of the slab_common.c code probing the default
swiotlb. In one incarnation I had a __weak arch_kmalloc_minalign()
overridden by the arch code but decided there wasn't anything arm64
specific in there.

 mm/slab.c        |  6 +-----
 mm/slab.h        |  2 ++
 mm/slab_common.c | 40 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 59c8e28f7b6a..6e31eb027ef6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1241,11 +1241,7 @@ void __init kmem_cache_init(void)
 	 * Initialize the caches that provide memory for the  kmem_cache_node
 	 * structures first.  Without this, further allocations will bug.
 	 */
-	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
-				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
-				kmalloc_info[INDEX_NODE].size,
-				ARCH_KMALLOC_FLAGS, 0,
-				kmalloc_info[INDEX_NODE].size);
+	new_kmalloc_cache(INDEX_NODE, KMALLOC_NORMAL, ARCH_KMALLOC_FLAGS);
 	slab_state = PARTIAL_NODE;
 	setup_kmalloc_cache_index_table();
 
diff --git a/mm/slab.h b/mm/slab.h
index 0202a8c2f0d2..d0460e0f6760 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -288,6 +288,8 @@ int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 struct kmem_cache *create_kmalloc_cache(const char *name, unsigned int size,
 			slab_flags_t flags, unsigned int useroffset,
 			unsigned int usersize);
+void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
+			      slab_flags_t flags);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
 			unsigned int size, slab_flags_t flags,
 			unsigned int useroffset, unsigned int usersize);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 33b1886b06eb..b62f27c2dda7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -17,6 +17,8 @@
 #include <linux/cpu.h>
 #include <linux/uaccess.h>
 #include <linux/seq_file.h>
+#include <linux/dma-mapping.h>
+#include <linux/swiotlb.h>
 #include <linux/proc_fs.h>
 #include <linux/debugfs.h>
 #include <linux/kasan.h>
@@ -852,9 +854,30 @@ void __init setup_kmalloc_cache_index_table(void)
 	}
 }
 
-static void __init
+static unsigned int __kmalloc_minalign(void)
+{
+	int cache_align = dma_get_cache_alignment();
+
+	/*
+	 * If CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC is not enabled,
+	 * ARCH_KMALLOC_MINALIGN matches ARCH_DMA_MINALIGN.
+	 */
+	if (!IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) ||
+	    cache_align < ARCH_KMALLOC_MINALIGN || io_tlb_default_mem.nslabs)
+		return ARCH_KMALLOC_MINALIGN;
+
+	pr_info_once("No default DMA bounce buffer, increasing the kmalloc() minimum alignment to %d\n",
+		     cache_align);
+	return cache_align;
+}
+
+void __init
 new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
+	unsigned int minalign = __kmalloc_minalign();
+	unsigned int aligned_size = kmalloc_info[idx].size;
+	int aligned_idx = idx;
+
 	if (type == KMALLOC_RECLAIM) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
 	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
@@ -867,10 +890,17 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 		flags |= SLAB_CACHE_DMA;
 	}
 
-	kmalloc_caches[type][idx] = create_kmalloc_cache(
-					kmalloc_info[idx].name[type],
-					kmalloc_info[idx].size, flags, 0,
-					kmalloc_info[idx].size);
+	if (minalign > ARCH_KMALLOC_MINALIGN) {
+		aligned_size = ALIGN(aligned_size, minalign);
+		aligned_idx = __kmalloc_index(aligned_size, false);
+	}
+
+	if (!kmalloc_caches[type][aligned_idx])
+		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
+					kmalloc_info[aligned_idx].name[type],
+					aligned_size, flags, 0, aligned_size);
+	if (idx != aligned_idx)
+		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
 
 	/*
 	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
