Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2918AFF
	for <iommu@lists.linux.dev>; Wed, 24 May 2023 17:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE70C433AC;
	Wed, 24 May 2023 17:20:07 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
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
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 15/15] arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64
Date: Wed, 24 May 2023 18:19:04 +0100
Message-Id: <20230524171904.3967031-16-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524171904.3967031-1-catalin.marinas@arm.com>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the DMA bouncing of unaligned kmalloc() buffers now in place,
enable it for arm64 to allow the kmalloc-{8,16,32,48,96} caches. In
addition, always create the swiotlb buffer even when the end of RAM is
within the 32-bit physical address range (the swiotlb buffer can still
be disabled on the kernel command line).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig   | 1 +
 arch/arm64/mm/init.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1201d25a8a4..af42871431c0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -120,6 +120,7 @@ config ARM64
 	select CRC32
 	select DCACHE_WORD_ACCESS
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
+	select DMA_BOUNCE_UNALIGNED_KMALLOC
 	select DMA_DIRECT_REMAP
 	select EDAC_SUPPORT
 	select FRAME_POINTER
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 66e70ca47680..3ac2e9d79ce4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -442,7 +442,12 @@ void __init bootmem_init(void)
  */
 void __init mem_init(void)
 {
-	swiotlb_init(max_pfn > PFN_DOWN(arm64_dma_phys_limit), SWIOTLB_VERBOSE);
+	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
+
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC))
+		swiotlb = true;
+
+	swiotlb_init(swiotlb, SWIOTLB_VERBOSE);
 
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
