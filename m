From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/rockchip: Perform a reset on shutdown
Date: Thu, 15 Mar 2018 15:12:10 +0100
Message-ID: <20180315141210.yb6c6tbzietiuty3@8bytes.org>
References: <20180220202504.19275-1-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180220202504.19275-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 20, 2018 at 08:25:04PM +0000, Marc Zyngier wrote:
> Trying to do a kexec whilst the iommus are still on is proving to be
> a challenging exercise. It is terribly unsafe, as we're reusing the
> memory allocated for the page tables, leading to a likely crash.
> 
> Let's implement a shutdown method that will at least try to stop
> DMA from going crazy behind our back. Note that we need to be
> extra cautious when doing so, as the IOMMU may not be clocked
> if controlled by a another master, as typical on Rockchip system.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied, thanks.
