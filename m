From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v8 9/9] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Tue, 7 Feb 2017 08:57:52 +0700
Message-ID: <af2bca1a-59a9-d36c-a700-ca5360852543@amd.com>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-10-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170125094653.GO6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170125094653.GO6515-ndre7Fmf5hadTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
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

On 1/25/17 16:46, Peter Zijlstra wrote:
> On Mon, Jan 16, 2017 at 01:23:36AM -0600, Suravee Suthikulpanit wrote:
>
>> +	pi = container_of(event->pmu, struct perf_amd_iommu, pmu);
>> +	hwc->idx              = pi->idx;
>> +	hwc->config           = event->attr.config;
>> +	hwc->extra_reg.config = event->attr.config1;
>
>>  static void perf_iommu_enable_event(struct perf_event *ev)
>>  {
>> +	struct hw_perf_event *hwc = &ev->hw;
>>  	u8 csource = _GET_CSOURCE(ev);
>>  	u16 devid = _GET_DEVID(ev);
>>  	u8 bank = _GET_BANK(ev);
>> @@ -253,30 +248,34 @@ static void perf_iommu_enable_event(struct perf_event *ev)
>>  	u64 reg = 0ULL;
>>
>>  	reg = csource;
>> -	amd_iommu_pc_set_reg(0, bank, cntr,
>> +	amd_iommu_pc_set_reg(hwc->idx, bank, cntr,
>>  			     IOMMU_PC_COUNTER_SRC_REG, &reg);
>
> Please explain about this IOMMU crud, this looks like fail.
> hwc->idx should be the counter, not a random pmu index.

Ok, I thought this was not used by the code, so I used it for
holding PMU index. This might not be a good idea.
I will change this part per Boris comment in the reply of this
thread.

> But instead it looks like you get the counter form:
>
>   #define _GET_CNTR(ev)       ((u8)(ev->hw.extra_reg.reg))
>
> Which is absolutely insane.
>

So, the IOMMU counters are grouped into bank, and there could be
many banks. I use the extra_reg.reg to hold the bank and counter
indices. This will be used to program onto the counter configuration
register. This is handled in get_next_avail_iommu_bnk_cntr() and
clear_avail_iommu_bnk_cntr().

Thanks,
Suravee
