From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/2] iommu/amd: Add support for fast IOTLB flushing
Date: Wed, 24 Jan 2018 18:43:18 +0700
Message-ID: <2783078a-1cf6-58da-35a7-98f91afabcc4@amd.com>
References: <1514366435-12723-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1514366435-12723-3-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1514366435-12723-3-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 12/27/17 4:20 PM, Suravee Suthikulpanit wrote:
> Implement the newly added IOTLB flushing interface for AMD IOMMU.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c       | 73 ++++++++++++++++++++++++++++++++++++++++-
>   drivers/iommu/amd_iommu_init.c  |  7 ++++
>   drivers/iommu/amd_iommu_types.h |  7 ++++
>   3 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 7d5eb00..42fe365 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
>  ...
> @@ -3163,6 +3168,69 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
>   	return dev_data->defer_attach;
>   }
>   
> +static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct protection_domain *dom = to_pdomain(domain);
> +
> +	domain_flush_tlb_pde(dom);
> +}

I made a mistake here ...

> ...
> +static void amd_iommu_iotlb_sync(struct iommu_domain *domain)
> +{
> +	struct protection_domain *pdom = to_pdomain(domain);
> +	struct amd_iommu_flush_entries *entry, *next;
> +	unsigned long flags;
> +
> +	/* Note:
> +	 * Currently, IOMMU driver just flushes the whole IO/TLB for
> +	 * a given domain. So, just remove entries from the list here.
> +	 */
> +	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);
> +	list_for_each_entry_safe(entry, next, &amd_iommu_flush_list, list) {
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +	spin_unlock_irqrestore(&amd_iommu_flush_list_lock, flags);
> +
> +	domain_flush_tlb_pde(pdom);
> +}

... and here where I should also call domain_flush_complete() after
domain_flush_tlb_pde(). I'll send out a new version (v3) as a separate patch
from the series.

Thanks,
Suravee
