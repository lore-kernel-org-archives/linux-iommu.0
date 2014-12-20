From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PING] [PATCH FOR v3.19 - v2] iommu/ipmmu-vmsa: change IOMMU_EXEC
	to IOMMU_NOEXEC
Date: Sat, 20 Dec 2014 21:07:33 +0200
Message-ID: <7279717.KWmNDRjuSk__49235.4513648481$1419110730$gmane$org@avalon>
References: <1418668873-5091-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418668873-5091-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Ping ?

On Monday 15 December 2014 20:41:13 Laurent Pinchart wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> Commit a720b41c41f5a7e4 ("iommu/arm-smmu: change IOMMU_EXEC to
> IOMMU_NOEXEC") has inverted and replaced the IOMMU_EXEC flag with
> IOMMU_NOEXEC. Update the driver accordingly.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Changes since v1:
> 
> - Rewrote the commit message
> 
> Joerg, this is a compilation breakage fix for v3.19. Could you please take
> it in your tree and submit it early during the -rc cycle ?
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 68dfb0f..7486931 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -558,7 +558,7 @@ static pmd_t *ipmmu_alloc_pmd(struct ipmmu_vmsa_device
> *mmu, pgd_t *pgd,
> 
>  static u64 ipmmu_page_prot(unsigned int prot, u64 type)
>  {
> -	u64 pgprot = ARM_VMSA_PTE_XN | ARM_VMSA_PTE_nG | ARM_VMSA_PTE_AF
> +	u64 pgprot = ARM_VMSA_PTE_nG | ARM_VMSA_PTE_AF
> 
>  		   | ARM_VMSA_PTE_SH_IS | ARM_VMSA_PTE_AP_UNPRIV
>  		   | ARM_VMSA_PTE_NS | type;
> 
> @@ -568,8 +568,8 @@ static u64 ipmmu_page_prot(unsigned int prot, u64 type)
>  	if (prot & IOMMU_CACHE)
>  		pgprot |= IMMAIR_ATTR_IDX_WBRWA << ARM_VMSA_PTE_ATTRINDX_SHIFT;
> 
> -	if (prot & IOMMU_EXEC)
> -		pgprot &= ~ARM_VMSA_PTE_XN;
> +	if (prot & IOMMU_NOEXEC)
> +		pgprot |= ARM_VMSA_PTE_XN;
>  	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
>  		/* If no access create a faulting entry to avoid TLB fills. */
>  		pgprot &= ~ARM_VMSA_PTE_PAGE;

-- 
Regards,

Laurent Pinchart
