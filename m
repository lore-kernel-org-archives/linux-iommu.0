Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB7A182C8
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 15:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA072C4339C;
	Mon, 12 Jun 2023 15:32:56 +0000 (UTC)
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
Subject: [PATCH v7 12/17] scatterlist: Add dedicated config for DMA flags
Date: Mon, 12 Jun 2023 16:31:56 +0100
Message-Id: <20230612153201.554742-13-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612153201.554742-1-catalin.marinas@arm.com>
References: <20230612153201.554742-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

The DMA flags field will be useful for users beyond PCI P2P, so upgrade
to its own dedicated config option.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[catalin.marinas@arm.com: use #ifdef CONFIG_NEED_SG_DMA_FLAGS in scatterlist.h]
[catalin.marinas@arm.com: update PCI_P2PDMA dma_flags comment in scatterlist.h]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/pci/Kconfig         |  1 +
 include/linux/scatterlist.h | 13 ++++++-------
 kernel/dma/Kconfig          |  3 +++
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9309f2469b41..3c07d8d214b3 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -168,6 +168,7 @@ config PCI_P2PDMA
 	#
 	depends on 64BIT
 	select GENERIC_ALLOCATOR
+	select NEED_SG_DMA_FLAGS
 	help
 	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
 	  BARs that are exposed in other devices that are the part of
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 375a5e90d86a..19833fd4113b 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -16,7 +16,7 @@ struct scatterlist {
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
 	unsigned int	dma_length;
 #endif
-#ifdef CONFIG_PCI_P2PDMA
+#ifdef CONFIG_NEED_SG_DMA_FLAGS
 	unsigned int    dma_flags;
 #endif
 };
@@ -249,12 +249,11 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 }
 
 /*
- * CONFGI_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
- * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
- * Use this padding for DMA flags bits to indicate when a specific
- * dma address is a bus address.
+ * One 64-bit architectures there is a 4-byte padding in struct scatterlist
+ * (assuming also CONFIG_NEED_SG_DMA_LENGTH is set). Use this padding for DMA
+ * flags bits to indicate when a specific dma address is a bus address.
  */
-#ifdef CONFIG_PCI_P2PDMA
+#ifdef CONFIG_NEED_SG_DMA_FLAGS
 
 #define SG_DMA_BUS_ADDRESS (1 << 0)
 
@@ -312,7 +311,7 @@ static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
 {
 }
 
-#endif
+#endif	/* CONFIG_NEED_SG_DMA_FLAGS */
 
 /**
  * sg_phys - Return physical address of an sg entry
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 6677d0e64d27..acc6f231259c 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -24,6 +24,9 @@ config DMA_OPS_BYPASS
 config ARCH_HAS_DMA_MAP_DIRECT
 	bool
 
+config NEED_SG_DMA_FLAGS
+	bool
+
 config NEED_SG_DMA_LENGTH
 	bool
 
