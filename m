From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 10/16] iommu: introduce device fault report API
Date: Thu, 18 Jan 2018 19:24:52 +0000
Message-ID: <6eea3b27-d0ca-8021-325f-fdc876ebf113@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1510944914-54430-11-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510944914-54430-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

I've got minor comments after working with this patch, sorry for the
multiple replies

On 17/11/17 18:55, Jacob Pan wrote:
[...]
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 829e9e9..97b7990 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -581,6 +581,12 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  		goto err_free_name;
>  	}
>  
> +	dev->iommu_param = kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);

This should be "sizeof(struct iommu_param)" or maybe
"sizeof(*dev->iommu_param)".

> +	if (!dev->iommu_param) {
> +		ret = -ENOMEM;
> +		goto err_free_name;
> +	}
> +
>  	kobject_get(group->devices_kobj);
>  
>  	dev->iommu_group = group;
> @@ -657,7 +663,7 @@ void iommu_group_remove_device(struct device *dev)
>  	sysfs_remove_link(&dev->kobj, "iommu_group");
>  
>  	trace_remove_device_from_group(group->id, dev);
> -
> +	kfree(dev->iommu_param);
>  	kfree(device->name);
>  	kfree(device);
>  	dev->iommu_group = NULL;
> @@ -791,6 +797,61 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
> 
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	struct iommu_param *idata = dev->iommu_param;
> +
> +	/*
> +	 * Device iommu_param should have been allocated when device is
> +	 * added to its iommu_group.
> +	 */
> +	if (!idata)
> +		return -EINVAL;
> +	/* Only allow one fault handler registered for each device */
> +	if (idata->fault_param)
> +		return -EBUSY;
> +	get_device(dev);
> +	idata->fault_param =
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
> +	if (!idata->fault_param)
> +		return -ENOMEM;
> +	idata->fault_param->handler = handler;
> +	idata->fault_param->data = data;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> +
> +int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	struct iommu_param *idata = dev->iommu_param;
> +
> +	if (!idata)
> +		return -EINVAL;
> +
> +	kfree(idata->fault_param);
> +	idata->fault_param = NULL;
> +	put_device(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);

We should probably document register() and unregister() functions since
they are part of the device driver API. If it helps I came up with:

/**
 * iommu_register_device_fault_handler() - Register a device fault handler
 * @dev: the device
 * @handler: the fault handler
 * @data: private data passed as argument to the handler
 *
 * When an IOMMU fault event is received, call this handler with the fault event
 * and data as argument. The handler should return 0. If the fault is
 * recoverable (IOMMU_FAULT_PAGE_REQ), the handler must also complete
 * the fault by calling iommu_page_response() with one of the following
 * response code:
 * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
 * - IOMMU_PAGE_RESP_INVALID: terminate the fault
 * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
 *   page faults if possible.
 *
 * Return 0 if the fault handler was installed successfully, or an error.
 */

/**
 * iommu_unregister_device_fault_handler() - Unregister the device fault handler
 * @dev: the device
 *
 * Remove the device fault handler installed with
 * iommu_register_device_fault_handler().
 *
 * Return 0 on success, or an error.
 */

Thanks,
Jean
