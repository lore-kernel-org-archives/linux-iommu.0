From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] On unmap, flush IOMMU TLB and return correct size
Date: Wed, 25 Sep 2013 10:33:35 -0600
Message-ID: <1380126815.3030.313.camel@ul30vt.home>
References: <CE494510.41547%hshankar@netapp.com>
	<1379818740.2547.51.camel@shinybook.infradead.org>
	<20130925155459.GA20372@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130925155459.GA20372-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Singh, Varinder" <Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Sundaram,
	Rajesh" <Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Kimmel,
	Jeff" <jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Spiller,
	John" <John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2013-09-25 at 17:54 +0200, Joerg Roedel wrote:
> On Sat, Sep 21, 2013 at 09:59:00PM -0500, David Woodhouse wrote:
> > I *hate* the bizarre calling convention for iommu_unmap(). Is it
> > actually clearly documented anywhere? Why on earth is it not just
> > returning void, and expected to unmap what it was *asked* to unmap?
> 
> Yeah, I agree that this should be documented since it is quite
> non-standard/non-obvious behaviour of a function. The reason the
> interface was implemented this way is that the caller should not need to
> know (or keep track of) the page-size which was used to map a given iova.
> 
> So the interface is basically, that you give an iova and a size and the
> iommu driver unmaps _at_least_ a region of that size. But if you ask for
> a 4k region which is mapped by a 2M page then the whole 2M are unmapped.
> The return value tells you how much was actually unmapped.
> 
> Not the best interface, I know. We should come up with a better way to
> handle this.

Actually, unmap can return zero too, which happens if you try to unmap
an offset into a super page mapping.  The current interface has issues,
but both legacy kvm assignment and vfio rely on it so we don't need to
track individual mappings.  Thanks,

Alex
