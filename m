From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 26/26] iommu/fsl: Remove extra paranthesis
Date: Fri, 30 Jan 2015 09:40:58 +0000
Message-ID: <BN3PR0301MB1219E470749D193F86206384EA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-27-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-27-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Emilian Medve <Emilian.Medve-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> Sent: Wednesday, January 28, 2015 8:05 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org;
> Sethi Varun-B16395
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH 26/26] iommu/fsl: Remove extra paranthesis
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c        | 4 ++--
>  drivers/iommu/fsl_pamu.h        | 4 ++--
>  drivers/iommu/fsl_pamu_domain.c | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> 7a4665d..ea49d9f 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -160,7 +160,7 @@ int pamu_disable_liodn(int liodn)  static unsigned int
> map_addrspace_size_to_wse(phys_addr_t addrspace_size)  {
>  	/* Bug if not a power of 2 */
> -	BUG_ON((addrspace_size & (addrspace_size - 1)));
> +	BUG_ON(addrspace_size & (addrspace_size - 1));
> 
>  	/* window size is 2^(WSE+1) bytes */
>  	return fls64(addrspace_size) - 2;
> @@ -801,7 +801,7 @@ static irqreturn_t pamu_av_isr(int irq, void *arg)
>  			}
> 
>  			/* clear access violation condition */
> -			out_be32((p + PAMU_AVS1), avs1 &
> PAMU_AV_MASK);
> +			out_be32(p + PAMU_AVS1, avs1 &
> PAMU_AV_MASK);
>  			paace = pamu_get_ppaace(avs1 >>
> PAMU_AVS1_LIODN_SHIFT);
>  			BUG_ON(!paace);
>  			/* check if we got a violation for a disabled LIODN */
> diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h index
> 342ac6d..aab723f 100644
> --- a/drivers/iommu/fsl_pamu.h
> +++ b/drivers/iommu/fsl_pamu.h
> @@ -26,8 +26,8 @@
>  /* Bit Field macros
>   *	v = bit field variable; m = mask, m##_SHIFT = shift, x = value to load
>   */
> -#define set_bf(v, m, x)		(v = ((v) & ~(m)) | (((x) <<
> (m##_SHIFT)) & (m)))
> -#define get_bf(v, m)		(((v) & (m)) >> (m##_SHIFT))
> +#define set_bf(v, m, x)		(v = ((v) & ~(m)) | (((x) <<
> m##_SHIFT) & (m)))
> +#define get_bf(v, m)		(((v) & (m)) >> m##_SHIFT)
> 
>  /* PAMU CCSR space */
>  #define PAMU_PGC 0x00000000     /* Allows all peripheral accesses */
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index 36622e2..ceebd28 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -84,7 +84,7 @@ static phys_addr_t get_phys_addr(struct
> fsl_dma_domain *dma_domain, dma_addr_t i
>  	}
> 
>  	if (win_ptr->valid)
> -		return (win_ptr->paddr + (iova & (win_ptr->size - 1)));
> +		return win_ptr->paddr + (iova & (win_ptr->size - 1));
> 
>  	return 0;
>  }
> @@ -386,8 +386,8 @@ static phys_addr_t fsl_pamu_iova_to_phys(struct
> iommu_domain *domain,  {
>  	struct fsl_dma_domain *dma_domain = domain->priv;
> 
> -	if ((iova < domain->geometry.aperture_start) ||
> -	    iova > (domain->geometry.aperture_end))
> +	if (iova < domain->geometry.aperture_start ||
> +	    iova > domain->geometry.aperture_end)
>  		return 0;
> 
>  	return get_phys_addr(dma_domain, iova); @@ -1029,7 +1029,7 @@
> static int fsl_pamu_set_windows(struct iommu_domain *domain, u32
> w_count)
>  	}
> 
>  	ret = pamu_set_domain_geometry(dma_domain, &domain-
> >geometry,
> -				       ((w_count > 1) ? w_count : 0));
> +				       w_count > 1 ? w_count : 0);
>  	if (!ret) {
>  		kfree(dma_domain->win_arr);
>  		dma_domain->win_arr = kcalloc(w_count,
> --
> 2.2.2
Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
