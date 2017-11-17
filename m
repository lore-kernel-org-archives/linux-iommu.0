From: Bharat Kumar Gogada <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFCv2 PATCH 31/36] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Fri, 17 Nov 2017 06:11:17 +0000
Message-ID: <BLUPR0201MB1505BC86D3838D13F38665E7A52F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
	<20171006133203.22803-32-jean-philippe.brucker@arm.com>
	<BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
	<673fda01-2ae0-87e4-637e-fe27096b6be0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <673fda01-2ae0-87e4-637e-fe27096b6be0-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master, &smmu_domain->devices, list)
> +		arm_smmu_atc_inv_master(master, &cmd);
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +
> +	return size;
> +}
> +
>  /* IOMMU API */
>  static bool arm_smmu_capable(enum iommu_cap cap)  { @@ -2361,6 +2506,8 @@ static void arm_smmu_detach_dev(struct device *dev)
>  		__iommu_process_unbind_dev_all(&smmu_domain->domain, dev);
>  
>  	if (smmu_domain) {
> +		arm_smmu_atc_inv_master_all(master, 0);
> +
> In BIND flow, when VFIO_IOMMU_UNBIND is invoked invalidation is sent on allocated PASID for this application.
> When vfio group fd is closed after UNBIND,  arm_smmu_detach_dev is invoked now invalidation is being sent on ssid zero.
> Why  invalidation needs to be sent on ssid zero ?

It's possible to use bind/unbind and map/unmap APIs at the same time on a domain. map/unmap modifies non-ssid mappings as usual, for context descriptor 0. Note that SSID 0 is converted to "no SSID" by arm_smmu_atc_inv_to_cmd.

That said, I think VFIO cleans all DMA mappings when the VFIO group fd is closed, which will send individual ATC invalidation for each mapping. But VFIO may not be the only user of this API, and future users may be less careful. It's safer to send this global invalidation whenever we detach the domain, to ensure we're not leaving stale ATC entries for the next user.

Thanks Jean, I see that currently vfio_group_fops_open does not allow multiple instances. 
If a device supports multiple PASID there might be different applications running parallel. 
So why is multiple instances restricted ?

Regards,
Bharat
