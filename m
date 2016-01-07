From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] iommu/amd: Manage iommu_group for non-pci devices
Date: Thu, 7 Jan 2016 13:06:59 +0100
Message-ID: <20160107120659.GC19149@8bytes.org>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
	<1451988444-4694-7-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451988444-4694-7-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 05, 2016 at 05:07:24AM -0500, Wan Zongshun wrote:
> +static struct iommu_group *amd_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +
> +	return acpihid_device_group(dev);
> +}
> +
>  /*****************************************************************************
>   *
>   * The next functions belong to the dma_ops mapping/unmapping code.
> @@ -3202,7 +3233,7 @@ static const struct iommu_ops amd_iommu_ops = {
>  	.iova_to_phys = amd_iommu_iova_to_phys,
>  	.add_device = amd_iommu_add_device,
>  	.remove_device = amd_iommu_remove_device,
> -	.device_group = pci_device_group,
> +	.device_group = amd_iommu_device_group,

Does this work? Which bus do the ACPIHID devices belong to (what does
dev->bus point to)? If it is not &pci_bus_type, then the iommu core code
will not create an iommu group for the devices.


	Joerg
