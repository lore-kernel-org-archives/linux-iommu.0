From: "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3] iommu/fsl_pamu: Use dev_is_pci() to check whether
	it is	pci device
Date: Tue, 10 Dec 2013 07:03:43 +0000
Message-ID: <e6c109cb73384650b07de2361c08f9ba@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1386243769-22672-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386243769-22672-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Yijing Wang
> Sent: Thursday, December 05, 2013 5:13 PM
> To: Alex Williamson; Joerg Roedel
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> Hanjun Guo
> Subject: [PATCH 2/3] iommu/fsl_pamu: Use dev_is_pci() to check whether it
> is pci device
> 
> Use PCI standard marco dev_is_pci() instead of directly compare
> pci_bus_type to check whether it is pci device.
> 
> Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu_domain.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index c857c30..93072ba 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -691,7 +691,7 @@ static int fsl_pamu_attach_device(struct iommu_domain
> *domain,
>  	 * Use LIODN of the PCI controller while attaching a
>  	 * PCI device.
>  	 */
> -	if (dev->bus == &pci_bus_type) {
> +	if (dev_is_pci(dev)) {
>  		pdev = to_pci_dev(dev);
>  		pci_ctl = pci_bus_to_host(pdev->bus);
>  		/*
> @@ -729,7 +729,7 @@ static void fsl_pamu_detach_device(struct
> iommu_domain *domain,
>  	 * Use LIODN of the PCI controller while detaching a
>  	 * PCI device.
>  	 */
> -	if (dev->bus == &pci_bus_type) {
> +	if (dev_is_pci(dev)) {
>  		pdev = to_pci_dev(dev);
>  		pci_ctl = pci_bus_to_host(pdev->bus);
>  		/*
> @@ -1056,7 +1056,7 @@ static int fsl_pamu_add_device(struct device *dev)
>  	 * For platform devices we allocate a separate group for
>  	 * each of the devices.
>  	 */
> -	if (dev->bus == &pci_bus_type) {
> +	if (dev_is_pci(dev)) {
>  		pdev = to_pci_dev(dev);
>  		/* Don't create device groups for virtual PCI bridges */
>  		if (pdev->subordinate)
> --
> 1.7.1
Acked-by: Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
