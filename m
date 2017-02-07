From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v8 3/9] perf/amd/iommu: Misc fix up perf_iommu_read
Date: Tue, 7 Feb 2017 11:50:27 +0700
Message-ID: <39fa57a2-7667-a8e4-6ae1-fc90f3b11d82@amd.com>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-4-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170123123330.GY6485@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170123123330.GY6485-ndre7Fmf5hadTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
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

On 1/23/17 19:33, Peter Zijlstra wrote:
> On Mon, Jan 16, 2017 at 01:23:30AM -0600, Suravee Suthikulpanit wrote:
>>  static void perf_iommu_read(struct perf_event *event)
>>  {
>> -	u64 count = 0ULL;
>> -	u64 prev_raw_count = 0ULL;
>> -	u64 delta = 0ULL;
>> +	u64 count, prev;
>> +	s64 delta;
>
> I did send that email where I told I was mistaken with that suggestion,
> right? Since the counter always increments (it does, right), a negative
> delta does not make sense.

Right, I sent this out before your reply email in V7. I'll change the delta
back to u64. I'll fix this in V9.

>
>>  	struct hw_perf_event *hwc = &event->hw;
>>
>>  	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
>> @@ -330,18 +329,20 @@ static void perf_iommu_read(struct perf_event *event)
>>  				IOMMU_PC_COUNTER_REG, &count, false);
>>
>>  	/* IOMMU pc counter register is only 48 bits */
>> -	count &= 0xFFFFFFFFFFFFULL;
>> +	count &= GENMASK_ULL(48, 0);
>
> Why do you need that at all? If the counter is only 48 bits, what does
> the hardware do with the upper bits?

So, bit 48-63 are reserved. I just try to ensure that the HW does not use them
for anything (also probably in the future).

>>
>> -	prev_raw_count =  local64_read(&hwc->prev_count);
>> -	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
>> -					count) != prev_raw_count)
>> -		return;
>> +	prev = local64_read(&hwc->prev_count);
>
> I'm still not convinced you can do away with that cmpxchg.

Ok, I can just leave the local64_read() in.

Thanks,
Suravee
