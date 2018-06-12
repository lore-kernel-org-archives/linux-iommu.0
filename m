From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v2 0/5] add non-strict mode support for arm-smmu-v3
Date: Tue, 12 Jun 2018 20:35:40 +0800
Message-ID: <5B1FBE1C.3060205@huawei.com>
References: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
 <d6f46de0-f8c3-2c9e-4de3-5949db0cf7b5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d6f46de0-f8c3-2c9e-4de3-5949db0cf7b5@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Xinwei Hu <huxinwei@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Guozhu Li <liguozhu@hisilicon.com>, Libin <huawei.libin@huawei.com>
List-Id: iommu@lists.linux-foundation.org



On 2018/6/11 19:05, Jean-Philippe Brucker wrote:
> Hi Zhen Lei,
> 
> On 10/06/18 12:07, Zhen Lei wrote:
>> v1 -> v2:
>> Use the lowest bit of the io_pgtable_ops.unmap's iova parameter to pass the strict mode:
>> 0, IOMMU_STRICT;
>> 1, IOMMU_NON_STRICT;
>> Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
>> other IOMMUs which still use strict mode. In other words, this patch series
>> will not impact other IOMMU drivers. I tried add a new quirk IO_PGTABLE_QUIRK_NON_STRICT
>> in io_pgtable_cfg.quirks, but it can not pass the strict mode of the domain from SMMUv3
>> driver to io-pgtable module. 
>>
>> Add a new member domain_non_strict in struct iommu_dma_cookie, this member will only be
>> initialized when the related domain and IOMMU driver support non-strict mode.
> 
> It's not obvious from the commit messages or comments what the
> non-strict mode involves exactly. Could you add a description, and point
> out the trade-off associated with it?

Sorry, I described it in V1, but remove it in V2.
https://lkml.org/lkml/2018/5/31/131

> 
> In this mode you don't send an invalidate commands when removing a leaf
> entry, but instead send invalidate-all commands at regular interval.
> This improves performance but introduces a vulnerability window, which
> should be pointed out to users.
> 
> IOVA allocation isn't the only problem, I'm concerned about the page
> allocator. If unmap() returns early, the TLB entry is still valid after
> the kernel reallocate the page. The device can then perform a
> use-after-free (instead of getting a translation fault), so a buggy
> device will corrupt memory and an untrusted one will access arbitrary data.

I have constrained VFIO to still use strict mode, so all other devices will only
access memory in the kernel state, these related drivers are unlikely to attack
kernel. The devices as part of the commercial product, the probability of such a
bug is very low, at least the bug will not be reserved for the purpose of the
attack. But the attackers may replace it as illegal devices on the spot.

Take a step back, IOMMU disabled is also supported, non-strict mode is better
than disabled. So maybe we should add a boot option, allowing the admin choose
which mode to be used.


> 
> Or is there a way in mm to ensure that the page isn't reallocated until
> the invalidation succeeds? Could dma-iommu help with this? Having

It's too hard. In some cases the memory is allocated by non dma-iommu API.

> support from the mm would also help consolidate ATS, mark a page stale
> when an ATC invalidation times out. But last time I checked it seemed
> quite difficult to implement, and ATS is inherently insecure so I didn't
> bother.
> 
> At the very least I think it might be worth warning users in dmesg about
> this pitfall (and add_taint?). Tell them that an IOMMU in this mode is
> good for scatter-gather performance but lacks full isolation. The
> "non-strict" name seems somewhat harmless, and people should know what
> they're getting into before enabling this.

Yes, warning or add comments in source code will be better.

> 
> Thanks,
> Jean
> 
> .
> 

-- 
Thanks!
BestRegards
