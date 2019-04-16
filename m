From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
Date: Tue, 16 Apr 2019 08:30:25 -0700
Message-ID: <20190416083025.378f3915@jacob-builder>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190415143711.13c29308@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Sorry I missed this in my previous reply.
VT-d virtual command interface always allocate PASIDs with full 20bit
range. I think a range checking is missing here. Thanks for pointing
this out.

>  [...]  
> 
