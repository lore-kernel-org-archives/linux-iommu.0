From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/7] iommu/iova: fix incorrect variable types
Date: Wed, 22 Mar 2017 14:27:41 +0800
Message-ID: <1490164067-12552-2-git-send-email-thunder.leizhen@huawei.com>
References: <1490164067-12552-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490164067-12552-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Keep these four variables type consistent with the paramters of function
__alloc_and_insert_iova_range and the members of struct iova:

1. static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
		unsigned long size, unsigned long limit_pfn,

2. struct iova {
	unsigned long	pfn_hi;
	unsigned long	pfn_lo;

In fact, limit_pfn is most likely larger than 32 bits on DMA64.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iova.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b7268a1..8ba8b496 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -104,8 +104,8 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
  * Computes the padding size required, to make the start address
  * naturally aligned on the power-of-two order of its size
  */
-static unsigned int
-iova_get_pad_size(unsigned int size, unsigned int limit_pfn)
+static unsigned long
+iova_get_pad_size(unsigned long size, unsigned long limit_pfn)
 {
 	return (limit_pfn + 1 - size) & (__roundup_pow_of_two(size) - 1);
 }
@@ -117,7 +117,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	struct rb_node *prev, *curr = NULL;
 	unsigned long flags;
 	unsigned long saved_pfn;
-	unsigned int pad_size = 0;
+	unsigned long pad_size = 0;
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-- 
2.5.0
