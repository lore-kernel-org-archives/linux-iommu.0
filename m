From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V4 2/6] perf/amd/iommu: Modify functions to query max
	banks and counters
Date: Mon, 22 Feb 2016 11:55:30 +0700
Message-ID: <56CA94C2.9090501@amd.com>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455182127-17551-3-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160218111116.GE3694@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160218111116.GE3694-fF5Pk5pvG8Y@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 02/18/2016 06:11 PM, Borislav Petkov wrote:
> On Thu, Feb 11, 2016 at 04:15:23PM +0700, Suravee Suthikulpanit wrote:
>> Currently, amd_iommu_pc_get_max_[banks|counters]() require devid,
>> which should not be the case.
>
> Why?
>
> Commit message could use an explanation.
>
>> Also, these don't properly support
>> multi-IOMMU system.
>>
>> Current and future AMD systems with IOMMU that support perf counter
>
> 				"with an IOMMU that supports performance counters"
>
>> would likely contain homogeneous IOMMUs where multiple IOMMUs are
>
> What are homogeneous IOMMUs?

I intended to mean the same IOMMU version/capability for all IOMMUs in 
the system.

>
>> availalbe. So, this patch modifies these function to iterate all IOMMU
>
> Please integrate a spellchecker in your patch creation workflow:
>
> s/availalbe/available/
>

Thanks. I have now rephrased and spell check the new commit message for 
the V5.

>>
>> Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   arch/x86/events/amd/iommu.c           | 17 +++++++----------
>>   arch/x86/include/asm/perf/amd/iommu.h |  7 ++-----
>>   drivers/iommu/amd_iommu_init.c        | 20 ++++++++++++--------
>>   3 files changed, 21 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
>> index 2f96072..debf22d 100644
>> --- a/arch/x86/events/amd/iommu.c
>> +++ b/arch/x86/events/amd/iommu.c
>> @@ -232,14 +232,6 @@ static int perf_iommu_event_init(struct perf_event *event)
>>   		return -EINVAL;
>>   	}
>>
>> -	/* integrate with iommu base devid (0000), assume one iommu */
>> -	perf_iommu->max_banks =
>> -		amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID);
>> -	perf_iommu->max_counters =
>> -		amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID);
>> -	if ((perf_iommu->max_banks == 0) || (perf_iommu->max_counters == 0))
>> -		return -EINVAL;
>> -
>>   	/* update the hw_perf_event struct with the iommu config data */
>>   	hwc->config = config;
>>   	hwc->extra_reg.config = config1;
>> @@ -450,6 +442,11 @@ static __init int _init_perf_amd_iommu(
>
> Btw, that _init_perf_amd_iommu is unnecessarily split from
> amd_iommu_pc_init(). You should merge those two. But that's another
> patch. In that same cleanup patch you could do
>
> s/perf_iommu/pi/g
>
> or so because that perf_iommu local var is unnecesarily long and impairs
> readability.
>

Sure, I'll clean up both of these.

>>   	if (_init_events_attrs(perf_iommu) != 0)
>>   		pr_err("perf: amd_iommu: Only support raw events.\n");
>>
>> +	perf_iommu->max_banks = amd_iommu_pc_get_max_banks();
>> +	perf_iommu->max_counters = amd_iommu_pc_get_max_counters();
>> +	if ((perf_iommu->max_banks == 0) || (perf_iommu->max_counters == 0))
>
> Simplify:
>
> 	if (!perf_iommu->max_banks ||
> 	    !perf_iommu->max_counters)

Ok

[....]
>> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
>> index d30f4b2..a62b5ce 100644
>> --- a/drivers/iommu/amd_iommu_init.c
>> +++ b/drivers/iommu/amd_iommu_init.c
>> @@ -2251,15 +2251,17 @@ EXPORT_SYMBOL(amd_iommu_v2_supported);
>>    *
>>    ****************************************************************************/
>>
>> -u8 amd_iommu_pc_get_max_banks(u16 devid)
>> +u8 amd_iommu_pc_get_max_banks(void)
>>   {
>>   	struct amd_iommu *iommu;
>>   	u8 ret = 0;
>>
>> -	/* locate the iommu governing the devid */
>> -	iommu = amd_iommu_rlookup_table[devid];
>> -	if (iommu)
>> +	for_each_iommu(iommu) {
>> +		if (!iommu->max_banks ||
>> +		    (ret && (iommu->max_banks != ret)))
>
> What is that supposed to do?
>
> Check that the max_banks of a previous IOMMU are == to the max_banks of
> the current IOMMU?
>
> Why? Could definitely use a comment.

Current AMD IOMMU perf implementation assumes that all IOMMUs must have
the same value of max_counters. Therefore, this logic iterates through 
all IOMMUs to check this. I'll add the comment here.

Thanks,
Suravee
