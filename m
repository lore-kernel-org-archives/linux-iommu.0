From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Add global SMR masking property
Date: Tue, 7 Mar 2017 18:35:55 +0000
Message-ID: <20170307183555.GH3514@leverpostej>
References: <f26137836bb8416e38390ba68973ae5cd19c2c53.1488910978.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f26137836bb8416e38390ba68973ae5cd19c2c53.1488910978.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 07, 2017 at 06:26:28PM +0000, Robin Murphy wrote:
> The current SMR masking support using a 2-cell iommu-specifier is
> primarily intended to handle individual masters with large and/or
> complex Stream ID assignments; it quickly gets a bit clunky in other SMR
> use-cases where we just want to consistently mask out the same part of
> every Stream ID (e.g. for MMU-500 configurations where the appended TBU
> number gets in the way unnecessarily). Let's add a new property to allow
> a single global mask value to better fit the latter situation.
> 
> Tested-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Time to rekindle the discussion about whether an architecture-level
> concept with a rather specific name needs a vendor prefix ;)
> 
> Robin.
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 10 ++++++++++
>  drivers/iommu/arm-smmu.c                             |  4 +++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 6cdf32d037fc..d66f355e174f 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -60,6 +60,16 @@ conditions.
>                    aliases of secure registers have to be used during
>                    SMMU configuration.
>  
> +- stream-match-mask : Specifies a fixed SMR mask value to combine with
> +                  the Stream ID value from every iommu-specifier. This
> +                  may be used instead of an "#iommu-cells" value of 2
> +                  when there is no need for per-master SMR masks, but
> +                  it is still desired to mask some portion of every
> +                  Stream ID (e.g. for certain MMU-500 configurations
> +                  given globally unique external IDs). This property is
> +                  not valid for SMMUs using stream indexing, and may be
> +                  ignored if stream matching is not supported.
> +

Generally, this sounds fine.

However, there is an ambiguity here (inherited from the existing
#iommu-cells = <2> case), in that it's not clear what is meant by "to
combine".

>From the example at the end of the file, this appears to be a mask of
bits to not consider for matching purposes?

Would you mind clarifying that in both cases?

This could also do with an example.

Thanks,
Mark.

>  ** Deprecated properties:
>  
>  - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index abf6496843a6..e394d55146a6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1590,13 +1590,15 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>  
>  static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  {
> -	u32 fwid = 0;
> +	u32 mask, fwid = 0;
>  
>  	if (args->args_count > 0)
>  		fwid |= (u16)args->args[0];
>  
>  	if (args->args_count > 1)
>  		fwid |= (u16)args->args[1] << SMR_MASK_SHIFT;
> +	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
> +		fwid |= (u16)mask << SMR_MASK_SHIFT;
>  
>  	return iommu_fwspec_add_ids(dev, &fwid, 1);
>  }
> -- 
> 2.11.0.dirty
> 
