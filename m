From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 09/26] iommu/fsl: Fix checkpatch type ALLOC_SIZEOF_STRUCT
Date: Fri, 30 Jan 2015 07:30:13 +0000
Message-ID: <BN3PR0301MB12194CAE007CA0E25B34F998EA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-10-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-10-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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
> Subject: [PATCH 09/26] iommu/fsl: Fix checkpatch type
> ALLOC_SIZEOF_STRUCT
> 
> CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*data)...) over
> kzalloc(sizeof(struct pamu_isr_data)...)
> +       data = kzalloc(sizeof(struct pamu_isr_data), GFP_KERNEL);
> 
> CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*dma_domain-
> >win_arr)...) over kzalloc(sizeof(struct dma_window)...)
> +               dma_domain->win_arr = kzalloc(sizeof(struct dma_window)
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c        | 2 +-
>  drivers/iommu/fsl_pamu_domain.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> 7f0181c..4f1926b 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -1039,7 +1039,7 @@ static int __init fsl_pamu_probe(struct
> platform_device *pdev)
>  		goto error;
>  	}
> 
> -	data = kzalloc(sizeof(struct pamu_isr_data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data) {
>  		dev_err(&pdev->dev, "PAMU isr data memory allocation
> failed\n");
>  		ret = -ENOMEM;
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index d5137dd..9417207 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -1037,7 +1037,7 @@ static int fsl_pamu_set_windows(struct
> iommu_domain *domain, u32 w_count)
>  				((w_count > 1) ? w_count : 0));
>  	if (!ret) {
>  		kfree(dma_domain->win_arr);
> -		dma_domain->win_arr = kzalloc(sizeof(struct dma_window)
> *
> +		dma_domain->win_arr = kzalloc(sizeof(*dma_domain-
> >win_arr) *
>  							  w_count,
> GFP_ATOMIC);
>  		if (!dma_domain->win_arr) {
>  			spin_unlock_irqrestore(&dma_domain-
> >domain_lock, flags);
> --
> 2.2.2
Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
