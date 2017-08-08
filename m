From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: fix null-pointer dereference in
 arm_smmu_add_device
Date: Tue, 8 Aug 2017 12:21:44 +0100
Message-ID: <20170808112144.GE13355@arm.com>
References: <20170808092614.GB12887@arm.com>
 <1502187962-16861-1-git-send-email-asavkov@redhat.com>
 <d7a07e48-862d-a6f7-8bad-9c71f5a5be5b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d7a07e48-862d-a6f7-8bad-9c71f5a5be5b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Artem Savkov <asavkov@redhat.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

[+ Joerg]

On Tue, Aug 08, 2017 at 11:37:40AM +0100, Robin Murphy wrote:
> On 08/08/17 11:26, Artem Savkov wrote:
> > Commit c54451a "iommu/arm-smmu: Fix the error path in arm_smmu_add_device"
> > removed fwspec assignment in legacy_binding path as redundant which is
> > wrong. It needs to be updated after fwspec initialisation in
> > arm_smmu_register_legacy_master() as it is dereferenced later. Without
> > this there is a NULL-pointer dereference panic during boot on some hosts.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks for fixing it up, and sorry for failing to document the
> unfortunately subtle logic in the first place!

Well, I was the one that messed it up:

Acked-by: Will Deacon <will.deacon@arm.com>

Joerg, can you pick this up as a fix for 4.13, please?

Will

> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index b97188a..2d80fa8 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1519,6 +1519,13 @@ static int arm_smmu_add_device(struct device *dev)
> >  
> >  	if (using_legacy_binding) {
> >  		ret = arm_smmu_register_legacy_master(dev, &smmu);
> > +
> > +		/*
> > +		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
> > +		 * will allocate/initialise a new one. Thus we need to update fwspec for
> > +		 * later use.
> > +		 */
> > +		fwspec = dev->iommu_fwspec;
> >  		if (ret)
> >  			goto out_free;
> >  	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
> > 
> 
