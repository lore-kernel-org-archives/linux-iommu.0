From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
Date: Fri, 16 Sep 2016 14:02:35 +0200
Message-ID: <2277430.yNKNTgNkoj@wuerfel>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
 <3152956.IVRykDnfF6@wuerfel> <2210422.ogrYIr1eQU@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2210422.ogrYIr1eQU@avalon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: hch@infradead.org, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Vinod Koul <vinod.koul@intel.com>, linus.walleij@linaro.org, linux@armlinux.org.uk, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, dmaengine@vger.kernel.org, dan.j.williams@intel.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Friday, September 16, 2016 12:48:23 PM CEST Laurent Pinchart wrote:
> On Friday 16 Sep 2016 11:07:48 Arnd Bergmann wrote:
> > On Thursday, September 15, 2016 9:56:51 PM CEST Vinod Koul wrote:
> > > On Wed, Aug 10, 2016 at 11:07:10PM +0530, Vinod Koul wrote:
> > >> On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas S=F6derlund wrote:
> > I had not looked at the series earlier, but this version looks entirely
> > reasonable to me, so
> > =

> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > =

> > =

> > One concern I have is that we might get an awkward situation if we ever
> > encounter one DMA engine hardware that is used in different systems tha=
t all
> > have an IOMMU, but on some of them the connection between the DMA maste=
r and
> > the slave FIFO bypasses the IOMMU while on others the IOMMU is required.
> =

> Do you mean systems where some of the channels of a specific DMA engine g=
o =

> through the IOMMU while others do not ? We indeed have no solution today =
for =

> such a situation.

I wasn't thinking quite that far, though that is also a theoretical
problem. However, the simple solution would be to have a bit in the DMA
specifier let the driver know whether translation is needed or not.

The simpler case I was thinking of is where the entire DMA engine
either goes through an IOMMU or doesn't (depending on the integration
into the SoC), so we'd have to find out through some DT property
or compatible string in the DMA enginen driver.

> The problem is a bit broader than that, we'll also have an issue with DMA =

> engines that have different channels served by different IOMMUs.

Do you mean a theoretical problem, or a chip that you already know exists?

> I recall =

> discussing this in the past with you, and the solution you proposed was t=
o add =

> a channel index to struct dma_attrs seems good to me. To support the case =

> where some channels don't go through an IOMMU we would only need support =
for =

> null entries in the IOMMUs list associated with a device (for instance in=
 the =

> DT case null entries in the iommus property).
> =

> Now I see that struct dma_attrs has been replaced by unsigned long in
> =

> commit 00085f1efa387a8ce100e3734920f7639c80caa3
> Author: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Date:   Wed Aug 3 13:46:00 2016 -0700
> =

>     dma-mapping: use unsigned long for dma_attrs
> =

> We still have enough bits to reserve some of them for a channel number, b=
ut =

> I'm not very happy with that patch as I can see how a future proposal to =

> handle the channel number through the DMA attributes will get rejected on=
 the =

> grounds of bits starvation then :-(

Agreed, that can become interesting.

	Arnd
