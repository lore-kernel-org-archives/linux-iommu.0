Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3CA7E
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 16:35:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34383139F;
	Tue,  6 Sep 2022 09:35:26 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B56913F7B4;
	Tue,  6 Sep 2022 09:35:18 -0700 (PDT)
Message-ID: <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>
Date: Tue, 6 Sep 2022 17:35:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Content-Language: en-GB
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-05 12:39, Vasant Hegde wrote:
> Hi Joerg, Robin,
> 
> Ping. Did you get a chance to look into this series?

The io-pgtable patches look OK to me at a glance (I'd be inclined to 
squash #2 into #1, but it's your choice). One thing that's not so 
obvious, though, is how this all interacts with 
amd_iommu_def_domain_type() that currently tries to force identity 
domains for IOMMUv2 devices - does that mean that this support won't 
actually be used a lot of the time, and/or is that override still necessary?

There's also a thread going on elsewhere that I suspect might tie in 
here as well:

https://lore.kernel.org/regressions/874jy4cqok.wl-tiwai@suse.de/

Will this series also mean that the domain shenanigans in 
amd_iommu_init_device() can be replaced by just making sure the GPU gets 
the proper type of v2 default domain in the first place, so KFD can use 
its PASIDs on top of that directly, and the audio driver problem goes 
away naturally?

Thanks,
Robin.

> 
> -Vasant
> 
> On 8/25/2022 12:09 PM, Vasant Hegde wrote:
>> This series introduces a new usage model for the v2 page table, where it
>> can be used to implement support for DMA-API by adopting the generic
>> IO page table framework.
>>
>> One of the target usecases is to support nested IO page tables
>> where the guest uses the guest IO page table (v2) for translating
>> GVA to GPA, and the hypervisor uses the host I/O page table (v1) for
>> translating GPA to SPA. This is a pre-requisite for supporting the new
>> HW-assisted vIOMMU presented at the KVM Forum 2020.
>>
>>    https://static.sched.com/hosted_files/kvmforum2020/26/vIOMMU%20KVM%20Forum%202020.pdf
>>
>> The following components are introduced in this series:
>>
>> - Part 1 (patch 1-3)
>>    Move AMD v1 page table to use [un]map_pages interfaces and minor fixes to unmap path.
>>
>> - Part 1 (patch 4-5 and 8)
>>    Refactor the current IOMMU page table code to adopt the generic IO page
>>    table framework, and add AMD IOMMU Guest (v2) page table management code.
>>
>> - Part 2 (patch 7)
>>    Add support for the AMD IOMMU Guest IO Protection feature (GIOV)
>>    where requests from the I/O device without a PASID are treated as
>>    if they have PASID of 0.
>>
>> - Part 3 (patch 9)
>>    Introduce new "amd_iommu_pgtable" command-line to allow users
>>    to select the mode of operation (v1 or v2).
>>
>> See AMD I/O Virtualization Technology Specification for more detail.
>>
>>    http://www.amd.com/system/files/TechDocs/48882_IOMMU_3.05_PUB.pdf
>>
>>
>> Thanks,
>> Vasant
>>
>> Changes from v2 -> v3 :
>>    - As Robin suggested added support to use [un]map_pages interface (Patch 1 - 3)
>>    - Removed [un]map interface from AMD IOMMU driver
>>    - Updated v2 page table to use [un]map_pages interface
>>
>> V2 patchset: https://lore.kernel.org/linux-iommu/20220713053034.12061-1-vasant.hegde@amd.com/
>>
>> Changes from v1 -> v2 :
>>    - Allow v2 page table only when FEATURE_GT is enabled
>>    - V2 page table doesn't support IOMMU passthrough mode. Hence added
>>      check to fall back to v1 mode if system is booted with iommu=pt
>>    - Overloaded amd_iommu command line option (removed amd_iommu_pgtable
>>      option)
>>    - Override supported page sizes dynamically instead of selecting at
>>      boot time.
>>
>> V1 patchset : https://lore.kernel.org/linux-iommu/20220603112107.8603-1-vasant.hegde@amd.com/T/#t
>>
>> Changes from RFC -> v1:
>>    - Addressed review comments from Joerg
>>    - Reimplemented v2 page table
>>
>> RFC patchset : https://lore.kernel.org/linux-iommu/20210312090411.6030-1-suravee.suthikulpanit@amd.com/T/#t
>>
>>
>> Suravee Suthikulpanit (4):
>>    iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
>>    iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
>>    iommu/amd: Add support for Guest IO protection
>>    iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
>>
>> Vasant Hegde (5):
>>    iommu/amd/io-pgtable: Implement map_pages io_pgtable_ops callback
>>    iommu/amd/io-pgtable: Implement unmap_pages io_pgtable_ops callback
>>    iommu/amd: Add map/unmap_pages() iommu_domain_ops callback support
>>    iommu/amd: Initial support for AMD IOMMU v2 page table
>>    iommu/amd: Add command-line option to enable different page table
>>
>>   .../admin-guide/kernel-parameters.txt         |   2 +
>>   drivers/iommu/amd/Makefile                    |   2 +-
>>   drivers/iommu/amd/amd_iommu_types.h           |   8 +-
>>   drivers/iommu/amd/init.c                      |  36 +-
>>   drivers/iommu/amd/io_pgtable.c                |  76 ++--
>>   drivers/iommu/amd/io_pgtable_v2.c             | 415 ++++++++++++++++++
>>   drivers/iommu/amd/iommu.c                     | 117 +++--
>>   drivers/iommu/io-pgtable.c                    |   1 +
>>   include/linux/io-pgtable.h                    |   2 +
>>   9 files changed, 584 insertions(+), 75 deletions(-)
>>   create mode 100644 drivers/iommu/amd/io_pgtable_v2.c
>>
> 
