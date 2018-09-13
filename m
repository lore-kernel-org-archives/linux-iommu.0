From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH v2 06/12] iommu/vt-d: Add second level page table
 interface
Date: Thu, 13 Sep 2018 05:52:32 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191301901@SHSMSX101.ccr.corp.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
        <20180830013524.28743-7-baolu.lu@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C24@SHSMSX101.ccr.corp.intel.com>
        <331eef29-ae41-2d36-9487-265d773aae5b@linux.intel.com>
 <20180907174328.GA95061@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907174328.GA95061@otc-nc-03>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Raj, Ashok" <ashok.raj@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

> From: Raj, Ashok
> Sent: Saturday, September 8, 2018 1:43 AM
> 
> On Fri, Sep 07, 2018 at 10:47:11AM +0800, Lu Baolu wrote:
> >
> > >>+
> > >>+	intel_pasid_clear_entry(dev, pasid);
> > >>+
> > >>+	if (!ecap_coherent(iommu->ecap)) {
> > >>+		pte = intel_pasid_get_entry(dev, pasid);
> > >>+		clflush_cache_range(pte, sizeof(*pte));
> > >>+	}
> > >>+
> > >>+	pasid_based_pasid_cache_invalidation(iommu, did, pasid);
> > >>+	pasid_based_iotlb_cache_invalidation(iommu, did, pasid);
> > >>+
> > >>+	/* Device IOTLB doesn't need to be flushed in caching mode. */
> > >>+	if (!cap_caching_mode(iommu->cap))
> > >>+		pasid_based_dev_iotlb_cache_invalidation(iommu, dev,
> > >>pasid);
> > >
> > >can you elaborate, or point to any spec reference?
> > >
> >
> > In the driver, device iotlb doesn't get flushed in caching mode. I just
> > follow what have been done there.
> >
> > It also makes sense to me since only the bare metal host needs to
> > consider whether and how to flush the device iotlb.
> >
> 
> DavidW might remember, i think the idea was to help with cost
> of virtualization, we can avoid taking 2 exits vs handling
> it directly when we do iotlb flushing instead.
> 

OK, performance-wise it makes sense. though strictly speaking it
doesn't follow spec...

Thanks
Kevin
