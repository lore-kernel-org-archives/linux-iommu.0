From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/18] MIPS: lantiq: pass struct device to DMA
	API functions
Date: Fri,  1 Feb 2019 09:47:44 +0100
Message-ID: <20190201084801.10983-2-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Also use GFP_KERNEL instead of GFP_ATOMIC as the gfp_t for the memory
allocation, as we aren't in interrupt context or under a lock.

Note that this whole function looks somewhat bogus given that we never
even look at the returned dma address, and the CPHYSADDR magic on
a returned noncached mapping looks "interesting".  But I'll leave
that to people more familiar with the code to sort out.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/lantiq/xway/vmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
index 577ec81b557d..3deab9a77718 100644
--- a/arch/mips/lantiq/xway/vmmc.c
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -31,8 +31,8 @@ static int vmmc_probe(struct platform_device *pdev)
 	dma_addr_t dma;
 
 	cp1_base =
-		(void *) CPHYSADDR(dma_alloc_coherent(NULL, CP1_SIZE,
-						    &dma, GFP_ATOMIC));
+		(void *) CPHYSADDR(dma_alloc_coherent(&pdev->dev, CP1_SIZE,
+						    &dma, GFP_KERNEL));
 
 	gpio_count = of_gpio_count(pdev->dev.of_node);
 	while (gpio_count > 0) {
-- 
2.20.1
