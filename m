From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 07/10] iommu/dma-reserved-iommu: delete bindings in
	iommu_free_reserved_iova_domain
Date: Wed, 20 Apr 2016 18:05:27 +0100
Message-ID: <5717B6D7.4010307@arm.com>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
	<1461084994-2355-8-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461084994-2355-8-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger-qxv4g6HH51o@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 19/04/16 17:56, Eric Auger wrote:
> Now reserved bindings can exist, destroy them when destroying
> the reserved iova domain. iommu_map is not supposed to be atomic,
> hence the extra complexity in the locking.
>
> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> ---
> v6 -> v7:
> - remove [PATCH v6 7/7] dma-reserved-iommu: iommu_unmap_reserved and
>    destroy the bindings in iommu_free_reserved_iova_domain
>
> v5 -> v6:
> - use spin_lock instead of mutex
>
> v3 -> v4:
> - previously "iommu/arm-smmu: relinquish reserved resources on
>    domain deletion"
> ---
>   drivers/iommu/dma-reserved-iommu.c | 34 ++++++++++++++++++++++++++++------
>   1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
> index 426d339..2522235 100644
> --- a/drivers/iommu/dma-reserved-iommu.c
> +++ b/drivers/iommu/dma-reserved-iommu.c
> @@ -157,14 +157,36 @@ void iommu_free_reserved_iova_domain(struct iommu_domain *domain)
>   	unsigned long flags;
>   	int ret = 0;
>
> -	spin_lock_irqsave(&domain->reserved_lock, flags);
> -
> -	rid = (struct reserved_iova_domain *)domain->reserved_iova_cookie;
> -	if (!rid) {
> -		ret = -EINVAL;
> -		goto unlock;
> +	while (1) {
> +		struct iommu_reserved_binding *b;
> +		struct rb_node *node;
> +		dma_addr_t iova;
> +		size_t size;
> +
> +		spin_lock_irqsave(&domain->reserved_lock, flags);
> +
> +		rid = (struct reserved_iova_domain *)
> +				domain->reserved_iova_cookie;

Same comment about casting as before.

> +		if (!rid) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +
> +		node = rb_first(&domain->reserved_binding_list);
> +		if (!node)
> +			break;
> +		b = rb_entry(node, struct iommu_reserved_binding, node);
> +
> +		iova = b->iova;
> +		size = b->size;
> +
> +		while (!kref_put(&b->kref, reserved_binding_release))
> +			;

Since you're freeing the thing anyway, why not just call the function 
directly?

> +		spin_unlock_irqrestore(&domain->reserved_lock, flags);
> +		iommu_unmap(domain, iova, size);
>   	}
>
> +	domain->reserved_binding_list = RB_ROOT;
>   	domain->reserved_iova_cookie = NULL;
>   unlock:
>   	spin_unlock_irqrestore(&domain->reserved_lock, flags);
>
