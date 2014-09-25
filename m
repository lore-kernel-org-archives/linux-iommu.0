From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 2/3] vfio/iommu_type1: add new
	VFIO_TYPE1_NESTING_IOMMU IOMMU type
Date: Thu, 25 Sep 2014 16:07:14 +0100
Message-ID: <20140925150714.GP20043@arm.com>
References: <1411550485-32483-1-git-send-email-will.deacon@arm.com>
	<1411550485-32483-3-git-send-email-will.deacon@arm.com>
	<1411582999.24563.110.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411582999.24563.110.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Wed, Sep 24, 2014 at 07:23:19PM +0100, Alex Williamson wrote:
> On Wed, 2014-09-24 at 10:21 +0100, Will Deacon wrote:
> > VFIO allows devices to be safely handed off to userspace by putting
> > them behind an IOMMU configured to ensure DMA and interrupt isolation.
> > This enables userspace KVM clients, such as kvmtool and qemu, to further
> > map the device into a virtual machine.
> > 
> > With IOMMUs such as the ARM SMMU, it is then possible to provide SMMU
> > translation services to the guest operating system, which are nested
> > with the existing translation installed by VFIO. However, enabling this
> > feature means that the IOMMU driver must be informed that the VFIO domain
> > is being created for the purposes of nested translation.
> > 
> > This patch adds a new IOMMU type (VFIO_TYPE1_NESTING_IOMMU) to the VFIO
> > type-1 driver. The new IOMMU type acts identically to the
> > VFIO_TYPE1v2_IOMMU type, but additionally sets the DOMAIN_ATTR_NESTING
> > attribute on its IOMMU domains.

[...]

> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 0734fbe5b651..d15b00700a31 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -57,7 +57,8 @@ struct vfio_iommu {
> >  	struct list_head	domain_list;
> >  	struct mutex		lock;
> >  	struct rb_root		dma_list;
> > -	bool v2;
> > +	bool			v2;
> > +	bool			nesting;
> >  };
> >  
> >  struct vfio_domain {
> > @@ -671,7 +672,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> >  	struct vfio_group *group, *g;
> >  	struct vfio_domain *domain, *d;
> >  	struct bus_type *bus = NULL;
> > -	int ret;
> > +	int ret, attr = 1;
> >  
> >  	mutex_lock(&iommu->lock);
> >  
> > @@ -705,6 +706,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> >  		goto out_free;
> >  	}
> >  
> > +	if (iommu->nesting) {
> 
> nit, attr declaration could be moved here

Sure.

> > +		ret = iommu_domain_set_attr(domain->domain, DOMAIN_ATTR_NESTING,
> > +					    &attr);
> > +		if (ret)
> > +			goto out_domain;
> > +	}
> > +
> >  	ret = iommu_attach_group(domain->domain, iommu_group);
> >  	if (ret)
> >  		goto out_domain;
> > @@ -819,17 +827,25 @@ static void *vfio_iommu_type1_open(unsigned long arg)
> >  {
> >  	struct vfio_iommu *iommu;
> >  
> > -	if (arg != VFIO_TYPE1_IOMMU && arg != VFIO_TYPE1v2_IOMMU)
> > -		return ERR_PTR(-EINVAL);
> > -
> >  	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> >  	if (!iommu)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > +	switch (arg) {
> > +	case VFIO_TYPE1_IOMMU:
> > +		break;
> > +	case VFIO_TYPE1_NESTING_IOMMU:
> > +		iommu->nesting = true;
> > +	case VFIO_TYPE1v2_IOMMU:
> > +		iommu->v2 = true;
> > +		break;
> > +	default:
> 
> Leaks iommu

Yikes, sorry about that. Will fix.

Will
