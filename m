From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V4 5/6] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Thu, 18 Feb 2016 14:21:08 +0100
Message-ID: <20160218132108.GC28866@pd.tnic>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455182127-17551-6-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455182127-17551-6-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 11, 2016 at 04:15:26PM +0700, Suravee Suthikulpanit wrote:
> The current amd_iommu_pc_get_set_reg_val() does not support muli-IOMMU

multi

> system. This patch replace amd_iommu_pc_get_set_reg_val() with

You don't need to say in the commit message what this patch does - I
think most of us can see it - but concentrate on the why. So if you catch
yourself starting a commit message with "This patch does... " then that
description is most of the time redundant and needless.

> amd_iommu_pc_set_reg_val() and amd_iommu_pc_[set|get]_cnt_vals().
> 
> Also, the current struct hw_perf_event.prev_count can only store the
> previous counter value only from one IOMMU. So, this patch introduces
> a new data structure, perf_amd_iommu.prev_cnts, to track previous value
> of each performance counter of each bank of each IOMMU.
> 
> Last, this patch introduce perf_iommu_cnts to temporary hold counter
> values from each IOMMU for internal use when manages counters among
> multiple IOMMUs.
> 
> Note that this implementation makes an assumption that the counters
> on all IOMMUs will be programmed the same way (i.e with the same events).

Why?

Is that some hw restriction or what's going on?

This needs to at least be documented why or even completely lifted. I'd
prefer the latter.

> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c           | 146 +++++++++++++++++++++++-----------
>  arch/x86/include/asm/perf/amd/iommu.h |   7 +-
>  drivers/iommu/amd_iommu_init.c        | 107 ++++++++++++++++++++++---
>  3 files changed, 201 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 812eff2..947ae8a 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -42,6 +42,13 @@ struct perf_amd_iommu {
>  	u64 cntr_assign_mask;
>  	raw_spinlock_t lock;
>  	const struct attribute_group *attr_groups[4];
> +
> +	/*
> +	 * This is a 3D array used to store the previous count values
> +	 * from each performance counter of each bank of each IOMMU.
> +	 * I.E. size of array = (num iommus * num banks * num counters)
> +	 */
> +	local64_t *prev_cnts;
>  };
>  
>  #define format_group	attr_groups[0]
> @@ -121,6 +128,12 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
>  	{ /* end: all zeroes */ },
>  };
>  
> +/*
> + * This is an array used to temporary hold the current values
> + * read from a particular perf counter from each IOMMU.
> + */
> +static u64 *perf_iommu_cnts;

Is this going to be accessed in parallel on different CPUs? If so, you
need synchronization for it.

> +
>  /*---------------------------------------------
>   * sysfs cpumask attributes
>   *---------------------------------------------*/
> @@ -255,44 +268,42 @@ static void perf_iommu_enable_event(struct perf_event *ev)
>  	u64 reg = 0ULL;
>  
>  	reg = csource;
> -	amd_iommu_pc_get_set_reg_val(devid,
> -			_GET_BANK(ev), _GET_CNTR(ev) ,
> -			 IOMMU_PC_COUNTER_SRC_REG, &reg, true);
> +	amd_iommu_pc_set_reg(devid, _GET_BANK(ev), _GET_CNTR(ev),
> +			     IOMMU_PC_COUNTER_SRC_REG, &reg);
>  
> -	reg = 0ULL | devid | (_GET_DEVID_MASK(ev) << 32);
> +	reg = devid | (_GET_DEVID_MASK(ev) << 32);
>  	if (reg)
> -		reg |= (1UL << 31);
> -	amd_iommu_pc_get_set_reg_val(devid,
> -			_GET_BANK(ev), _GET_CNTR(ev) ,
> -			 IOMMU_PC_DEVID_MATCH_REG, &reg, true);
> +		reg |= BIT(31);
> +	amd_iommu_pc_set_reg(devid, _GET_BANK(ev), _GET_CNTR(ev),
> +			     IOMMU_PC_DEVID_MATCH_REG, &reg);
>  
> -	reg = 0ULL | _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
> +	reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
>  	if (reg)
> -		reg |= (1UL << 31);
> -	amd_iommu_pc_get_set_reg_val(devid,
> -			_GET_BANK(ev), _GET_CNTR(ev) ,
> -			 IOMMU_PC_PASID_MATCH_REG, &reg, true);
> +		reg |= BIT(31);
> +	amd_iommu_pc_set_reg(devid, _GET_BANK(ev), _GET_CNTR(ev),
> +			     IOMMU_PC_PASID_MATCH_REG, &reg);
>  
> -	reg = 0ULL | _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
> +	reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
>  	if (reg)
> -		reg |= (1UL << 31);
> -	amd_iommu_pc_get_set_reg_val(devid,
> -			_GET_BANK(ev), _GET_CNTR(ev) ,
> -			 IOMMU_PC_DOMID_MATCH_REG, &reg, true);
> +		reg |= BIT(31);
> +	amd_iommu_pc_set_reg(devid, _GET_BANK(ev), _GET_CNTR(ev),
> +			     IOMMU_PC_DOMID_MATCH_REG, &reg);
>  }
>  

