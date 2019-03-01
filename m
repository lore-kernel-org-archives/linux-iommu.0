From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as
 non-strict
Date: Fri, 1 Mar 2019 12:44:12 +0800
Message-ID: <5C78B89C.7040100@huawei.com>
References: <20190131135211.6732-1-thunder.leizhen@huawei.com>
 <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
 <dc06dfd0-0ab6-6f0b-64c6-2587a2a55798@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc06dfd0-0ab6-6f0b-64c6-2587a2a55798@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Chengchuanning (Hisi-Turing)" <chengchuanning@hisilicon.com>
List-Id: iommu@lists.linux-foundation.org



On 2019/2/26 20:36, Hanjun Guo wrote:
> Hi Jean,
> 
> On 2019/1/31 22:55, Jean-Philippe Brucker wrote:
>> Hi,
>>
>> On 31/01/2019 13:52, Zhen Lei wrote:
>>> Currently, many peripherals are faster than before. For example, the top
>>> speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
>>> when iommu page-table mapping enabled, it's hard to reach the top speed
>>> in strict mode, because of frequently map and unmap operations. In order
>>> to keep abreast of the times, I think it's better to set non-strict as
>>> default.
>>
>> Most users won't be aware of this relaxation and will have their system
>> vulnerable to e.g. thunderbolt hotplug. See for example 4.3 Deferred
>> Invalidation in
>> http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/2018/MSC/MSC-2018-21.pdf
Hi Jean,

   In fact, we have discussed the vulnerable of deferred invalidation before upstream
the non-strict patches. The attacks maybe possible because of an untrusted device or
the mistake of the device driver. And we limited the VFIO to still use strict mode.
   As mentioned in the pdf, limit the freed memory with deferred invalidation only to
be reused by the device, can mitigate the vulnerability. But it's too hard to implement
it now.
   A compromise maybe we only apply non-strict to (1) dma_free_coherent, because the
memory is controlled by DMA common module, so we can make the memory to be freed after
the global invalidation in the timer handler. (2) And provide some new APIs related to
iommu_unmap_page/sg, these new APIs deferred invalidation. And the candiate device
drivers update the APIs if they want to improve performance. (3) Make sure that only
the trusted devices and trusted drivers can apply (1) and (2). For example, the driver
must be built into kernel Image.
   So that some high-end trusted devices use non-strict mode, and keep others still using
strict mode. The drivers who want to use non-strict mode, should change to use new APIs
by themselves.


>>
>> Why not keep the policy to secure by default, as we do for
>> iommu.passthrough? And maybe add something similar to
>> CONFIG_IOMMU_DEFAULT_PASSTRHOUGH? It's easy enough for experts to pass a
>> command-line argument or change the default config.
> 
> Sorry for the late reply, it was Chinese new year, and we had a long discussion
> internally, we are fine to add a Kconfig but not sure OS vendors will set it
> to default y.
> 
> OS vendors seems not happy to pass a command-line argument, to be honest,
> this is our motivation to enable non-strict as default. Hope OS vendors
> can see this email thread, and give some input here.
> 
> Thanks
> Hanjun
> 
> 
> .
> 

-- 
Thanks!
BestRegards
