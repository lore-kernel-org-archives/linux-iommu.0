From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2 01/11] iommu/vt-d: Cache PCI ATS state and Invalidate
	Queue Depth
Date: Mon, 27 Jul 2015 15:08:10 +0200
Message-ID: <20150727130810.GG27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150721001357.28145.83631.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150721001357.28145.83631.stgit-1RhO1Y9PlrlHTL0Zs8A6p/gx64E7kk8eUsxypvmhUTTZJqsBc5GL+g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 20, 2015 at 07:13:57PM -0500, Bjorn Helgaas wrote:
> We check the ATS state (enabled/disabled) and fetch the PCI ATS Invalidate
> Queue Depth in performance-sensitive paths.  It's easy to cache these,
> which removes dependencies on PCI.
> 
> Remember the ATS enabled state.  When enabling, read the queue depth once
> and cache it in the device_domain_info struct.  This is similar to what
> amd_iommu.c does.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c |   26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a98a7b2..50832f1 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -408,6 +408,10 @@ struct device_domain_info {
>  	struct list_head global; /* link to global list */
>  	u8 bus;			/* PCI bus number */
>  	u8 devfn;		/* PCI devfn number */
> +	struct {
> +		int enabled:1;
> +		u8 qdep;
> +	} ats;			/* ATS state */
>  	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
>  	struct intel_iommu *iommu; /* IOMMU used by this device */
>  	struct dmar_domain *domain; /* pointer to domain */
> @@ -1391,19 +1395,26 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
>  
>  static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  {
> +	struct pci_dev *pdev;
> +
>  	if (!info || !dev_is_pci(info->dev))
>  		return;
>  
> -	pci_enable_ats(to_pci_dev(info->dev), VTD_PAGE_SHIFT);
> +	pdev = to_pci_dev(info->dev);
> +	if (pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> +		return;
> +
> +	info->ats.enabled = 1;
> +	info->ats.qdep = pci_ats_queue_depth(pdev);

Hmm, this is a place where the relaxed error handling in
pci_enable_ats() can get problematic. If ATS is (by accident or a bug
elsewhere) already enabled an the function returns -EINVAL, the IOMMU
driver considers ATS disabled and doesn't flush the IO/TLBs of the
device. This can cause data corruption later on, so we should make sure
that info->ats.enabled is consistent with pdev->ats_enabled.


	Joerg
