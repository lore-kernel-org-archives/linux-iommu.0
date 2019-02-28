From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Date: Thu, 28 Feb 2019 13:15:49 -0800
Message-ID: <20190228131549.6c0e5fad@jacob-builder>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
        <20190220142759.33308-2-jean-philippe.brucker@arm.com>
        <20190226111743.GK20740@8bytes.org>
        <20190227134129.51ad42ac@jacob-builder>
        <20190228140950.GD1594@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228140950.GD1594@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, ashok.raj@intel.com, baolu.lu@linux.intel.com, alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Thu, 28 Feb 2019 15:09:50 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Jacob,
> 
> On Wed, Feb 27, 2019 at 01:41:29PM -0800, Jacob Pan wrote:
> > On Tue, 26 Feb 2019 12:17:43 +0100
> > Joerg Roedel <joro@8bytes.org> wrote:  
> 
> > Just trying to understand how to use this API.
> > So if we bind the same mm to two different devices, we should get
> > two different iommu_sva handle, right?
> > I think intel-svm still needs a flag argument for supervisor pasid
> > etc. Other than that, I think both interface should work for vt-d.  
> 
> I second Jean's question here, is supervisor pasid still needed with
> scalable mode? What is the use-case and which mm_struct will be used
> for supervisor accesses?
> 
I will delegate this to Ashok.

> > Another question is that for nested SVA, we will need to bind guest
> > mm. Do you think we should try to reuse this or have it separate? I
> > am working on a separate API for now.  
> 
> I think a separate API makes more sense. It could be somehow fit into
> this as well, but having it separate is cleaner. And we already have
> separate API for aux-domains, so this would be just another extension
> of the IOMMU-API for using PASIDs.
> 
Agreed.
> 
> > > 	int iommu_sva_get_pasid(struct iommu_sva *handle);  
> > If multiple bind to the same mm gets multiple handles, this API
> > should retrieve the same pasid for different handle?  
> 
> It can return the same handle if we store the pasid in the mm_struct,
> for example ...
> > Just curious why making the handle private instead of returning the
> > pasid value in the handle?  
> 
> ... which is also the reason why I prefer the accessor function, it
> allows to have the pasid not in the iommu_sva handle, but to retrieve
> it from somewhere else (like the mm_struct).
make sense, more flexible storage and controlled access too. thanks for
explaining.


Jacob
