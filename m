From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 21/33] iommu/vt-d: Make get_domain_for_dev() take struct
	device
Date: Mon, 14 Apr 2014 15:22:21 -0600
Message-ID: <1397510541.3060.15.camel@ul30vt.home>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
	<1395422354-19762-22-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-22-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2014-03-21 at 17:19 +0000, David Woodhouse wrote:
> Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 75 ++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 741fb1d..05c5214 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2207,52 +2207,51 @@ static struct dmar_domain *dmar_insert_dev_info(struct intel_iommu *iommu,
>  }
>  
>  /* domain is initialized */
> -static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
> +static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
>  {
>  	struct dmar_domain *domain, *free = NULL;
>  	struct intel_iommu *iommu = NULL;
>  	struct device_domain_info *info;
> -	struct dmar_drhd_unit *drhd;
> -	struct pci_dev *dev_tmp;
> +	struct pci_dev *dev_tmp = NULL;
>  	unsigned long flags;
> -	int bus = 0, devfn = 0;
> -	int segment;
> +	u8 bus, devfn, bridge_bus, bridge_devfn;
>  
> -	domain = find_domain(&pdev->dev);
> +	domain = find_domain(dev);
>  	if (domain)
>  		return domain;
>  
> -	segment = pci_domain_nr(pdev->bus);
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		u16 segment;
>  
> -	dev_tmp = pci_find_upstream_pcie_bridge(pdev);
> -	if (dev_tmp) {
> -		if (pci_is_pcie(dev_tmp)) {
> -			bus = dev_tmp->subordinate->number;
> -			devfn = 0;
> -		} else {
> -			bus = dev_tmp->bus->number;
> -			devfn = dev_tmp->devfn;
> -		}
> -		spin_lock_irqsave(&device_domain_lock, flags);
> -		info = dmar_search_domain_by_dev_info(segment, bus, devfn);
> -		if (info) {
> -			iommu = info->iommu;
> -			domain = info->domain;
> +		segment = pci_domain_nr(pdev->bus);
> +		dev_tmp = pci_find_upstream_pcie_bridge(pdev);
> +		if (dev_tmp) {
> +			if (pci_is_pcie(dev_tmp)) {
> +				bridge_bus = dev_tmp->subordinate->number;
> +				bridge_devfn = 0;
> +			} else {
> +				bridge_bus = dev_tmp->bus->number;
> +				bridge_devfn = dev_tmp->devfn;
> +			}
> +			spin_lock_irqsave(&device_domain_lock, flags);
> +			info = dmar_search_domain_by_dev_info(segment, bus, devfn);


bus and devfn are uninitialized here, CID 1197747 & 1197746.  Thanks,

Alex


> +			if (info) {
> +				iommu = info->iommu;
> +				domain = info->domain;
> +			}
> +			spin_unlock_irqrestore(&device_domain_lock, flags);
> +			/* pcie-pci bridge already has a domain, uses it */
> +			if (info)
> +				goto found_domain;
>  		}
> -		spin_unlock_irqrestore(&device_domain_lock, flags);
> -		if (info)
> -			goto found_domain;
>  	}
>  
> -	drhd = dmar_find_matched_drhd_unit(pdev);
> -	if (!drhd) {
> -		printk(KERN_ERR "IOMMU: can't find DMAR for device %s\n",
> -			pci_name(pdev));
> -		return NULL;
> -	}
> -	iommu = drhd->iommu;
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		goto error;
>  
> -	/* Allocate and intialize new domain for the device */
> +	/* Allocate and initialize new domain for the device */
>  	domain = alloc_domain(false);
>  	if (!domain)
>  		goto error;
> @@ -2266,15 +2265,14 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
>  
>  	/* register pcie-to-pci device */
>  	if (dev_tmp) {
> -		domain = dmar_insert_dev_info(iommu, bus, devfn, NULL,
> -					      domain);
> +		domain = dmar_insert_dev_info(iommu, bridge_bus, bridge_devfn,
> +					      NULL, domain);
>  		if (!domain)
>  			goto error;
>  	}
>  
>  found_domain:
> -	domain = dmar_insert_dev_info(iommu, pdev->bus->number,
> -				      pdev->devfn, &pdev->dev, domain);
> +	domain = dmar_insert_dev_info(iommu, bus, devfn, dev, domain);
>  error:
>  	if (free != domain)
>  		domain_exit(free);
> @@ -2320,7 +2318,7 @@ static int iommu_prepare_identity_map(struct pci_dev *pdev,
>  	struct dmar_domain *domain;
>  	int ret;
>  
> -	domain = get_domain_for_dev(pdev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
> +	domain = get_domain_for_dev(&pdev->dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
>  	if (!domain)
>  		return -ENOMEM;
>  
> @@ -2864,8 +2862,7 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct pci_dev *pdev)
>  	struct dmar_domain *domain;
>  	int ret;
>  
> -	domain = get_domain_for_dev(pdev,
> -			DEFAULT_DOMAIN_ADDRESS_WIDTH);
> +	domain = get_domain_for_dev(&pdev->dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
>  	if (!domain) {
>  		printk(KERN_ERR
>  			"Allocating domain for %s failed", pci_name(pdev));
