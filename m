From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCHv7 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
Date: Thu, 2 Jun 2016 22:17:11 +0530
Message-ID: <20160602164711.GS16910@localhost>
References: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160601180610.GV16910@localhost>
 <20160602125807.GN8307@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160602125807.GN8307@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: hch@infradead.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, dan.j.williams@intel.com, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org, arnd@arndb.de
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 02, 2016 at 02:58:07PM +0200, Niklas S=F6derlund wrote:
> Hi Vinod,
>=20
> On 2016-06-01 23:36:11 +0530, Vinod Koul wrote:
> > On Wed, Jun 01, 2016 at 05:22:23PM +0200, Niklas S=F6derlund wrote:
> > > Hi,
> > >=20
> > > [In this v7 series I have tried to address the questions raised b=
y Christoph=20
> > > Hellwig and I hope it can awnser your concernes regarding dma-deb=
ug.]
> > >=20
> > > This series tries to solve the problem with DMA with device regis=
ters
> > > (MMIO registers) that are behind an IOMMU for the rcar-dmac drive=
r. A
> > > recent patch '9575632 (dmaengine: make slave address physical)'
> > > clarifies that DMA slave address provided by clients is the physi=
cal
> > > address. This puts the task of mapping the DMA slave address from=
 a
> > > phys_addr_t to a dma_addr_t on the DMA engine.
> > >=20
> > > Without an IOMMU this is easy since the phys_addr_t and dma_addr_=
t are
> > > the same and no special care is needed. However if you have a IOM=
MU you
> > > need to map the DMA slave phys_addr_t to a dma_addr_t using somet=
hing
> > > like this.
> > >=20
> > > This series is based on top of v4.7-rc1.
> >=20
> > The dmanegine bits looks okay to me. Btw how is the merge planned f=
or this?
> > Do you wnat this to be merged thru dmaengine tree or something else=
?
>=20
> Yes, since the arm specific patch are depending on other parts of the=
=20
> series I was hoping to be able to get Russells Ack on it and then try=
 to=20
> get it all in through the dmaengine tree.

Sounds good to me..

> If you see a better way I'm happy to do it that way, let me know what=
=20
> you think. I hold off v8 that adresses the issues Russell brought up =
a=20
> few days untill I know what you think is best.

--=20
~Vinod
