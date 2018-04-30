From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 12/22] iommu: introduce device fault report API
Date: Mon, 30 Apr 2018 11:54:56 -0700
Message-ID: <20180430115456.54a4b22e@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
        <b9175586-e638-c807-3ef0-f0e0bc1b8243@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b9175586-e638-c807-3ef0-f0e0bc1b8243@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 30 Apr 2018 17:53:52 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi,
> 
> I noticed a couple issues when testing
> 
> On 16/04/18 22:49, Jacob Pan wrote:
> > +int iommu_register_device_fault_handler(struct device *dev,
> > +					iommu_dev_fault_handler_t
> > handler,
> > +					void *data)
> > +{
> > +	struct iommu_param *param = dev->iommu_param;
> > +
> > +	/*
> > +	 * Device iommu_param should have been allocated when
> > device is
> > +	 * added to its iommu_group.
> > +	 */
> > +	if (!param)
> > +		return -EINVAL;
> > +
> > +	/* Only allow one fault handler registered for each device
> > */
> > +	if (param->fault_param)
> > +		return -EBUSY;  
> 
> Should this be inside the param lock? We probably don't expect
> concurrent register/unregister but it seems cleaner
agreed, same as corrections below. Thanks!
> 
>  [...]  
> 
> We should return EINVAL here, if fault_param is NULL. That way users
> can call unregister_fault_handler unconditionally in their cleanup
> paths
> 
> > +	/* we cannot unregister handler if there are pending
> > faults */
> > +	if (list_empty(&param->fault_param->faults)) {  
> 
> if (!list_empty(...))
> 
> > +		ret = -EBUSY;
> > +		goto unlock;
> > +	}
> > +
> > +	list_del(&param->fault_param->faults);  
> 
> faults is the list head, no need for list_del
> 
> > +	kfree(param->fault_param);
> > +	param->fault_param = NULL;
> > +	put_device(dev);
> > +
> > +unlock:
> > +	mutex_unlock(&param->lock);
> > +
> > +	return 0;  
> 
> return ret
> 
> Thanks,
> Jean

[Jacob Pan]
