From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] IOMMU: enhance dmar to support device hotplug
Date: Tue, 4 Mar 2014 15:31:58 +0100
Message-ID: <20140304143158.GC2799@8bytes.org>
References: <1385022116-228-1-git-send-email-wangyijing@huawei.com>
	<1385022116-228-2-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385022116-228-2-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 21, 2013 at 04:21:56PM +0800, Yijing Wang wrote:
> @@ -3641,21 +3681,42 @@ static int device_notifier(struct notifier_block *nb,
>  	struct device *dev = data;
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct dmar_domain *domain;
> +	struct dmar_device *dmar_dev;
> +	struct dmar_drhd_unit *drhd;
>  
> -	if (iommu_no_mapping(dev))
> -		return 0;
> -
> -	domain = find_domain(pdev);
> -	if (!domain)
> -		return 0;
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		for_each_drhd_unit(drhd)
> +			list_for_each_entry(dmar_dev, &drhd->devices, list)
> +				if (dmar_dev->segment == pci_domain_nr(pdev->bus)
> +					&& dmar_dev->bus == pdev->bus->number
> +					&& dmar_dev->devfn == pdev->devfn)
> +					dmar_dev->pdev = pci_dev_get(pdev);
> +		break;
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		for_each_drhd_unit(drhd)
> +			list_for_each_entry(dmar_dev, &drhd->devices, list)
> +				if (dmar_dev->pdev == pdev) {
> +					pci_dev_put(pdev);
> +					dmar_dev->pdev = NULL;
> +				}

How is that synchronized with other users of this dmar_dev structure.
Could it happen that you drop the device reference while other parts of
the driver still use it?


	Joerg
