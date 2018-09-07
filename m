From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Add second level page table
 interface
Date: Fri, 7 Sep 2018 10:43:28 -0700
Message-ID: <20180907174328.GA95061@otc-nc-03>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-7-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2C24@SHSMSX101.ccr.corp.intel.com>
 <331eef29-ae41-2d36-9487-265d773aae5b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <331eef29-ae41-2d36-9487-265d773aae5b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 07, 2018 at 10:47:11AM +0800, Lu Baolu wrote:
> 
> >>+
> >>+	intel_pasid_clear_entry(dev, pasid);
> >>+
> >>+	if (!ecap_coherent(iommu->ecap)) {
> >>+		pte = intel_pasid_get_entry(dev, pasid);
> >>+		clflush_cache_range(pte, sizeof(*pte));
> >>+	}
> >>+
> >>+	pasid_based_pasid_cache_invalidation(iommu, did, pasid);
> >>+	pasid_based_iotlb_cache_invalidation(iommu, did, pasid);
> >>+
> >>+	/* Device IOTLB doesn't need to be flushed in caching mode. */
> >>+	if (!cap_caching_mode(iommu->cap))
> >>+		pasid_based_dev_iotlb_cache_invalidation(iommu, dev,
> >>pasid);
> >
> >can you elaborate, or point to any spec reference?
> >
> 
> In the driver, device iotlb doesn't get flushed in caching mode. I just
> follow what have been done there.
> 
> It also makes sense to me since only the bare metal host needs to
> consider whether and how to flush the device iotlb.
> 

DavidW might remember, i think the idea was to help with cost
of virtualization, we can avoid taking 2 exits vs handling
it directly when we do iotlb flushing instead.

the other optimization was to only do devtlb flushing when you unmap 
since when establish not-present to present there is no need to 
flush devtlb at that point.
