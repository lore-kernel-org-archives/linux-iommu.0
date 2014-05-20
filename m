From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 20 May 2014 22:40:50 +0200
Message-ID: <4511166.2tFHJMxbnG@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<20140520152659.GA30404@arm.com>
	<20140520163912.GC5041@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140520163912.GC5041-M5GwZQ6tE7x5pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 20 May 2014 17:39:12 Dave Martin wrote:
> On Tue, May 20, 2014 at 04:26:59PM +0100, Will Deacon wrote:
> > On Tue, May 20, 2014 at 02:23:47PM +0100, Arnd Bergmann wrote:
> > > 	Bit#   33222222 22221111 11111100 00000000
> > > 	       10987654 32109876 54321098 76543210
> > > phys.hi cell:  npt000ss bbbbbbbb dddddfff rrrrrrrr
> > > phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
> > > phys.lo cell:  llllllll llllllll llllllll llllllll
> > > 
> > > where:
> > > n is 0 if the address is relocatable, 1 otherwise
> > > p is 1 if the addressable region is "prefetchable", 0 otherwise
> > > t is 1 if the address is aliased (for non-relocatable I/O),
> > >  below 1 MB (for Memory), or below 64 KB (for relocatable I/O).
> > > ss is the space code, denoting the address space
> > > bbbbbbbb is the 8-bit Bus Number
> > > ddddd is the 5-bit Device Number
> > > fff is the 3-bit Function Number
> > > rrrrrrrr is the 8-bit Register Number
> > > hh...hh is a 32-bit unsigned number
> > > ll...ll is a 32-bit unsigned number
> > > 
> > > We can ignore n, p, t and r here, and use the same format for a DMA
> > > address, then define an empty "dma-ranges" property. That would
> > > imply that using b/d/f is sufficient to identify each master at the
> > > iommu. Any device outside of the PCI host but connected to the same
> > > iommu can use the same notation to list the logical b/d/f that gets
> > > sent to the IOMMU in bus master transactions.
> > > 
> > > Do you think this is sufficient for the ARM SMMU, or do we need
> > > something beyond that?
> > 
> > I think it can define the common-cases for the existing implementations,
> > yes. I anticipate Stream-IDs becoming > 16-bit in the near future though,
> > so we'd need extra bits if we're describing other devices coming into the
> > SMMU.
> > 
> > Note that we already have a binding for the current SMMU driver, so I'm not
> > really in a position to shift over to a new binding until the next version of
> > the SMMU architecture comes along...
> 
> How much code relies on the meaning of the nptsbdf bits?

Not much at all, I think this was defined mostly for open firmware
client interfaces, which we don't use with FDT.

n, t and r are probably only used in PCI functions that are listed
in DT, not in the host bridge.

b/d/f I think is mostly used for the interrupt-maps property, when
describing hardwired interrupts.

p and s are used when setting up the translation for inbound MMIO
and PIO.

	Arnd
