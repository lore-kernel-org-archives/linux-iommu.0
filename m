From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 05 Jun 2014 11:42:12 +0200
Message-ID: <6794037.0YTCc6JFQV@wuerfel>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
	<4830064.JvgTAs8Xty@wuerfel> <20140604213159.GB18780@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140604213159.GB18780@mithrandir>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wednesday 04 June 2014 23:32:00 Thierry Reding wrote:
> On Fri, May 30, 2014 at 09:01:19PM +0200, Arnd Bergmann wrote:
> > On Friday 30 May 2014 12:22:32 Dave Martin wrote:
> > > > +
> > > > +Examples:
> > > > +=========
> > > > +
> > > > +Single-master IOMMU:
> > > > +--------------------
> > > > +
> > > > + iommu {
> > > > +         #address-cells = <0>;
> > > > +         #size-cells = <0>;
> > > > + };
> > > > +
> > > > + master {
> > > > +         iommus = <&/iommu>;
> > > > + };
> > > > +
> > > > +Multiple-master IOMMU with fixed associations:
> > > > +----------------------------------------------
> > > > +
> > > > + /* multiple-master IOMMU */
> > > > + iommu {
> > > > +         /*
> > > > +          * Masters are statically associated with this IOMMU and
> > > > +          * address translation is always enabled.
> > > > +          */
> > > > +         #address-cells = <0>;
> > > > +         #size-cells = <0>;
> > > 
> > > In this example, can different translations be set up for the different
> > > masters?
> > > 
> > > With no cells available to contain any sort of ID, it looks like this
> > > is not possible.
> > 
> > Correct, this example is for an IOMMU that does not use IDs but has a
> > shared address space for all devices.
> 
> Couldn't these device all still have separate address spaces?

No. If they had separate address spaces, they would require a more
sophisticated IOMMU. A simple IOMMU without IDs can only be used
for overcoming address space limits (e.g. for 32-bit DMA masters on
systems with more than 4GB RAM) but not for strict isolation.

You basically have one page table shared across all devices connected
to the IOMMU, and every call to dma_alloc_coherent or dma_map_*
allocates a new IOVA that isn't used by any of the other devices
already, but you can't prevent a malicious user from getting a device
to do DMA to an IOVA that has been set up for another device.

You could have one such IOMMU per device of course, but I guess that's
not what you mean.

	Arnd
