From: Huaisheng Ye <yehs2007-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH v3 4/9] fs/btrfs/extent_io: update usage of zone modifiers
Date: Thu, 24 May 2018 00:57:19 +0800
Message-ID: <1527094639-4562-1-git-send-email-yehs2007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mhocko-IBi9RG/b67k@public.gmane.org, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org, Josef Bacik <jbacik-b10kYP2dOMg@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, colyli-l3A5Bk7waGM@public.gmane.org, Chris Mason <clm-b10kYP2dOMg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-btrfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chengnt-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org, David Sterba <dsterba-IBi9RG/b67k@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>

Use __GFP_ZONE_MASK to replace (__GFP_DMA32 | __GFP_HIGHMEM).

In function alloc_extent_state, it is obvious that __GFP_DMA is not
the expecting zone type.

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
each others by OR.

Use GFP_NORMAL() to clear bottom 3 bits of GFP bitmaks.

Signed-off-by: Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
Cc: Chris Mason <clm-b10kYP2dOMg@public.gmane.org>
Cc: Josef Bacik <jbacik-b10kYP2dOMg@public.gmane.org>
Cc: David Sterba <dsterba-IBi9RG/b67k@public.gmane.org>
Cc: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e99b329..f41fc61 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -220,7 +220,7 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
 	 * The given mask might be not appropriate for the slab allocator,
 	 * drop the unsupported bits
 	 */
-	mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);
+	mask = GFP_NORMAL(mask);
 	state = kmem_cache_alloc(extent_state_cache, mask);
 	if (!state)
 		return state;
-- 
1.8.3.1
