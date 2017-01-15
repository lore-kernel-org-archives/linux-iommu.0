From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 1/7] perf/amd/iommu: Misc fix up perf_iommu_read
Date: Sun, 15 Jan 2017 09:36:10 +0700
Message-ID: <8d529523-21b4-d917-e83f-ed616a29083c@amd.com>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484019227-11473-2-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170111115735.GI3107@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170111115735.GI3107-ndre7Fmf5hadTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Peter,

On 1/11/17 18:57, Peter Zijlstra wrote:
> On Mon, Jan 09, 2017 at 09:33:41PM -0600, Suravee Suthikulpanit wrote:
>> This patch contains the following minor fixup:
>>   * Fixed overflow handling since u64 delta would lose the MSB sign bit.
>
> Please explain.. afaict this actually introduces a bug.

I'm changing the u64 to s64 ..... (see below)

>
>> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
>> index b28200d..f387baf 100644
>> --- a/arch/x86/events/amd/iommu.c
>> +++ b/arch/x86/events/amd/iommu.c
>> @@ -319,29 +319,30 @@ static void perf_iommu_start(struct perf_event *event, int flags)
>>
>>  static void perf_iommu_read(struct perf_event *event)
>>  {
>> -	u64 count = 0ULL;
>> -	u64 prev_raw_count = 0ULL;
>> -	u64 delta = 0ULL;
>> +	u64 cnt, prev;
>> +	s64 delta;

.... (here) because we had a discussion (https://lkml.org/lkml/2016/2/18/325),
and you suggested the following:

     Your overflow handling is broken, you want delta to be s64. Otherwise:

	delta >>= COUNTER_SHIFT;

     ends up as a SHR and you loose the MSB sign bits.

>>  	struct hw_perf_event *hwc = &event->hw;
>>  	pr_debug("perf: amd_iommu:perf_iommu_read\n");
>>
>>  	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
>>  				_GET_BANK(event), _GET_CNTR(event),
>> -				IOMMU_PC_COUNTER_REG, &count, false);
>> +				IOMMU_PC_COUNTER_REG, &cnt, false);
>>
>>  	/* IOMMU pc counter register is only 48 bits */
>> -	count &= 0xFFFFFFFFFFFFULL;
>> +	cnt &= GENMASK_ULL(48, 0);
>>
>> -	prev_raw_count =  local64_read(&hwc->prev_count);
>> -	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
>> -					count) != prev_raw_count)
>> -		return;
>> +	prev = local64_read(&hwc->prev_count);
>>
>> -	/* Handling 48-bit counter overflowing */
>> -	delta = (count << COUNTER_SHIFT) - (prev_raw_count << COUNTER_SHIFT);
>> +	/*
>> +	 * Since we do not enable counter overflow interrupts,
>> +	 * we do not have to worry about prev_count changing on us.
>> +	 */
>
> So you cannot group this event with a software event that reads this
> from their sample?

Not sure if I understand you point here. When you say sample, I assume you mean
the profiling mode used w/ perf record. These counters are not supported for
sampling mode. So, we only perf stat (i.e. counting mode).

Thanks,
Suravee
