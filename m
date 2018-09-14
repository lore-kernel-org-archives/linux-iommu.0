From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Date: Fri, 14 Sep 2018 11:58:03 +0200
Message-ID: <20180914095808.22202-2-hch@lst.de>
References: <20180914095808.22202-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914095808.22202-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The patch adding the infrastructure failed to actually add the symbol
declaration, oops..

Fixes: faef87723a ("dma-noncoherent: add a arch_sync_dma_for_cpu_all hook")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9bd54304446f..1b1d63b3634b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 	bool
 	select NEED_DMA_MAP_STATE
 
+config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+	bool
+
 config DMA_DIRECT_OPS
 	bool
 	depends on HAS_DMA
-- 
2.18.0
