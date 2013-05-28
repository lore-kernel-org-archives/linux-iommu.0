From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] perf/x86/amd: AMD IOMMU PC PERF uncore PMU
	implementation
Date: Tue, 28 May 2013 12:17:28 -0500
Message-ID: <51A4E6A8.7080004@amd.com>
References: <1368819813-6481-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1368819813-6481-3-git-send-email-suravee.suthikulpanit@amd.com>
	<20130528121850.GC2575@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130528121850.GC2575-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 5/28/2013 7:18 AM, Joerg Roedel wrote:
> On Fri, May 17, 2013 at 02:43:32PM -0500, Suthikulpanit, Suravee wrote:
>> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
>> index b0684e4..fcbd3b8 100644
>> --- a/arch/x86/kernel/cpu/Makefile
>> +++ b/arch/x86/kernel/cpu/Makefile
>> @@ -30,7 +30,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
>>   obj-$(CONFIG_PERF_EVENTS)		+= perf_event.o
>>   
>>   ifdef CONFIG_PERF_EVENTS
>> -obj-$(CONFIG_CPU_SUP_AMD)		+= perf_event_amd.o perf_event_amd_uncore.o
>> +obj-$(CONFIG_CPU_SUP_AMD)		+= perf_event_amd.o perf_event_amd_uncore.o perf_event_amd_iommu.o
> This should also depend on CONFIG_AMD_IOMMU. If no IOMMU driver is
> compiled in it doesn't make sense to have that PMU.
I will take care of this.
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	/* integrate with iommu base devid (0000), assume one iommu */
> +	perf_iommu->max_banks =
> +		amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID);
> +	perf_iommu->max_counters =
> +		amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID);
> +
> +	/* update the hw_perf_event struct with the iommu config data */
> +	hwc->config = config;
> +	hwc->extra_reg.config = config1;
> +
> +	return 0;
> +}
> That implementation is very basic. Any reason for not using the event
> reporting mechanism of the IOMMU? You could implement a nice perf
> iommutop or something to see which devices do the most transactions or
> something like that.
>
>
> 	Joerg
This patch is adding perf system-wide counting mode support which is 
used by "perf stat" tool.  We are not implementing the sampling mode 
since MSI interrupt of the IOMMU cannot be used for current perf 
sampling tools (e.g. perf record or top) since the IOMMU counters are 
not core-specific.   The current "perf record" and "perf top" needs to 
attribute each sample to a particular core/pid which would allow the 
tools to figure out the instruction pointer and map the sample to a 
paticular module.

If I understand correctly, when you mentioned "perf iommutop", you want 
a new perf user-space tool which will show real-time IOMMU events per 
IOMMU HW and/or device?

Suravee
