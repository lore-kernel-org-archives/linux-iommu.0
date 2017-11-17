From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/amd: Add support for fast IOTLB flushing
Date: Fri, 17 Nov 2017 16:25:45 -0600
Message-ID: <273179a4-43fe-1e5f-802a-31eea5a91bd3@amd.com>
References: <1510953080-5619-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1510953080-5619-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1510953080-5619-3-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/17/2017 3:11 PM, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Implement the newly added IOTLB flushing interface by introducing
> per-protection-domain IOTLB flush list, which maintains a list of
> IOVAs to be invalidated (by INVALIDATE_IOTLB_PAGES command) during
> IOTLB sync.
> 
> Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c       | 77 ++++++++++++++++++++++++++++++++++++++++-
>   drivers/iommu/amd_iommu_init.c  |  2 --
>   drivers/iommu/amd_iommu_types.h |  2 ++
>   3 files changed, 78 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 8e8874d..bf92809 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -130,6 +130,12 @@ struct dma_ops_domain {
>   static struct iova_domain reserved_iova_ranges;
>   static struct lock_class_key reserved_rbtree_key;
>   
> +struct iotlb_flush_entry {
> +	struct list_head list;
> +	unsigned long iova;
> +	size_t size;
> +};
> +
>   /****************************************************************************
>    *
>    * Helper functions
> @@ -2838,11 +2844,13 @@ static void protection_domain_free(struct protection_domain *domain)
>   static int protection_domain_init(struct protection_domain *domain)
>   {
>   	spin_lock_init(&domain->lock);
> +	spin_lock_init(&domain->iotlb_flush_list_lock);
>   	mutex_init(&domain->api_lock);
>   	domain->id = domain_id_alloc();
>   	if (!domain->id)
>   		return -ENOMEM;
>   	INIT_LIST_HEAD(&domain->dev_list);
> +	INIT_LIST_HEAD(&domain->iotlb_flush_list);
>   
>   	return 0;
>   }
> @@ -3047,7 +3055,6 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
>   	unmap_size = iommu_unmap_page(domain, iova, page_size);
>   	mutex_unlock(&domain->api_lock);
>   
> -	domain_flush_tlb_pde(domain);
>   	domain_flush_complete(domain);
>   
>   	return unmap_size;
> @@ -3167,6 +3174,71 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>   	return dev_data->defer_attach;
>   }
>   
> +static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct protection_domain *dom = to_pdomain(domain);
> +
> +	domain_flush_tlb_pde(dom);
> +}
> +
> +static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
> +				      unsigned long iova, size_t size)
> +{
> +	struct protection_domain *pdom = to_pdomain(domain);
> +	struct iotlb_flush_entry *entry, *p;
> +	unsigned long flags;
> +	bool found = false;
> +
> +	spin_lock_irqsave(&pdom->iotlb_flush_list_lock, flags);
> +	list_for_each_entry(p, &pdom->iotlb_flush_list, list) {
> +		if (iova != p->iova)
> +			continue;
> +
> +		if (size > p->size) {
> +			p->size = size;
> +			pr_debug("%s: update range: iova=%#lx, size = %#lx\n",
> +				 __func__, p->iova, p->size);
> +		}
> +		found = true;
> +		break;
> +	}
> +
> +	if (!found) {
> +		entry = kzalloc(sizeof(struct iotlb_flush_entry),
> +				GFP_ATOMIC);
> +		if (!entry)
> +			return;

You need to release the spinlock before returning here.

Thanks,
Tom

> +
> +		pr_debug("%s: new range: iova=%lx, size=%#lx\n",
> +			 __func__, iova, size);
> +
> +		entry->iova = iova;
> +		entry->size = size;
> +		list_add(&entry->list, &pdom->iotlb_flush_list);
> +	}
> +	spin_unlock_irqrestore(&pdom->iotlb_flush_list_lock, flags);
> +}
> +
> +static void amd_iommu_iotlb_sync(struct iommu_domain *domain)
> +{
> +	struct protection_domain *pdom = to_pdomain(domain);
> +	struct iotlb_flush_entry *entry, *next;
> +	unsigned long flags;
> +
> +	/* Note:
> +	 * Currently, IOMMU driver just flushes the whole IO/TLB for
> +	 * a given domain. So, just remove entries from the list here.
> +	 */
> +	spin_lock_irqsave(&pdom->iotlb_flush_list_lock, flags);
> +	list_for_each_entry_safe(entry, next, &pdom->iotlb_flush_list, list) {
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +	spin_unlock_irqrestore(&pdom->iotlb_flush_list_lock, flags);
> +
> +	domain_flush_tlb_pde(pdom);
> +}
> +
>   const struct iommu_ops amd_iommu_ops = {
>   	.capable = amd_iommu_capable,
>   	.domain_alloc = amd_iommu_domain_alloc,
> @@ -3185,6 +3257,9 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>   	.apply_resv_region = amd_iommu_apply_resv_region,
>   	.is_attach_deferred = amd_iommu_is_attach_deferred,
>   	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
> +	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
> +	.iotlb_range_add = amd_iommu_iotlb_range_add,
> +	.iotlb_sync = amd_iommu_iotlb_sync,
>   };
>   
>   /*****************************************************************************
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 6fe2d03..1659377 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2489,8 +2489,6 @@ static int __init early_amd_iommu_init(void)
>   	 */
>   	__set_bit(0, amd_iommu_pd_alloc_bitmap);
>   
> -	spin_lock_init(&amd_iommu_pd_lock);
> -
>   	/*
>   	 * now the data structures are allocated and basically initialized
>   	 * start the real acpi table scan
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index f6b24c7..30e1c68 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -462,9 +462,11 @@ struct amd_iommu_fault {
>   struct protection_domain {
>   	struct list_head list;  /* for list of all protection domains */
>   	struct list_head dev_list; /* List of all devices in this domain */
> +	struct list_head iotlb_flush_list; /* store iovas for iotlb sync */
>   	struct iommu_domain domain; /* generic domain handle used by
>   				       iommu core code */
>   	spinlock_t lock;	/* mostly used to lock the page table*/
> +	spinlock_t iotlb_flush_list_lock; /* protect iova flush list */
>   	struct mutex api_lock;	/* protect page tables in the iommu-api path */
>   	u16 id;			/* the domain id written to the device table */
>   	int mode;		/* paging mode (0-6 levels) */
> 
