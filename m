From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Fri, 16 Sep 2016 15:09:29 +0300
Message-ID: <5489283.7nVYvaYEH8@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se> <2210422.ogrYIr1eQU@avalon> <2277430.yNKNTgNkoj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2277430.yNKNTgNkoj@wuerfel>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk, hch@infradead.org, dan.j.williams@intel.com, robin.murphy@arm.com, linus.walleij@linaro.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On Friday 16 Sep 2016 14:02:35 Arnd Bergmann wrote:
> On Friday, September 16, 2016 12:48:23 PM CEST Laurent Pinchart wrote=
:
> > On Friday 16 Sep 2016 11:07:48 Arnd Bergmann wrote:
> >> On Thursday, September 15, 2016 9:56:51 PM CEST Vinod Koul wrote:
> >>> On Wed, Aug 10, 2016 at 11:07:10PM +0530, Vinod Koul wrote:
> >>>> On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas S=F6derlund wro=
te:
> >>
> >> I had not looked at the series earlier, but this version looks ent=
irely
> >> reasonable to me, so
> >>=20
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>=20
> >>=20
> >> One concern I have is that we might get an awkward situation if we=
 ever
> >> encounter one DMA engine hardware that is used in different system=
s that
> >> all have an IOMMU, but on some of them the connection between the =
DMA
> >> master and the slave FIFO bypasses the IOMMU while on others the I=
OMMU
> >> is required.
> >
> > Do you mean systems where some of the channels of a specific DMA en=
gine go
> > through the IOMMU while others do not ? We indeed have no solution =
today
> > for such a situation.
>=20
> I wasn't thinking quite that far, though that is also a theoretical
> problem. However, the simple solution would be to have a bit in the D=
MA
> specifier let the driver know whether translation is needed or not.
>=20
> The simpler case I was thinking of is where the entire DMA engine
> either goes through an IOMMU or doesn't (depending on the integration=

> into the SoC), so we'd have to find out through some DT property
> or compatible string in the DMA enginen driver.

Don't we already get that information from the iommus DT property ? If =
the DMA=20
engine goes through an IOMMU the property will be set, otherwise it wil=
l not.

> > The problem is a bit broader than that, we'll also have an issue wi=
th DMA
> > engines that have different channels served by different IOMMUs.
>=20
> Do you mean a theoretical problem, or a chip that you already know ex=
ists?

That's theoretical. The problem I'm facing today is a DMA engine whose=20=

channels are served by different ports of the same IOMMU. This works in=
 a=20
suboptimal way because I have to keep all the IOMMU ports enabled regar=
dless=20
of whether they're used or not, as the DMA engine and IOMMU APIs don't =
carry=20
channel information.

> > I recall discussing this in the past with you, and the solution you=

> > proposed was to add a channel index to struct dma_attrs seems good =
to me.
> > To support the case where some channels don't go through an IOMMU w=
e would
> > only need support for null entries in the IOMMUs list associated wi=
th a
> > device (for instance in the DT case null entries in the iommus prop=
erty).
> >=20
> > Now I see that struct dma_attrs has been replaced by unsigned long =
in
> >=20
> > commit 00085f1efa387a8ce100e3734920f7639c80caa3
> > Author: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Date:   Wed Aug 3 13:46:00 2016 -0700
> >=20
> >     dma-mapping: use unsigned long for dma_attrs
> >=20
> > We still have enough bits to reserve some of them for a channel num=
ber,
> > but I'm not very happy with that patch as I can see how a future pr=
oposal
> > to handle the channel number through the DMA attributes will get re=
jected
> > on the grounds of bits starvation then :-(
>=20
> Agreed, that can become interesting.

Does the above-mentioned patch really fix a performance, memory consump=
tion or=20
other issue ?

--=20
Regards,

Laurent Pinchart
