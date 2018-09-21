From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
Date: Fri, 21 Sep 2018 10:29:42 +0100
Message-ID: <50330f32-b051-bdf6-af26-3e24ed133480@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi John,

On 2018-09-21 10:20 AM, John Garry wrote:
> On 20/09/2018 17:10, Robin Murphy wrote:
>> Hi all,
>>
>> Hopefully this is the last spin of the series - I've now dropped my light
>> touch and fixed up all the various prose text, plus implemented the 
>> proper
>> quirk support for short-descriptor because it's actually just a trivial
>> cut-and-paste job.
>>
>> Robin.
>>
> 
> Hi Robin,
> 
> JFYI, I'm trying to test this patchset to get some figures and provide a 
> tested-by tag, but 4/8 seems to rely on "iommu/io-pgtable-arm: Fix race 
> handling in split_blk_unmap()" - more specifically, it seems to rely on 
> the version which Will rewrote in your patch review, and I am not sure 
> on what branch it exists on, if any.

Sorry, I should have said this is based on Will's iommu/devel branch:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel

Robin.

> 
> Thanks,
> John
> 
>>
>> Robin Murphy (2):
>>   iommu/io-pgtable-arm-v7s: Add support for non-strict mode
>>   iommu/arm-smmu: Support non-strict mode
>>
>> Zhen Lei (5):
>>   iommu/arm-smmu-v3: Implement flush_iotlb_all hook
>>   iommu/dma: Add support for non-strict mode
>>   iommu: Add "iommu.strict" command line option
>>   iommu/io-pgtable-arm: Add support for non-strict mode
>>   iommu/arm-smmu-v3: Add support for non-strict mode
>>
>>  .../admin-guide/kernel-parameters.txt         | 12 +++
>>  drivers/iommu/arm-smmu-v3.c                   | 89 +++++++++++++-----
>>  drivers/iommu/arm-smmu.c                      | 93 +++++++++++++------
>>  drivers/iommu/dma-iommu.c                     | 32 ++++++-
>>  drivers/iommu/io-pgtable-arm-v7s.c            | 11 ++-
>>  drivers/iommu/io-pgtable-arm.c                | 14 ++-
>>  drivers/iommu/io-pgtable.h                    |  5 +
>>  drivers/iommu/iommu.c                         | 23 +++++
>>  include/linux/iommu.h                         |  1 +
>>  9 files changed, 225 insertions(+), 55 deletions(-)
>>
> 
> 
