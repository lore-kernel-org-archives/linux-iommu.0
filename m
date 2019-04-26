From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 10/19] iommu/vt-d: Add custom allocator for IOASID
Date: Fri, 26 Apr 2019 13:11:22 -0700
Message-ID: <20190426131122.2093e3ba@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <7a79c1cd-eef2-2233-3b31-4d93a6c3b48d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a79c1cd-eef2-2233-3b31-4d93a6c3b48d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Wed, 24 Apr 2019 19:27:26 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 4/24/19 1:31 AM, Jacob Pan wrote:
> > When VT-d driver runs in the guest, PASID allocation must be
> > performed via virtual command interface. This patch register a  
> registers
will fix
> > custom IOASID allocator which takes precedence over the default
> > IDR based allocator.  
> nit: s/IDR based// . It is xarray based now.
right, changed code but not commit message :)
>  The resulting IOASID allocation will always
> > come from the host. This ensures that PASID namespace is system-
> > wide.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 58
> > +++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h |  2 ++ 2 files changed, 60
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index d93c4bd..ec6f22d 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1711,6 +1711,8 @@ static void free_dmar_iommu(struct
> > intel_iommu *iommu) if (ecap_prs(iommu->ecap))
> >  			intel_svm_finish_prq(iommu);
> >  	}
> > +	ioasid_unregister_allocator(&iommu->pasid_allocator);
> > +
> >  #endif
> >  }
> >  
> > @@ -4811,6 +4813,46 @@ static int __init
> > platform_optin_force_iommu(void) return 1;
> >  }
> >  
> > +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max,
> > void *data) +{
> > +	struct intel_iommu *iommu = data;
> > +	ioasid_t ioasid;
> > +
> > +	/*
> > +	 * VT-d virtual command interface always uses the full 20
> > bit
> > +	 * PASID range. Host can partition guest PASID range based
> > on
> > +	 * policies but it is out of guest's control.
> > +	 */  
> The above comment does not exactly relate to the check below
> > +	if (min < PASID_MIN || max > PASID_MAX)
> > +		return -EINVAL;
> > +
> > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > +		return INVALID_IOASID;
> > +
> > +	return ioasid;
> > +}
> > +
> > +static int intel_ioasid_free(ioasid_t ioasid, void *data)
> > +{
> > +	struct iommu_pasid_alloc_info *svm;
> > +	struct intel_iommu *iommu = data;
> > +
> > +	if (!iommu || !cap_caching_mode(iommu->cap))
> > +		return -EINVAL;  
> can !cap_caching_mode(iommu->cap) be true as the allocator only is set
> if CM?
right, should never happen.
> > +	/*
> > +	 * Sanity check the ioasid owner is done at upper layer,
> > e.g. VFIO
> > +	 * We can only free the PASID when all the devices are
> > unbond.
> > +	 */
> > +	svm = ioasid_find(NULL, ioasid, NULL);
> > +	if (!svm) {  
> you can avoid using the local svm variable.
> > +		pr_warn("Freeing unbond IOASID %d\n", ioasid);  
> unbound
> > +		return -EBUSY;  
> -EINVAL?
It meant the PASID is still being used, bond to a device doing DMA etc.
thus -EBUSY. But I will make the free a void function.
> > +	}
> > +	vcmd_free_pasid(iommu, ioasid);
> > +
> > +	return 0;
> > +}
> > +
> >  int __init intel_iommu_init(void)
> >  {
> >  	int ret = -ENODEV;
> > @@ -4912,6 +4954,22 @@ int __init intel_iommu_init(void)
> >  				       "%s", iommu->name);
> >  		iommu_device_set_ops(&iommu->iommu,
> > &intel_iommu_ops); iommu_device_register(&iommu->iommu);
> > +		if (cap_caching_mode(iommu->cap) &&
> > sm_supported(iommu)) {  
> so shouldn't you test VCCAP_REG as well?
> > +			/*
> > +			 * Register a custom ASID allocator if we
> > are running
> > +			 * in a guest, the purpose is to have a
> > system wide PASID
> > +			 * namespace among all PASID users.
> > +			 * There can be multiple vIOMMUs in each
> > guest but only
> > +			 * one allocator is active. All vIOMMU
> > allocators will
> > +			 * eventually be calling the same host
> > allocator.
> > +			 */
> > +			iommu->pasid_allocator.alloc =
> > intel_ioasid_alloc;
> > +			iommu->pasid_allocator.free =
> > intel_ioasid_free;
> > +			iommu->pasid_allocator.pdata = (void
> > *)iommu;
> > +			ret =
> > ioasid_register_allocator(&iommu->pasid_allocator);
> > +			if (ret)
> > +				pr_warn("Custom PASID allocator
> > registeration failed\n");  
> registration
> > +		}
> >  	}
> >  
> >  	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index bff907b..c24c8aa 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -31,6 +31,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/dmar.h>
> > +#include <linux/ioasid.h>
> >  
> >  #include <asm/cacheflush.h>
> >  #include <asm/iommu.h>
> > @@ -549,6 +550,7 @@ struct intel_iommu {
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> >  	struct page_req_dsc *prq;
> >  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> > +	struct ioasid_allocator pasid_allocator; /* Custom
> > allocator for PASIDs */ #endif
> >  	struct q_inval  *qi;            /* Queued invalidation
> > info */ u32 *iommu_state; /* Store iommu states between suspend and
> > resume.*/ 
> 
> Thanks
> 
> Eric

[Jacob Pan]
