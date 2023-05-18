Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54417182B8
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 17:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79802C4339E;
	Thu, 18 May 2023 17:35:06 +0000 (UTC)
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
Subject: [PATCH v4 15/15] arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64
Date: Thu, 18 May 2023 18:34:03 +0100
Message-Id: <20230518173403.1150549-16-catalin.marinas@arm.com>
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
index d11340b41703..1dcfa78f131f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -102,6 +102,7 @@ config ARM64
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
+	select ARCH_WANT_KMALLOC_DMA_BOUNCE
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
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
