From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Date: Tue, 26 Feb 2019 14:02:04 +0100
Message-ID: <20190226130204.GA23259@8bytes.org>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
 <20190226111743.GK20740@8bytes.org>
 <559a7ef6-8591-3936-b208-3bbae555a15a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559a7ef6-8591-3936-b208-3bbae555a15a@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, christian.koenig@amd.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 26, 2019 at 12:49:15PM +0000, Jean-Philippe Brucker wrote:
> On 26/02/2019 11:17, Joerg Roedel wrote:
> > 	int iommu_sva_get_pasid(struct iommu_sva *handle);
> > 	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
> > 					iommu_mm_exit_handler_t mm_exit);
> 
> Ok sounds good. It doesn't look like this interface requires a lot of
> changes on my side (iommu_sva corresponds to the iommu_bond structure
> I've been using internally) but I might find problems while implementing it.

Great!

> Device drivers will also want to have some private data to easily
> identify the faulting or exiting context. How about:
> 
>     struct iommu_sva_ops {
>         void (*mm_exit)(struct iommu_sva *handle, void *drvdata);
>     };
>     int iommu_sva_set_ops(struct iommu_sva *handle,
>                           const struct iommu_sva_ops *ops,
>                           void *drvdata);

Okay, we can also do it this way. But then please pass the drvdata via
the bind() call and not via set_ops(). Set_ops() should then really only
pass the call-backs, as the name implies.

> I now think that device driver should always call unbind() to release
> the iommu_sva handle, even if they got notified by mm_exit.

Yes, this should be required. I think it also makes driver
implementation easier because it doesn't need to care too much about
this special case.

Regards,

	Joerg
