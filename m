From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Fri, 16 Sep 2016 12:48:23 +0300
Message-ID: <2210422.ogrYIr1eQU@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se> <20160915162650.GZ13920@localhost> <3152956.IVRykDnfF6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <3152956.IVRykDnfF6@wuerfel>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk, hch@infradead.org, dan.j.williams@intel.com, robin.murphy@arm.com, linus.walleij@linaro.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On Friday 16 Sep 2016 11:07:48 Arnd Bergmann wrote:
> On Thursday, September 15, 2016 9:56:51 PM CEST Vinod Koul wrote:
> > On Wed, Aug 10, 2016 at 11:07:10PM +0530, Vinod Koul wrote:
> >> On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas S=F6derlund wrote=
:
> >>> Hi,
> >>>=20
> >>> This series tries to solve the problem with DMA with device regis=
ters
> >>> (MMIO registers) that are behind an IOMMU for the rcar-dmac drive=
r. A
> >>> recent patch '9575632 (dmaengine: make slave address physical)'
> >>> clarifies that DMA slave address provided by clients is the physi=
cal
> >>> address. This puts the task of mapping the DMA slave address from=
 a
> >>> phys_addr_t to a dma_addr_t on the DMA engine.
> >>>=20
> >>> Without an IOMMU this is easy since the phys_addr_t and dma_addr_=
t are
> >>> the same and no special care is needed. However if you have a IOM=
MU
> >>> you need to map the DMA slave phys_addr_t to a dma_addr_t using
> >>> something like this.
> >>>=20
> >>> This series is based on top of v4.8-rc1. And I'm hoping to be abl=
e to
> >>> collect a Ack from Russell King on patch 4/6 that adds the ARM
> >>> specific part and then be able to take the whole series through t=
he
> >>> dmaengine tree. If this is not the best route I'm more then happy=
 to
> >>> do it another way.
> >>>=20
> >>> It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling t=
he
> >>> ipmmu_ds node in r8a7791.dtsi. I verified operation by interactin=
g
> >>> with /dev/mmcblk1, i2c and the serial console which are devices b=
ehind
> >>> the iommu.
> >>=20
> >> As I said in last one, the dmaengine parts look fine to me. But to=
 go
> >> thru dmaengine tree I would need ACK on non dmaengine patches.
> >=20
> > I havent heard back from this one and I am inclined to merge this o=
ne now.
> > If anyone has any objects, please speak up now...
> >=20
> > Also ACKs welcome...
>=20
> I had not looked at the series earlier, but this version looks entire=
ly
> reasonable to me, so
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
>=20
> One concern I have is that we might get an awkward situation if we ev=
er
> encounter one DMA engine hardware that is used in different systems t=
hat all
> have an IOMMU, but on some of them the connection between the DMA mas=
ter and
> the slave FIFO bypasses the IOMMU while on others the IOMMU is requir=
ed.

Do you mean systems where some of the channels of a specific DMA engine=
 go=20
through the IOMMU while others do not ? We indeed have no solution toda=
y for=20
such a situation.

The problem is a bit broader than that, we'll also have an issue with D=
MA=20
engines that have different channels served by different IOMMUs. I reca=
ll=20
discussing this in the past with you, and the solution you proposed was=
 to add=20
a channel index to struct dma_attrs seems good to me. To support the ca=
se=20
where some channels don't go through an IOMMU we would only need suppor=
t for=20
null entries in the IOMMUs list associated with a device (for instance =
in the=20
DT case null entries in the iommus property).

Now I see that struct dma_attrs has been replaced by unsigned long in

commit 00085f1efa387a8ce100e3734920f7639c80caa3
Author: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date:   Wed Aug 3 13:46:00 2016 -0700

    dma-mapping: use unsigned long for dma_attrs

We still have enough bits to reserve some of them for a channel number,=
 but=20
I'm not very happy with that patch as I can see how a future proposal t=
o=20
handle the channel number through the DMA attributes will get rejected =
on the=20
grounds of bits starvation then :-(

> I don't have any idea for how this could be handled in a generic way,=
 so my
> best answer here is to hope we never get there, and if we do, handle =
it
> using some local hack in the driver.

--=20
Regards,

Laurent Pinchart
