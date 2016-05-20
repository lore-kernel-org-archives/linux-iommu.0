From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V5 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Fri, 20 May 2016 13:44:10 +0200
Message-ID: <3164695.VzCnHHyi7r@wuerfel>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org> <1463741694-1735-7-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463741694-1735-7-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Friday 20 May 2016 16:24:53 Sricharan R wrote:
> While using the generic pagetable ops the tlb maintenance
> operation gets completed in the sync callback. So use writel_relaxed
> for all register access and add a mb() at appropriate places.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/msm_iommu.c         |  24 +++++++--
>  drivers/iommu/msm_iommu_hw-8xxx.h | 109 ++++++++++++++++++++------------------
>  2 files changed, 79 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0299a37..dfcaeef 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -124,6 +124,9 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
>  		SET_TLBLKCR(base, ctx, 0);
>  		SET_CONTEXTIDR(base, ctx, 0);
>  	}
> +
> +	/* Ensure completion of relaxed writes from the above SET macros */
> +	mb();
>  }

Why do the above use the relaxed writes? Do you have any performance
numbers showing that skipping the sync for the reset makes a measurable
difference?

How did you prove that skipping the sync before the write is safe?

How about resetting the iommu less often instead?

>  static void __flush_iotlb(void *cookie)
> @@ -141,6 +144,9 @@ static void __flush_iotlb(void *cookie)
>  		list_for_each_entry(master, &iommu->ctx_list, list)
>  			SET_CTX_TLBIALL(iommu->base, master->num, 0);
>  
> +		/* To ensure completion of TLBIALL above */
> +		mb();
> +
>  		__disable_clocks(iommu);
>  	}
>  fail:

__disable_clocks() takes spinlocks and accesses the hardware, which
in turn will also involve multiple syncs, so this seems like
a premature optimization. 

Have you tried just leaving the clocks enabled? I'd suspect you could
gain more performance that way.

> @@ -181,7 +187,8 @@ fail:
>  
>  static void __flush_iotlb_sync(void *cookie)
>  {
> -	/* To avoid a null function pointer */
> +	/* To ensure completion of the TLBIVA in __flush_iotlb_range */
> +	mb();
>  }

I don't understand the specific race from the comment.

What operation comes after this that relies on __flush_iotlb_range
having completed, and how does an mb() guarantee this?

This seems to be a bug fix that is unrelated to the change to
use writel_relaxed(), so better split it out into a separate
patch, with a longer changeset description. Did you spot this
race by running into incorrect data, or by inspection?

>  static const struct iommu_gather_ops msm_iommu_gather_ops = {
> @@ -235,6 +242,9 @@ static void config_mids(struct msm_iommu_dev *iommu,
>  		/* Set security bit override to be Non-secure */
>  		SET_NSCFG(iommu->base, mid, 3);
>  	}
> +
> +	/* Ensure completion of relaxed writes from the above SET macros */
> +	mb();
>  }
>  

This looks similar to the msm_iommu_reset() case. Maybe put those
two into one patch, or find a way to run config_mids() less often so
it doesn't show up in the profiles any more.

If you hit this often enough that it causes performance problems,
it's more likely that there is a bug in your code than that changing
to relaxed accessors is a good idea.

>  static void __reset_context(void __iomem *base, int ctx)
> @@ -257,6 +267,9 @@ static void __reset_context(void __iomem *base, int ctx)
>  	SET_TLBFLPTER(base, ctx, 0);
>  	SET_TLBSLPTER(base, ctx, 0);
>  	SET_TLBLKCR(base, ctx, 0);
> +
> +	/* Ensure completion of relaxed writes from the above SET macros */
> +	mb();
>  }
>
>  static void __program_context(void __iomem *base, int ctx,
> @@ -305,6 +318,9 @@ static void __program_context(void __iomem *base, int ctx,
>  
>  	/* Enable the MMU */
>  	SET_M(base, ctx, 1);
> +
> +	/* Ensure completion of relaxed writes from the above SET macros */
> +	mb();
>  }
>  
>  static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)

Maybe one more patch for these? I can see that
__reset_context/__program_context would be run often enough to make
a difference, though maybe not as much as the flushes.

Also, split this in two patches: one that adds a comment describing
how you proved that you don't need barriers before the writes, and
another one adding the barrier afterwards, with a description of
the failure scenario.

