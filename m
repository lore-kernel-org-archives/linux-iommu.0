From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 1/2] dma-direct: Make DIRECT_MAPPING_ERROR viable for SWIOTLB
Date: Wed, 21 Nov 2018 16:00:50 +0000
Message-ID: <0b969e82ff750c50587550c55cb46c4025d35f39.1542812807.git.robin.murphy@arm.com>
References: <cover.1542812807.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1542812807.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, konrad.wilk@oracle.com
Cc: m.szyprowski@samsung.com, john.stultz@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sstabellini@kernel.org
List-Id: iommu@lists.linux-foundation.org

With the overflow buffer removed, we no longer have a unique address
which is guaranteed not to be a valid DMA target to use as an error
token. The DIRECT_MAPPING_ERROR value of 0 tries to at least represent
an unlikely DMA target, but unfortunately there are already SWIOTLB
users with DMA-able memory at physical address 0 which now gets falsely
treated as a mapping failure and leads to all manner of misbehaviour.

The best we can do to mitigate that is flip DIRECT_MAPPING_ERROR to the
other commonly-used error value of all-bits-set, since the last single
byte of memory is by far the least-likely-valid DMA target.

Fixes: dff8d6c1ed58 ("swiotlb: remove the overflow buffer")
Reported-by: John Stultz <john.stultz@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Add parentheses, tweak commit message, collect tags

 include/linux/dma-direct.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index bd73e7a91410..9e66bfe369aa 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -5,7 +5,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mem_encrypt.h>
 
-#define DIRECT_MAPPING_ERROR		0
+#define DIRECT_MAPPING_ERROR		(~(dma_addr_t)0)
 
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
-- 
2.19.1.dirty