This is a cleanup and belongs in a separate patch. Each patch should
contain one logical change: patch 1 cleans up things, patch2 cleans up
things even more, ... patch N adds functionality, patch N + 1 adds more
functionality ... and so on.

>  static void perf_iommu_disable_event(struct perf_event *event)
>  {
>  	u64 reg = 0ULL;
>  
> -	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
> -			_GET_BANK(event), _GET_CNTR(event),
> -			IOMMU_PC_COUNTER_SRC_REG, &reg, true);
> +	amd_iommu_pc_set_reg(_GET_DEVID(event), _GET_BANK(event),
> +			     _GET_CNTR(event), IOMMU_PC_COUNTER_SRC_REG, &reg);
>  }

Ditto.

>  static void perf_iommu_start(struct perf_event *event, int flags)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_amd_iommu *perf_iommu = container_of(event->pmu,
> +							 struct perf_amd_iommu,
> +							 pmu);

Or simply:

        struct perf_amd_iommu *pi = container_of(event->pmu, struct perf_amd_iommu, pmu);

I'd make that struct perf_amd_iommu name shorter too.

>  	pr_debug("perf: amd_iommu:perf_iommu_start\n");
>  	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> @@ -302,10 +313,19 @@ static void perf_iommu_start(struct perf_event *event, int flags)
>  	hwc->state = 0;
>  
>  	if (flags & PERF_EF_RELOAD) {

Flip check and save an indentation level:

	if (!(flags & PERF_EF_RELOAD))
		goto enable;

> -		u64 prev_raw_count =  local64_read(&hwc->prev_count);
> -		amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
> -				_GET_BANK(event), _GET_CNTR(event),
> -				IOMMU_PC_COUNTER_REG, &prev_raw_count, true);
> +		int i;
> +
> +		for (i = 0; i < amd_iommu_get_num_iommus(); i++) {
> +			int index = get_iommu_bnk_cnt_evt_idx(perf_iommu, i,
> +							      _GET_BANK(event),
> +							      _GET_CNTR(event));
> +
> +			perf_iommu_cnts[i] = local64_read(&perf_iommu->prev_cnts[index]);
> +		}
> +
> +		amd_iommu_pc_set_counters(_GET_BANK(event), _GET_CNTR(event),
> +					  amd_iommu_get_num_iommus(),
> +					  perf_iommu_cnts);
>  	}
>  
>  	perf_iommu_enable_event(event);
> @@ -315,29 +335,45 @@ static void perf_iommu_start(struct perf_event *event, int flags)
>  
>  static void perf_iommu_read(struct perf_event *event)
>  {
> -	u64 count = 0ULL;
> -	u64 prev_raw_count = 0ULL;
> +	int i;
>  	u64 delta = 0ULL;
>  	struct hw_perf_event *hwc = &event->hw;
> -	pr_debug("perf: amd_iommu:perf_iommu_read\n");
> -
> -	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
> -				_GET_BANK(event), _GET_CNTR(event),
> -				IOMMU_PC_COUNTER_REG, &count, false);
> -
> -	/* IOMMU pc counter register is only 48 bits */
> -	count &= 0xFFFFFFFFFFFFULL;
> +	struct perf_amd_iommu *perf_iommu = container_of(event->pmu,
> +							 struct perf_amd_iommu,
> +							 pmu);

See above.

