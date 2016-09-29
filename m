From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCH 2/2] dma-mapping: fix m32r build warning
Date: Thu, 29 Sep 2016 12:02:40 +0200
Message-ID: <20160929100240.7955-3-niklas.soderlund@ragnatech.se>
References: <20160929100240.7955-1-niklas.soderlund@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160929100240.7955-1-niklas.soderlund@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, arnd@arndb.de, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: iommu@lists.linux-foundation.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

kbuild test robot reports:

   In file included from include/linux/skbuff.h:34:0,
                    from include/linux/icmpv6.h:4,
                    from include/linux/ipv6.h:75,
                    from include/net/ipv6.h:16,
                    from include/linux/sunrpc/clnt.h:27,
                    from include/linux/nfs_fs.h:30,
                    from fs/lockd/clntlock.c:13:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
>> include/linux/dma-mapping.h:274:16: warning: unused variable 'pfn' [-Wunused-variable]
     unsigned long pfn = __phys_to_pfn(phys_addr);
                   ^~~

The pfn value is only used once in the call to pfn_valid(), remove the
variable and calculate the pfn when it's needed. Note that the kbuild
report is old and PHYS_PFN() is now used instead of __phys_to_pfn() to
calculate the pfn.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 include/linux/dma-mapping.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ff7c87f..642cb4c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -271,13 +271,12 @@ static inline dma_addr_t dma_map_resource(struct device *dev,
 					  unsigned long attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
-	unsigned long pfn = PHYS_PFN(phys_addr);
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
 
 	/* Don't allow RAM to be mapped */
-	BUG_ON(pfn_valid(pfn));
+	BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
 
 	addr = phys_addr;
 	if (ops->map_resource)
-- 
2.9.3
