Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D0337F
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 18:46:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E511FB;
	Wed, 13 Sep 2023 11:47:30 -0700 (PDT)
Received: from [10.57.93.239] (unknown [10.57.93.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D953D3F5A1;
	Wed, 13 Sep 2023 11:46:51 -0700 (PDT)
Message-ID: <8c8451aa-d0d7-058e-cfc2-7402f9002234@arm.com>
Date: Wed, 13 Sep 2023 19:46:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 8/8] iommu: Improve map/unmap sanity checks
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
 vdumpa@nvidia.com
References: <cover.1694525662.git.robin.murphy@arm.com>
 <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>
 <ZQHJoK0Er/nekjL6@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZQHJoK0Er/nekjL6@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-09-13 15:39, Jason Gunthorpe wrote:
> On Tue, Sep 12, 2023 at 05:18:44PM +0100, Robin Murphy wrote:
>> The current checks for the __IOMMU_DOMAIN_PAGING capability seem a
>> bit stifled, since it is quite likely now that a non-paging domain
>> won't have a pgsize_bitmap and/or mapping ops, and thus get caught
>> by the earlier condition anyway. Swap them around to test the more
>> fundamental condition first, then we can reasonably also upgrade
>> the other to a WARN_ON, since if a driver does ever expose a paging
>> domain without the means to actually page, it's clearly very broken.
> 
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iommu.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index c83f2e4c56f5..391bcae4d02d 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2427,12 +2427,12 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>>   	phys_addr_t orig_paddr = paddr;
>>   	int ret = 0;
>>   
>> -	if (unlikely(!ops->map_pages || domain->pgsize_bitmap == 0UL))
>> -		return -ENODEV;
>> -
>>   	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
>>   		return -EINVAL;
> 
> Why isn't this a WARN_ON? The caller is clearly lost its mind if it
> is calling map on a non paging domain..

Sure it's a dumb thing to do, however I don't think we can reasonably 
say without question that an external caller being dumb represents an 
unexpected and serious loss of internal consistency.

>> +	if (WARN_ON(!ops->map_pages || domain->pgsize_bitmap == 0UL))
>> +		return -ENODEV;
>> +
> 
> And these could be moved to after attach so they are not in any fast
> path, and eventually to after alloc..

Perhaps, although TBH I can't imagine it making any appreciable 
difference - they're both values we need to load and use soon anyway, so 
on a sensible CPU, the additional overhead should only really be a 
couple of not-taken branch-if-zero instructions, which is nothing at all 
compared to how much goes on in the main loop and the driver op call itself.

Thanks,
Robin.
