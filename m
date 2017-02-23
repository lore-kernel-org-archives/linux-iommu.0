From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v8 9/9] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Fri, 24 Feb 2017 01:20:58 +0700
Message-ID: <e19db1f0-d6ab-de0d-c5a5-f574b0cb9814@amd.com>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-10-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170125094653.GO6515@twins.programming.kicks-ass.net>
	<af2bca1a-59a9-d36c-a700-ca5360852543@amd.com>
	<20170214123149.GV6515@twins.programming.kicks-ass.net>
	<a2d532c4-2a58-f892-eb75-ffc94f0a125a@amd.com>
	<20170223181116.GJ6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170223181116.GJ6515-ndre7Fmf5hadTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
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



On 2/24/17 01:11, Peter Zijlstra wrote:
>> However, I have looked into reworking to not use the extra_regs, and I see
>> that the union in struct hw_perf_event currently contains various PMU-specific
>> structures (hardware, software, tracepoint, intel_cqm, itrace, amd_power,
>> and breakpoint).
>>
>> For amd_iommu PMU, we need additional registers for holding amd_iommu-specific
>> parameters. So, it seems that we can just introduce amd_iommu-specific struct
>> instead of re-using the existing structure for hardware events.
>>
>> I'm planning to add the following structure in the same union:
>>
>>     union {
>>         ......
>>                 struct { /* amd_iommu */
>>                         u8      iommu_csource;
>>                         u8      iommu_bank;
>>                         u8      iommu_cntr;
>>                         u16     iommu_devid;
>>                         u16     iommu_devid_msk;
>>                         u16     iommu_domid;
>>                         u16     iommu_domid_msk;
>>                         u32     iommu_pasid;
>>                         u32     iommu_pasid_msk;
>>                 };
>>     };
>>
>> Please let me know what you think, of if I am still missing your points.
> Yes, adding a struct to that union is fine and clarifies things. And
> just because I'm weird like that, there's a u8 hole after iommu_cntr.

Ok, I'll update this in V10 that I'll be sending out this week.

Thanks,
Suravee
