Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B6D6D24
	for <iommu@lists.linux.dev>; Fri,  1 Jul 2022 18:27:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BA4113E;
	Fri,  1 Jul 2022 11:17:48 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDCD33F5A1;
	Fri,  1 Jul 2022 11:17:43 -0700 (PDT)
Message-ID: <2ccb6033-4c34-ff59-50a8-549c924d269d@arm.com>
Date: Fri, 1 Jul 2022 19:17:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev,
 robdclark@gmail.com, baolu.lu@linux.intel.com, orsonzhai@gmail.com,
 baolin.wang7@gmail.com, zhang.lyra@gmail.com, jean-philippe@linaro.org,
 alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
 suravee.suthikulpanit@amd.com, alyssa@rosenzweig.io, dwmw2@infradead.org,
 mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 cohuck@redhat.com, thunder.leizhen@huawei.com,
 christophe.jaillet@wanadoo.fr, chenxiang66@hisilicon.com,
 john.garry@huawei.com, yangyingliang@huawei.com,
 iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org
References: <20220630203635.33200-1-nicolinc@nvidia.com>
 <20220630203635.33200-2-nicolinc@nvidia.com>
 <fab41f28-8f48-9f40-09c8-fd5f0714a9e0@arm.com>
 <Yr8kHnK7xRx2DZus@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yr8kHnK7xRx2DZus@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220701181738.7RsP3OSB0AF_m8gW9YFW3hJLeZEn64FNytZGlXnKIoM@z>

On 01/07/2022 5:43 pm, Nicolin Chen wrote:
> On Fri, Jul 01, 2022 at 11:21:48AM +0100, Robin Murphy wrote:
> 
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index 2ed3594f384e..072cac5ab5a4 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -1135,10 +1135,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>>        struct arm_smmu_device *smmu;
>>>        int ret;
>>>
>>> -     if (!fwspec || fwspec->ops != &arm_smmu_ops) {
>>> -             dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
>>> -             return -ENXIO;
>>> -     }
>>> +     if (!fwspec || fwspec->ops != &arm_smmu_ops)
>>> +             return -EMEDIUMTYPE;
>>
>> This is the wrong check, you want the "if (smmu_domain->smmu != smmu)"
>> condition further down. If this one fails it's effectively because the
>> device doesn't have an IOMMU at all, and similar to patch #3 it will be
> 
> Thanks for the review! I will fix that. The "on the same bus" is
> quite eye-catching.
> 
>> removed once the core code takes over properly (I even have both those
>> patches written now!)
> 
> Actually in my v1 the proposal for ops check returned -EMEDIUMTYPE
> also upon an ops mismatch, treating that too as an incompatibility.
> Do you mean that we should have fine-grained it further?

On second look, I think this particular check was already entirely 
redundant by the time I made the fwspec conversion to it, oh well. Since 
it remains harmless for the time being, let's just ignore it entirely 
until we can confidently say goodbye to the whole lot[1].

I don't think there's any need to differentiate an instance mismatch 
from a driver mismatch, once the latter becomes realistically possible, 
mostly due to iommu_domain_alloc() also having to become device-aware to 
know which driver to allocate from. Thus as far as a user is concerned, 
if attaching a device to an existing domain fails with -EMEDIUMTYPE, 
allocating a new domain using the given device, and attaching to that, 
can be expected to succeed, regardless of why the original attempt was 
rejected. In fact even in the theoretical different-driver-per-bus model 
the same principle still holds up.

Thanks,
Robin.

[1] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/aa4accfa4a10e92daad0d51095918e8a89014393
