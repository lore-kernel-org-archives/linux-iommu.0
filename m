From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] KVM: Return the actual unmapped size in
	intel_iommu_unmap()
Date: Mon, 28 Oct 2013 11:59:29 -0600
Message-ID: <1382983169.4097.43.camel@ul30vt.home>
References: <E959C4978C3B6342920538CF579893F001C608DE@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F001C608DE-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2013-10-25 at 11:21 +0000, Wu, Feng wrote:
> Actual unmapped size should be returned by intel_iommu_unmap(), because
> iommu_map() which calls this function depends on the real unmapped size.
> However, in the current logic, the return value of intel_iommu_unmap()
> is far smaller than the actual unmapped size, which leads a lot of
> redundant calls to intel_iommu_unmap() in iommu_map(). Since dma_pte_clear_range()
> can always unmap the space from "start_pfn" to "last_pfn" successfully,
> it is okay to return "size" for intel_iommu_unmap().

This is an intel-iommu patch not a KVM patch so it should go to the
iommu list and copy the maintainer.

Secondly, this seems wrong to me.  Neither KVM nor VFIO track the size
of individual mappings, so when we unmap a page that was previously
mapped as a large page, we we try to unmap 4K and test the return value
to see what was actually unmapped.  That may be 2M, 1G, etc.  With this
change we'll try to unmap each 4K page within a larger mapping, even if
the first mapping actually unmapped it already.  Thanks,

Alex

> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 15e9b57..bb795d5 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4113,15 +4113,14 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
>                              unsigned long iova, size_t size)
>  {
>         struct dmar_domain *dmar_domain = domain->priv;
> -       int order;
> 
> -       order = dma_pte_clear_range(dmar_domain, iova >> VTD_PAGE_SHIFT,
> +       dma_pte_clear_range(dmar_domain, iova >> VTD_PAGE_SHIFT,
>                             (iova + size - 1) >> VTD_PAGE_SHIFT);
> 
>         if (dmar_domain->max_addr == iova + size)
>                 dmar_domain->max_addr = iova;
> 
> -       return PAGE_SIZE << order;
> +       return size;
>  }
> 
>  static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
> --
> 1.7.1
> 
> BTW: Here is the only place where the return value of dma_pte_clear_range() is used, if we don't use it here neither, maybe we can make it a void function.
> 
