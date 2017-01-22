From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 8/9] perf/amd/iommu: Fix sysfs perf attribute groups
Date: Sun, 22 Jan 2017 20:54:36 +0100
Message-ID: <20170122195436.p5bj4zcq5ndvhkzt@pd.tnic>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1484551416-5440-9-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-9-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, peterz@infradead.org, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 01:23:35AM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Introduce static amd_iommu_attr_groups to simplify the
> sysfs attributes initialization code.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/x86/events/amd/iommu.c | 85 ++++++++++++++++++++-------------------------
>  1 file changed, 37 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index cc7bea4..223c01d 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -43,14 +43,8 @@ struct perf_amd_iommu {
>  	u8 max_counters;
>  	u64 cntr_assign_mask;
>  	raw_spinlock_t lock;
> -	const struct attribute_group *attr_groups[4];
>  };
>  
> -#define format_group	attr_groups[0]
> -#define cpumask_group	attr_groups[1]
> -#define events_group	attr_groups[2]
> -#define null_group	attr_groups[3]
> -
>  /*---------------------------------------------
>   * sysfs format attributes
>   *---------------------------------------------*/
> @@ -81,6 +75,10 @@ struct perf_amd_iommu {
>  /*---------------------------------------------
>   * sysfs events attributes
>   *---------------------------------------------*/
> +static struct attribute_group amd_iommu_events_group = {
> +	.name = "events",
> +};
> +
>  struct amd_iommu_event_desc {
>  	struct kobj_attribute attr;
>  	const char *event;
> @@ -388,76 +386,63 @@ static void perf_iommu_del(struct perf_event *event, int flags)
>  	perf_event_update_userpage(event);
>  }
>  
> -static __init int _init_events_attrs(struct perf_amd_iommu *perf_iommu)
> +static __init int _init_events_attrs(void)
>  {
> -	struct attribute **attrs;
> -	struct attribute_group *attr_group;
>  	int i = 0, j;
> +	struct attribute **attrs;
>  
>  	while (amd_iommu_v2_event_descs[i].attr.attr.name)
>  		i++;
>  
> -	attr_group = kzalloc(sizeof(struct attribute *)
> -		* (i + 1) + sizeof(*attr_group), GFP_KERNEL);
> -	if (!attr_group)
> +	attrs = kzalloc(sizeof(struct attribute **) * (i + 1), GFP_KERNEL);
> +	if (!attrs)
>  		return -ENOMEM;
>  
> -	attrs = (struct attribute **)(attr_group + 1);
>  	for (j = 0; j < i; j++)
>  		attrs[j] = &amd_iommu_v2_event_descs[j].attr.attr;
>  
> -	attr_group->name = "events";
> -	attr_group->attrs = attrs;
> -	perf_iommu->events_group = attr_group;
> -
> +	amd_iommu_events_group.attrs = attrs;
>  	return 0;
>  }
>  
>  static __init void amd_iommu_pc_exit(void)
>  {
> -	if (__perf_iommu.events_group != NULL) {
> -		kfree(__perf_iommu.events_group);
> -		__perf_iommu.events_group = NULL;
> +	if (amd_iommu_events_group.attrs) {
> +		kfree(amd_iommu_events_group.attrs);


Please integrate scripts/checkpatch.pl in your patch creation workflow.
Some of the warnings/errors *actually* make sense. Like this one:

WARNING: kfree(NULL) is safe and this check is probably not required
#98: FILE: arch/x86/events/amd/iommu.c:411:
+       if (amd_iommu_events_group.attrs) {
+               kfree(amd_iommu_events_group.attrs);

> +		amd_iommu_events_group.attrs = NULL;

You keep doing that. Why?

>  	}
>  }
>  
> -static __init int _init_perf_amd_iommu(
> -	struct perf_amd_iommu *perf_iommu, char *name)
> +const struct attribute_group *amd_iommu_attr_groups[] = {
> +	&amd_iommu_format_group,
> +	&amd_iommu_cpumask_group,
> +	&amd_iommu_events_group,
> +	NULL,
> +};
> +
> +static __init int
> +_init_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, char *name)
>  {
>  	int ret;
>  
>  	raw_spin_lock_init(&perf_iommu->lock);
>  
> -	perf_iommu->format_group = &amd_iommu_format_group;
> -
>  	/* Init cpumask attributes to only core 0 */
>  	cpumask_set_cpu(0, &iommu_cpumask);
> -	perf_iommu->cpumask_group = &amd_iommu_cpumask_group;
> -
> -	ret = _init_events_attrs(perf_iommu);
> -	if (ret) {
> -		pr_err("Error initializing AMD IOMMU perf events.\n");
> -		return ret;
> -	}
>  
>  	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(0);
>  	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
>  	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
>  		return -EINVAL;
>  
> -	perf_iommu->null_group = NULL;
> -	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
> -
> +	perf_iommu->pmu.attr_groups = amd_iommu_attr_groups;
>  	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
> -	if (ret) {
> +	if (ret)
>  		pr_err("Error initializing AMD IOMMU perf counters.\n");
> -		amd_iommu_pc_exit();
> -	} else {
> +	else
>  		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
>  			amd_iommu_pc_get_max_banks(0),
>  			amd_iommu_pc_get_max_counters(0));
> -	}
> -
>  	return ret;
>  }
>  
> @@ -471,24 +456,28 @@ static __init int _init_perf_amd_iommu(
>  		.stop		= perf_iommu_stop,
>  		.read		= perf_iommu_read,
>  	},
> -	.max_banks		= 0x00,
> -	.max_counters		= 0x00,
> -	.cntr_assign_mask	= 0ULL,
> -	.format_group		= NULL,
> -	.cpumask_group		= NULL,
> -	.events_group		= NULL,
> -	.null_group		= NULL,
>  };
>  
>  static __init int amd_iommu_pc_init(void)
>  {
> +	int ret;
> +
>  	/* Make sure the IOMMU PC resource is available */
>  	if (!amd_iommu_pc_supported())
>  		return -ENODEV;
>  
> -	_init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
> +	ret = _init_events_attrs();
> +	if (ret)
> +		goto err_out;

So that's actually

	if (ret)
		return ret;

to propagate the -ENOMEM.

>  
> -	return 0;
> +	ret = _init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
> +	if (ret)
> +		goto err_out;

Then here you can do:

	if (ret)
		amd_iommu_pc_exit();

	return ret;

and simplify it a bit and get rid of the err_out label.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
