Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82D182B8
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 17:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A72C4339C;
	Thu, 18 May 2023 17:34:13 +0000 (UTC)
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
Subject: [PATCH v4 02/15] dma: Allow dma_get_cache_alignment() to return the smaller cache_line_size()
Date: Thu, 18 May 2023 18:33:50 +0100
Message-Id: <20230518173403.1150549-3-catalin.marinas@arm.com>
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

On architectures like arm64, ARCH_DMA_MINALIGN is larger than most cache
line size configurations deployed. However, the single kernel binary
requirement doesn't allow the smaller ARCH_DMA_MINALIGN. Permit an
architecture to opt in to dma_get_cache_alignment() returning
cache_line_size() which can be probed at run-time.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/dma-mapping.h | 2 ++
 kernel/dma/Kconfig          | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 3288a1339271..b29124341317 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -545,6 +545,8 @@ static inline int dma_set_min_align_mask(struct device *dev,
 
 static inline int dma_get_cache_alignment(void)
 {
+	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CACHE_LINE_SIZE))
+		return cache_line_size();
 #ifdef ARCH_HAS_DMA_MINALIGN
 	return ARCH_DMA_MINALIGN;
 #endif
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 6677d0e64d27..cc750062c412 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -76,6 +76,13 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_HAS_DMA_CACHE_LINE_SIZE
+	bool
+	help
+	  Select if the architecture has non-coherent DMA and
+	  defines ARCH_DMA_MINALIGN larger than a run-time
+	  cache_line_size().
+
 #
 # Select this option if the architecture assumes DMA devices are coherent
 # by default.
