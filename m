Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824FD182C8
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 15:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A00C433AE;
	Mon, 12 Jun 2023 15:32:52 +0000 (UTC)
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
Subject: [PATCH v7 11/17] arm64: Allow kmalloc() caches aligned to the smaller cache_line_size()
Date: Mon, 12 Jun 2023 16:31:55 +0100
Message-Id: <20230612153201.554742-12-catalin.marinas@arm.com>
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

On arm64, ARCH_DMA_MINALIGN is 128, larger than the cache line size on
most of the current platforms (typically 64). Define
ARCH_KMALLOC_MINALIGN to 8 (the default for architectures without their
own ARCH_DMA_MINALIGN) and override dma_get_cache_alignment() to return
cache_line_size(), probed at run-time. The kmalloc() caches will be
limited to the cache line size. This will allow the additional
kmalloc-{64,192} caches on most arm64 platforms.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 arch/arm64/include/asm/cache.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a51e6e8f3171..ceb368d33bf4 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -33,6 +33,7 @@
  * the CPU.
  */
 #define ARCH_DMA_MINALIGN	(128)
+#define ARCH_KMALLOC_MINALIGN	(8)
 
 #ifndef __ASSEMBLY__
 
@@ -90,6 +91,8 @@ static inline int cache_line_size_of_cpu(void)
 
 int cache_line_size(void);
 
+#define dma_get_cache_alignment	cache_line_size
+
 /*
  * Read the effective value of CTR_EL0.
  *
