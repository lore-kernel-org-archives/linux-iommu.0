From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4 00/13] iommu/rockchip: Use OF_IOMMU
Date: Thu, 18 Jan 2018 22:07:59 +0800
Message-ID: <5A60AA3F.6010801@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com> <20180118124403.GX28161@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180118124403.GX28161@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thanks for your reply.

On 01/18/2018 08:44 PM, Joerg Roedel wrote:
> On Thu, Jan 18, 2018 at 07:52:38PM +0800, Jeffy Chen wrote:
>> Jeffy Chen (9):
>>    iommu/rockchip: Prohibit unbind and remove
>>    iommu/rockchip: Fix error handling in probe
>>    iommu/rockchip: Request irqs in rk_iommu_probe()
>>    ARM: dts: rockchip: add clocks in vop iommu nodes
>>    iommu/rockchip: Use IOMMU device for dma mapping operations
>>    iommu/rockchip: Use OF_IOMMU to attach devices automatically
>>    iommu/rockchip: Fix error handling in init
>>    iommu/rockchip: Add runtime PM support
>>    iommu/rockchip: Support sharing IOMMU between masters
>>
>> Tomasz Figa (4):
>>    iommu/rockchip: Fix error handling in attach
>>    iommu/rockchip: Use iopoll helpers to wait for hardware
>>    iommu/rockchip: Fix TLB flush of secondary IOMMUs
>>    iommu/rockchip: Control clocks needed to access the IOMMU
>
> Please stop resending this every day with minimal changes. I am not
> going to take it for v4.16, as we are late in the cycle already and there
> are still review comments.
>
> Just collect all feedback, update the patches, rebase them to v4.16-rc1
> when its out, and send a new version.

oops, sorry, i send v4 today is mainly because i found v3 would break 
some of the rk platforms, which needs an extra patch [7] (ARM: dts: 
rockchip: add clocks in vop iommu nodes),  but forgot to mention it in 
the change log...

will send new version after all the rest patches been reviewed :)
>
>
> 	Joerg
>
>
>
