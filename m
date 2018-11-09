From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH RFC 2/3] include/linux/gfp.h: Add __get_dma32_pages macro
Date: Fri,  9 Nov 2018 16:24:47 +0800
Message-ID: <20181109082448.150302-3-drinkcat@chromium.org>
References: <20181109082448.150302-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109082448.150302-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <alexander.levin@verizon.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
List-Id: iommu@lists.linux-foundation.org

Some callers (e.g. iommu/io-pgtable-arm-v7s) require DMA32 memory
when calling __get_dma_pages. Add a new macro for that purpose.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 include/linux/gfp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 76f8db0b0e715c..50e04896b78017 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -535,6 +535,8 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
 
 #define __get_dma_pages(gfp_mask, order) \
 		__get_free_pages((gfp_mask) | GFP_DMA, (order))
+#define __get_dma32_pages(gfp_mask, order) \
+		__get_free_pages((gfp_mask) | GFP_DMA32, (order))
 
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
-- 
2.19.1.930.g4563a0d9d0-goog
