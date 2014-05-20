From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 20 May 2014 16:26:59 +0100
Message-ID: <20140520152659.GA30404@arm.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <5080348.QmhgfQRxZW@wuerfel>
 <20140520130659.GA5041@e103592.cambridge.arm.com>
 <6382280.3uMvoxaUSK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6382280.3uMvoxaUSK@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 20, 2014 at 02:23:47PM +0100, Arnd Bergmann wrote:
> 	Bit#   33222222 22221111 11111100 00000000
> 	       10987654 32109876 54321098 76543210
> phys.hi cell:  npt000ss bbbbbbbb dddddfff rrrrrrrr
> phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
> phys.lo cell:  llllllll llllllll llllllll llllllll
> 
> where:
> n is 0 if the address is relocatable, 1 otherwise
> p is 1 if the addressable region is "prefetchable", 0 otherwise
> t is 1 if the address is aliased (for non-relocatable I/O),
>  below 1 MB (for Memory), or below 64 KB (for relocatable I/O).
> ss is the space code, denoting the address space
> bbbbbbbb is the 8-bit Bus Number
> ddddd is the 5-bit Device Number
> fff is the 3-bit Function Number
> rrrrrrrr is the 8-bit Register Number
> hh...hh is a 32-bit unsigned number
> ll...ll is a 32-bit unsigned number
> 
> We can ignore n, p, t and r here, and use the same format for a DMA
> address, then define an empty "dma-ranges" property. That would
> imply that using b/d/f is sufficient to identify each master at the
> iommu. Any device outside of the PCI host but connected to the same
> iommu can use the same notation to list the logical b/d/f that gets
> sent to the IOMMU in bus master transactions.
> 
> Do you think this is sufficient for the ARM SMMU, or do we need
> something beyond that?

I think it can define the common-cases for the existing implementations,
yes. I anticipate Stream-IDs becoming > 16-bit in the near future though,
so we'd need extra bits if we're describing other devices coming into the
SMMU.

Note that we already have a binding for the current SMMU driver, so I'm not
really in a position to shift over to a new binding until the next version of
the SMMU architecture comes along...

Will
