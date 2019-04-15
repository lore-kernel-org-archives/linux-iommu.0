From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
Date: Mon, 15 Apr 2019 16:10:15 -0700
Message-ID: <20190415161015.564cb071@jacob-builder>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190415143711.13c29308@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415143711.13c29308@x1.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 15 Apr 2019 14:37:11 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon,  8 Apr 2019 16:59:25 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > When VT-d driver runs in the guest, PASID allocation must be
> > performed via virtual command interface. This patch register a
> > custom IOASID allocator which takes precedence over the default
> > IDR based allocator. The resulting IOASID allocation will always
> > come from the host. This ensures that PASID namespace is system-
> > wide.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 50
> > +++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h |  1 + 2 files changed, 51 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 28cb713..a38d774 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -4820,6 +4820,42 @@ static int __init
> > platform_optin_force_iommu(void) return 1;
> >  }
> >  
> > +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max,
> > void *data) +{
> > +	struct intel_iommu *iommu = data;
> > +	ioasid_t ioasid;
> > +
> > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > +		return INVALID_IOASID;
> > +	return ioasid;  
> 
> How does this honor min/max?
> 
> > +}
> > +
> > +static int intel_ioasid_free(ioasid_t ioasid, void *data)
> > +{
> > +	struct iommu_pasid_alloc_info *svm;
> > +	struct intel_iommu *iommu = data;
> > +
> > +	if (!iommu || !cap_caching_mode(iommu->cap))
> > +		return -EINVAL;
> > +	/*
> > +	 * Sanity check the ioasid owner is done at upper layer,
> > e.g. VFIO
> > +	 * We can only free the PASID when all the devices are
> > unbond.
> > +	 */
> > +	svm = ioasid_find(NULL, ioasid, NULL);
> > +	if (!svm) {
> > +		pr_warn("Freeing unbond IOASID %d\n", ioasid);
> > +		return -EBUSY;
> > +	}
> > +	vcmd_free_pasid(iommu, ioasid);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct ioasid_allocator intel_iommu_ioasid_allocator = {
> > +	.alloc = intel_ioasid_alloc,
> > +	.free = intel_ioasid_free,
> > +};
> > +
> >  int __init intel_iommu_init(void)
> >  {
> >  	int ret = -ENODEV;
> > @@ -4921,6 +4957,20 @@ int __init intel_iommu_init(void)
> >  				       "%s", iommu->name);
> >  		iommu_device_set_ops(&iommu->iommu,
> > &intel_iommu_ops); iommu_device_register(&iommu->iommu);
> > +		if (cap_caching_mode(iommu->cap) &&
> > sm_supported(iommu)) {
> > +			/*
> > +			 * Register a custom ASID allocator if we
> > are running
> > +			 * in a guest, the purpose is to have a
> > system wide PASID
> > +			 * namespace among all PASID users.
> > +			 * Note that only one vIOMMU in each guest
> > is supported.  
> 
> Why one vIOMMU per guest?  This would prevent guests with multiple PCI
> domains aiui.
> 
This is mainly for simplicity reasons. These are all virtual BDFs
anyway. As long as guest BDF can be mapped to a host BDF, it should be
sufficient, am I missing anything?

>From PASID allocation perspective, it is not tied to any PCI device
until bind call. We only need to track PASID ownership per guest.

virtio-IOMMU spec does support multiple PCI domains but I am not sure
if that applies to all assigned devices, whether all assigned devices
are under the same domain. Perhaps Jean can help to clarify how PASID
allocation API looks like on virtio IOMMU.

> > +			 */
> > +			intel_iommu_ioasid_allocator.pdata = (void
> > *)iommu;
> > +			ret =
> > ioasid_set_allocator(&intel_iommu_ioasid_allocator);
> > +			if (ret == -EBUSY) {
> > +				pr_info("Custom IOASID allocator
> > already registered\n");
> > +				break;
> > +			}
> > +		}
> >  	}
> >  
> >  	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index b29c85c..bc09d80 100644
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
> 
