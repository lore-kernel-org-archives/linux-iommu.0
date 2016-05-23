From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V5 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Mon, 23 May 2016 11:35:04 +0530
Message-ID: <000601d1b4b9$119c2410$34d46c30$@codeaurora.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
	<1463741694-1735-7-git-send-email-sricharan@codeaurora.org>
	<3164695.VzCnHHyi7r@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3164695.VzCnHHyi7r@wuerfel>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

>> @@ -124,6 +124,9 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
>>  		SET_TLBLKCR(base, ctx, 0);
>>  		SET_CONTEXTIDR(base, ctx, 0);
>>  	}
>> +
>> +	/* Ensure completion of relaxed writes from the above SET macros */
>> +	mb();
>>  }
>
>Why do the above use the relaxed writes? Do you have any performance
>numbers showing that skipping the sync for the reset makes a measurable
>difference?
>
>How did you prove that skipping the sync before the write is safe?
>
>How about resetting the iommu less often instead?
>

I had measured the numbers only for the full usecase path, not for the
reset path alone. I saw improvement of about 5% on full numbers.
As you said, the reset path would be called only less often
and might not bring a measurable change. I did not see a difference in behavior
when changing the sync to happen after the writes. But my understanding was that
the sync after the writes was required to ensure write completion. 

I should have made smaller patches to do this change.
The only patch relevant for this series is the one that changes the write in _iotlb_range
function. Rest of the changes, should be added one by one in a separate series.

>>  static void __flush_iotlb(void *cookie)
>> @@ -141,6 +144,9 @@ static void __flush_iotlb(void *cookie)
>>  		list_for_each_entry(master, &iommu->ctx_list, list)
>>  			SET_CTX_TLBIALL(iommu->base, master->num, 0);
>>
>> +		/* To ensure completion of TLBIALL above */
>> +		mb();
>> +
>>  		__disable_clocks(iommu);
>>  	}
>>  fail:
>
>__disable_clocks() takes spinlocks and accesses the hardware, which
>in turn will also involve multiple syncs, so this seems like
>a premature optimization.
>
>Have you tried just leaving the clocks enabled? I'd suspect you could
>gain more performance that way.

I have not tried by keep clocks enabled always. But intention here was
to have more granular clock control. But agree that the barrier might not
be needed in this case as it is indirectly taken care. I will remove this here
and explain it.

>
>> @@ -181,7 +187,8 @@ fail:
>>
>>  static void __flush_iotlb_sync(void *cookie)
>>  {
>> -	/* To avoid a null function pointer */
>> +	/* To ensure completion of the TLBIVA in __flush_iotlb_range */
>> +	mb();
>>  }
>
>I don't understand the specific race from the comment.
>
>What operation comes after this that relies on __flush_iotlb_range
>having completed, and how does an mb() guarantee this?
>

The flush_iotlb_range operation invalidates the tlb for writes to
pagetable and the finally calls the sync operation to ensure completion
of the flush and this is required before returning back to the client
of the iommu. In the case of this iommu, only a barrier is required to
ensure completion of the invalidate operation. 

>This seems to be a bug fix that is unrelated to the change to
>use writel_relaxed(), so better split it out into a separate
>patch, with a longer changeset description. Did you spot this
>race by running into incorrect data, or by inspection?
>

No i did not see a data corruption issue without the mb(),
but that it would have been hidden in someother way as well.
Another difference was the sync  was done before the write
previously and now its moved after the write. As i understand
sync after the write is correct. So i will change this patch with more
description and move rest of that changes out.

>>  static const struct iommu_gather_ops msm_iommu_gather_ops = {
>> @@ -235,6 +242,9 @@ static void config_mids(struct msm_iommu_dev *iommu,
>>  		/* Set security bit override to be Non-secure */
>>  		SET_NSCFG(iommu->base, mid, 3);
>>  	}
>> +
>> +	/* Ensure completion of relaxed writes from the above SET macros */
>> +	mb();
>>  }
>>
>
>This looks similar to the msm_iommu_reset() case. Maybe put those
>two into one patch, or find a way to run config_mids() less often so
>it doesn't show up in the profiles any more.
>
>If you hit this often enough that it causes performance problems,
>it's more likely that there is a bug in your code than that changing
>to relaxed accessors is a good idea.
>

  Ok, similar to reset this is called less often compared to flushes and
  may not show difference in performance. I will move this out.

