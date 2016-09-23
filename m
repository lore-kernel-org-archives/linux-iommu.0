From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
	transfers
Date: Fri, 23 Sep 2016 09:25:00 +0200
Message-ID: <20160923072459.GJ19172@bigcity.dyn.berto.se>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
	<20160810173710.GK9681@localhost>
	<20160915162650.GZ13920@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160915162650.GZ13920@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Vinod,

On 2016-09-15 21:56:51 +0530, Vinod Koul wrote:
> On Wed, Aug 10, 2016 at 11:07:10PM +0530, Vinod Koul wrote:
> > On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas S=F6derlund wrote:
> > > Hi,
> > > =

> > > This series tries to solve the problem with DMA with device registers
> > > (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> > > recent patch '9575632 (dmaengine: make slave address physical)'
> > > clarifies that DMA slave address provided by clients is the physical
> > > address. This puts the task of mapping the DMA slave address from a
> > > phys_addr_t to a dma_addr_t on the DMA engine.
> > > =

> > > Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
> > > the same and no special care is needed. However if you have a IOMMU y=
ou
> > > need to map the DMA slave phys_addr_t to a dma_addr_t using something
> > > like this.
> > > =

> > > This series is based on top of v4.8-rc1. And I'm hoping to be able to=
 collect a
> > > Ack from Russell King on patch 4/6 that adds the ARM specific part an=
d then be
> > > able to take the whole series through the dmaengine tree. If this is =
not the
> > > best route I'm more then happy to do it another way.
> > > =

> > > It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling the
> > > ipmmu_ds node in r8a7791.dtsi. I verified operation by interacting wi=
th
> > > /dev/mmcblk1, i2c and the serial console which are devices behind the
> > > iommu.
> > =

> > As I said in last one, the dmaengine parts look fine to me. But to go t=
hru
> > dmaengine tree I would need ACK on non dmaengine patches.
> =

> I havent heard back from this one and I am inclined to merge this one now.
> If anyone has any objects, please speak up now...

I'm just curios, do you plan to merge this series with Arnds Ack? If not =

is there anything I can do to help move the series in the right =

direction?

> =

> Also ACKs welcome...
> =


-- =

Regards,
Niklas S=F6derlund
