From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 00/13] iommu/rockchip: Use OF_IOMMU
Date: Thu, 18 Jan 2018 13:44:03 +0100
Message-ID: <20180118124403.GX28161@8bytes.org>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 18, 2018 at 07:52:38PM +0800, Jeffy Chen wrote:
> Jeffy Chen (9):
>   iommu/rockchip: Prohibit unbind and remove
>   iommu/rockchip: Fix error handling in probe
>   iommu/rockchip: Request irqs in rk_iommu_probe()
>   ARM: dts: rockchip: add clocks in vop iommu nodes
>   iommu/rockchip: Use IOMMU device for dma mapping operations
>   iommu/rockchip: Use OF_IOMMU to attach devices automatically
>   iommu/rockchip: Fix error handling in init
>   iommu/rockchip: Add runtime PM support
>   iommu/rockchip: Support sharing IOMMU between masters
> 
> Tomasz Figa (4):
>   iommu/rockchip: Fix error handling in attach
>   iommu/rockchip: Use iopoll helpers to wait for hardware
>   iommu/rockchip: Fix TLB flush of secondary IOMMUs
>   iommu/rockchip: Control clocks needed to access the IOMMU

Please stop resending this every day with minimal changes. I am not
going to take it for v4.16, as we are late in the cycle already and there
are still review comments.

Just collect all feedback, update the patches, rebase them to v4.16-rc1
when its out, and send a new version.


	Joerg
