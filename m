From: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Date: Fri, 23 Nov 2018 13:34:48 -0800
Message-ID: <20181123213448.GW3065@bombadil.infradead.org>
References: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
	<bbad42cb-4a76-a7e7-c385-db77f1cc588b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bbad42cb-4a76-a7e7-c385-db77f1cc588b-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: mhocko-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 23, 2018 at 05:23:06PM +0000, Robin Murphy wrote:
> On 15/11/2018 15:49, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> > 
> > Signed-off-by: Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Reviewed-by: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 12 ++----------
> >   1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index d1b0475..69c66b1 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -622,17 +622,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >   int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
> >   {
> > -	unsigned long uaddr = vma->vm_start;
> > -	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -	int ret = -ENXIO;
> > +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> > -		ret = vm_insert_page(vma, uaddr, pages[i]);
> > -		if (ret)
> > -			break;
> > -		uaddr += PAGE_SIZE;
> > -	}
> > -	return ret;
> > +	return vm_insert_range(vma, vma->vm_start, pages, count);
> 
> AFIACS, vm_insert_range() doesn't respect vma->vm_pgoff, so doesn't this
> break partial mmap()s of a large buffer? (which I believe can be a thing)

Whoops.  That should have been:

return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff, count);

I suppose.

Although arguably we should respect vm_pgoff inside vm_insert_region()
and then callers automatically get support for vm_pgoff without having
to think about it ... although we should then also pass in the length
of the pages array to avoid pages being mapped in which aren't part of
the allocated array.

Hm.  More thought required.
