Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A42F34
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 11:32:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566DA1474;
	Fri, 15 Jul 2022 04:32:46 -0700 (PDT)
Received: from [10.57.86.139] (unknown [10.57.86.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F3993F73D;
	Fri, 15 Jul 2022 04:32:45 -0700 (PDT)
Message-ID: <81ae0b69-c86c-a1f0-22ba-7fafc2c0c7f3@arm.com>
Date: Fri, 15 Jul 2022 12:32:40 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 3/7] iommu/amd: Fix sparse warning
Content-Language: en-GB
To: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <20220603112107.8603-4-vasant.hegde@amd.com> <YrQeXdR8yPOyv957@8bytes.org>
 <82767d0d-a04b-4432-0e7e-77bcca095e09@arm.com>
 <403e6853-86ac-a81f-42a0-2d896163ab81@amd.com>
 <15337b9f-48d7-d956-5d6c-b40319ba38ad@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <15337b9f-48d7-d956-5d6c-b40319ba38ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-07-13 05:07, Vasant Hegde wrote:
> 
> Hi Robin,
> 
> On 6/27/2022 3:59 PM, Vasant Hegde wrote:
>>
>>
>> On 6/23/2022 3:12 PM, Robin Murphy wrote:
>>> On 2022-06-23 09:03, Joerg Roedel wrote:
>>>> On Fri, Jun 03, 2022 at 04:51:03PM +0530, Vasant Hegde wrote:
>>>>> Fix below sparse warning:
>>>>>     CHECK   drivers/iommu/amd/iommu.c
>>>>>     drivers/iommu/amd/iommu.c:73:24: warning: symbol 'amd_iommu_ops' was not declared. Should it be static?
>>>>>
>>>>> Also we are going to introduce v2 page table which has different
>>>>> pgsize_bitmaps. Hence remove 'const' qualifier.
>>>>
>>>> I am not a fan of removing the consts. Please use separate ops
>>>> structures for v2 page-tables and make then const as well. This probably
>>>> also has some optimization potential in the future when we can make the
>>>> ops call-back functions page-table specific.
>>>
>>> TBH it's probably time to retire iommu_ops->pgsize_bitmap anyway. At the very least it would be logical to move it to iommu_domain_ops now, but maybe we could skip ahead and just rely on drivers initialising domain->pgsize_bitmap directly in their .domain_alloc?
>>>
>>
>> Robin,
>>
>> Something like below? If yes, I will cleanup and get proper fix.
> 
> Ping.

Sorry for the delay :)

> Will you be cleaning up pgsize_bitmap -OR- do you want me to cleanup (I can do that as separate
> series)?

I started prototyping it too, and at least for the Arm SMMU drivers it 
turns out the change is a little bit fiddly, then the idea started 
steadily turned into moving *all* the data out of iommu_ops. That then 
ties directly into what I'm already working on, so I'm happy to pick it 
up. I think it should fit in quite neatly right after the 
bus_set_iommu() series, so I'll aim to get something ready for next cycle.

Thanks,
Robin.
