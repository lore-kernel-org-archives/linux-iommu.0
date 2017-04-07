From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH] iommu/iova: fix underflow bug in __alloc_and_insert_iova_range
Date: Fri,  7 Apr 2017 01:36:20 -0400
Message-ID: <1491543380-10275-1-git-send-email-nwatters@codeaurora.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, manoj.iyer-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Normally, calling alloc_iova() using an iova_domain with insufficient
pfns remaining between start_pfn and dma_limit will fail and return a
NULL pointer. Unexpectedly, if such a "full" iova_domain contains an
iova with pfn_lo == 0, the alloc_iova() call will instead succeed and
return an iova containing invalid pfns.

This is caused by an underflow bug in __alloc_and_insert_iova_range()
that occurs after walking the "full" iova tree when the search ends
at the iova with pfn_lo == 0 and limit_pfn is then adjusted to be just
below that (-1). This (now huge) limit_pfn gives the impression that a
vast amount of space is available between it and start_pfn and thus
a new iova is allocated with the invalid pfn_hi value, 0xFFF.... .

To rememdy this, a check is introduced to ensure that adjustments to
limit_pfn will not underflow.

This issue has been observed in the wild, and is easily reproduced with
the following sample code.

	struct iova_domain *iovad = kzalloc(sizeof(*iovad), GFP_KERNEL);
	struct iova *rsvd_iova, *good_iova, *bad_iova;
	unsigned long limit_pfn = 3;
	unsigned long start_pfn = 1;
	unsigned long va_size = 2;

	init_iova_domain(iovad, SZ_4K, start_pfn, limit_pfn);
	rsvd_iova = reserve_iova(iovad, 0, 0);
	good_iova = alloc_iova(iovad, va_size, limit_pfn, true);
	bad_iova = alloc_iova(iovad, va_size, limit_pfn, true);

Prior to the patch, this yielded:
	*rsvd_iova == {0, 0}   /* Expected */
	*good_iova == {2, 3}   /* Expected */
	*bad_iova  == {-2, -1} /* Oh no... */

After the patch, bad_iova is NULL as expected since inadequate
space remains between limit_pfn and start_pfn after allocating
good_iova.

Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b7268a1..f6533e0 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -138,7 +138,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 				break;	/* found a free slot */
 		}
 adjust_limit_pfn:
-		limit_pfn = curr_iova->pfn_lo - 1;
+		limit_pfn = curr_iova->pfn_lo ? (curr_iova->pfn_lo - 1) : 0;
 move_left:
 		prev = curr;
 		curr = rb_prev(curr);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
