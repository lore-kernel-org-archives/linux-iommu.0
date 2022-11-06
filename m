Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BABA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A241C4314C;
	Sun,  6 Nov 2022 22:02:38 +0000 (UTC)
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
Subject: [PATCH v3 13/13] dma: arm64: Add CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Date: Sun,  6 Nov 2022 22:01:43 +0000
Message-Id: <20221106220143.2129263-14-catalin.marinas@arm.com>
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

With all the infrastructure in place for bouncing small kmalloc()
buffers, add the corresponding Kconfig entry and select it for arm64.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/Kconfig | 1 +
 kernel/dma/Kconfig | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3991cb7b8a33..f889cf16e6ab 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -100,6 +100,7 @@ config ARM64
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	select ARCH_WANT_KMALLOC_DMA_BOUNCE
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d6fab8e3cbae..b56e76371023 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -86,6 +86,14 @@ config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
 
+config ARCH_WANT_KMALLOC_DMA_BOUNCE
+	bool
+
+config DMA_BOUNCE_UNALIGNED_KMALLOC
+	def_bool y
+	depends on ARCH_WANT_KMALLOC_DMA_BOUNCE
+	depends on SWIOTLB && !SLOB
+
 config DMA_RESTRICTED_POOL
 	bool "DMA Restricted Pool"
 	depends on OF && OF_RESERVED_MEM && SWIOTLB
