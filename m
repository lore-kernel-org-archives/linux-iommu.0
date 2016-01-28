From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v3 06/12] iommu/amd: Clean up the useless
	IOMMU_PTE_U/IOMMU_PTE_FC
Date: Thu, 28 Jan 2016 18:30:00 +0800
Message-ID: <20160128103000.GF3851@x1.redhat.com>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
	<1453804166-25646-7-git-send-email-bhe@redhat.com>
	<56A89A74.6060501@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56A89A74.6060501-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/27/16 at 06:22pm, Wan Zongshun wrote:
> 
> 
> -------- Original Message --------
> >In amd-vi spec bit[60:58] are only used to store the bit[14:12] of GCR3.
> >No any other useage is found in several versions of amd-vi spec. So remove
> >them in this patch.
> 
> Also,this patch also made me confusion, please keep FC bit here,
> bit[60] should be PTE's FC bit.

Right, both of these two shoule be kept. I was just confused by the
mixed use of IOMMU_PTE/DTE macro.

By the way do you know what IOMMU_PTE_U/IOMMU_PTE_FC is used for and
what do they mean? I can't see from code and spec.
> 
> Vincent.
> 
> >
> >Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >---
> >  drivers/iommu/amd_iommu.c       | 6 +++---
> >  drivers/iommu/amd_iommu_types.h | 2 --
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> >index f02d4b1..93bc690 100644
> >--- a/drivers/iommu/amd_iommu.c
> >+++ b/drivers/iommu/amd_iommu.c
> >@@ -1331,9 +1331,9 @@ static int iommu_map_page(struct protection_domain *dom,
> >
> >  	if (count > 1) {
> >  		__pte = PAGE_SIZE_PTE(phys_addr, page_size);
> >-		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_V | IOMMU_PTE_FC;
> >+		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_V;
> >  	} else
> >-		__pte = phys_addr | IOMMU_PTE_V | IOMMU_PTE_FC;
> >+		__pte = phys_addr | IOMMU_PTE_V;
> >
> >  	if (prot & IOMMU_PROT_IR)
> >  		__pte |= IOMMU_PTE_IR;
> >@@ -2463,7 +2463,7 @@ static dma_addr_t dma_ops_domain_map(struct dma_ops_domain *dom,
> >  	if (!pte)
> >  		return DMA_ERROR_CODE;
> >
> >-	__pte = paddr | IOMMU_PTE_V | IOMMU_PTE_FC;
> >+	__pte = paddr | IOMMU_PTE_V;
> >
> >  	if (direction == DMA_TO_DEVICE)
> >  		__pte |= IOMMU_PTE_IR;
> >diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> >index 65f7988..42cd3d5 100644
> >--- a/drivers/iommu/amd_iommu_types.h
> >+++ b/drivers/iommu/amd_iommu_types.h
> >@@ -295,8 +295,6 @@
> >
> >  #define IOMMU_PTE_V  (1ULL << 0)
> >  #define IOMMU_PTE_TV (1ULL << 1)
> >-#define IOMMU_PTE_U  (1ULL << 59)
> >-#define IOMMU_PTE_FC (1ULL << 60)
> >  #define IOMMU_PTE_IR (1ULL << 61)
> >  #define IOMMU_PTE_IW (1ULL << 62)
> >
> >
