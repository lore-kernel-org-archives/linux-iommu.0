From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Date: Wed, 27 Feb 2019 13:41:29 -0800
Message-ID: <20190227134129.51ad42ac@jacob-builder>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
        <20190220142759.33308-2-jean-philippe.brucker@arm.com>
        <20190226111743.GK20740@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226111743.GK20740@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, ashok.raj@intel.com, baolu.lu@linux.intel.com, alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 26 Feb 2019 12:17:43 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Jean-Philippe,
> 
> Thanks for the patch! I think this is getting close to be applied
> after the next merge window.
> 
> On Wed, Feb 20, 2019 at 02:27:59PM +0000, Jean-Philippe Brucker wrote:
> > +int iommu_sva_bind_device(struct device *dev, struct mm_struct
> > *mm, int *pasid,
> > +			  iommu_mm_exit_handler_t mm_exit, void
> > *drvdata)  
> 
> I think we are better of with introducing a sva-bind handle which can
> be used to extend and further configure the binding done with this
> function.
> 
> How about a 'struct iommu_sva' with an iommu-private definition that
> is returned by this function:
> 
> 	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> 						struct mm_struct *mm);
> 
Just trying to understand how to use this API.
So if we bind the same mm to two different devices, we should get two
different iommu_sva handle, right?
I think intel-svm still needs a flag argument for supervisor pasid etc.
Other than that, I think both interface should work for vt-d.

Another question is that for nested SVA, we will need to bind guest mm.
Do you think we should try to reuse this or have it separate? I am
working on a separate API for now.

> and the corresponding unbind function:
> 
> 	int iommu_sva_unbind_device(struct iommu_sva* *handle);
> 
> (Btw, does this need to return and int? Can unbinding fail?).
> 
> With that in place we can implement and extentable API base on the
> handle:
> 
> 	int iommu_sva_get_pasid(struct iommu_sva *handle);
If multiple bind to the same mm gets multiple handles, this API should
retrieve the same pasid for different handle?

Just curious why making
the handle private instead of returning the pasid value in the handle?

> 	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
> 					iommu_mm_exit_handler_t
> mm_exit);
> 
> I think at least the AMD IOMMU driver needs more call-backs like a
> handler that is invoked when a fault can not be resolved. And there
> might be others in the future, putting them all in the parameter list
> of the bind function doesn't scale well.
> 

> Regards,
> 
> 	Joerg
