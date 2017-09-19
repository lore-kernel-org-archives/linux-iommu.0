From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v2 0/3] arm-smmu: performance optimization
Date: Tue, 19 Sep 2017 14:26:53 +0800
Message-ID: <59C0B8AD.4010201@huawei.com>
References: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
 <6b051916-c49f-f9d0-81d8-05f857e4672e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b051916-c49f-f9d0-81d8-05f857e4672e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nate Watterson <nwatters@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jinyue Li <lijinyue@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Libin <huawei.libin@huawei.com>, Hanjun Guo <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org



On 2017/9/19 12:31, Nate Watterson wrote:
> Hi Leizhen,
> 
> On 9/12/2017 9:00 AM, Zhen Lei wrote:
>> v1 -> v2:
>> base on (add02cfdc9bc2 "iommu: Introduce Interface for IOMMU TLB Flushing")
>>
>> Zhen Lei (3):
>>    iommu/arm-smmu-v3: put off the execution of TLBI* to reduce lock
>>      confliction
>>    iommu/arm-smmu-v3: add support for unmap an iova range with only one
>>      tlb sync
> 
> I tested these (2) patches on QDF2400 hardware and saw performance
> improvements in line with those I reported when testing the original
> series. I don't have any hardware close at hand to test the 3rd patch
> in the series so that will have to come from someone else.
Thanks a lot.

> 
> Tested-by: Nate Watterson <nwatters@codeaurora.org>
> 
> Thanks,
> Nate
> 
>>    iommu/arm-smmu: add support for unmap a memory range with only one tlb
>>      sync
>>
>>   drivers/iommu/arm-smmu-v3.c        | 52 ++++++++++++++++++++++++++++++++++----
>>   drivers/iommu/arm-smmu.c           | 10 ++++++++
>>   drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++--------
>>   drivers/iommu/io-pgtable-arm.c     | 30 ++++++++++++++--------
>>   drivers/iommu/io-pgtable.h         |  1 +
>>   5 files changed, 99 insertions(+), 26 deletions(-)
>>
> 

-- 
Thanks!
BestRegards
