From: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: fix incorrect use of S2CR_TYPE_SHIFT
Date: Tue, 22 Apr 2014 18:27:42 +0800
Message-ID: <5356441E.3040601@huawei.com>
References: <1397786874-11372-1-git-send-email-wangkefeng.wang@huawei.com>
	<53508E75.2080703@huawei.com> <20140422100015.GA7484@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140422100015.GA7484-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/22 18:00, Will Deacon wrote:
> On Fri, Apr 18, 2014 at 03:31:17AM +0100, Kefeng Wang wrote:
>> On 04/18 10:07, Kefeng Wang wrote:
>>> There is already S2CR_TYPE_TRANS in S2CR_TYPE_TRANS macro,
                     ^^^^^^^^^^^^^^^
>>> so drop the second shift.
>>
>> Typo issue, please use following patch.
> 
> They look the same to me -- which one should I take?
> 
> Also, since S2CR_TYPE_TRANS is 0x0, this fix isn't critical, so I'll include
> it in my updates pull for 3.16.

OK, please use second one, thanks.

Kefeng

> 
> Cheers,
> 
> Will
> 
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/iommu/arm-smmu.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 8b89e33..96755ec 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1167,7 +1167,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>>>  	for (i = 0; i < master->num_streamids; ++i) {
>>>  		u32 idx, s2cr;
>>>  		idx = master->smrs ? master->smrs[i].idx : master->streamids[i];
>>> -		s2cr = (S2CR_TYPE_TRANS << S2CR_TYPE_SHIFT) |
>>> +		s2cr = S2CR_TYPE_TRANS |
>>>  		       (smmu_domain->root_cfg.cbndx << S2CR_CBNDX_SHIFT);
>>>  		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
>>>  	}
>>>
>>
>>
>> From bfcdbee6f5e71c561dfddf8751c4eabdca1e3a56 Mon Sep 17 00:00:00 2001
>> From: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> Date: Fri, 18 Apr 2014 10:20:48 +0800
>> Subject: [PATCH] iommu/arm-smmu: fix incorrect use of S2CR_TYPE_SHIFT
>>
>> There is already S2CR_TYPE_SHIFT in S2CR_TYPE_TRANS macro,
>> so drop the second shift.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 8b89e33..96755ec 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1167,7 +1167,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>>  	for (i = 0; i < master->num_streamids; ++i) {
>>  		u32 idx, s2cr;
>>  		idx = master->smrs ? master->smrs[i].idx : master->streamids[i];
>> -		s2cr = (S2CR_TYPE_TRANS << S2CR_TYPE_SHIFT) |
>> +		s2cr = S2CR_TYPE_TRANS |
>>  		       (smmu_domain->root_cfg.cbndx << S2CR_CBNDX_SHIFT);
>>  		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
>>  	}
>> -- 
>> 1.7.1
>>
>>
>>
> 
> .
> 
