From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Fri, 16 Sep 2016 11:07:48 +0200
Message-ID: <3152956.IVRykDnfF6@wuerfel>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se> <20160810173710.GK9681@localhost> <20160915162650.GZ13920@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160915162650.GZ13920@localhost>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk, hch@infradead.org, dan.j.williams@intel.com, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org
List-Id: iommu@lists.linux-foundation.org

On Thursday, September 15, 2016 9:56:51 PM CEST Vinod Koul wrote:
> On Wed, Aug 10, 2016 at 11:07:10PM +0530, Vinod Koul wrote:
> > On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas Söderlund wrote:
> > > Hi,
> > > 
> > > This series tries to solve the problem with DMA with device registers
> > > (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> > > recent patch '9575632 (dmaengine: make slave address physical)'
> > > clarifies that DMA slave address provided by clients is the physical
> > > address. This puts the task of mapping the DMA slave address from a
> > > phys_addr_t to a dma_addr_t on the DMA engine.
> > > 
> > > Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
> > > the same and no special care is needed. However if you have a IOMMU you
> > > need to map the DMA slave phys_addr_t to a dma_addr_t using something
> > > like this.
> > > 
> > > This series is based on top of v4.8-rc1. And I'm hoping to be able to collect a
> > > Ack from Russell King on patch 4/6 that adds the ARM specific part and then be
> > > able to take the whole series through the dmaengine tree. If this is not the
> > > best route I'm more then happy to do it another way.
> > > 
> > > It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling the
> > > ipmmu_ds node in r8a7791.dtsi. I verified operation by interacting with
> > > /dev/mmcblk1, i2c and the serial console which are devices behind the
> > > iommu.
> > 
> > As I said in last one, the dmaengine parts look fine to me. But to go thru
> > dmaengine tree I would need ACK on non dmaengine patches.
> 
> I havent heard back from this one and I am inclined to merge this one now.
> If anyone has any objects, please speak up now...
> 
> Also ACKs welcome...
> 


I had not looked at the series earlier, but this version looks entirely
reasonable to me, so

Acked-by: Arnd Bergmann <arnd@arndb.de>


One concern I have is that we might get an awkward situation if we
ever encounter one DMA engine hardware that is used in different
systems that all have an IOMMU, but on some of them the connection
between the DMA master and the slave FIFO bypasses the IOMMU
while on others the IOMMU is required. I don't have any idea for
how this could be handled in a generic way, so my best answer
here is to hope we never get there, and if we do, handle it
using some local hack in the driver.

	Arnd
