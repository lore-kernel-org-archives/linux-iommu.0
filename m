Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CBD182B8
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 17:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C9C4339B;
	Thu, 18 May 2023 17:34:21 +0000 (UTC)
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
Subject: [PATCH v4 04/15] mm/slab: Limit kmalloc() minimum alignment to dma_get_cache_alignment()
Date: Thu, 18 May 2023 18:33:52 +0100
Message-Id: <20230518173403.1150549-5-catalin.marinas@arm.com>
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

Do not create kmalloc() caches which are not aligned to
dma_get_cache_alignment(). There is no functional change since for
current architectures defining ARCH_DMA_MINALIGN, ARCH_KMALLOC_MINALIGN
equals ARCH_DMA_MINALIGN (and dma_get_cache_alignment()). On
architectures without a specific ARCH_DMA_MINALIGN,
dma_get_cache_alignment() is 1, so no change to the kmalloc() caches.

If an architecture selects ARCH_HAS_DMA_CACHE_LINE_SIZE (introduced
previously), the kmalloc() caches will be aligned to a cache line size.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 mm/slab_common.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7f069159aee2..7c6475847fdf 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/uaccess.h>
 #include <linux/seq_file.h>
+#include <linux/dma-mapping.h>
 #include <linux/proc_fs.h>
 #include <linux/debugfs.h>
 #include <linux/kasan.h>
@@ -862,9 +863,18 @@ void __init setup_kmalloc_cache_index_table(void)
 	}
 }
 
+static unsigned int __kmalloc_minalign(void)
+{
+	return dma_get_cache_alignment();
+}
+
 void __init
 new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
+	unsigned int minalign = __kmalloc_minalign();
+	unsigned int aligned_size = kmalloc_info[idx].size;
+	int aligned_idx = idx;
+
 	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
 	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
@@ -877,9 +887,17 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 		flags |= SLAB_CACHE_DMA;
 	}
 
-	kmalloc_caches[type][idx] = create_kmalloc_cache(
-					kmalloc_info[idx].name[type],
-					kmalloc_info[idx].size, flags);
+	if (minalign > ARCH_KMALLOC_MINALIGN) {
+		aligned_size = ALIGN(aligned_size, minalign);
+		aligned_idx = __kmalloc_index(aligned_size, false);
+	}
+
+	if (!kmalloc_caches[type][aligned_idx])
+		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
+					kmalloc_info[aligned_idx].name[type],
+					aligned_size, flags);
+	if (idx != aligned_idx)
+		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
 
 	/*
 	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
