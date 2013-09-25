From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] On unmap, flush IOMMU TLB and return correct size
Date: Wed, 25 Sep 2013 11:36:28 -0600
Message-ID: <1380130588.3030.342.camel@ul30vt.home>
References: <CE494510.41547%hshankar@netapp.com>
	<1379818740.2547.51.camel@shinybook.infradead.org>
	<20130925155459.GA20372@8bytes.org>
	<1380125113.28494.14.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380125113.28494.14.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Singh, Varinder" <Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Sundaram,
	Rajesh" <Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Kimmel,
	Jeff" <jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Spiller,
	John" <John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2013-09-25 at 17:05 +0100, David Woodhouse wrote:
> On Wed, 2013-09-25 at 17:54 +0200, Joerg Roedel wrote:
> > On Sat, Sep 21, 2013 at 09:59:00PM -0500, David Woodhouse wrote:
> > > I *hate* the bizarre calling convention for iommu_unmap(). Is it
> > > actually clearly documented anywhere? Why on earth is it not just
> > > returning void, and expected to unmap what it was *asked* to unmap?
> > 
> > Yeah, I agree that this should be documented since it is quite
> > non-standard/non-obvious behaviour of a function. The reason the
> > interface was implemented this way is that the caller should not need to
> > know (or keep track of) the page-size which was used to map a given iova.
> 
> Why would it ever care? If it *happens* to map something that can use
> large pages, yay!. If it subsequently breaks apart those large pages by
> unmapping 4KiB in the middle, let the IOMMU driver break that apart.

Can this be done atomically?  I thought part of the reason for this
interface was that iommu drivers typically couldn't replace a huge page
with multiple smaller pages in the presence of DMA.

> And why are we not allowed to unmap more than a single page at a time?
> 
> Doing unmaps in small pieces (with a full flush between every one) is
> *horribly* slow.

While we call iommu_unmap with PAGE_SIZE, we certainly expect that
larger chunks will be used if they were mapped that way.

> > So the interface is basically, that you give an iova and a size and the
> > iommu driver unmaps _at_least_ a region of that size. But if you ask for
> > a 4k region which is mapped by a 2M page then the whole 2M are unmapped.
> > The return value tells you how much was actually unmapped.
> > 
> > Not the best interface, I know. We should come up with a better way to
> > handle this.
> 
> Seriously, just the address and the size. Let the IOMMU code deal with
> whether it can *actually* use large pages on the particular set of
> IOMMUs that are in use for the devices you've added to the domain so
> far.

You're contradicting yourself here.  Just let the iommu deal with it,
but now you're raising concerns that Intel may be mixing super page
IOMMU hardware with non-super page IOMMU hardware on the same box, so I
do need to be concerned, yet there's no interface to discover super page
support.  What happens if my IOMMU domain makes use of super pages and
then I add a new device behind a new IOMMU without hardware super page
support?  We have the same problem with snoop control already.  There's
no atomic re-mapping interface, so KVM just pretends it can unmap and
remap without anyone noticing.  Thanks,

Alex
