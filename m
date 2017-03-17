From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v11 09/10] perf/amd/iommu: Introduce amd_iommu-specific
	struct in struct hw_perf_event
Date: Fri, 17 Mar 2017 11:00:30 +0100
Message-ID: <20170317100030.2pga4ev2435lcr7s@pd.tnic>
References: <1487926102-13073-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1487926102-13073-10-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487926102-13073-10-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 24, 2017 at 02:48:21AM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Current AMD IOMMU Perf PMU inappropriately uses hardware struct
> inside the union inside the struct hw_perf_event, mainly the use of
> extra_reg.
> 
> Instead, introduce amd_iommu-specific struct with required
> parameters to be programmed onto the IOMMU performance counter
> control register.
> 
> Also update the pasid field from 16 to 20 bits.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c | 91 ++++++++++++++++++++++++---------------------
>  include/linux/perf_event.h  | 12 ++++++
>  2 files changed, 61 insertions(+), 42 deletions(-)

...

> @@ -150,10 +149,13 @@ static ssize_t _iommu_cpumask_show(struct device *dev,
>  
>  /*---------------------------------------------*/
>  
> -static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
> +static int get_next_avail_iommu_bnk_cntr(struct perf_event *event)
>  {
>  	unsigned long flags;
> -	int shift, bank, cntr, retval;
> +	u32 shift, bank, cntr;
> +	int retval;
> +	struct perf_amd_iommu *perf_iommu =
> +			container_of(event->pmu, struct perf_amd_iommu, pmu);
>  	int max_banks = perf_iommu->max_banks;
>  	int max_cntrs = perf_iommu->max_counters;
>  
> @@ -166,7 +168,9 @@ static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
>  				continue;
>  			} else {
>  				perf_iommu->cntr_assign_mask |= BIT_ULL(shift);
> -				retval = ((bank & 0xFF) << 8) | (cntr & 0xFF);
> +				event->hw.iommu_bank = bank;
> +				event->hw.iommu_cntr = cntr;
> +				retval = 0;
>  				goto out;
>  			}
>  		}
> @@ -238,8 +242,13 @@ static int perf_iommu_event_init(struct perf_event *event)
>  	}

It is not in the diff here but you have this above the assignment below:

        if (perf_iommu) {
                config = event->attr.config;
                config1 = event->attr.config1;
        } else {
                return -EINVAL;
        }

Those two config and config1 get assigned and never used. I see that
you're removing them in the next patch though.

>  	/* update the hw_perf_event struct with the iommu config data */
> -	hwc->config = config;
> -	hwc->extra_reg.config = config1;
> +	hwc->iommu_csource   = GET_CSOURCE(event->attr.config);
> +	hwc->iommu_devid     = GET_DEVID(event->attr.config);
> +	hwc->iommu_domid     = GET_DOMID(event->attr.config);
> +	hwc->iommu_pasid     = GET_PASID(event->attr.config);
> +	hwc->iommu_devid_msk = GET_DEVID_MASK(event->attr.config1);
> +	hwc->iommu_domid_msk = GET_DOMID_MASK(event->attr.config1);
> +	hwc->iommu_pasid_msk = GET_PASID_MASK(event->attr.config1);

You produce all those from two u64 values. So you can just as well do

                struct { /* amd_iommu */
			u64 a;
			u64 b;
                };

and produce all the rest with the macros at the usage sites. (The naming
of the variables is purely arbitrary).

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
