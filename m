From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] On unmap, flush IOMMU TLB and return correct size
Date: Mon, 02 Sep 2013 22:25:40 -0600
Message-ID: <1378182340.3246.19.camel@ul30vt.home>
References: <CE494510.41547%hshankar@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CE494510.41547%hshankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Cc: "Singh, Varinder" <Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Sundaram,
	Rajesh" <Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Kimmel,
	Jeff" <jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Spiller,
	John" <John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Hari,

On Mon, 2013-09-02 at 02:24 +0000, Shankar, Hari wrote:
> Patch Description: The patch is for Intel IOMMU driver. It forces IOMMU TLB flush for the particular domain and return correct unmap size when intel_iommu_unmap() is called

"Patch Description:" is unnecessary.  Look at other commits that have
touched this file to get an idea how to format the subject and commit
log:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/iommu/intel-iommu.c

Sign-off should go here, not below the patch.  Subject should include a
subsystem, such as "iommu/intel:" or "intel-iommu:".  Also a good idea
to provide some justification why this is necessary for stable (unmaps
from userspace through vfio results in coherency issue...)

> The patch is generated on Linux kernel version 3.6.11

This should be noted, but not part of the commit message.  See section
15 of SubmittingPatches and note the additional comments between the
"---" marker and the beginning of the patch.

> --- linux/drivers/iommu/intel-iommu.c.orig      2013-09-01 10:10:14.723958000 -0700
> +++ linux/drivers/iommu/intel-iommu.c   2013-09-01 18:22:58.497578000 -0700
> @@ -4060,14 +4060,31 @@ static size_t intel_iommu_unmap(struct i

Tabs seem to have been clobbered in your patch, scripts/checkpatch.pl
will note this for you.

>  {
>         struct dmar_domain *dmar_domain = domain->priv;
>         int order;
> +       struct intel_iommu *iommu;
> +       unsigned long start_pfn, last_pfn;
> +       unsigned int npages;
> +       int iommu_id, num, ndomains;
> 
> -       order = dma_pte_clear_range(dmar_domain, iova >> VTD_PAGE_SHIFT,
> -                           (iova + size - 1) >> VTD_PAGE_SHIFT);
> +       start_pfn = iova >> VTD_PAGE_SHIFT;
> +       last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
> +       order = dma_pte_clear_range(dmar_domain, start_pfn, last_pfn);
> +       last_pfn |= (1UL << order) - 1;
> +       npages = last_pfn - start_pfn + 1;

Doesn't order tell us npages more directly?  npages = 1UL << order?

> +       for_each_set_bit(iommu_id, dmar_domain->iommu_bmp, g_num_of_iommus) {
> +               iommu = g_iommus[iommu_id];
> 
> -       if (dmar_domain->max_addr == iova + size)
> +               /*
> +                * find bit position of dmar_domain
> +                */
> +               ndomains = cap_ndoms(iommu->cap);
> +               for_each_set_bit(num, iommu->domain_ids, ndomains)
> +                       if (iommu->domains[num] == dmar_domain)
> +                               iommu_flush_iotlb_psi(iommu, num,
> +                                                       start_pfn, npages, 0);

This second bitmap search seems unnecessary, I think
iommu_flush_iotlb_psi wants dmar_domain->id as the second parameter in
all cases, not num.  So this could be reduced to :

for_each_set_bit(iommu_id, dmar_domain->iommu_bmp, g_num_of_iommus)
	iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain->id, start_pfn, npages, 0);

> +       }
> +       if (dmar_domain->max_addr <= iova + (npages << VTD_PAGE_SHIFT))
>                 dmar_domain->max_addr = iova;
> -
> -       return PAGE_SIZE << order;
> +       return npages << VTD_PAGE_SHIFT;
>  }
> 
>  static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
> 
> Signed-off-by: Hari Shankar <hshankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
> cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Please configure your mailer to drop the html version.  Thanks,

Alex
