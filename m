From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 12/22] iommu: introduce device fault report API
Date: Mon, 30 Apr 2018 17:53:52 +0100
Message-ID: <b9175586-e638-c807-3ef0-f0e0bc1b8243@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523915351-54415-13-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

I noticed a couple issues when testing

On 16/04/18 22:49, Jacob Pan wrote:
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +
> +	/*
> +	 * Device iommu_param should have been allocated when device is
> +	 * added to its iommu_group.
> +	 */
> +	if (!param)
> +		return -EINVAL;
> +
> +	/* Only allow one fault handler registered for each device */
> +	if (param->fault_param)
> +		return -EBUSY;

Should this be inside the param lock? We probably don't expect
concurrent register/unregister but it seems cleaner

> +
> +	mutex_lock(&param->lock);
> +	get_device(dev);
> +	param->fault_param =
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_ATOMIC);
> +	if (!param->fault_param) {
> +		put_device(dev);
> +		mutex_unlock(&param->lock);
> +		return -ENOMEM;
> +	}
> +	mutex_init(&param->fault_param->lock);
> +	param->fault_param->handler = handler;
> +	param->fault_param->data = data;
> +	INIT_LIST_HEAD(&param->fault_param->faults);
> +
> +	mutex_unlock(&param->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> +
> +/**
> + * iommu_unregister_device_fault_handler() - Unregister the device fault handler
> + * @dev: the device
> + *
> + * Remove the device fault handler installed with
> + * iommu_register_device_fault_handler().
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = 0;
> +
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);

We should return EINVAL here, if fault_param is NULL. That way users can
call unregister_fault_handler unconditionally in their cleanup paths

> +	/* we cannot unregister handler if there are pending faults */
> +	if (list_empty(&param->fault_param->faults)) {

if (!list_empty(...))

> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	list_del(&param->fault_param->faults);

faults is the list head, no need for list_del

> +	kfree(param->fault_param);
> +	param->fault_param = NULL;
> +	put_device(dev);
> +
> +unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return 0;

return ret

Thanks,
Jean
