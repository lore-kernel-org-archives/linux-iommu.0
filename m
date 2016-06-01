From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCHv7 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
Date: Wed, 1 Jun 2016 23:36:11 +0530
Message-ID: <20160601180610.GV16910@localhost>
References: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: hch@infradead.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, dan.j.williams@intel.com, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org, arnd@arndb.de
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 01, 2016 at 05:22:23PM +0200, Niklas S=F6derlund wrote:
> Hi,
>=20
> [In this v7 series I have tried to address the questions raised by Ch=
ristoph=20
> Hellwig and I hope it can awnser your concernes regarding dma-debug.]
>=20
> This series tries to solve the problem with DMA with device registers
> (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> recent patch '9575632 (dmaengine: make slave address physical)'
> clarifies that DMA slave address provided by clients is the physical
> address. This puts the task of mapping the DMA slave address from a
> phys_addr_t to a dma_addr_t on the DMA engine.
>=20
> Without an IOMMU this is easy since the phys_addr_t and dma_addr_t ar=
e
> the same and no special care is needed. However if you have a IOMMU y=
ou
> need to map the DMA slave phys_addr_t to a dma_addr_t using something
> like this.
>=20
> This series is based on top of v4.7-rc1.

The dmanegine bits looks okay to me. Btw how is the merge planned for t=
his?
Do you wnat this to be merged thru dmaengine tree or something else?

--=20
~Vinod
