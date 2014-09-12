From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/3] vfio/iommu_type1: add new
	VFIO_TYPE1_NESTING_IOMMU IOMMU type
Date: Fri, 12 Sep 2014 17:55:20 +0100
Message-ID: <20140912165520.GF12108@arm.com>
References: <1409651619-27342-1-git-send-email-will.deacon@arm.com>
	<1409651619-27342-3-git-send-email-will.deacon@arm.com>
	<1410462748.2982.342.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410462748.2982.342.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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

Thanks for taking a look.

On Thu, Sep 11, 2014 at 08:12:28PM +0100, Alex Williamson wrote:
> On Tue, 2014-09-02 at 10:53 +0100, Will Deacon wrote:
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 0734fbe5b651..50aa56c7b6a7 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -53,11 +53,15 @@ module_param_named(disable_hugepages,
> >  MODULE_PARM_DESC(disable_hugepages,
> >  		 "Disable VFIO IOMMU support for IOMMU hugepages.");
> >  
> > +/* Feature flags for VFIO Type-1 IOMMUs */
> > +#define VFIO_IOMMU_FEAT_V2	(1 << 0)
> > +#define VFIO_IOMMU_FEAT_NESTING	(1 << 1)
> > +
> >  struct vfio_iommu {
> >  	struct list_head	domain_list;
> >  	struct mutex		lock;
> >  	struct rb_root		dma_list;
> > -	bool v2;
> > +	int			features;
> 
> Personally I'd rather add a nesting bool than mask out flag bits.

Sure.

> > @@ -705,6 +710,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> >  		goto out_free;
> >  	}
> >  
> > +	if (iommu->features & VFIO_IOMMU_FEAT_NESTING)
> > +		iommu_domain_set_attr(domain->domain, DOMAIN_ATTR_NESTING, &attr);
> > +
> 
> Shouldn't we fail if this doesn't work?

The reason I don't fail is because device passthrough can still work with an
IOMMU that isn't capable of nesting. The part that won't work is attempting
to instantiate a virtual SMMU interface for the guest.

However, it just struck me that userspace knows whether or not it's going to
want a virtual SMMU interface. If it does, then failure to set NESTING is
fatal. If it doesn't, then it doesn't need to set the flag so there is no
issue.

> >  	ret = iommu_attach_group(domain->domain, iommu_group);
> >  	if (ret)
> >  		goto out_domain;
> > @@ -815,12 +823,50 @@ done:
> >  	mutex_unlock(&iommu->lock);
> >  }
> >  
> > +static int vfio_iommus_have_nesting(void)
> > +{
> > +	static struct bus_type *bus_types[] = { &pci_bus_type };
> 
> Hmm, we just got rid of all traces of pci in this file, so I'm not too
> excited about adding it back.  Don't we no longer include pci.h?  I'm
> surprised this doesn't throw a warning.  We should try to be independent
> of CONFIG_PCI here.

I don't see any warning here.

> > +		if (!iommu_present(bus))
> > +			continue;
> > +
> > +		domain = iommu_domain_alloc(bus);
> > +		if (!domain)
> > +			continue;
> > +
> > +		if (!iommu_domain_set_attr(domain, DOMAIN_ATTR_NESTING, &attr))
> > +			ret = 1;
> > +
> > +		iommu_domain_free(domain);
> > +	}
> 
> Can this support Joerg's iommu_capable() interface so we can test w/o
> creating a domain?  We still have the bus_type problem though.

[...]

> > @@ -886,6 +955,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		case VFIO_TYPE1_IOMMU:
> >  		case VFIO_TYPE1v2_IOMMU:
> >  			return 1;
> > +		case VFIO_TYPE1_NESTING_IOMMU:
> > +			if (!iommu)
> > +				return vfio_iommus_have_nesting();
> > +			return vfio_domains_have_iommu_nesting(iommu);
> 
> I'd just about prefer to statically return 1 for NESTING and then fail
> to add groups if we can't set the attribute.  It sucks, but here we test
> an arbitrary bus type to determine whether nesting is supported, allow a
> nesting iommu type to be set regardless of what kind of devices are
> about to go into it, and require that the user test to see whether the
> requested IOMMU attribute actually stuck.  That's not a very intuitive
> interface.  Thanks,

Yes, I totally agree that the interface is clunky. Returning 1 for NESTING
solves both the pci bus problem and the iommu_capable issue, so that sounds
like a great simplification of the code.

That means userspace:

  - Can always open a VFIO_TYPE1_NESTING_IOMMU
  - VFIO_CHECK_EXTENSION will always return 1
  - When adding groups (e.g. SET_IOMMU), the iommu_domain_set_attr can
    fail, which will cause the corresponding ioctl to fail

If nesting is not required because there is no virtual SMMU interface,
then the usual TYPE1 IOMMU can be used.

Sound good?

Will
