From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v9 8/8] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Wed, 8 Feb 2017 20:33:40 +0100
Message-ID: <20170208193340.x7lka54ismqqy7nw@pd.tnic>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1486456836-17428-9-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486456836-17428-9-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Tue, Feb 07, 2017 at 02:40:36AM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Add multi-IOMMU support for perf by exposing an AMD IOMMU PMU
> for each IOMMU found in the system via:
> 
>   /bus/event_source/devices/amd_iommu_x
> 
> where x is the IOMMU index. This allows users to specify
> different events to be programmed onto performance counters
> of each IOMMU.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---

...

> @@ -414,46 +417,46 @@ static __init void amd_iommu_pc_exit(void)
>  };
>  
>  static __init int
> -_init_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, char *name)
> +init_one_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, unsigned int idx)

It's a static function - just call it "init_one_iommu".

>  {
>  	int ret;
>  
>  	raw_spin_lock_init(&perf_iommu->lock);
>  
> -	/* Init cpumask attributes to only core 0 */
> -	cpumask_set_cpu(0, &iommu_cpumask);
> -
> -	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(0);
> -	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
> +	perf_iommu->iommu	 = get_amd_iommu(idx);

This function can return NULL - you need to handle that here otherwise
it will blow up later.

> +	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(idx);
> +	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(idx);
>  	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
>  		return -EINVAL;
>  
> +	snprintf(perf_iommu->name, PERF_AMD_IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
> +
> +	perf_iommu->pmu.event_init  = perf_iommu_event_init;
> +	perf_iommu->pmu.add         = perf_iommu_add;
> +	perf_iommu->pmu.del         = perf_iommu_del;
> +	perf_iommu->pmu.start       = perf_iommu_start;
> +	perf_iommu->pmu.stop        = perf_iommu_stop;
> +	perf_iommu->pmu.read        = perf_iommu_read;
> +	perf_iommu->pmu.task_ctx_nr = perf_invalid_context;
>  	perf_iommu->pmu.attr_groups = amd_iommu_attr_groups;

So you can define a static struct pmu in the driver and do struct
assignment directly instead of writing them one-by-one.

	perf_iommu->pmu = pmu;

> -	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
> +
> +	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
>  	if (ret)
>  		pr_err("Error initializing AMD IOMMU perf counters.\n");
>  	else
> -		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
> -			amd_iommu_pc_get_max_banks(0),
> -			amd_iommu_pc_get_max_counters(0));
> +	pr_info("Detected AMD IOMMU #%d (%d banks, %d counters/bank)\n",
> +		idx, amd_iommu_pc_get_max_banks(idx),

perf_iommu->max_banks

> +		amd_iommu_pc_get_max_counters(idx));

perf_iommu->max_counters

You already read them above.

>  	return ret;
>  }
>  
> -static struct perf_amd_iommu __perf_iommu = {
> -	.pmu = {
> -		.task_ctx_nr    = perf_invalid_context,
> -		.event_init	= perf_iommu_event_init,
> -		.add		= perf_iommu_add,
> -		.del		= perf_iommu_del,
> -		.start		= perf_iommu_start,
> -		.stop		= perf_iommu_stop,
> -		.read		= perf_iommu_read,
> -	},
> -};
> -
>  static __init int amd_iommu_pc_init(void)
>  {
>  	int ret;
> +	unsigned int i;
> +
> +	/* Init cpumask attributes to only core 0 */
> +	cpumask_set_cpu(0, &iommu_cpumask);

This belongs at the end of the function, once everything has been
initialized successfully.

>  	/* Make sure the IOMMU PC resource is available */
>  	if (!amd_iommu_pc_supported())


> @@ -463,7 +466,24 @@ static __init int amd_iommu_pc_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = _init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
> +	for (i = 0 ; i < amd_iommu_get_num_iommus(); i++) {
> +		struct perf_amd_iommu *pi;
> +
> +		pi = kzalloc(sizeof(struct perf_amd_iommu), GFP_KERNEL);
> +		if (!pi) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		ret = init_one_perf_amd_iommu(pi, i);
> +		if (ret) {
> +			kfree(pi);
> +			break;

What happens with the iommus that have been initialized successfully
before this one fails? They remain in use?

I think we need at least a warning saying here:

	pr_warning("Error initializing IOMMU %d ...")

so that we at least know why some are missing.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
