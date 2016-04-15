From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Don't allocate resources for bypass
	domains
Date: Fri, 15 Apr 2016 14:05:21 +0100
Message-ID: <20160415130520.GH22906@arm.com>
References: <1459527597-10740-1-git-send-email-will.deacon@arm.com>
	<570397F4.8080504@arm.com> <5703A289.30308@linaro.org>
	<491c885f61c509d959b04cfb63676bd07e481dea.1460558667.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <491c885f61c509d959b04cfb63676bd07e481dea.1460558667.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 13, 2016 at 03:46:57PM +0100, Robin Murphy wrote:
> Until we get fully plumbed into of_iommu_configure, our default
> IOMMU_DOMAIN_DMA domains just bypass translation. Since we achieve that
> by leaving the stream table entries set to bypass instead of pointing at
> a translation context, the context bank we allocate for the domain is
> completely wasted. Context banks are typically a rather limited
> resource, so don't hog ones we don't need.

Eric, does this resolve your remaining passthrough regressions when applied
on top of my patch?

Will

> Reported-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 5158feb..7c39ac4 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -826,6 +826,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	if (smmu_domain->smmu)
>  		goto out_unlock;
>  
> +	/* We're bypassing these SIDs, so don't allocate an actual context */
> +	if (domain->type == IOMMU_DOMAIN_DMA) {
> +		smmu_domain->smmu = smmu;
> +		goto out_unlock;
> +	}
> +
>  	/*
>  	 * Mapping the requested stage onto what we support is surprisingly
>  	 * complicated, mainly because the spec allows S1+S2 SMMUs without
> @@ -948,7 +954,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>  	void __iomem *cb_base;
>  	int irq;
>  
> -	if (!smmu)
> +	if (!smmu || domain->type == IOMMU_DOMAIN_DMA)
>  		return;
>  
>  	/*
> -- 
> 2.7.3.dirty
> 
