From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH] iommu/iova: validate iova_domain input to put_iova_domain
Date: Wed, 13 Jul 2016 14:49:32 -0400
Message-ID: <1468435772-27905-1-git-send-email-nwatters@codeaurora.org>
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
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Passing a NULL or uninitialized iova_domain into put_iova_domain
will currently crash the kernel when the unconfigured iova_domain
data members are accessed. To prevent this from occurring, this patch
adds a check to make sure that the domain is non-NULL and that the
domain granule is non-zero. The granule can be used to check if the
domain was properly initialized because calling init_iova_domain
with a granule of zero would have already triggered a BUG statement
crashing the kernel.

Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/iova.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e23001b..3511a1c 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -459,6 +459,10 @@ void put_iova_domain(struct iova_domain *iovad)
 	struct rb_node *node;
 	unsigned long flags;
 
+	/* Only teardown properly initialized domains */
+	if (!iovad || !iovad->granule)
+		return;
+
 	free_iova_rcaches(iovad);
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	node = rb_first(&iovad->rbroot);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
