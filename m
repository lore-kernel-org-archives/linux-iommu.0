From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fixing kvm_iommu_put_pages()
Date: Mon, 17 Mar 2014 10:51:12 -0600
Message-ID: <1395075072.8201.58.camel@ul30vt.home>
References: <1394585481.2270.179.camel@shinybook.infradead.org>
	<1395071061.8201.14.camel@ul30vt.home>
	<1395071417.4588.45.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395071417.4588.45.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2014-03-17 at 15:50 +0000, David Woodhouse wrote:
> On Mon, 2014-03-17 at 09:44 -0600, Alex Williamson wrote:
> > 
> > 
> > As mentioned on irc, I think this could probably be made to work and
> > doing a callback would likely give the IOMMU driver the most flexibility
> > versus some sort of interface for iommu_iova_to_phys() to return the
> > mapping size. 
> 
> Is it acceptable to have an API which says that the physical address may
> *still* be accessible through the IOTLB until iommu_unmap() returns?
> Even *after* the callback has been called for that physical address?
> 
> We have the physical addresses to hand as we clear the PTEs, of course.
> But we haven't flushed the IOTLB yet. It would be painful to keep a
> *list* of pages and then call the callback after the IOTLB is flushed;
> we'd prefer to punt that cost to the caller, if the caller needs to
> worry about use-after-free problems.
> 
> If that's too much of a pain, then maybe augmenting iova_to_phys() might
> be the better option...?

In order to maintain the trivial callback you suggest, the IOTLB would
need to guarantee that the physical addresses are not accessible prior
to the callback.  Without such a guarantee, we can't unpin the pages and
the callback wouldn't be able to do anything more than collect a list of
pages to later unpin.  For reducing IOTLB flushes maybe that still makes
sense, but it does seem like it could easily get ugly.  For instance,
the callback would need the option to return -errno if it runs out of
resources, so the IOMMU driver would need the ability to reinstate the
last chunk.

It's starting to seem like augmenting iova_to_phys() might be the better
path.  It fixes the API and allows for a trivial (if sub-optimal)
implementation like we have today.  An optimal implementation would
require looping through iova_to_phys() for the entire range to be
unmapped, caching the translation and size of each, calling
iommu_unmap() once for the entire range, then using the cached values to
unpin physical memory.  At least it's easier for the caller to bound
it's resource consumption that way.  Thanks,

Alex
