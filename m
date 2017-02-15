From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v9 8/8] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Wed, 15 Feb 2017 14:13:29 +0700
Message-ID: <483deec0-412f-bc34-de30-ce6ffcce3d4b@amd.com>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1486456836-17428-9-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170208193340.x7lka54ismqqy7nw@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170208193340.x7lka54ismqqy7nw-fF5Pk5pvG8Y@public.gmane.org>
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

On 2/9/17 02:33, Borislav Petkov wrote:
> On Tue, Feb 07, 2017 at 02:40:36AM -0600, Suravee Suthikulpanit wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>>  [......]
>> +	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(idx);
>> +	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(idx);
>>  	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
>>  		return -EINVAL;
>>
>> +	snprintf(perf_iommu->name, PERF_AMD_IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
>> +
>> +	perf_iommu->pmu.event_init  = perf_iommu_event_init;
>> +	perf_iommu->pmu.add         = perf_iommu_add;
>> +	perf_iommu->pmu.del         = perf_iommu_del;
>> +	perf_iommu->pmu.start       = perf_iommu_start;
>> +	perf_iommu->pmu.stop        = perf_iommu_stop;
>> +	perf_iommu->pmu.read        = perf_iommu_read;
>> +	perf_iommu->pmu.task_ctx_nr = perf_invalid_context;
>>  	perf_iommu->pmu.attr_groups = amd_iommu_attr_groups;
>
> So you can define a static struct pmu in the driver and do struct
> assignment directly instead of writing them one-by-one.

I believe this is the same suggestion you have made in V8.
Here our previous discussion in V8:

On 2/7/17 08:42, Suravee Suthikulpanit wrote:
 >
 > On 1/23/17 02:55, Borislav Petkov wrote:
 >> Because otherwise you're carrying a struct pmu in each struct
 >> perf_amd_iommu which has identical contents.
 >
 > Actually, only the callbacks above will be identical on each pmu, but
 > there are other parts of the structure which are different
 > (e.g. pmu->name, pmu->type, etc.) Also, we need one pmu instance per
 > IOMMU since each pmu reference will get assigned to perf_event, and
 > also used to reference back to struct perf_amd_iommu. Note that each
 > pmu can also have different events.

So, I still don't think we can have just one static PMU structure and
assign it to each IOMMU. Lemme know if I am missing your point here.


>> [...]
 >> @@ -463,7 +466,24 @@ static __init int amd_iommu_pc_init(void)
>>  	if (ret)
>>  		return ret;
>>
>> -	ret = _init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
>> +	for (i = 0 ; i < amd_iommu_get_num_iommus(); i++) {
>> +		struct perf_amd_iommu *pi;
>> +
>> +		pi = kzalloc(sizeof(struct perf_amd_iommu), GFP_KERNEL);
>> +		if (!pi) {
>> +			ret = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		ret = init_one_perf_amd_iommu(pi, i);
>> +		if (ret) {
>> +			kfree(pi);
>> +			break;
>
> What happens with the iommus that have been initialized successfully
> before this one fails? They remain in use?
>
> I think we need at least a warning saying here:
>
> 	pr_warning("Error initializing IOMMU %d ...")
>
> so that we at least know why some are missing.
>

The initialized ones should be functioning independently (as separate PMUs).
So, it should be alright to just leave them. I'll add the warning message
as you suggested.

Thanks,
Suravee
