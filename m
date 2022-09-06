Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E964B17D1
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 14:52:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FB0B1A32;
	Tue,  6 Sep 2022 07:52:24 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F7EC3F7B4;
	Tue,  6 Sep 2022 07:52:16 -0700 (PDT)
Message-ID: <54c4ec3a-a9c5-c920-bcb7-d737a63c5d1b@arm.com>
Date: Tue, 6 Sep 2022 15:52:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: amd iommu configuration
Content-Language: en-GB
To: Vasant Hegde <vasant.hegde@amd.com>, Steven J Abner
 <pheonix.sja@att.net>, Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
References: <6JULHR.A756AJXX1SBV2.ref@att.net> <6JULHR.A756AJXX1SBV2@att.net>
 <efdd6848-6bbb-8e24-efd5-3b79865a653b@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <efdd6848-6bbb-8e24-efd5-3b79865a653b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-05 15:13, Vasant Hegde wrote:
> Steven,
> 
> [+Felix, amd-fgx list]
> 
> 
> On 9/3/2022 4:29 AM, Steven J Abner wrote:
>> Hi
>> I was referred to you from linux-kernel@vger.kernel.org about the following issue.
>> Here is as was written:
>> On 9/1/22 11:36, Steven J Abner wrote:
>> Hi
>> Building a kernel tailored for AMD 2400g on ASRock B450 using 5.18.12 as base.
>> I stumbled across an odd situation and which lacked Kconfig info and lead to
>> oddity.
>> /drivers/iommu/amd/Kconfig states 'config AMD_IOMMU_V2' is 'tristate' but unlike
>> many
>> other tristate configures doesn't mention that module name is 'iommu_v2.ko' and
>> loading should be done by adding to modules-load.d.
>>
>> The oddity is that by loading as module is as follows (differences):
>>
>> builtin iommu_v2 version dmesg:
>> amdgpu: HMM registered 2048MB device memory
>> amdgpu: Topology: Add APU node [0x0:0x0]
>> amdgpu: Topology: Add APU node [0x15dd:0x1002]
>> AMD-Vi: AMD IOMMUv2 loaded and initialized
>> kfd kfd: amdgpu: added device 1002:15dd
>> kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>> memmap_init_zone_device initialised 524288 pages in 0ms
> 
> IOMMU V2 modules provides IOMMU feature like attaching device to
> process. I think amdgpu uses those features if available.
> So in this case amdgpu is using those IOMMU features.
> 
>>
>> module not loaded due to missing iommu.conf dmesg:
>> amdgpu: CRAT table disabled by module option
>> amdgpu: Topology: Add CPU node
>> amdgpu: Virtual CRAT table created for CPU
>> kfd kfd: amdgpu: GC IP 090100 not supported in kfd
>>
>> module load through iommu.conf dmesg:
>> amdgpu: CRAT table disabled by module option
>> amdgpu: Topology: Add CPU node
>> amdgpu: Virtual CRAT table created for CPU
>> AMD-Vi: AMD IOMMUv2 loaded and initialized
>> kfd kfd: amdgpu: GC IP 090100 not supported in kfd
>>
>> Note, only difference on witk/without iommu.conf is:
>> AMD-Vi: AMD IOMMUv2 loaded and initialized
> 
> I think in this case iommu_v2.ko module got loaded after GPU
> initialized. Hence amdgpu is not using iommu v2 features.
> 
> 
>>
>> So does this mean missing features by not having builtin?
>> If not, should Kconfig have hint about module and loading?
> 
> @Felix,
>    I see that drivers/gpu/drm/amd/amdkfd/Kconfig contains below line
>      imply AMD_IOMMU_V2 if X86_64
> 
> 
>    Should we change `s/imply/select` ?

"select" might help when KFD is built-in, but it probably still wants a 
MODULE_SOFTDEP() to enforce load order when they're both modular.

Robin.
