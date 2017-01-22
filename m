From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v8 9/9] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Sun, 22 Jan 2017 20:55:31 +0100
Message-ID: <20170122195531.5y4ufm7pm5qkz3yx@pd.tnic>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-10-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-10-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Mon, Jan 16, 2017 at 01:23:36AM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Add multi-IOMMU support for perf by exposing an AMD IOMMU PMU
> for each IOMMU found in the system via:
> 
>   /bus/event_source/devices/amd_iommu_x
> 
> where x is the IOMMU index. This allows users to specify
> different events to be programed onto performance counters

"programmed"

Please introduce a spellchecker into your patch creation workflow.

> of each IOMMU.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c | 114 ++++++++++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 223c01d..38eafbf 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -35,16 +35,21 @@
>  #define _GET_PASID_MASK(ev) ((ev->hw.extra_reg.config >> 16) & 0xFFFFULL)
>  #define _GET_DOMID_MASK(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFULL)
>  
> -static struct perf_amd_iommu __perf_iommu;
> +#define PERF_AMD_IOMMU_NAME_SZ 16

AMD_IOMMU_PMU_NAME_SIZE

sounds more to the point to me.

>  struct perf_amd_iommu {
> +	struct list_head list;
>  	struct pmu pmu;
> +	unsigned int idx;
> +	char name[PERF_AMD_IOMMU_NAME_SZ];
>  	u8 max_banks;
>  	u8 max_counters;
>  	u64 cntr_assign_mask;
>  	raw_spinlock_t lock;
>  };

...

> @@ -253,30 +248,34 @@ static void perf_iommu_enable_event(struct perf_event *ev)
>  	u64 reg = 0ULL;
>  
>  	reg = csource;
> -	amd_iommu_pc_set_reg(0, bank, cntr,
> +	amd_iommu_pc_set_reg(hwc->idx, bank, cntr,
>  			     IOMMU_PC_COUNTER_SRC_REG, &reg);
>  
>  	reg = devid | (_GET_DEVID_MASK(ev) << 32);
>  	if (reg)
>  		reg |= BIT(31);
> -	amd_iommu_pc_set_reg(0, bank, cntr, IOMMU_PC_DEVID_MATCH_REG, &reg);
> +	amd_iommu_pc_set_reg(hwc->idx, bank, cntr,
> +			     IOMMU_PC_DEVID_MATCH_REG, &reg);
>  
>  	reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
>  	if (reg)
>  		reg |= BIT(31);
> -	amd_iommu_pc_set_reg(0, bank, cntr, IOMMU_PC_PASID_MATCH_REG, &reg);
> +	amd_iommu_pc_set_reg(hwc->idx, bank, cntr,
> +			     IOMMU_PC_PASID_MATCH_REG, &reg);
>  
>  	reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
>  	if (reg)
>  		reg |= BIT(31);
> -	amd_iommu_pc_set_reg(0, bank, cntr, IOMMU_PC_DOMID_MATCH_REG, &reg);
> +	amd_iommu_pc_set_reg(hwc->idx, bank, cntr,
> +			     IOMMU_PC_DOMID_MATCH_REG, &reg);

You can let those stick out - the 80 cols rule is not a strict one:

        reg = csource;
        amd_iommu_pc_set_reg(hwc->idx, bank, cntr, IOMMU_PC_COUNTER_SRC_REG, &reg);

        reg = devid | (_GET_DEVID_MASK(ev) << 32);
        if (reg)
                reg |= BIT(31);
        amd_iommu_pc_set_reg(hwc->idx, bank, cntr, IOMMU_PC_DEVID_MATCH_REG, &reg);

        reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
        if (reg)
                reg |= BIT(31);
        amd_iommu_pc_set_reg(hwc->idx, bank, cntr, IOMMU_PC_PASID_MATCH_REG, &reg);

        reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
        if (reg)
                reg |= BIT(31);
        amd_iommu_pc_set_reg(hwc->idx, bank, cntr, IOMMU_PC_DOMID_MATCH_REG, &reg);
}

