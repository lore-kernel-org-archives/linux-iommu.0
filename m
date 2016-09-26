From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
Date: Mon, 26 Sep 2016 22:17:22 +0530
Message-ID: <20160926164722.GB2467@localhost>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk, hch@infradead.org, dan.j.williams@intel.com, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org, arnd@arndb.de
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas Söderlund wrote:
> Hi,
> 
> This series tries to solve the problem with DMA with device registers
> (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> recent patch '9575632 (dmaengine: make slave address physical)'
> clarifies that DMA slave address provided by clients is the physical
> address. This puts the task of mapping the DMA slave address from a
> phys_addr_t to a dma_addr_t on the DMA engine.
> 
> Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
> the same and no special care is needed. However if you have a IOMMU you
> need to map the DMA slave phys_addr_t to a dma_addr_t using something
> like this.
> 
> This series is based on top of v4.8-rc1. And I'm hoping to be able to collect a
> Ack from Russell King on patch 4/6 that adds the ARM specific part and then be
> able to take the whole series through the dmaengine tree. If this is not the
> best route I'm more then happy to do it another way.
> 
> It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling the
> ipmmu_ds node in r8a7791.dtsi. I verified operation by interacting with
> /dev/mmcblk1, i2c and the serial console which are devices behind the
> iommu.
> 
> Furthermore I have audited to the best of my ability all call paths
> involved to make sure that the dma_addr_t obtained from
> dma_map_resource() to is not used in a way where it would be expected
> for the mapping to be RAM (have a struct page). Many thanks to Christoph
> Hellwig and Laurent Pinchart for there input in this effort.

Applied, thanks

-- 
~Vinod
