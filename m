Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB520F8
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 19:41:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A6CD75;
	Thu, 17 Aug 2023 12:41:54 -0700 (PDT)
Received: from [10.57.90.41] (unknown [10.57.90.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0D883F64C;
	Thu, 17 Aug 2023 12:41:11 -0700 (PDT)
Message-ID: <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
Date: Thu, 17 Aug 2023 20:41:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over
 installed_smmus
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
 tina.zhang@intel.com, jean-philippe@linaro.org
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZN5y4N8ffSoiR/sm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-08-17 20:20, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 02:16:24AM +0800, Michael Shavit wrote:
>> Prepare and batch invalidation commands for each SMMU that a domain is
>> installed onto.
>> Move SVA's check against the smmu's ARM_SMMU_FEAT_BTM bit into
>> arm_smmu_tlb_inv_range_asid so that it can be checked against each
>> installed SMMU.
>>
>> Signed-off-by: Michael Shavit <mshavit@google.com>
>> ---
>> It's not obvious to me whether skipping the tlb_inv_range_asid when
>> ARM_SMMU_FEAT_BTM is somehow specific to SVA? Is moving the check into
>> arm_smmu_tlb_inv_range_asid still valid if that function were called
>> outside of SVA?
> 
> Logically it should be linked to SVA, and specifically to the mmu
> notifier callback. The mmu notifier callback is done whenever the CPU
> did an invalidation and BTM means the SMMU tracks exactly those
> automatically. Thus we don't need to duplicated it. Indeed, we should
> probably not even register a mmu notifier on BTM capable devices.

Almost - broadcast invalidates from the CPU only apply to SMMU TLBs; we 
still need the notifier for the sake of issuing ATC invalidate commands 
to endpoints.

> It is certainly wrong to skip invalidations generated for any other
> reason.
> 
>  From what I can tell SVA domains should have their CD table entry
> programmed with "ASET=0" and normal paging domains should be
> programmed with "ASET=1". This causes only the SVA domains to listen
> to the BTM invalidations.

Correct.

Thanks,
Robin.