>  static void perf_iommu_disable_event(struct perf_event *event)
>  {
> +	struct hw_perf_event *hwc = &event->hw;
>  	u64 reg = 0ULL;
>  
> -	amd_iommu_pc_set_reg(0, _GET_BANK(event), _GET_CNTR(event),
> +	amd_iommu_pc_set_reg(hwc->idx, _GET_BANK(event), _GET_CNTR(event),
>  			     IOMMU_PC_COUNTER_SRC_REG, &reg);
>  }
>  
> @@ -295,7 +294,7 @@ static void perf_iommu_start(struct perf_event *event, int flags)
>  		return;
>  
>  	val = local64_read(&hwc->prev_count) & GENMASK_ULL(48, 0);
> -	if (amd_iommu_pc_set_reg(0, _GET_BANK(event), _GET_CNTR(event),
> +	if (amd_iommu_pc_set_reg(hwc->idx, _GET_BANK(event), _GET_CNTR(event),
>  				   IOMMU_PC_COUNTER_REG, &val))
>  		return;
>  
> @@ -309,7 +308,7 @@ static void perf_iommu_read(struct perf_event *event)
>  	s64 delta;
>  	struct hw_perf_event *hwc = &event->hw;
>  
> -	if (amd_iommu_pc_get_reg(0, _GET_BANK(event), _GET_CNTR(event),
> +	if (amd_iommu_pc_get_reg(hwc->idx, _GET_BANK(event), _GET_CNTR(event),
>  				 IOMMU_PC_COUNTER_REG, &count))
>  		return;
>  
> @@ -407,6 +406,13 @@ static __init int _init_events_attrs(void)
>  
>  static __init void amd_iommu_pc_exit(void)
>  {
> +	struct perf_amd_iommu *pi, *next;
> +
> +	list_for_each_entry_safe(pi, next, &perf_amd_iommu_list, list) {
> +		list_del(&pi->list);
> +		kfree(pi);
> +	}
> +
>  	if (amd_iommu_events_group.attrs) {
>  		kfree(amd_iommu_events_group.attrs);
>  		amd_iommu_events_group.attrs = NULL;
> @@ -421,46 +427,46 @@ static __init void amd_iommu_pc_exit(void)
>  };
>  
>  static __init int
> -_init_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, char *name)
> +init_one_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, unsigned int idx)
>  {
>  	int ret;
>  
>  	raw_spin_lock_init(&perf_iommu->lock);
>  
> -	/* Init cpumask attributes to only core 0 */
> -	cpumask_set_cpu(0, &iommu_cpumask);
> -
> -	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(0);
> -	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
> +	perf_iommu->idx          = idx;
> +	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(idx);
> +	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(idx);
>  	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
>  		return -EINVAL;
>  
> +	snprintf(perf_iommu->name, PERF_AMD_IOMMU_NAME_SZ, "amd_iommu_%u", idx);
> +
> +	perf_iommu->pmu.event_init  = perf_iommu_event_init,
> +	perf_iommu->pmu.add         = perf_iommu_add,
> +	perf_iommu->pmu.del         = perf_iommu_del,
> +	perf_iommu->pmu.start       = perf_iommu_start,
> +	perf_iommu->pmu.stop        = perf_iommu_stop,
> +	perf_iommu->pmu.read        = perf_iommu_read,

This compiles but it is yucky.

You should do that instead:

static struct pmu amd_iommu_pmu = {
        .event_init  = perf_iommu_event_init,
        .add         = perf_iommu_add,
        .del         = perf_iommu_del,
        .start       = perf_iommu_start,
        .stop        = perf_iommu_stop,
        .read        = perf_iommu_read,
        .task_ctx_nr = perf_invalid_context,
        .attr_groups = amd_iommu_attr_groups,
};

...

	ret = perf_pmu_register(&amd_iommu_pmu, perf_iommu->name, -1);

Because otherwise you're carrying a struct pmu in each struct
perf_amd_iommu which has identical contents.

Now, you need to access the struct perf_amd_iommu pointer for each
IOMMU PMU in some of the functions like perf_iommu_event_init(), for
example. But for that you only need the index and to iterate the
perf_amd_iommu_list.

I wasn't able to find a good way to do that from a quick stare but
PeterZ might have a better idea...

> +	perf_iommu->pmu.task_ctx_nr = perf_invalid_context;
>  	perf_iommu->pmu.attr_groups = amd_iommu_attr_groups;
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
> +		amd_iommu_pc_get_max_counters(idx));
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
>  
>  	/* Make sure the IOMMU PC resource is available */
>  	if (!amd_iommu_pc_supported())
> @@ -470,7 +476,21 @@ static __init int amd_iommu_pc_init(void)
>  	if (ret)
>  		goto err_out;
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
> +		list_add_tail(&pi->list, &perf_amd_iommu_list);
> +		ret = init_one_perf_amd_iommu(pi, i);

You need to init *first* and iff you succeed, only *then* add to the
list.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