> @@ -500,7 +516,8 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
>  	/* Invalidate context TLB */
>  	SET_CTX_TLBIALL(iommu->base, master->num, 0);
>  	SET_V2PPR(iommu->base, master->num, va & V2Pxx_VA);
> -
> +	/* Ensure completion of relaxed writes from the above SET macros */
> +	mb();
>  	par = GET_PAR(iommu->base, master->num);
>  
>  	/* We are dealing with a supersection */

In this case, I'd say it's better to rewrite the function to avoid the
read: iova_to_phys() should be fast, and not require hardware access.
Getting rid of the hardware access by using an in-memory cache for
this should gain more than just removing the barriers, as an MMIO read
is always slow.

> @@ -714,7 +731,8 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  	par = GET_PAR(iommu->base, 0);
>  	SET_V2PCFG(iommu->base, 0, 0);
>  	SET_M(iommu->base, 0, 0);
> -
> +	/* Ensure completion of relaxed writes from the above SET macros */
> +	mb();
>  	if (!par) {

Probe() clearly isn't performance sensitive, so please back this out
and use the non-relaxed accessors.

> diff --git a/drivers/iommu/msm_iommu_hw-8xxx.h b/drivers/iommu/msm_iommu_hw-8xxx.h
> index fc16010..fe2c5ca 100644
> --- a/drivers/iommu/msm_iommu_hw-8xxx.h
> +++ b/drivers/iommu/msm_iommu_hw-8xxx.h
> @@ -24,13 +24,19 @@
>  #define GET_CTX_REG(reg, base, ctx) \
>  				(readl((base) + (reg) + ((ctx) << CTX_SHIFT)))
>  
> -#define SET_GLOBAL_REG(reg, base, val)	writel((val), ((base) + (reg)))
> +/*
> + * The writes to the global/context registers needs to be synced only after
> + * all the configuration writes are done. So use relaxed accessors and
> + * a barrier at the end.
> + */
> +#define SET_GLOBAL_REG_RELAXED(reg, base, val) \
> +			       writel_relaxed((val), ((base) + (reg)))
>  
> -#define SET_CTX_REG(reg, base, ctx, val) \
> -			writel((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
> +#define SET_CTX_REG_RELAXED(reg, base, ctx, val) \
> +		writel_relaxed((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))

Please add the relaxed accessors first in a separate patch, and then
change over one user at a time before you remove the non-relaxed ones.

It's hard to believe that all users are actually performance critical,
so start with the ones that gain the most performance. As commented above,
some of the conversions seem particularly fishy and it's likely that
a slow reset() function should not be fixed by making reset() faster
but by calling it less often.

>  /* Context register setters/getters */
> -#define SET_SCTLR(b, c, v)	 SET_CTX_REG(SCTLR, (b), (c), (v))
> -#define SET_ACTLR(b, c, v)	 SET_CTX_REG(ACTLR, (b), (c), (v))
> -#define SET_CONTEXTIDR(b, c, v)	 SET_CTX_REG(CONTEXTIDR, (b), (c), (v))
> -#define SET_TTBR0(b, c, v)	 SET_CTX_REG(TTBR0, (b), (c), (v))
> -#define SET_TTBR1(b, c, v)	 SET_CTX_REG(TTBR1, (b), (c), (v))
> +#define SET_SCTLR(b, c, v)	 SET_CTX_REG_RELAXED(SCTLR, (b), (c), (v))
> +#define SET_ACTLR(b, c, v)	 SET_CTX_REG_RELAXED(ACTLR, (b), (c), (v))
> +#define SET_CONTEXTIDR(b, c, v)	 SET_CTX_REG_RELAXED(CONTEXTIDR, (b), (c), (v))
> +#define SET_TTBR0(b, c, v)	 SET_CTX_REG_RELAXED(TTBR0, (b), (c), (v))
> +#define SET_TTBR1(b, c, v)	 SET_CTX_REG_RELAXED(TTBR1, (b), (c), (v))
> +#define SET_TTBCR(b, c, v)	 SET_CTX_REG_RELAXED(TTBCR, (b), (c), (v))
> +#define SET_PAR(b, c, v)	 SET_CTX_REG_RELAXED(PAR, (b), (c), (v))

Can you just remove those macros, and open-code the function calls?

This is an unnecessary obfuscation that now also hides the fact that you
are using relaxed accessors.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
