From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 21 May 2014 18:09:54 +0100
Message-ID: <20140521170954.GC3830@e103592.cambridge.arm.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<5612206.Fzsy1mf3q3@wuerfel> <20140521082606.GB11068@ulmo>
	<4367469.BqpJyVF8PT@wuerfel> <20140521090037.GA19268@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140521090037.GA19268@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 21, 2014 at 11:00:38AM +0200, Thierry Reding wrote:
> On Wed, May 21, 2014 at 10:50:38AM +0200, Arnd Bergmann wrote:
> > On Wednesday 21 May 2014 10:26:11 Thierry Reding wrote:
> > > On Tue, May 20, 2014 at 10:26:12PM +0200, Arnd Bergmann wrote:
> > > > On Tuesday 20 May 2014 16:24:59 Dave Martin wrote:
> > > > > On Tue, May 20, 2014 at 02:41:18PM +0200, Arnd Bergmann wrote:
> > > > > > On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
> > > [...]
> > > > > > > Multiple-master IOMMU:
> > > > > > > ----------------------
> > > > > > > 
> > > > > > > 	iommu {
> > > > > > > 		/* the specifier represents the ID of the master */
> > > > > > > 		#address-cells = <1>;
> > > > > > > 		#size-cells = <0>;
> > > > > 
> > > > > How do we know the size of the input address to the IOMMU?  Do we
> > > > > get cases for example where the IOMMU only accepts a 32-bit input
> > > > > address, but some 64-bit capable masters are connected through it?
> > > > 
> > > > I was stuck on this question for a while before, but then I realized
> > > > that it doesn't matter at all: It's the IOMMU driver itself that
> > > > manages the address space, and it doesn't matter if a slave can
> > > > address a larger range than the IOMMU can accept. If the IOMMU
> > > > needs to deal with the opposite case (64-bit input addresses
> > > > but a 32-bit master), that limitation can be put into the specifier.
> > > 
> > > Isn't this what DMA masks are for? Couldn't the IOMMU simply use the
> > > master device's DMA mask to do the right thing here?
> > 
> > Ah, yes. I guess that's the right way to do it.
> > 
> > > > > For determining dma masks, it is the output address that it
> > > > > important.  Santosh's code can probably be taught to handle this,
> > > > > if given an additional traversal rule for following "iommus"
> > > > > properties.  However, deploying an IOMMU whose output address size
> > > > > is smaller than the 
> > > > 
> > > > Something seems to be missing here. I don't think we want to handle
> > > > the case where the IOMMU output cannot the entire memory address
> > > > space. If necessary, that would mean using both an IOMMU driver
> > > > and swiotlb, but I think it's a reasonable assumption that hardware
> > > > isn't /that/ crazy.
> > > 
> > > Similarily, should the IOMMU not be treated like any other device here?
> > > Its DMA mask should determine what address range it can access.
> > 
> > Right. But for that we need a dma-ranges property in the parent of the
> > iommu, just so the mask can be set correctly and we don't have to
> > rely on the 32-bit fallback case.
> 
> Shouldn't the IOMMU driver be the one to set the DMA mask for the device
> in exactly the same way that other drivers override the 32-bit default?
> 

Are we confusing the "next-hop DMA mask" with the "end-to-end DMA mask"
here?  The device has a next-hop mask which may be non-trivial.  The
IOMMU also has a next-hop mask and/or remapping, but I think we agree
that in sensible systems that will be trivial.  There might be other
non-trivial remappings between the IOMMU and memory (but again, not
in the common case).

If we just use the same name for all these, we are liable to get
confused.

To answer the question "what memory can the kernel allocate for DMA
with this device", it is the end-to-end transformation that is
important.

Cheers
---Dave
