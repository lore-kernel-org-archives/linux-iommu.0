Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3879C5
	for <iommu@lists.linux.dev>; Tue,  3 Jan 2023 13:58:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2E811595;
	Tue,  3 Jan 2023 05:59:02 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214223F587;
	Tue,  3 Jan 2023 05:58:15 -0800 (PST)
Message-ID: <de09ddad-3f08-6dd3-0774-9f5997958cc3@arm.com>
Date: Tue, 3 Jan 2023 13:58:09 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arch/arm/mm/dma-mapping.c: fix __alloc_from_pool
 returning a dirty buffer
Content-Language: en-GB
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Igor Klochko <igor.klochko@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
 m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org
References: <14dccd8c-e29a-fe93-5d4c-f0c3ff4f2430@gmail.com>
 <20221223143938.GA29147@lst.de>
 <43ef46fc-2fbc-31b7-d683-f7496b39dae5@gmail.com>
 <Y7P6jeHCoTVRhl7X@shell.armlinux.org.uk>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y7P6jeHCoTVRhl7X@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/01/2023 9:51 am, Russell King (Oracle) wrote:
> On Fri, Dec 23, 2022 at 11:51:43PM +0100, Igor Klochko wrote:
>> Thanks Christoph,
>>
>> Added fixes and a changelog.
>> This issue is present in all current LTS versions.
>>
>> ----
>> Buffers allocated by __alloc_from_pool() should be zeroed out as done by other allocators.
>> Certain drivers expect a clean buffer and clearing the buffer is beneficial from the security point of view.
>> ---
>> Fixes: 36d0fd2198da3 (*arm: use genalloc for the atomic pool*)
>> Signed-off-by: Igor Klochko <igor.klochko@gmail.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index c135f6e37a00..bb2bb3ab497a 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -366,6 +366,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
>>   
>>   		*ret_page = phys_to_page(phys);
>>   		ptr = (void *)val;
>> +		memset(ptr, 0, size);
> 
> I'm not up to speed with the current structure of the DMA implementation
> on ARM, but isn't this going to make cache lines dirty for the returned
> buffer, which will corrupt DMA on non-coherent devices?

The virtual address of the pool, and thus VAs within the pool as 
returned by gen_pool_alloc(), should be a non-cacheable remap set up by 
atomic_pool_init(), so it looks appropriate to me. In fact "ptr" here 
appears to be the final return value propagated all the way back out to 
the caller of dma_alloc_coherent(), so if that were dodgy then there 
would already be problems afoot.

Robin.
