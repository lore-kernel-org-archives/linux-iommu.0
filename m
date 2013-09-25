From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] On unmap, flush IOMMU TLB and return correct size
Date: Wed, 25 Sep 2013 18:58:47 +0200
Message-ID: <20130925165846.GC20372@8bytes.org>
References: <CE494510.41547%hshankar@netapp.com>
	<1379818740.2547.51.camel@shinybook.infradead.org>
	<20130925155459.GA20372@8bytes.org>
	<1380125113.28494.14.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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

On Wed, Sep 25, 2013 at 05:05:13PM +0100, David Woodhouse wrote:
> On Wed, 2013-09-25 at 17:54 +0200, Joerg Roedel wrote:
> > Yeah, I agree that this should be documented since it is quite
> > non-standard/non-obvious behaviour of a function. The reason the
> > interface was implemented this way is that the caller should not need to
> > know (or keep track of) the page-size which was used to map a given iova.
> 
> Why would it ever care? If it *happens* to map something that can use
> large pages, yay!. If it subsequently breaks apart those large pages by
> unmapping 4KiB in the middle, let the IOMMU driver break that apart.

All that was implemented back in the old days where KVM was the only
user of that code. And back then it didn't make sense for the IOMMU
driver to split huge-pages because in the next step KVM would unmap all
the small pages anyway. So I took the other route and just told KVM how
much was unmapped so that the unmap code could skip over it.

> And why are we not allowed to unmap more than a single page at a time?

The user of iommu_unmap is actually allowed to do that. But the
page-size splitting it done in the iommu_unmap() function already to
have that code common between different IOMMU drivers. In the end the
IOMMU driver only exports the page-size bitmap and is fine.

> Doing unmaps in small pieces (with a full flush between every one) is
> *horribly* slow.

I proposed an iommu_commit() function to move all the necessary flushes
there after a couple of page-table changes. And this also allows to keep
the generic page-size splitting code generic.

> Seriously, just the address and the size. Let the IOMMU code deal with
> whether it can *actually* use large pages on the particular set of
> IOMMUs that are in use for the devices you've added to the domain so
> far.

Actually we can get rid of the unmapped_size thing by putting the same
constraints the DMA-API has in place. The user of the API has to unmap a
region with the same iova,size parameters used for mapping it. Then we
can guarantee that only the requested range will be unmapped.


	Joerg
