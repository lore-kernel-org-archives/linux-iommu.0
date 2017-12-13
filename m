From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Fix shift overflow in qi_flush_dev_iotlb
Date: Wed, 13 Dec 2017 08:58:47 -0700
Message-ID: <20171213085847.3d3245c6@t450s.home>
References: <20171212224250.22173.74201.stgit@gimli.home>
        <20171213071355.GD7780@xz-mi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171213071355.GD7780@xz-mi>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Xu <peterx@redhat.com>
Cc: iommu@lists.linux-foundation.org, tursulin@ursulin.net, dwmw2@infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 13 Dec 2017 15:13:55 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Dec 12, 2017 at 03:43:08PM -0700, Alex Williamson wrote:
> 
> [...]
> 
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index 9a7ffd13c7f0..87888b102057 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -1345,7 +1345,9 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
> >  	struct qi_desc desc;
> >  
> >  	if (mask) {
> > -		BUG_ON(addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1));
> > +		BUG_ON((mask > MAX_AGAW_PFN_WIDTH) ||
> > +		       ((mask == MAX_AGAW_PFN_WIDTH) && addr) ||
> > +		       (addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1)));  
> 
> Could it work if we just use 1ULL instead of 1 here?  Thanks,

In either case we're talking about shifting off the end of the
variable, which I understand to be undefined.  Right?  Thanks,

Alex
