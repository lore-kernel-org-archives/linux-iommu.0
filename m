From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 10/16] iommu: introduce device fault report API
Date: Wed, 10 Jan 2018 12:39:59 +0000
Message-ID: <f612ccea-fd59-38d5-0d16-465645f3b443@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1510944914-54430-11-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510944914-54430-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Jean Delvare <khali@linux-fr.org>
List-Id: iommu@lists.linux-foundation.org

On 17/11/17 18:55, Jacob Pan wrote:
[...]
> +static inline int iommu_register_device_fault_handler(struct device *dev,
> +						iommu_dev_fault_handler_t handler,
> +						void *data)
> +{
> +	return 0;> +}
> +
> +static inline int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static inline bool iommu_has_device_fault_handler(struct device *dev)
> +{
> +	return false;
> +}
> +
> +static inline int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	return 0;
> +}

Not too important but these stubs, when CONFIG_IOMMU_API is disabled,
usually return an error value (-ENODEV) instead of 0.

Thanks,
Jean

> +
>  static inline int iommu_group_id(struct iommu_group *group)
>  {
>  	return -ENODEV;
> 
