Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDF182C8
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 15:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA261C4339C;
	Mon, 12 Jun 2023 15:32:12 +0000 (UTC)
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
Subject: [PATCH v7 02/17] dma: Allow dma_get_cache_alignment() to be overridden by the arch code
Date: Mon, 12 Jun 2023 16:31:46 +0100
Message-Id: <20230612153201.554742-3-catalin.marinas@arm.com>
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

On arm64, ARCH_DMA_MINALIGN is larger than most cache line size
configurations deployed. Allow an architecture to override
dma_get_cache_alignment() in order to return a run-time probed value
(e.g. cache_line_size()).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/linux/dma-mapping.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a50375331eac..e13050eb9777 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -544,6 +544,7 @@ static inline int dma_set_min_align_mask(struct device *dev,
 	return 0;
 }
 
+#ifndef dma_get_cache_alignment
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_HAS_DMA_MINALIGN
@@ -551,6 +552,7 @@ static inline int dma_get_cache_alignment(void)
 #endif
 	return 1;
 }
+#endif
 
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
