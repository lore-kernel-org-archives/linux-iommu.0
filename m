From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
Date: Tue, 13 Mar 2018 10:40:26 +0100
Message-ID: <8903307.QazHKW0JrR@aspire.rjw.lan>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org> <20180313085534.11650-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313085534.11650-2-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will.deacon@arm.com, robdclark@gmail.com, tfiga@chromium.org, sricharan@codeaurora.org, m.szyprowski@samsung.com, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday, March 13, 2018 9:55:30 AM CET Vivek Gautam wrote:
> The lists managing the device-links can be traversed to
> find the link between two devices. The device_link_add() APIs
> does traverse these lists to check if there's already a link
> setup between the two devices.
> So, add a new APIs, device_link_find(), to find an existing
> device link between two devices - suppliers and consumers.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
>  * New patch added to this series.
> 
>  drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>  include/linux/device.h |  2 ++
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5847364f25d9..e8c9774e4ba2 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>  	return 0;
>  }
>  
> +/**
> + * device_link_find - find any existing link between two devices.
> + * @consumer: Consumer end of the link.
> + * @supplier: Supplier end of the link.
> + *
> + * Returns pointer to the existing link between a supplier and
> + * and consumer devices, or NULL if no link exists.
> + */
> +struct device_link *device_link_find(struct device *consumer,
> +				     struct device *supplier)
> +{
> +	struct device_link *link = NULL;
> +
> +	if (!consumer || !supplier)
> +		return NULL;
> +
> +	list_for_each_entry(link, &supplier->links.consumers, s_node)
> +		if (link->consumer == consumer)
> +			break;
> +

Any mutual exclusion?

Or is the caller expected to take care of it?  And if so, then how?

> +	return link;
> +}
> +EXPORT_SYMBOL_GPL(device_link_find);
> +
>  /**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
> @@ -195,9 +219,9 @@ struct device_link *device_link_add(struct device *consumer,
>  		goto out;
>  	}
>  
> -	list_for_each_entry(link, &supplier->links.consumers, s_node)
> -		if (link->consumer == consumer)
> -			goto out;
> +	link = device_link_find(consumer, supplier);
> +	if (link)
> +		goto out;
>  
>  	link = kzalloc(sizeof(*link), GFP_KERNEL);
>  	if (!link)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405ed525..13bc1884c3eb 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1278,6 +1278,8 @@ extern const char *dev_driver_string(const struct device *dev);
>  struct device_link *device_link_add(struct device *consumer,
>  				    struct device *supplier, u32 flags);
>  void device_link_del(struct device_link *link);
> +struct device_link *device_link_find(struct device *consumer,
> +				     struct device *supplier);
>  
>  #ifdef CONFIG_PRINTK
>  
> 
