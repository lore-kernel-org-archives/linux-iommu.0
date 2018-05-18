From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] arc: fix arc_dma_sync_sg_for_{cpu,device}
Date: Fri, 18 May 2018 15:45:43 +0200
Message-ID: <20180518134545.5036-5-hch@lst.de>
References: <20180518134545.5036-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180518134545.5036-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, iommu@lists.linux-foundation.org
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

These functions should perform the same functionality as calling
arc_dma_sync_single_for_{cpu,device} on each S/G list element.  Ensure
they actually do that by calling arc_dma_sync_single_for_{cpu,device}.
Otherwise we could be passing a different dir argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/mm/dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 98e21ce526be..eafdbd2ad20a 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -241,7 +241,7 @@ static void arc_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 
 	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync(sg_phys(sg), sg->length, dir);
+		arc_dma_sync_single_for_cpu(dev, sg_phys(sg), sg->length, dir);
 }
 
 static void arc_dma_sync_sg_for_device(struct device *dev,
@@ -252,7 +252,8 @@ static void arc_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 
 	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync(sg_phys(sg), sg->length, dir);
+		arc_dma_sync_single_for_device(dev, sg_phys(sg), sg->length,
+				dir);
 }
 
 static int arc_dma_supported(struct device *dev, u64 dma_mask)
-- 
2.17.0
