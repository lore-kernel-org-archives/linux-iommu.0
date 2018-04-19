From: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/iova: Update cached node pointer when current node
	fails to get any free IOVA
Date: Thu, 19 Apr 2018 22:42:34 +0530
Message-ID: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: Vadim.Lomovtsev-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Jan.Glauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, gklkml16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tomasz.nowicki-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Robert.Richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The performance drop is observed with long hours iperf testing using 40G
cards. This is mainly due to long iterations in finding the free iova
range in 32bit address space.

In current implementation for 64bit PCI devices, there is always first
attempt to allocate iova from 32bit(SAC preferred over DAC) address
range. Once we run out 32bit range, there is allocation from higher range,
however due to cached32_node optimization it does not suppose to be
painful. cached32_node always points to recently allocated 32-bit node.
When address range is full, it will be pointing to last allocated node
(leaf node), so walking rbtree to find the available range is not
expensive affair. However this optimization does not behave well when
one of the middle node is freed. In that case cached32_node is updated
to point to next iova range. The next iova allocation will consume free
range and again update cached32_node to itself. From now on, walking
over 32-bit range is more expensive.

This patch adds fix to update cached node to leaf node when there are no
iova free range left, which avoids unnecessary long iterations.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iova.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe262..e6ee2ea 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -201,6 +201,12 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	} while (curr && new_pfn <= curr_iova->pfn_hi);
 
 	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+		/* No more cached node points to free hole, update to leaf node.
+		 */
+		struct iova *prev_iova;
+
+		prev_iova = rb_entry(prev, struct iova, node);
+		__cached_rbnode_insert_update(iovad, prev_iova);
 		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 		return -ENOMEM;
 	}
-- 
2.9.4