>>  static void __reset_context(void __iomem *base, int ctx)
>> @@ -257,6 +267,9 @@ static void __reset_context(void __iomem *base, int ctx)
>>  	SET_TLBFLPTER(base, ctx, 0);
>>  	SET_TLBSLPTER(base, ctx, 0);
>>  	SET_TLBLKCR(base, ctx, 0);
>> +
>> +	/* Ensure completion of relaxed writes from the above SET macros */
>> +	mb();
>>  }
>>
>>  static void __program_context(void __iomem *base, int ctx,
>> @@ -305,6 +318,9 @@ static void __program_context(void __iomem *base, int ctx,
>>
>>  	/* Enable the MMU */
>>  	SET_M(base, ctx, 1);
>> +
>> +	/* Ensure completion of relaxed writes from the above SET macros */
>> +	mb();
>>  }
>>
>>  static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
>
>Maybe one more patch for these? I can see that
>__reset_context/__program_context would be run often enough to make
>a difference, though maybe not as much as the flushes.
>
>Also, split this in two patches: one that adds a comment describing
>how you proved that you don't need barriers before the writes, and
>another one adding the barrier afterwards, with a description of
>the failure scenario.

ok, i will split it. I did not see a failure though explicitly. It is based on
the understanding that the sync after the write is more appropriate
 than before it.
>
>> @@ -500,7 +516,8 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
>>  	/* Invalidate context TLB */
>>  	SET_CTX_TLBIALL(iommu->base, master->num, 0);
>>  	SET_V2PPR(iommu->base, master->num, va & V2Pxx_VA);
>> -
>> +	/* Ensure completion of relaxed writes from the above SET macros */
>> +	mb();
>>  	par = GET_PAR(iommu->base, master->num);
>>
>>  	/* We are dealing with a supersection */
>
>In this case, I'd say it's better to rewrite the function to avoid the
>read: iova_to_phys() should be fast, and not require hardware access.
>Getting rid of the hardware access by using an in-memory cache for
>this should gain more than just removing the barriers, as an MMIO read
>is always slow

Ok, you mean using the software walk through ? I will check on this to measure
 the latency difference. If thats true, then the iopgtable ops itself provides a
function for iova_to_phys conversion, so that can be used.

>
>> @@ -714,7 +731,8 @@ static int msm_iommu_probe(struct platform_device *pdev)
>>  	par = GET_PAR(iommu->base, 0);
>>  	SET_V2PCFG(iommu->base, 0, 0);
>>  	SET_M(iommu->base, 0, 0);
>> -
>> +	/* Ensure completion of relaxed writes from the above SET macros */
>> +	mb();
>>  	if (!par) {
>
>Probe() clearly isn't performance sensitive, so please back this out
>and use the non-relaxed accessors.
>

ok, will change this back.

>> diff --git a/drivers/iommu/msm_iommu_hw-8xxx.h b/drivers/iommu/msm_iommu_hw-8xxx.h
>> index fc16010..fe2c5ca 100644
>> --- a/drivers/iommu/msm_iommu_hw-8xxx.h
>> +++ b/drivers/iommu/msm_iommu_hw-8xxx.h
>> @@ -24,13 +24,19 @@
>>  #define GET_CTX_REG(reg, base, ctx) \
>>  				(readl((base) + (reg) + ((ctx) << CTX_SHIFT)))
>>
>> -#define SET_GLOBAL_REG(reg, base, val)	writel((val), ((base) + (reg)))
>> +/*
>> + * The writes to the global/context registers needs to be synced only after
>> + * all the configuration writes are done. So use relaxed accessors and
>> + * a barrier at the end.
>> + */
>> +#define SET_GLOBAL_REG_RELAXED(reg, base, val) \
>> +			       writel_relaxed((val), ((base) + (reg)))
>>
>> -#define SET_CTX_REG(reg, base, ctx, val) \
>> -			writel((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
>> +#define SET_CTX_REG_RELAXED(reg, base, ctx, val) \
>> +		writel_relaxed((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
>
>Please add the relaxed accessors first in a separate patch, and then
>change over one user at a time before you remove the non-relaxed ones.
>

ok

>It's hard to believe that all users are actually performance critical,
>so start with the ones that gain the most performance. As commented above,
>some of the conversions seem particularly fishy and it's likely that
>a slow reset() function should not be fixed by making reset() faster
>but by calling it less often.

Ok. Will change this. So i will split this in to separate series, one patch to modify
relevant the flush_iotlb_range function in this series and rest of all changes
as  a driver improvement in one more.

>Can you just remove those macros, and open-code the function calls?
>
>This is an unnecessary obfuscation that now also hides the fact that you
>are using relaxed accessors.

Ok, will make this in to inline functions to make it obvious.

Regards,
 Sricharan
