From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 18/19] iommu/arm-smmu: Set domain geometry
Date: Wed, 31 Aug 2016 23:00:57 +0200
Message-ID: <f8e7e2eb-c237-d569-9323-5aec229c18f4@redhat.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
 <d6cedec16fe96a081ea2f9f27378dd1a6f406c72.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d6cedec16fe96a081ea2f9f27378dd1a6f406c72.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 23/08/2016 21:05, Robin Murphy wrote:
> For non-aperture-based IOMMUs, the domain geometry seems to have become
> the de-facto way of indicating the input address space size. That is
> quite a useful thing from the users' perspective, so let's do the same.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 ++
>  drivers/iommu/arm-smmu.c    | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 72b996aa7460..9c56bd194dc2 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1574,6 +1574,8 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  		return -ENOMEM;
>  
>  	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> +	domain->geometry.aperture_end = (1UL << ias) - 1;
> +	domain->geometry.force_aperture = true;
>  	smmu_domain->pgtbl_ops = pgtbl_ops;
>  
>  	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 85bc74d8fca0..112918d787eb 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -913,6 +913,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  
>  	/* Update the domain's page sizes to reflect the page table format */
>  	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> +	domain->geometry.aperture_end = (1UL << ias) - 1;
> +	domain->geometry.force_aperture = true;
>  
>  	/* Initialise the context bank with our page table cfg */
>  	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> 
Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


Eric
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
