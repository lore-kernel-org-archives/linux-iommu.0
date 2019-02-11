From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/12] device.h: dma_mem is only needed for HAVE_GENERIC_DMA_COHERENT
Date: Mon, 11 Feb 2019 14:35:44 +0100
Message-ID: <20190211133554.30055-3-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

No need to carry an unused field around.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..be544400acdd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1017,8 +1017,10 @@ struct device {
 
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
+#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+#endif
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
-- 
2.20.1