>  
> -	prev_raw_count =  local64_read(&hwc->prev_count);
> -	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> -					count) != prev_raw_count)
> +	if (amd_iommu_pc_get_counters(_GET_BANK(event), _GET_CNTR(event),
> +				      amd_iommu_get_num_iommus(),
> +				      perf_iommu_cnts))
>  		return;
>  
> -	/* Handling 48-bit counter overflowing */
> -	delta = (count << COUNTER_SHIFT) - (prev_raw_count << COUNTER_SHIFT);
> -	delta >>= COUNTER_SHIFT;
> -	local64_add(delta, &event->count);
> -
> +	/*
> +	 * Now we re-aggregating event counts and prev-counts
> +	 * from all IOMMUs

Just say "Aggregate ..." and finish that sentence with a "."

> +	 */
> +	local64_set(&hwc->prev_count, 0);
> +
> +	for (i = 0; i < amd_iommu_get_num_iommus(); i++) {
> +		int indx = get_iommu_bnk_cnt_evt_idx(perf_iommu, i,

		"idx" is what most code calls it.

> +						     _GET_BANK(event),
> +						     _GET_CNTR(event));

I'd let it stick out and shorten that function's name:

		int idx = get_bank_evt_idx(perf_iommu, i, _GET_BANK(event), _GET_CNTR(event));


> +		u64 prev_raw_count = local64_read(&perf_iommu->prev_cnts[indx]);
> +
> +		/* IOMMU pc counter register is only 48 bits */
> +		perf_iommu_cnts[i] &= GENMASK_ULL(48, 0);
> +
> +		/*
> +		 * Since we do not enable counter overflow interrupts,
> +		 * we do not have to worry about prev_count changing on us

Comments should be normal english sentences ending with a "."

> +		 */
> +		local64_set(&perf_iommu->prev_cnts[indx], perf_iommu_cnts[i]);
> +		local64_add(prev_raw_count, &hwc->prev_count);
> +
> +		/* Handle 48-bit counter overflow */
> +		delta = (perf_iommu_cnts[i] << COUNTER_SHIFT) - (prev_raw_count << COUNTER_SHIFT);
> +		delta >>= COUNTER_SHIFT;
> +		local64_add(delta, &event->count);
> +	}
>  }
>  
>  static void perf_iommu_stop(struct perf_event *event, int flags)
> @@ -427,10 +463,14 @@ static __init int _init_events_attrs(struct perf_amd_iommu *perf_iommu)
>  
>  static __init void amd_iommu_pc_exit(void)
>  {
> -	if (__perf_iommu.events_group != NULL) {
> -		kfree(__perf_iommu.events_group);
> -		__perf_iommu.events_group = NULL;
> -	}
> +	kfree(__perf_iommu.events_group);
> +	__perf_iommu.events_group = NULL;
> +
> +	kfree(__perf_iommu.prev_cnts);
> +	__perf_iommu.prev_cnts = NULL;
> +
> +	kfree(perf_iommu_cnts);
> +	perf_iommu_cnts = NULL;
>  }
>  
>  static __init int _init_perf_amd_iommu(
> @@ -460,6 +500,18 @@ static __init int _init_perf_amd_iommu(
>  	perf_iommu->null_group = NULL;
>  	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
>  
> +	perf_iommu->prev_cnts = kzalloc(sizeof(*perf_iommu->prev_cnts) *
> +					amd_iommu_get_num_iommus() *
> +					perf_iommu->max_banks *
> +					perf_iommu->max_counters, GFP_KERNEL);
> +	if (!perf_iommu->prev_cnts)
> +		return -ENOMEM;
> +
> +	perf_iommu_cnts = kzalloc(sizeof(*perf_iommu_cnts) * amd_iommu_get_num_iommus(),
> +				  GFP_KERNEL);


Sometimes checkpatch is right:

WARNING: Prefer kcalloc over kzalloc with multiply
#253: FILE: arch/x86/events/amd/iommu.c:510:
+       perf_iommu_cnts = kzalloc(sizeof(*perf_iommu_cnts) * amd_iommu_get_num_iommus(),

You could integrate it into your patch creation workflow but not take it
too seriously.


> +	if (!perf_iommu_cnts)
> +		return -ENOMEM;
> +
>  	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
>  	if (ret) {
>  		pr_err("perf: amd_iommu: Failed to initialized.\n");
> diff --git a/arch/x86/include/asm/perf/amd/iommu.h b/arch/x86/include/asm/perf/amd/iommu.h
> index 40919eb..e0aa9be 100644
> --- a/arch/x86/include/asm/perf/amd/iommu.h
> +++ b/arch/x86/include/asm/perf/amd/iommu.h
> @@ -33,9 +33,10 @@ u8 amd_iommu_pc_get_max_banks(void);
>  
>  u8 amd_iommu_pc_get_max_counters(void);
>  
> -int amd_iommu_pc_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn, u64 *value);
> +int amd_iommu_pc_set_reg(u16 devid, u8 bank, u8 cntr, u8 fxn, u64 *value);
>  
> -int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
> -				 u64 *value, bool is_write);
> +int amd_iommu_pc_set_counters(u8 bank, u8 cntr, int num, u64 *value);
> +
> +int amd_iommu_pc_get_counters(u8 bank, u8 cntr, int num, u64 *value);
>  
>  #endif /*_PERF_EVENT_AMD_IOMMU_H_*/
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index ffa057e..fd4f2b1 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1133,6 +1133,8 @@ static int __init init_iommu_all(struct acpi_table_header *table)
>  	return 0;
>  }
>  
> +static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> +				u8 fxn, u64 *value, bool is_write);

Why the forward declaration? Just move the whole function.

>  static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>  {
> @@ -1144,8 +1146,8 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>  	amd_iommu_pc_present = true;
>  
>  	/* Check if the performance counters can be written to */
> -	if ((0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val, true)) ||
> -	    (0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val2, false)) ||
> +	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
> +	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
>  	    (val != val2)) {
>  		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
>  		amd_iommu_pc_present = false;

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
