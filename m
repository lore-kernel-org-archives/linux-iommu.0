From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: Add global SMR masking property
Date: Fri, 31 Mar 2017 13:43:55 +0100
Message-ID: <20170331124355.GA6488@leverpostej>
References: <7472f6f57d04431bca5b2dba2a53918225eaf432.1490958040.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7472f6f57d04431bca5b2dba2a53918225eaf432.1490958040.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 31, 2017 at 12:03:33PM +0100, Robin Murphy wrote:
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
> v2: Rewrite the documentation to actually make sense, and add an
>     explicit example per Mark's suggestion.
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 27 ++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c                           |  4 +++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 6cdf32d037fc..b744b231766f 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -60,6 +60,16 @@ conditions.
>                    aliases of secure registers have to be used during
>                    SMMU configuration.
>  
> +- stream-match-mask : For SMMUs supporting stream matching and using
> +                  #iommu-cells = <1>, specifies a fixed value to set in
> +                  the SMRn.MASK field of every stream match register
> +                  used, for cases where it is desirable to ignore some
> +                  portion of every Stream ID (e.g. for certain MMU-500
> +                  configurations given globally unique input IDs). This
> +                  property is not valid for SMMUs using stream indexing,
> +                  or using stream matching with #iommu-cells = <2>, and
> +                  may be ignored if present in such cases.

This generally sounds fine, but I'd like it to be a little more explicit
about what this means for matching. Can we change the first sentence to:

	For SMMUs supporting stream matching and using
	#iommu-cells = <1>, specifies a mask of bits to
	ignore when matching stream IDs (e.g. this may be
	programmed into the SMRn.MASK field of every
	stream match register used). 


Otherwise, this looks good to me; thanks for respinning this.

If you're happy to make the above change:

Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Thanks,
Mark.

> +
>  ** Deprecated properties:
>  
>  - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> @@ -109,3 +119,20 @@ conditions.
>          master3 {
>                  iommus = <&smmu2 1 0x30>;
>          };
> +
> +
> +        /* ARM MMU-500 with 10-bit stream ID input configuration */
> +        smmu3: iommu {
> +                compatible = "arm,mmu-500", "arm,smmu-v2";
> +                ...
> +                #iommu-cells = <1>;
> +                /* always ignore appended 5-bit TBU number */
> +                stream-match-mask = 0x7c00;
> +        };
> +
> +        bus {
> +                /* bus whose child devices emit one unique 10-bit stream
> +                   ID each, but may master through multiple SMMU TBUs */
> +                iommu-map = <0 &smmu3 0 0x400>;
> +                ...
> +        };
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
