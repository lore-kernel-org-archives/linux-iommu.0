Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B91E534
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 15:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3B6C433A1;
	Mon, 12 Jun 2023 15:33:14 +0000 (UTC)
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
Subject: [PATCH v7 16/17] mm: slab: Reduce the kmalloc() minimum alignment if DMA bouncing possible
Date: Mon, 12 Jun 2023 16:32:00 +0100
Message-Id: <20230612153201.554742-17-catalin.marinas@arm.com>
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

If an architecture opted in to DMA bouncing of unaligned kmalloc()
buffers (ARCH_WANT_KMALLOC_DMA_BOUNCE), reduce the minimum kmalloc()
cache alignment below cache-line size to ARCH_KMALLOC_MINALIGN.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 mm/slab_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7c6475847fdf..43c008165f56 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/seq_file.h>
 #include <linux/dma-mapping.h>
+#include <linux/swiotlb.h>
 #include <linux/proc_fs.h>
 #include <linux/debugfs.h>
 #include <linux/kasan.h>
@@ -865,6 +866,10 @@ void __init setup_kmalloc_cache_index_table(void)
 
 static unsigned int __kmalloc_minalign(void)
 {
+#ifdef CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC
+	if (io_tlb_default_mem.nslabs)
+		return ARCH_KMALLOC_MINALIGN;
+#endif
 	return dma_get_cache_alignment();
 }
 
