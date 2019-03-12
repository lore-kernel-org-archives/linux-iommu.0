From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] iommu/amd: fix sg->dma_address for sg->offset bigger
 than PAGE_SIZE
Date: Tue, 12 Mar 2019 08:08:33 +0100
Message-ID: <20190312070832.GA2483@redhat.com>
References: <20190226112407.GB2989@redhat.com>
 <20190228090411.GA24938@redhat.com>
 <20190228104223.GA2749@redhat.com>
 <20190228121948.GD6072@redhat.com>
 <20190228134029.GC1594@8bytes.org>
 <20190304071037.GA2787@redhat.com>
 <CAKxU2N-k-9DCYBv6W3CohL963dr3AeY3VHyt8FrUuo=BfacDsw@mail.gmail.com>
 <20190311084319.GA3310@redhat.com>
 <20190311090314.GB3310@redhat.com>
 <e0630ae9d9bee73d8a1ce3499ea9f77900e9cdfa.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0630ae9d9bee73d8a1ce3499ea9f77900e9cdfa.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Rosen Penev <rosenp@gmail.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, linux-wireless <linux-wireless@vger.kernel.org>, Samuel Sieb <samuel@sieb.net>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, jan.viktorin@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 11, 2019 at 08:47:44AM -0700, Alexander Duyck wrote:
> >  drivers/iommu/amd_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index 6b0760dafb3e..949621f33624 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -2604,7 +2604,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
> >  
> >  	/* Everything is mapped - write the right values into s->dma_address */
> >  	for_each_sg(sglist, s, nelems, i) {
> > -		s->dma_address += address + s->offset;
> > +		s->dma_address += address + (s->offset & ~PAGE_MASK);
> >  		s->dma_length   = s->length;
> >  	}
> >  
> 
> You should add a comment calling out that this is needed because the
> sg_phys(s) call above this is masked with PAGE_MASK. Then this makes
> much more sense. Otherwise I would have assumed you needed either the
> full offset or none.

Would something like this 

/*
 * Everything is mapped - write the right values into s->dma_address. 
 * Take into account s->offset can be bigger than page size and sg_phys(s)
 * address has to be aligned to page granularity.
 */

be appropriate ?

Stanislaw
