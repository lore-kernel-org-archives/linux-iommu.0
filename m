From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 11/11] arm: dma-mapping: Add support to extend DMA IOMMU
	mappings
Date: Thu, 30 Jan 2014 09:44:13 +0100
Message-ID: <20140130084413.GC13543@alberich>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-12-git-send-email-andreas.herrmann@calxeda.com>
	<52E8DE7D.5020801@samsung.com>
	<20140129110537.GG26622@mudshark.cambridge.arm.com>
	<20140129144017.GA13543@alberich> <52EA0D43.1010802@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52EA0D43.1010802-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 30, 2014 at 03:28:51AM -0500, Marek Szyprowski wrote:
> Hello,
> 
> On 2014-01-29 15:40, Andreas Herrmann wrote:
> > Hi Will, Marek,
> >
> > On Wed, Jan 29, 2014 at 06:05:37AM -0500, Will Deacon wrote:
> > > Hi Marek,
> > >
> > > On Wed, Jan 29, 2014 at 10:57:01AM +0000, Marek Szyprowski wrote:
> > > > On 2014-01-16 13:44, Andreas Herrmann wrote:
> > > > > Instead of using just one bitmap to keep track of IO virtual addresses
> > > > > (handed out for IOMMU use) introduce a list of iova_ranges (each
> > > > > having its own bitmap). This allows us to extend existing mappings
> > > > > when running out of iova space for a mapping.
> > > > >
> > > > > If there is not enough space in the mapping to service an IO virtual
> > > > > address allocation request, __alloc_iova() tries to extend the mapping
> > > > > -- by allocating another bitmap -- and makes another allocation
> > > > > attempt using the freshly allocated bitmap.
> > > > >
> > > > > This allows arm iommu drivers to start with a decent initial size when
> > > > > an dma_iommu_mapping is created and still to avoid running out of IO
> > > > > virtual addresses for the mapping.
> > > > >
> > > > > Tests were done on Calxeda ECX-2000 with smmu for sata and xgmac.
> > > > > I've used SZ_512K both for initial mapping size and grow_size.
> > > >
> > > > Thanks for implementing this feature! I remember it was discussed from
> > > > early beginning of arm dma iommu support, but I never had enough time
> > > > to actually implement it. I briefly checked the code and it look fine,
> > > > however I really wonder if we need separate grow_size parameter?
> > > > Personally I would simplify it to simply grow the bitmap by initial
> > > > size until it reaches the maximal size.
> > >
> > > That sounds sensible, but I also think it would be worth taking into account
> > > the page sizes supported by the IOMMU as well, since aligning to those makes
> > > sense from a TLB utilisation perspective.
> >
> > Meanwhile I also think that the grow_size parameter is overkill. Only
> > the initial mapping size and the maximum size really matter. Then we
> > could try to extend the mapping by initial mapping size and if this
> > fails (we might not have enough pages to serve such an allocation) we
> > could/should even fall back to allocate a single page (which should
> > give us at least a 16MB range).
> >
> > > > The whole concept of the simplified bitmap (where 1 bit != 1 page) for
> > > > iova allocation is a specific feature of this code and it has nothing
> > > > to the hardware. After thinking a bit more on the existing
> > > > implementation I've already observed that it is sometimes hard to
> > > > understand the parameters for arm_iommu_create_mapping() function,
> > > > especially the 'order' argument is ofter misunderstood. With your
> > > > patch we got two additional parameters. Maybe it will be much better
> > > > to use only 2 arguments: max_mapping_size and allocation_accuracy.
> > > > The initial bitmap size can be then calculated to fit it into single
> > > > memory page (that's quite important to avoid allocations larger that
> > > > a single memory page). 'allocation_accuracy' will serve the same way
> > > > as 'order' parameter now (but expressed in bytes rather than being
> > > > the multiplier for the number of pages). This way the
> > > > arm_iommu_create_mapping() function should be much easier to
> > > > understand, while keeping the implementation details hidden from the
> > > > caller.
> > >
> > > Hmm, I wouldn't guess the SI unit of accuracy to be bytes ;)
> >   
> > Have to think about the alignment argument and the last paragraph for
> > a while.
> >
> > All I can say now is that starting with a bitmap size that fits into a
> > single memory page doesn't sound right to me. The initial allocation
> > is "easy" (not GFP_ATOMIC) and thus I think we should start with a
> > larger bitmap. Say you have a device for which at runtime 512MB
> > mapping range are required and you use a 4k page for the bitmaps (each
> > tracking 16MB IOVA range) you'll have 32 bitmaps to maintain. Whereas
> > when you start with 128MB initial bitmap size and (successfully)
> > enhance the mapping by 128MB you just have to maintain 4 bitmaps.
> 
> Huh? In the 'worst' case scenario (1 bit represents 1 page) a bitmap
> which occupies a single memory page holds 4096 bytes (PAGE SIZE) * 8
> (bits/byte) = 32768 bits, what gives us 32768 * 4KiB (PAGE SIZE) = 128MiB
> of address space, so for 512MiB mapping you just need at most 4 pages for
> bitmap.

Arrgh, yes of course it's 128 and not 16 MB. (That's the reason why I
had chosen 128MB as the initial and grow size.) Not sure why I came up
with the 16MB thing yesterday. Sorry.

Of course that means that the number of bitmaps to maintain is
manageable (at least for most devices).

> Maybe the whole concept of simplified bitmap was already an over
> engineering from the beginning? I've added it to increase total supported
> mapping size (in my case I worked with devices which allocates quite
> large buffers), but now I see that it is not really needed if we have
> dynamically extended bitmaps.
> 
> BTW, I thought a bit more one your implementation and I think that it will
> be better to replace lists with simple arrays of bitmaps. We know the
> maximum number of sub-bitmaps from beginning and such approach will
> simplify iova freeing (no need for searching the address in a list).

Yep, that sounds reasonable.

> > But of course coming up with the right choice for the initial bitmap
> > size that fits all master devices is a hard thing to do ...
> 
> Right, but the dynamically extended bitmaps will adapt to particular use
> cases, so the initial values doesn't really matter that much.

Yes, (now that's again clear on my end that we cover 128MB ranges with
a bitmap of one page ;-) I don't see an issue here anymore.


Andreas
