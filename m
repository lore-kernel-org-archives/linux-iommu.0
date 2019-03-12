From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: fix sg->dma_address for sg->offset bigger
	than PAGE_SIZE
Date: Tue, 12 Mar 2019 08:18:16 -0700
Message-ID: <67c062b183fbd5651a9aa990e677d31673ff7580.camel@linux.intel.com>
References: <20190226112407.GB2989@redhat.com>
	<20190228090411.GA24938@redhat.com> <20190228104223.GA2749@redhat.com>
	<20190228121948.GD6072@redhat.com> <20190228134029.GC1594@8bytes.org>
	<20190304071037.GA2787@redhat.com>
	<CAKxU2N-k-9DCYBv6W3CohL963dr3AeY3VHyt8FrUuo=BfacDsw@mail.gmail.com>
	<20190311084319.GA3310@redhat.com> <20190311090314.GB3310@redhat.com>
	<e0630ae9d9bee73d8a1ce3499ea9f77900e9cdfa.camel@linux.intel.com>
	<20190312070832.GA2483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190312070832.GA2483-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stanislaw Gruszka <sgruszka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Samuel Sieb <samuel-yL8jFUf1A1M@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvme-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rosen Penev <rosenp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Bianconi <lorenzo.bianconi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jan.viktorin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2019-03-12 at 08:08 +0100, Stanislaw Gruszka wrote:
> On Mon, Mar 11, 2019 at 08:47:44AM -0700, Alexander Duyck wrote:
> > >  drivers/iommu/amd_iommu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > > index 6b0760dafb3e..949621f33624 100644
> > > --- a/drivers/iommu/amd_iommu.c
> > > +++ b/drivers/iommu/amd_iommu.c
> > > @@ -2604,7 +2604,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
> > >  
> > >  	/* Everything is mapped - write the right values into s->dma_address */
> > >  	for_each_sg(sglist, s, nelems, i) {
> > > -		s->dma_address += address + s->offset;
> > > +		s->dma_address += address + (s->offset & ~PAGE_MASK);
> > >  		s->dma_length   = s->length;
> > >  	}
> > >  
> > 
> > You should add a comment calling out that this is needed because the
> > sg_phys(s) call above this is masked with PAGE_MASK. Then this makes
> > much more sense. Otherwise I would have assumed you needed either the
> > full offset or none.
> 
> Would something like this 
> 
> /*
>  * Everything is mapped - write the right values into s->dma_address. 
>  * Take into account s->offset can be bigger than page size and sg_phys(s)
>  * address has to be aligned to page granularity.
>  */
> 
> be appropriate ?
> 
> Stanislaw
> 

No, that isn't a good description. If you take a look at the code a few
lines up you find:
	phys_addr = (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);

Now if I am not mistaken the whole reason why you are having to make
the change here is because the application of PAGE_MASK in this line.
Basically what sg_phys() will do is take the address of the page,
convert it to a physical address and add the offset. However what the
mask is doing is limiting how much of that offset can be added. As a
result you have to add the remainder that was masked out. So maybe a
better comment would be something like:

/*
 * Add in the remaining piece of the scatter-gather offset that was 
 * masked out when we were determining the physical address via
 * (sg_phys(s) & PAGE_MASK) earlier.
 */
