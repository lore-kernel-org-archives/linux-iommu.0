From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/tegra: smmu: Fix unsleepable memory allocation
Date: Mon, 2 Jul 2012 12:19:03 +0200
Message-ID: <20120702.131903.1053229523265080291.hdoyu@nvidia.com>
References: <1340790841-23349-1-git-send-email-hdoyu@nvidia.com><20120702095747.GB2558@amd.com><20120702.131326.685361720133451299.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120702.131326.685361720133451299.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Mon, 2 Jul 2012 12:13:26 +0200:

> Hi Joerg,
> 
> Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote @ Mon, 2 Jul 2012 11:57:47 +0200:
> 
> > On Wed, Jun 27, 2012 at 12:54:01PM +0300, Hiroshi DOYU wrote:
> > > allo_pdir() is called in smmu_iommu_domain_init() with spin_lock
> > > held. memory allocations in it have to be atomic/unsleepable.
> > > 
> > > Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > Reported-by: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
> > > ---
> > >  drivers/iommu/tegra-smmu.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > > index ecd6790..3f3d09d 100644
> > > --- a/drivers/iommu/tegra-smmu.c
> > > +++ b/drivers/iommu/tegra-smmu.c
> > > @@ -550,13 +550,13 @@ static int alloc_pdir(struct smmu_as *as)
> > >  		return 0;
> > >  
> > >  	as->pte_count = devm_kzalloc(smmu->dev,
> > > -		     sizeof(as->pte_count[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
> > > +		     sizeof(as->pte_count[0]) * SMMU_PDIR_COUNT, GFP_ATOMIC);
> > >  	if (!as->pte_count) {
> > >  		dev_err(smmu->dev,
> > >  			"failed to allocate smmu_device PTE cunters\n");
> > >  		return -ENOMEM;
> > >  	}
> > > -	as->pdir_page = alloc_page(GFP_KERNEL | __GFP_DMA);
> > > +	as->pdir_page = alloc_page(GFP_ATOMIC | __GFP_DMA);
> > >  	if (!as->pdir_page) {
> > >  		dev_err(smmu->dev,
> > >  			"failed to allocate smmu_device page directory\n");
> > 
> > Okay, I queued this one for v3.5. It is small enough so that it counts
> > as a fix. The other two patches are 3.6 stuff.
> 
> The other 2 patehs are the replacement of this one. They are
> exclusive. Both of them are basically for the same fix.

I might not get your point. If you plan to take the this(the original)
as immediate fix for v3.5  you need tok take the others for v3.6 after
*reverting* the original. This would also work.
