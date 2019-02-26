From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH RFC 1/1] iommu: set the default iommu-dma mode as
 non-strict
Date: Tue, 26 Feb 2019 20:36:14 +0800
Message-ID: <dc06dfd0-0ab6-6f0b-64c6-2587a2a55798@huawei.com>
References: <20190131135211.6732-1-thunder.leizhen@huawei.com>
 <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94b9b0c9-1a24-63ba-5abe-5f6d79fed415@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Zhen Lei <thunder.leizhen@huawei.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Chengchuanning (Hisi-Turing)" <chengchuanning@hisilicon.com>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On 2019/1/31 22:55, Jean-Philippe Brucker wrote:
> Hi,
> 
> On 31/01/2019 13:52, Zhen Lei wrote:
>> Currently, many peripherals are faster than before. For example, the top
>> speed of the older netcard is 10Gb/s, and now it's more than 25Gb/s. But
>> when iommu page-table mapping enabled, it's hard to reach the top speed
>> in strict mode, because of frequently map and unmap operations. In order
>> to keep abreast of the times, I think it's better to set non-strict as
>> default.
> 
> Most users won't be aware of this relaxation and will have their system
> vulnerable to e.g. thunderbolt hotplug. See for example 4.3 Deferred
> Invalidation in
> http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/2018/MSC/MSC-2018-21.pdf
> 
> Why not keep the policy to secure by default, as we do for
> iommu.passthrough? And maybe add something similar to
> CONFIG_IOMMU_DEFAULT_PASSTRHOUGH? It's easy enough for experts to pass a
> command-line argument or change the default config.

Sorry for the late reply, it was Chinese new year, and we had a long discussion
internally, we are fine to add a Kconfig but not sure OS vendors will set it
to default y.

OS vendors seems not happy to pass a command-line argument, to be honest,
this is our motivation to enable non-strict as default. Hope OS vendors
can see this email thread, and give some input here.

Thanks
Hanjun
