From: Gary R Hook <gary.hook@amd.com>
Subject: Re: [PATCH] iommu: Limit the IOVA page range to the specified
 addresses
Date: Fri, 27 Oct 2017 10:20:43 -0500
Message-ID: <df434365-6972-f87c-c77b-f0008aa2b1c8@amd.com>
References: <150827532101.76237.2380796046683480798.stgit@sosxen2.amd.com>
 <20171026103201.6ac9f21c@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171026103201.6ac9f21c@t450s.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 10/26/2017 03:32 AM, Alex Williamson wrote:
> On Tue, 17 Oct 2017 16:22:01 -0500
> Gary R Hook <gary.hook@amd.com> wrote:
> 
>> From: amd <amd@sosxen2.amd.com>
>>
>> The extent of pages specified when applying a reserved region should
>> include up to the last page of the range, but not the page following
>> the range.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>   drivers/iommu/amd_iommu.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index 27eb0d6fcdc2..bb3ef33e3784 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -3271,7 +3271,7 @@ static void amd_iommu_apply_resv_region(struct device *dev,
>>   	unsigned long start, end;
>>   
>>   	start = IOVA_PFN(region->start);
>> -	end   = IOVA_PFN(region->start + region->length);
>> +	end   = IOVA_PFN(region->start + region->length - 1);
>>   
>>   	WARN_ON_ONCE(reserve_iova(&dma_dom->iovad, start, end) == NULL);
>>   }
> 
> This looks like a fix, should we include:
> 
> Fixes: 8d54d6c8b8f3 ('iommu/amd: Implement apply_dm_region call-back')

It turns out there are other places where the computation is incorrect.
Would you prefer a single patch to address all of them, or separate
patches that apply to specific areas of the driver?
