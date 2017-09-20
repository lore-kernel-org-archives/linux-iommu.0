From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 7/6] iommu/iova: Make cached_node always valid
Date: Wed, 20 Sep 2017 12:02:48 +0100
Message-ID: <0c9865fdc53820a81f81adec5a7bb4239aba7bc1.1505904195.git.robin.murphy@arm.com>
References: <cover.1505829018.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1505829018.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With the anchor node at the top of the rbtree, there is always a valid
node for rb_next() to return, such that cached_node is only ever NULL
until the first allocation. Initialising it to point at the anchor node
gets rid of that window and makes the NULL checking entirely redundant.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Oops, spotted this one slightly too late. This could be squashed into
patch #5 (which I'll do myself if I there's any cause to resend the
whole series again).

Robin.

 drivers/iommu/iova.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index a7af8273fa98..ec443c0a8319 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -51,7 +51,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
-	iovad->cached_node = NULL;
+	iovad->cached_node = &iovad->anchor.node;
 	iovad->cached32_node = NULL;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
@@ -120,10 +120,7 @@ __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
 	if (limit_pfn <= iovad->dma_32bit_pfn && iovad->cached32_node)
 		return iovad->cached32_node;
 
-	if (iovad->cached_node)
-		return iovad->cached_node;
-
-	return &iovad->anchor.node;
+	return iovad->cached_node;
 }
 
 static void
@@ -141,14 +138,11 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 	struct iova *cached_iova;
 	struct rb_node **curr;
 
-	if (free->pfn_hi < iovad->dma_32bit_pfn)
+	if (free->pfn_hi < iovad->dma_32bit_pfn && iovad->cached32_node)
 		curr = &iovad->cached32_node;
 	else
 		curr = &iovad->cached_node;
 
-	if (!*curr)
-		return;
-
 	cached_iova = rb_entry(*curr, struct iova, node);
 	if (free->pfn_lo >= cached_iova->pfn_lo)
 		*curr = rb_next(&free->node);
-- 
2.13.4.dirty
