From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] of: base: Allow more args than MAX_PHANDLE_ARGS if
 required
Date: Thu, 16 Jul 2015 11:23:26 +0100
Message-ID: <20150716102325.GC26390@arm.com>
References: <1437035444-13867-1-git-send-email-joro@8bytes.org>
 <1437035444-13867-2-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437035444-13867-2-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 16, 2015 at 09:30:43AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> The main use of MAX_PHANDLE_ARGS is to define the number of
> args elements in 'struct of_phandle_args'. This struct is
> often declared on the stack and thus it is impractical to
> increase MAX_PHANDLE_ARGS again and again.
> 
> To handle situations where more than MAX_PHANDLE_ARGS
> elements may appear in a device-tree, introduce functions
> to allocate/free 'struct of_phandle_args' with more than
> MAX_PHANDLE_ARGS elements and provide the new function
> of_parse_phandle_with_var_args(), which can handle those
> variable-size structs.
> 
> This is necessary for the ARM-SMMU driver, where the number
> of mmu-masters can be up to 128.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/of/base.c  | 43 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/of.h |  7 +++++++
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 8b5a187..2b288db 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -54,6 +54,24 @@ DEFINE_MUTEX(of_mutex);
>   */
>  DEFINE_RAW_SPINLOCK(devtree_lock);
>  
> +struct of_phandle_args *of_alloc_phandle_args(int size)
> +{
> +	struct of_phandle_args *args;
> +	int e = max(0, size - MAX_PHANDLE_ARGS);
> +
> +	args =  kzalloc(sizeof(struct of_phandle_args) + e * sizeof(uint32_t),
> +			GFP_KERNEL);

Should you also update args->args_count to reflect the extended array?

That said, extending the fixed-size array member like this feels a bit
fragile. Does GCC not complain about out-of-bounds accesses if you
statically address args->args[MAX_PHANDLE_ARGS]? Admittedly, I can't
think *why* this would be break (things like additional padding will be
harmless), but I'm not intimate with the C standard.

I guess the more worrying possibility is if somebody adds a new member to
the end of of_phandle_args.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
