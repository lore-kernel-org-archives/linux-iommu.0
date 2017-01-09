From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V6 2/7] perf/amd/iommu: Modify functions to query max
	banks and counters
Date: Mon, 9 Jan 2017 17:48:27 +0700
Message-ID: <44d807c7-35e2-006d-ed82-ec367a817239@amd.com>
References: <1482500330-5606-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1482500330-5606-3-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170104144853.GE10632@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170104144853.GE10632-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 1/4/17 21:48, Joerg Roedel wrote:
> On Fri, Dec 23, 2016 at 08:38:45PM +0700, Suravee Suthikulpanit wrote:
>> --- a/arch/x86/events/amd/iommu.h
>> +++ b/arch/x86/events/amd/iommu.h
>> @@ -24,15 +24,12 @@
>>  #define PC_MAX_SPEC_BNKS			64
>>  #define PC_MAX_SPEC_CNTRS			16
>>
>> -/* iommu pc reg masks*/
>> -#define IOMMU_BASE_DEVID			0x0000
>> -
>>  /* amd_iommu_init.c external support functions */
>>  extern bool amd_iommu_pc_supported(void);
>>
>> -extern u8 amd_iommu_pc_get_max_banks(u16 devid);
>> +extern u8 amd_iommu_pc_get_max_banks(uint devid);
>>
>> -extern u8 amd_iommu_pc_get_max_counters(u16 devid);
>> +extern u8 amd_iommu_pc_get_max_counters(uint devid);
>
> The parameters are now iommu-indexes and not device-ids anymore. You
> should reflect that in the prototypes here too.

Ahh.. thanks for pointing out. I missed this part.

>> diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
>> index 7eb60c1..1f10b3f 100644
>> --- a/drivers/iommu/amd_iommu_proto.h
>> +++ b/drivers/iommu/amd_iommu_proto.h
>> @@ -58,8 +58,8 @@ extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
>>
>>  /* IOMMU Performance Counter functions */
>>  extern bool amd_iommu_pc_supported(void);
>> -extern u8 amd_iommu_pc_get_max_banks(u16 devid);
>> -extern u8 amd_iommu_pc_get_max_counters(u16 devid);
>> +extern u8 amd_iommu_pc_get_max_banks(uint devid);
>> +extern u8 amd_iommu_pc_get_max_counters(uint devid);
>
> Same here, and why do you need to declare the prototypes in two
> different header files?

Hm.. actually good point. I will remove the unnecessary function 
declarations in the amd_iommu_proto.h.

Thanks,
Suravee
