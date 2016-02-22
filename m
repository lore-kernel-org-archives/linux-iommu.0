From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V4 5/6] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Mon, 22 Feb 2016 15:00:31 +0700
Message-ID: <56CAC01F.8090800@amd.com>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455182127-17551-6-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160218131853.GU6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160218131853.GU6357-ndre7Fmf5hadTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Peter,

On 02/18/2016 08:18 PM, Peter Zijlstra wrote:
> On Thu, Feb 11, 2016 at 04:15:26PM +0700, Suravee Suthikulpanit wrote:
>>   static void perf_iommu_read(struct perf_event *event)
>>   {
>> +	int i;
>>   	u64 delta = 0ULL;
>>   	struct hw_perf_event *hwc = &event->hw;
>> +	struct perf_amd_iommu *perf_iommu = container_of(event->pmu,
>> +							 struct perf_amd_iommu,
>> +							 pmu);
>>
>> +	if (amd_iommu_pc_get_counters(_GET_BANK(event), _GET_CNTR(event),
>> +				      amd_iommu_get_num_iommus(),
>> +				      perf_iommu_cnts))
>>   		return;
>>
>> +	/*
>> +	 * Now we re-aggregating event counts and prev-counts
>> +	 * from all IOMMUs
>> +	 */
>> +	local64_set(&hwc->prev_count, 0);
>> +
>> +	for (i = 0; i < amd_iommu_get_num_iommus(); i++) {
>> +		int indx = get_iommu_bnk_cnt_evt_idx(perf_iommu, i,
>> +						     _GET_BANK(event),
>> +						     _GET_CNTR(event));
>> +		u64 prev_raw_count = local64_read(&perf_iommu->prev_cnts[indx]);
>> +
>> +		/* IOMMU pc counter register is only 48 bits */
>> +		perf_iommu_cnts[i] &= GENMASK_ULL(48, 0);
>> +
>> +		/*
>> +		 * Since we do not enable counter overflow interrupts,
>> +		 * we do not have to worry about prev_count changing on us
>> +		 */
>> +		local64_set(&perf_iommu->prev_cnts[indx], perf_iommu_cnts[i]);
>> +		local64_add(prev_raw_count, &hwc->prev_count);
>> +
>> +		/* Handle 48-bit counter overflow */
>> +		delta = (perf_iommu_cnts[i] << COUNTER_SHIFT) - (prev_raw_count << COUNTER_SHIFT);
>> +		delta >>= COUNTER_SHIFT;
>> +		local64_add(delta, &event->count);
>> +	}
>>   }
>
> So I really don't have time to review new muck while I'm hunting perf
> core fail, but Boris made me look at this.
>
> This is crazy, if you have multiple IOMMUs then create an event per
> IOMMU, do _NOT_ fold them all into a single event.

These are system-wide events, which are programmed on every IOMMU the 
same way. I am not sure what you meant by creating an event per IOMMU. 
Do you mean I should create internal per-IOMMU struct perf_event for 
each event? Could you please give me some pointers?

> In any case, the reason Boris asked me to look at this is that your
> overflow handling is broken, you want delta to be s64. Otherwise:
>
> 	delta >>= COUNTER_SHIFT;
>
> ends up as a SHR and you loose the MSB sign bits.

Ah. Sorry, I missed that.

Thanks,
Suravee
