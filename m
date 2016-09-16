From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Fri, 16 Sep 2016 15:05:41 +0300
Message-ID: <1757972.L4qX7sAfEW@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se> <2210422.ogrYIr1eQU@avalon> <55e0ee95-fcbb-918a-da94-85f3aeb6ed37@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <55e0ee95-fcbb-918a-da94-85f3aeb6ed37@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk, hch@infradead.org, dan.j.williams@intel.com, linus.walleij@linaro.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Rubin,

On Friday 16 Sep 2016 11:36:29 Robin Murphy wrote:
> On 16/09/16 10:48, Laurent Pinchart wrote:
> > On Friday 16 Sep 2016 11:07:48 Arnd Bergmann wrote:
> >> On Thursday, September 15, 2016 9:56:51 PM CEST Vinod Koul wrote:
> >>> On Wed, Aug 10, 2016 at 11:07:10PM +0530, Vinod Koul wrote:
> >>>> On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas S=F6derlund wro=
te:
> >>>>> Hi,
> >>>>>=20
> >>>>> This series tries to solve the problem with DMA with device reg=
isters
> >>>>> (MMIO registers) that are behind an IOMMU for the rcar-dmac dri=
ver. A
> >>>>> recent patch '9575632 (dmaengine: make slave address physical)'=

> >>>>> clarifies that DMA slave address provided by clients is the phy=
sical
> >>>>> address. This puts the task of mapping the DMA slave address fr=
om a
> >>>>> phys_addr_t to a dma_addr_t on the DMA engine.
> >>>>>=20
> >>>>> Without an IOMMU this is easy since the phys_addr_t and dma_add=
r_t are
> >>>>> the same and no special care is needed. However if you have a I=
OMMU
> >>>>> you need to map the DMA slave phys_addr_t to a dma_addr_t using=

> >>>>> something like this.
> >>>>>=20
> >>>>> This series is based on top of v4.8-rc1. And I'm hoping to be a=
ble to
> >>>>> collect a Ack from Russell King on patch 4/6 that adds the ARM
> >>>>> specific part and then be able to take the whole series through=
 the
> >>>>> dmaengine tree. If this is not the best route I'm more then hap=
py to
> >>>>> do it another way.
> >>>>>=20
> >>>>> It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling=
 the
> >>>>> ipmmu_ds node in r8a7791.dtsi. I verified operation by interact=
ing
> >>>>> with /dev/mmcblk1, i2c and the serial console which are devices=
 behind
> >>>>> the iommu.
> >>>>=20
> >>>> As I said in last one, the dmaengine parts look fine to me. But =
to go
> >>>> thru dmaengine tree I would need ACK on non dmaengine patches.
> >>>=20
> >>> I havent heard back from this one and I am inclined to merge this=
 one
> >>> now. If anyone has any objects, please speak up now...
> >>>=20
> >>> Also ACKs welcome...
> >>=20
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
> >=20
> > The problem is a bit broader than that, we'll also have an issue wi=
th DMA
> > engines that have different channels served by different IOMMUs. I =
recall
> > discussing this in the past with you, and the solution you proposed=
 was to
> > add a channel index to struct dma_attrs seems good to me. To suppor=
t the
> > case where some channels don't go through an IOMMU we would only ne=
ed
> > support for null entries in the IOMMUs list associated with a devic=
e (for
> > instance in the DT case null entries in the iommus property).
>=20
> I think at that point we just create the channels as child devices of=

> the main dmaengine device so they each get their own DMA ops, and can=
 do
> whatever. The Qualcomm HIDMA driver already does that for a very simi=
lar
> reason (so that the IOMMU can map individual channels into different
> guest VMs).

That's another option, but it seems more like a workaround to me, inste=
ad of a=20
proper solution to fix the more global problem of multiple memory paths=
 within=20
a single device. I have other hardware devices that can act as bus mast=
ers=20
through different paths (for instance a display-related device that fet=
ches=20
data and commands through different paths). Luckily so far all those pa=
ths are=20
served by the same IOMMU, but there's no guarantee this will remain tru=
e in=20
the future. Furthermore, even today, the IOMMU connected to that device=
 has=20
the ability to selectively enable and disable its ports. I have to keep=
 them=20
all enabled due to the lack of channel information in the DMA mapping a=
nd=20
IOMMU APIs, leading to increased power consumption.

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
> >=20
> >> I don't have any idea for how this could be handled in a generic w=
ay, so
> >> my best answer here is to hope we never get there, and if we do, h=
andle
> >> it using some local hack in the driver.

--=20
Regards,

Laurent Pinchart
