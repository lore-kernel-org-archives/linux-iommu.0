From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Detach domain *only* from attached iommus
Date: Tue, 17 Mar 2015 13:08:42 -0600
Message-ID: <1426619322.3643.325.camel@redhat.com>
References: <20150304182905.23660.81378.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150304182905.23660.81378.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


Ping?  I think this needs to be a v4.0 candidate.  Thanks,

Alex

On Wed, 2015-03-04 at 11:30 -0700, Alex Williamson wrote:
> Device domains never span IOMMU hardware units, which allows the
> domain ID space for each IOMMU to be an independent address space.
> Therefore we can have multiple, independent domains, each with the
> same domain->id, but attached to different hardware units.  This is
> also why we need to do a heavy-weight search for VM domains since
> they can span multiple IOMMUs hardware units and we don't require a
> single global ID to use for all hardware units.
> 
> Therefore, if we call iommu_detach_domain() across all active IOMMU
> hardware units for a non-VM domain, the result is that we clear domain
> IDs that are not associated with our domain, allowing them to be
> re-allocated and causing apparent coherency issues when the device
> cannot access IOVAs for the intended domain.
> 
> This bug was introduced in commit fb170fb4c548 ("iommu/vt-d: Introduce
> helper functions to make code symmetric for readability"), but is
> significantly exacerbated by the more recent commit 62c22167dd70
> ("iommu/vt-d: Fix dmar_domain leak in iommu_attach_device") which calls
> domain_exit() more frequently to resolve a domain leak.
> 
> Fixes: fb170fb4c548 ("iommu/vt-d: Introduce helper functions to make code symmetric for readability")
> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v3.17+
> ---
>  drivers/iommu/intel-iommu.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ae4c1a8..a83c965 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1743,8 +1743,8 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
>  static void domain_exit(struct dmar_domain *domain)
>  {
>  	struct dmar_drhd_unit *drhd;
> -	struct intel_iommu *iommu;
>  	struct page *freelist = NULL;
> +	int i;
>  
>  	/* Domain 0 is reserved, so dont process it */
>  	if (!domain)
> @@ -1764,8 +1764,8 @@ static void domain_exit(struct dmar_domain *domain)
>  
>  	/* clear attached or cached domains */
>  	rcu_read_lock();
> -	for_each_active_iommu(iommu, drhd)
> -		iommu_detach_domain(domain, iommu);
> +	for_each_set_bit(i, domain->iommu_bmp, g_num_of_iommus)
> +		iommu_detach_domain(domain, g_iommus[i]);
>  	rcu_read_unlock();
>  
>  	dma_free_pagelist(freelist);
> 
