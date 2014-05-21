From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 21 May 2014 11:36:32 +0200
Message-ID: <5371868.4QO1YJ0hU2@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<4367469.BqpJyVF8PT@wuerfel> <20140521090037.GA19268@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wednesday 21 May 2014 11:00:38 Thierry Reding wrote:
> On Wed, May 21, 2014 at 10:50:38AM +0200, Arnd Bergmann wrote:
> > On Wednesday 21 May 2014 10:26:11 Thierry Reding wrote:

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

The IOMMU driver could /ask/ for an appropriate mask based on its internal
design, but if you have an IOMMU with a 64-bit output address connected
to a 32-bit bus, that should fail.

Note that it's not obvious what the IOMMU's DMA mask actually means.
It clearly has to be the mask that is used for allocating the IO page
tables, but it wouldn't normally be used in the path that allocates
pages on behalf of a DMA master attached to the IOMMU, because that
allocation is performed by the code that looks at the other device's
dma mask.

	Arnd
