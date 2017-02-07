From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v8 9/9] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Tue, 7 Feb 2017 08:42:42 +0700
Message-ID: <d1e38417-286a-015f-b7c3-6f78b0929363@amd.com>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-10-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170122195531.5y4ufm7pm5qkz3yx@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170122195531.5y4ufm7pm5qkz3yx-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Boris,

On 1/23/17 02:55, Borislav Petkov wrote:
>> @@ -421,46 +427,46 @@ static __init void amd_iommu_pc_exit(void)
>>  };
>>
>>  static __init int
>> -_init_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, char *name)
>> +init_one_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, unsigned int idx)
>>  {
>>  	int ret;
>>
>>  	raw_spin_lock_init(&perf_iommu->lock);
>>
>> -	/* Init cpumask attributes to only core 0 */
>> -	cpumask_set_cpu(0, &iommu_cpumask);
>> -
>> -	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(0);
>> -	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
>> +	perf_iommu->idx          = idx;
>> +	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(idx);
>> +	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(idx);
>>  	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
>>  		return -EINVAL;
>>
>> +	snprintf(perf_iommu->name, PERF_AMD_IOMMU_NAME_SZ, "amd_iommu_%u", idx);
>> +
>> +	perf_iommu->pmu.event_init  = perf_iommu_event_init,
>> +	perf_iommu->pmu.add         = perf_iommu_add,
>> +	perf_iommu->pmu.del         = perf_iommu_del,
>> +	perf_iommu->pmu.start       = perf_iommu_start,
>> +	perf_iommu->pmu.stop        = perf_iommu_stop,
>> +	perf_iommu->pmu.read        = perf_iommu_read,
> This compiles but it is yucky.
>
> You should do that instead:
>
> static struct pmu amd_iommu_pmu = {
>         .event_init  = perf_iommu_event_init,
>         .add         = perf_iommu_add,
>         .del         = perf_iommu_del,
>         .start       = perf_iommu_start,
>         .stop        = perf_iommu_stop,
>         .read        = perf_iommu_read,
>         .task_ctx_nr = perf_invalid_context,
>         .attr_groups = amd_iommu_attr_groups,
> };
>
> ...
>
> 	ret = perf_pmu_register(&amd_iommu_pmu, perf_iommu->name, -1);
>
> Because otherwise you're carrying a struct pmu in each struct
> perf_amd_iommu which has identical contents.

Actually, only the callbacks above will be identical on each pmu, but
there are other parts of the structure which are different
(e.g. pmu->name, pmu->type, etc.) Also, we need one pmu instance per
IOMMU since each pmu reference will get assigned to perf_event, and
also used to reference back to struct perf_amd_iommu. Note that each
pmu can also have different events.

> Now, you need to access the struct perf_amd_iommu pointer for each
> IOMMU PMU in some of the functions like perf_iommu_event_init(), for
> example. But for that you only need the index and to iterate the
> perf_amd_iommu_list.

I think replacing the index w/ pointer to amd_iommu is a good idea.
I'm changing this in V9.

Thanks,
Suravee
>
> I wasn't able to find a good way to do that from a quick stare but
> PeterZ might have a better idea...
>
