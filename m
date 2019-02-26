From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Date: Tue, 26 Feb 2019 12:17:43 +0100
Message-ID: <20190226111743.GK20740@8bytes.org>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220142759.33308-2-jean-philippe.brucker@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, ashok.raj@intel.com, baolu.lu@linux.intel.com, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

Thanks for the patch! I think this is getting close to be applied after
the next merge window.

On Wed, Feb 20, 2019 at 02:27:59PM +0000, Jean-Philippe Brucker wrote:
> +int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
> +			  iommu_mm_exit_handler_t mm_exit, void *drvdata)

I think we are better of with introducing a sva-bind handle which can be
used to extend and further configure the binding done with this
function.

How about a 'struct iommu_sva' with an iommu-private definition that is
returned by this function:

	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
						struct mm_struct *mm);

and the corresponding unbind function:

	int iommu_sva_unbind_device(struct iommu_sva* *handle);

(Btw, does this need to return and int? Can unbinding fail?).

With that in place we can implement and extentable API base on the
handle:

	int iommu_sva_get_pasid(struct iommu_sva *handle);
	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
					iommu_mm_exit_handler_t mm_exit);

I think at least the AMD IOMMU driver needs more call-backs like a
handler that is invoked when a fault can not be resolved. And there
might be others in the future, putting them all in the parameter list of
the bind function doesn't scale well.

Regards,

	Joerg
