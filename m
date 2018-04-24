From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
Date: Mon, 23 Apr 2018 21:32:33 -0400
Message-ID: <57d77955-caa7-ddac-df7d-7eef1f05dbb2@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-4-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180212183352.22730-4-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> /**
>   * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a device
>   * @dev: the device
> @@ -129,7 +439,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_device_shutdown);
>  int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>  			  unsigned long flags, void *drvdata)
>  {
> +	int i, ret;
> +	struct io_mm *io_mm = NULL;
>  	struct iommu_domain *domain;
> +	struct iommu_bond *bond = NULL, *tmp;
>  	struct iommu_param *dev_param = dev->iommu_param;
>  
>  	domain = iommu_get_domain_for_dev(dev);
> @@ -145,7 +458,42 @@ int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>  	if (flags != (IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF))
>  		return -EINVAL;
>  
> -	return -ENOSYS; /* TODO */
> +	/* If an io_mm already exists, use it */
> +	spin_lock(&iommu_sva_lock);
> +	idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
> +		if (io_mm->mm != mm || !io_mm_get_locked(io_mm))
> +			continue;
> +
> +		/* Is it already bound to this device? */
> +		list_for_each_entry(tmp, &io_mm->devices, mm_head) {
> +			if (tmp->dev != dev)
> +				continue;
> +
> +			bond = tmp;
> +			refcount_inc(&bond->refs);
> +			io_mm_put_locked(io_mm);
> +			break;
> +		}
> +		break;
> +	}
> +	spin_unlock(&iommu_sva_lock);
> +
> +	if (bond)

Please return pasid when you find an io_mm that is already bound. Something like
*pasid = io_mm->pasid should do the work here when bond is true.

> +		return 0;


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
