From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu: narrow the search range by iterating on current bus
Date: Thu, 28 Jul 2016 09:01:32 -0600
Message-ID: <20160728090132.42c6ebc1@t450s.home>
References: <1469717579-8244-1-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1469717579-8244-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 28 Jul 2016 14:52:59 +0000
Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> According to the comments and code, get_pci_function_alias_group() and
> get_pci_alias_group() do the search on the same pci bus. This means we can
> just iterate on the bus the pci device attaches to.
> 
> This patch narrows the search range by just iterating on the current bus
> and fix one typo in comment.
> 
> Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/iommu.c |   22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3000051..0338a81 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -643,17 +643,15 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
>  	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>  		return NULL;
>  
> -	for_each_pci_dev(tmp) {
> -		if (tmp == pdev || tmp->bus != pdev->bus ||
> +	list_for_each_entry(tmp, &pdev->bus->devices, bus_list) {

I believe this was using for_each_pci_dev() exactly because it takes a
reference to the device and therefore we can use it to get a reference
to the group.  How do you justify removing these reference semantics?
Thanks,

Alex

> +		if (tmp == pdev ||
>  		    PCI_SLOT(tmp->devfn) != PCI_SLOT(pdev->devfn) ||
>  		    pci_acs_enabled(tmp, REQ_ACS_FLAGS))
>  			continue;
>  
>  		group = get_pci_alias_group(tmp, devfns);
> -		if (group) {
> -			pci_dev_put(tmp);
> +		if (group)
>  			return group;
> -		}
>  	}
>  
>  	return NULL;
> @@ -681,23 +679,19 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>  	if (group)
>  		return group;
>  
> -	for_each_pci_dev(tmp) {
> -		if (tmp == pdev || tmp->bus != pdev->bus)
> +	list_for_each_entry(tmp, &pdev->bus->devices, bus_list) {
> +		if (tmp == pdev)
>  			continue;
>  
>  		/* We alias them or they alias us */
>  		if (pci_devs_are_dma_aliases(pdev, tmp)) {
>  			group = get_pci_alias_group(tmp, devfns);
> -			if (group) {
> -				pci_dev_put(tmp);
> +			if (group)
>  				return group;
> -			}
>  
>  			group = get_pci_function_alias_group(tmp, devfns);
> -			if (group) {
> -				pci_dev_put(tmp);
> +			if (group)
>  				return group;
> -			}
>  		}
>  	}
>  
> @@ -794,7 +788,7 @@ struct iommu_group *pci_device_group(struct device *dev)
>  
>  	/*
>  	 * Look for existing groups on non-isolated functions on the same
> -	 * slot and aliases of those funcions, if any.  No need to clear
> +	 * slot and aliases of those functions, if any. No need to clear
>  	 * the search bitmap, the tested devfns are still valid.
>  	 */
>  	group = get_pci_function_alias_group(pdev, (unsigned long *)devfns);
