Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FA31F959
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD49811FB;
	Fri,  6 Oct 2023 06:46:29 -0700 (PDT)
Received: from [10.57.66.230] (unknown [10.57.66.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DEAD3F641;
	Fri,  6 Oct 2023 06:45:48 -0700 (PDT)
Message-ID: <14555232-bc81-496d-bb06-7a7502f26568@arm.com>
Date: Fri, 6 Oct 2023 14:45:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] iommu/arm-smmu: Reorganize
 arm_smmu_domain_add_master()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <jroedel@suse.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>
References: <1-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <a75f54d3-cd16-499d-b6d2-eed38153b0e2@arm.com>
 <20231006123001.GO682044@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231006123001.GO682044@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-06 13:30, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 01:05:03PM +0100, Robin Murphy wrote:
>> On 2023-10-05 19:28, Jason Gunthorpe wrote:
>>> Make arm_smmu_domain_add_master() not use the smmu_domain to detect the
>>> s2cr configuration, instead pass it in as a parameter. It always returns
>>> zero so make it return void.
>>
>> It doesn't follow that a function named arm_smmu_domain_<operation>() should
>> not operate on an arm_smmu_domain... I think this is the point to rename it
>> to something like arm_smmu_master_install_s2crs() to reflect that what it's
>> actually doing by now is a lot less than it did 10 years ago.
> 
> heh, yes, I did not notice
>   
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index d6d1a2a55cc069..7f33363719f4ac 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -1081,21 +1081,14 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg,
>>>    	mutex_unlock(&smmu->stream_map_mutex);
>>>    }
>>> -static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>>> -				      struct arm_smmu_master_cfg *cfg,
>>> -				      struct iommu_fwspec *fwspec)
>>> +static void arm_smmu_domain_add_master(struct arm_smmu_device *smmu,
>>
>> We already have the SMMU device in cfg->smmu, no need to pass it twice.
> 
> Sure, but the caller also already has it on its stack..

Stack? Caller? Not in my build ;)

00000000000040b8 <arm_smmu_attach_dev>:
...
         smmu = cfg->smmu;
     410c:       f94002d3        ldr     x19, [x22]
...
         smmu_domain->smmu = smmu;
     4268:       f90002f3        str     x19, [x23]
...
         struct arm_smmu_s2cr *s2cr = smmu->s2crs;
     44e0:       f9403a79        ldr     x25, [x19, #112]
...
         ret = arm_smmu_domain_add_master(smmu_domain, cfg, fwspec);
     4544:       5280001c        mov     w28, #0x0
...

Even if the compiler didn't inline the heck out of an easy inlining 
candidate, this is hardly a critical hot path where an extra load would 
make any difference, so the only thing this code needs optimising for is 
readability, or Donald Knuth will be sad :(

Thanks,
Robin.
