From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Date: Thu, 11 Apr 2019 10:12:14 +0200
Message-ID: <20190411081214.pgdztqdlud5ta466@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-2-geert+renesas@glider.be>
 <20190411081028.b2wf3nnzx4tw7xdr@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411081028.b2wf3nnzx4tw7xdr@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 11, 2019 at 10:10:28AM +0200, Simon Horman wrote:
> On Wed, Apr 03, 2019 at 08:21:43PM +0200, Geert Uytterhoeven wrote:
> > As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
> > iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
> > /sys/class/iommus/, but their "devices" subdirectories are empty.
> 
> Hi Geert,
> 
> Should the path be /sys/class/iommu/ (no trailing 's') ?
> 
> > Likewise, devices tied to an IOMMU do not have an "iommu" backlink.
> > 
> > Make sure all links are created, on both arm32 and arm64.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > v2:
> >   - Add Reviewed-by.
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 9a380c10655e182d..9f2b781e20a0eba6 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
> >  
> >  static int ipmmu_add_device(struct device *dev)
> >  {
> > +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> >  	struct iommu_group *group;
> > +	int ret;
> >  
> >  	/*
> >  	 * Only let through devices that have been verified in xlate()
> >  	 */
> > -	if (!to_ipmmu(dev))
> > +	if (!mmu)
> >  		return -ENODEV;
> >  
> > -	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
> > -		return ipmmu_init_arm_mapping(dev);
> > +	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
> > +		ret = ipmmu_init_arm_mapping(dev);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		group = iommu_group_get_for_dev(dev);
> > +		if (IS_ERR(group))
> > +			return PTR_ERR(group);
> >  
> > -	group = iommu_group_get_for_dev(dev);
> > -	if (IS_ERR(group))
> > -		return PTR_ERR(group);
> > +		iommu_group_put(group);
> > +	}
> >  
> > -	iommu_group_put(group);
> > +	iommu_device_link(&mmu->iommu, dev);

Also, is there any value in propagating the return value
of iommu_device_link() ?

> >  	return 0;
> >  }
> >  
> >  static void ipmmu_remove_device(struct device *dev)
> >  {
> > +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> > +
> > +	iommu_device_unlink(&mmu->iommu, dev);
> >  	arm_iommu_detach_device(dev);
> >  	iommu_group_remove_device(dev);
> >  }
> > -- 
> > 2.17.1
> > 
