Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE11C07
	for <iommu@lists.linux.dev>; Mon, 16 Jan 2023 10:56:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9EE5AD7;
	Mon, 16 Jan 2023 02:57:08 -0800 (PST)
Received: from [10.57.74.207] (unknown [10.57.74.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4E903F71A;
	Mon, 16 Jan 2023 02:56:25 -0800 (PST)
Message-ID: <7a53ac6f-640b-436d-9bfa-3e49066b2460@arm.com>
Date: Mon, 16 Jan 2023 10:56:21 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu: Tidy up io-pgtable dependencies
Content-Language: en-GB
To: Conor Dooley <conor@kernel.org>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, palmer@dabbelt.com
References: <51d8c78e2ecc6696ac5907526580209ea6da167f.1673553587.git.robin.murphy@arm.com>
 <Y8HYlFp2ZIlzIPfB@spud>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y8HYlFp2ZIlzIPfB@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-01-13 22:17, Conor Dooley wrote:
> Hey Robin,
> 
> On Thu, Jan 12, 2023 at 07:59:47PM +0000, Robin Murphy wrote:
>> Some io-pgtable implementations, and thus their users too, carry a
>> slightly odd dependency to get around the GENERIC_ATOMIC64 version of
>> cmpxchg64() often failing to compile. Since this is a functional
>> dependency, it's a bit misleading and untidy to tie it explicitly to
>> COMPILE_TEST while assuming that it's also implied by the other
>> platform/architecture options. Make things clearer by separating these
>> functional dependencies into distinct statements from those controlling
>> visibility, and since they do look a bit non-obvious to the uninitiated,
>> also commenting them for good measure.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/Kconfig | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
>>   config IPMMU_VMSA
>>   	bool "Renesas VMSA-compatible IPMMU"
>> -	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
>> +	depends on ARCH_RENESAS || COMPILE_TEST
>> +	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
>>   	select IOMMU_API
>>   	select IOMMU_IO_PGTABLE_LPAE
>>   	select ARM_DMA_USE_IOMMU
> 
> This is a fix for the broken riscv32 allmodconfig stuff that Palmer
> reported, right?

Indirectly - that made it clear that the whole area was worth cleaning 
up in general, so I did this expecting to rebase it around one of the 
other fix patches, but none of those seem to have gone anywhere.

In the meantime I guess it might now be simplest to apply Palmer's 
config workaround if you want something more expedient.

Cheers,
Robin.

> https://lore.kernel.org/all/20221214180409.7354-1-palmer@rivosinc.com/
> 
> I did a dfn:drivers/iommu/Kconfig search on lore & saw this, but AFAICT
> the patch was applied to next rather than fixes.
> 
> Apologies if I'm off here, I have had that report in my follow-up-on
> queue for a while & since Christmas happened in between I've lost track
> of when the build failure was introduced.
> 
> Last I remember, Guo Ren sent a patch that was not to your liking, but I
> didn't see anything after that.
> 
> Thanks,
> Conor.
