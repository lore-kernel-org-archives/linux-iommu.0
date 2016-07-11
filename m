From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iommu: arm-smmu: use devm_request_irq and devm_free_irq
Date: Mon, 11 Jul 2016 11:38:30 +0100
Message-ID: <20160711103829.GB17735@arm.com>
References: <1467625102-9755-1-git-send-email-van.freenix@gmail.com>
 <578375D7.7090609@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <578375D7.7090609@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Peng Fan <van.freenix@gmail.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 11, 2016 at 11:32:55AM +0100, Robin Murphy wrote:
> On 04/07/16 10:38, Peng Fan wrote:
> > Use devm_request_irq to simplify error handling path,
> > when probe smmu device.
> > 
> > Also devm_{request|free}_irq when init or destroy domain context.
> > 
> > Signed-off-by: Peng Fan <van.freenix@gmail.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > ---
> [...]
> > @@ -2050,7 +2046,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >  		dev_err(dev, "removing device with active domains!\n");
> >  
> >  	for (i = 0; i < smmu->num_global_irqs; ++i)
> > -		free_irq(smmu->irqs[i], smmu);
> > +		devm_free_irq(smmu->dev, smmu->irqs[i], smmu);
> 
> There shouldn't be any need for this at all, since the very next thing
> called after drv->remove() is devres_release_all().

I already sent a pull request for this, so any further changes will need
to be sent as incremental patches.

Will
