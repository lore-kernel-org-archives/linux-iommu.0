From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Date: Tue, 26 Feb 2019 12:49:15 +0000
Message-ID: <559a7ef6-8591-3936-b208-3bbae555a15a@arm.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
 <20190226111743.GK20740@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226111743.GK20740@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, christian.koenig@amd.com
List-Id: iommu@lists.linux-foundation.org

On 26/02/2019 11:17, Joerg Roedel wrote:
> Hi Jean-Philippe,
> 
> Thanks for the patch! I think this is getting close to be applied after
> the next merge window.
> 
> On Wed, Feb 20, 2019 at 02:27:59PM +0000, Jean-Philippe Brucker wrote:
>> +int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>> +			  iommu_mm_exit_handler_t mm_exit, void *drvdata)
> 
> I think we are better of with introducing a sva-bind handle which can be
> used to extend and further configure the binding done with this
> function.
> 
> How about a 'struct iommu_sva' with an iommu-private definition that is
> returned by this function:
> 
> 	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> 						struct mm_struct *mm);
> 
> and the corresponding unbind function:
> 
> 	int iommu_sva_unbind_device(struct iommu_sva* *handle);
> 
> (Btw, does this need to return and int? Can unbinding fail?).

With the pasid-based interface, unbind would have failed if the mm had
exited before the device driver called unbind (and with invalid
parameters). But even then returning an error is only useful for debug,
since callers usually can't handle or propagate release errors.

> With that in place we can implement and extentable API base on the
> handle:
> 
> 	int iommu_sva_get_pasid(struct iommu_sva *handle);
> 	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
> 					iommu_mm_exit_handler_t mm_exit);

Ok sounds good. It doesn't look like this interface requires a lot of
changes on my side (iommu_sva corresponds to the iommu_bond structure
I've been using internally) but I might find problems while implementing it.

> I think at least the AMD IOMMU driver needs more call-backs like a
> handler that is invoked when a fault can not be resolved. And there
> might be others in the future, putting them all in the parameter list of
> the bind function doesn't scale well.

Device drivers will also want to have some private data to easily
identify the faulting or exiting context. How about:

    struct iommu_sva_ops {
        void (*mm_exit)(struct iommu_sva *handle, void *drvdata);
    };
    int iommu_sva_set_ops(struct iommu_sva *handle,
                          const struct iommu_sva_ops *ops,
                          void *drvdata);

I now think that device driver should always call unbind() to release
the iommu_sva handle, even if they got notified by mm_exit.

Thanks,
Jean
