From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/12] dma-mapping: remove an incorrect __iommem annotation
Date: Mon, 11 Feb 2019 14:35:47 +0100
Message-ID: <20190211133554.30055-6-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

memmap return a regular void pointer, not and __iomem one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 66f0fb7e9a3a..4b76aba574c2 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -43,7 +43,7 @@ static int dma_init_coherent_memory(
 	struct dma_coherent_mem **mem)
 {
 	struct dma_coherent_mem *dma_mem = NULL;
-	void __iomem *mem_base = NULL;
+	void *mem_base = NULL;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	int ret;
-- 
2.20.1
