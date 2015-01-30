From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 17/26] iommu/fsl: Remove pr/dev_*() prefixes
Date: Fri, 30 Jan 2015 07:47:22 +0000
Message-ID: <BN3PR0301MB121920CE5BE76397564D7C8AEA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-18-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-18-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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
> Subject: [PATCH 17/26] iommu/fsl: Remove pr/dev_*() prefixes
> 
> pr_fmt() and dev_*() already take care of it
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c        |  2 +-
>  drivers/iommu/fsl_pamu_domain.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> 22b72e2..e46c75f 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -1135,7 +1135,7 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
>  	spaace_pool = gen_pool_create(ilog2(sizeof(struct paace)), -1);
>  	if (!spaace_pool) {
>  		ret = -ENOMEM;
> -		dev_err(dev, "PAMU : failed to allocate spaace gen pool\n");
> +		dev_err(dev, "Failed to allocate spaace gen pool\n");
>  		goto error;
>  	}
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index c7af760..3e7954a 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -113,7 +113,7 @@ static int map_subwins(int liodn, struct
> fsl_dma_domain *dma_domain)
>  						 sub_win_ptr[i].prot);
>  			spin_unlock_irqrestore(&iommu_lock, flags);
>  			if (ret) {
> -				pr_debug("PAMU SPAACE configuration
> failed for liodn %d\n",
> +				pr_debug("SPAACE configuration failed for
> liodn %d\n",
>  					 liodn);
>  				return ret;
>  			}
> @@ -139,7 +139,7 @@ static int map_win(int liodn, struct fsl_dma_domain
> *dma_domain)
>  				 0, wnd->prot);
>  	spin_unlock_irqrestore(&iommu_lock, flags);
>  	if (ret)
> -		pr_debug("PAMU PAACE configuration failed for liodn
> %d\n",
> +		pr_debug("PAACE configuration failed for liodn %d\n",
>  			liodn);
> 
>  	return ret;
> @@ -250,7 +250,7 @@ static int pamu_set_liodn(int liodn, struct device
> *dev,
>  					 dma_domain->stash_id, win_cnt, 0);
>  	spin_unlock_irqrestore(&iommu_lock, flags);
>  	if (ret) {
> -		pr_debug("PAMU PAACE configuration failed for liodn %d,
> win_cnt =%d\n", liodn, win_cnt);
> +		pr_debug("PAACE configuration failed for liodn %d, win_cnt
> =%d\n",
> +liodn, win_cnt);
>  		return ret;
>  	}
> 
> @@ -267,7 +267,7 @@ static int pamu_set_liodn(int liodn, struct device
> *dev,
>  							 0, 0);
>  			spin_unlock_irqrestore(&iommu_lock, flags);
>  			if (ret) {
> -				pr_debug("PAMU SPAACE configuration
> failed for liodn %d\n", liodn);
> +				pr_debug("SPAACE configuration failed for
> liodn %d\n", liodn);
>  				return ret;
>  			}
>  		}
> @@ -283,13 +283,13 @@ static int check_size(u64 size, dma_addr_t iova)
>  	 * to PAMU page size.
>  	 */
>  	if ((size & (size - 1)) || size < PAMU_PAGE_SIZE) {
> -		pr_debug("%s: size too small or not a power of two\n",
> __func__);
> +		pr_debug("Size too small or not a power of two\n");
>  		return -EINVAL;
>  	}
> 
>  	/* iova must be page size aligned*/
>  	if (iova & (size - 1)) {
> -		pr_debug("%s: address is not aligned with window size\n",
> __func__);
> +		pr_debug("Address is not aligned with window size\n");
>  		return -EINVAL;
>  	}
> 
> --
> 2.2.2
Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
