From: Cho KyongHo <pullip.cho@samsung.com>
Subject: Re: [PATCH v10 20/20] iommu/exynos: add devices attached to the System
 MMU to an IOMMU group
Date: Mon, 14 Oct 2013 20:02:27 +0900
Message-ID: <20131014200227.10964a2e57d711c23c345c10@samsung.com>
References: <20131007105844.a260f37a9a941bed894adca3@samsung.com>
 <1381438469.2796.58.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1381438469.2796.58.camel@ul30vt.home>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Subash Patel <supash.ramaswamy@linaro.org>, Varun Sethi <Varun.Sethi@freescale.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, 10 Oct 2013 14:54:29 -0600, Alex Williamson wrote:
> On Mon, 2013-10-07 at 10:58 +0900, Cho KyongHo wrote:
> > Patch written by Antonios Motakis <a.motakis@virtualopensystems.com>:
> > 
> > IOMMU groups are expected by certain users of the IOMMU API,
> > e.g. VFIO. Since each device is behind its own System MMU, we
> > can allocate a new IOMMU group for each device.
> > 
> > Reviewd-by: Cho KyongHo <pullip.cho@samsung.com>
> > Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> > ---
> >  drivers/iommu/exynos-iommu.c |   28 ++++++++++++++++++++++++++++
> >  1 files changed, 28 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 5025338..24505a0 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -1028,6 +1028,32 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
> >  	return phys;
> >  }
> >  
> > +static int exynos_iommu_add_device(struct device *dev)
> > +{
> > +	struct iommu_group *group;
> > +	int ret;
> > +
> > +	group = iommu_group_get(dev);
> 
> Seems reasonable, my only nit would be whether it's really an error to
> get a group back from the above call.  If devices are always isolated
> and IOMMU groups are always singleton, it would be an error to find one
> already associated with the device.  Right?  Thanks,
> 
Do you mean that calling iommu_group_add_device() with the group that is
returned by the above iommu_group_get() will return -EEXIST?

I didn't think about that.

> Alex

Thank you.

KyongHo.
> 
> > +
> > +	if (!group) {
> > +		group = iommu_group_alloc();
> > +		if (IS_ERR(group)) {
> > +			dev_err(dev, "Failed to allocate IOMMU group\n");
> > +			return PTR_ERR(group);
> > +		}
> > +	}
> > +
> > +	ret = iommu_group_add_device(group, dev);
> > +	iommu_group_put(group);
> > +
> > +	return ret;
> > +}
> > +
> > +static void exynos_iommu_remove_device(struct device *dev)
> > +{
> > +	iommu_group_remove_device(dev);
> > +}
> > +
> >  static struct iommu_ops exynos_iommu_ops = {
> >  	.domain_init = &exynos_iommu_domain_init,
> >  	.domain_destroy = &exynos_iommu_domain_destroy,
> > @@ -1036,6 +1062,8 @@ static struct iommu_ops exynos_iommu_ops = {
> >  	.map = &exynos_iommu_map,
> >  	.unmap = &exynos_iommu_unmap,
> >  	.iova_to_phys = &exynos_iommu_iova_to_phys,
> > +	.add_device = &exynos_iommu_add_device,
> > +	.remove_device = &exynos_iommu_remove_device,
> >  	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
> >  };
> >  
> 
> 
> 
