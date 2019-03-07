From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [v3] dma-mapping: work around clang bug
Date: Thu,  7 Mar 2019 11:48:41 +0100
Message-ID: <20190307104900.2506657-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Robin Murphy <robin.murphy@arm.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paul.burton@mips.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Clang has a rather annoying behavior of checking for integer
arithmetic problems in code paths that are discarded by gcc
before that perfoms the same checks.

For DMA_BIT_MASK(64), this leads to a warning despite the
result of the macro being completely sensible:

arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
                .coherent_dma_mask = DMA_BIT_MASK(64),

The best workaround I could come up with is to shift the
value twice, which makes the macro way less readable but
always has the same result.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: use (2ull << n-1) instead of ((1ull << n-1) << 1)
    special-case 0 instead of 64
v2: fix off-by-one error
---
 include/linux/dma-mapping.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..5788d60c2223 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,7 +138,11 @@ struct dma_map_ops {
 extern const struct dma_map_ops dma_virt_ops;
 extern const struct dma_map_ops dma_dummy_ops;
 
-#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+/*
+ * Shifting '2' instead of '1' because of
+ * https://bugs.llvm.org/show_bug.cgi?id=38789
+ */
+#define DMA_BIT_MASK(n)	(((n) == 0) ? 0ULL : (2ULL<<((n)-1))-1)
 
 #define DMA_MASK_NONE	0x0ULL
 
-- 
2.20.0
