From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/6] trivial cleanup for iommu/vt-d
Date: Fri, 4 Jul 2014 11:22:09 +0200
Message-ID: <20140704092209.GA13434@8bytes.org>
References: <1400589472-8544-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400589472-8544-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 20, 2014 at 08:37:46PM +0800, Yijing Wang wrote:
> 
> Yijing Wang (6):
>   iommu/vt-d: Use list_for_each_safe() to simplify code
>   iommu/vt-d: move up no_iommu and dmar_disabled check
>   iommu/vt-d: clear the redundant assignment in dmar_enable_qi
>   iommu/vt-d: clear the redundant assignment for domain->nid
>   iommu/vt-d: use inline function dma_pte_superpage instead of macros
>   iommu/vt-d: fix reference count in iommu_prepare_isa

Applied patches 1, 3, 4, 5 and 6, thanks. Also added another patch
on-top, see below.

>From 77c704bebc5d023ece7af32ea18bc3508cdb0007 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Fri, 4 Jul 2014 11:19:10 +0200
Subject: [PATCH] iommu/vt-d: Don't use magic number in dma_pte_superpage

Use the already defined DMA_PTE_LARGE_PAGE for testing
instead of hardcoding the value again.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9b9f28e..5d86e93 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -304,7 +304,7 @@ static inline bool dma_pte_present(struct dma_pte *pte)
 
 static inline bool dma_pte_superpage(struct dma_pte *pte)
 {
-	return (pte->val & (1 << 7));
+	return (pte->val & DMA_PTE_LARGE_PAGE);
 }
 
 static inline int first_pte_in_page(struct dma_pte *pte)
-- 
1.8.4.5
