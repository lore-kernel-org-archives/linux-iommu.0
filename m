Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5A18AFF
	for <iommu@lists.linux.dev>; Wed, 24 May 2023 17:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768AFC433A8;
	Wed, 24 May 2023 17:19:51 +0000 (UTC)
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
Subject: [PATCH v5 11/15] scatterlist: Add dedicated config for DMA flags
Date: Wed, 24 May 2023 18:19:00 +0100
Message-Id: <20230524171904.3967031-12-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524171904.3967031-1-catalin.marinas@arm.com>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
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
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/Kconfig         | 1 +
 include/linux/scatterlist.h | 4 ++--
 kernel/dma/Kconfig          | 3 +++
 3 files changed, 6 insertions(+), 2 deletions(-)

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
index 375a5e90d86a..87aaf8b5cdb4 100644
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
@@ -249,7 +249,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 }
 
 /*
- * CONFGI_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
+ * CONFIG_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
  * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
  * Use this padding for DMA flags bits to indicate when a specific
  * dma address is a bus address.
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
 
