From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 0/5] add non-strict mode support for arm-smmu-v3
Date: Wed, 12 Sep 2018 18:12:57 +0100
Message-ID: <d0775377-206f-ae3e-051d-3b829b499471@arm.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
 <20180912165700.GC16071@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912165700.GC16071@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 12/09/18 17:57, Will Deacon wrote:
> Hi all,
> 
> On Wed, Aug 15, 2018 at 09:28:25AM +0800, Zhen Lei wrote:
>> v4 -> v5:
>> 1. change the type of global variable and struct member named "non_strict" from
>>     "int" to "bool".
>> 2. cancel the unnecessary parameter "strict" of __arm_lpae_unmap which was added
>>     in v4.
>> 3. change boot option "arm_iommu" to "iommu.non_strict".
>> 4. convert __iommu_dma_unmap to use iommu_unmap_fast()/iommu_tlb_sync(), because
>>     non-leaf unmaps still need to be synchronous.
>>
>> Thanks for Robin's review comments.
> 
> Since this is 90% of the way there now, I suggest Robin picks up what's here
> and incorporates his remaining review comments directly (especially since it
> sounded like Zhen Lei hasn't got much free time lately). With that, I can
> queue this lot via my smmu branch, which already has some stuff queued
> for SMMUv3 and io-pgtable.
> 
> Please shout if you have any objections, but I'm keen for this not to
> languish on the lists given how close it is!

Sure, having got this far I'd like to see it get done too. I'll make 
some time and give it a go.

Robin.
