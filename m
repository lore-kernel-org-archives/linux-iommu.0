From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 7/8] iommu/amd: Don't update domain info to dte entry
	at iommu init stage
Date: Tue, 20 Sep 2016 14:50:04 +0200
Message-ID: <20160920125004.GF3541@8bytes.org>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
	<1473951806-25511-8-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473951806-25511-8-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 15, 2016 at 11:03:25PM +0800, Baoquan He wrote:
> AMD iommu creates protection domain and assign each device to it during
> iommu driver initialization stage. This happened just after system pci
> bus scanning stage, and much earlier than device driver init stage. So
> at this time if in kdump kernel the domain info, especially pte_root,
> can't be updated to dte entry. We should wait until device driver init
> stage.
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index fcb69ff..6c37300 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -137,6 +137,7 @@ struct iommu_dev_data {
>  	bool pri_tlp;			  /* PASID TLB required for
>  					     PPR completions */
>  	u32 errata;			  /* Bitmap for errata to apply */
> +	bool domain_updated;
>  };
>  
>  /*
> @@ -1708,6 +1709,15 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
>  {
>  	u64 pte_root = 0;
>  	u64 flags = 0;
> +	struct iommu_dev_data *dev_data;
> +	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
> +
> +	dev_data = find_dev_data(devid);
> +        if (!dev_data)
> +                return;
> +
> +	if (translation_pre_enabled(iommu) && !dev_data->domain_updated)
> +		return;
>  
>  	if (domain->mode != PAGE_MODE_NONE)
>  		pte_root = virt_to_phys(domain->pt_root);
> @@ -1756,6 +1766,14 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
>  
>  static void clear_dte_entry(u16 devid)
>  {
> +	struct iommu_dev_data *dev_data;
> +	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
> +
> +	dev_data = find_dev_data(devid);
> +        if (!dev_data)
> +                return;
> +	if (translation_pre_enabled(iommu) && !dev_data->domain_updated)
> +		return;

This should be moved to do_attach/do_detach. There you also already have
the dev_data you need here.

>  	/* remove entry from the device table seen by the hardware */
>  	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
>  	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
> -- 
> 2.5.5
> 
