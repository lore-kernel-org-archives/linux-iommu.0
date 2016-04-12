From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 6/7] iommu: change intel-iommu to use IOVA frame numbers
Date: Tue, 12 Apr 2016 11:55:01 +0100
Message-ID: <570CD405.7010403@arm.com>
References: <20151228161724.GA27916@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151228161724.GA27916-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Adam,

On 28/12/15 16:17, Adam Morrison wrote:
> From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
>
> Make intel-iommu map/unmap/invalidate work with IOVA pfns instead of
> pointers to "struct iova". This avoids using the iova struct from the IOVA
> red-black tree and the resulting explicit find_iova() on unmap.
>
> This patch will allow us to cache IOVAs in the next patch, in order to
> avoid rbtree operations for the majority of map/unmap operations.
>
> Note: In eliminating the find_iova() operation, we have also eliminated
> the sanity check previously done in the unmap flow. Arguably, this was
> overhead that is better avoided in production code, but it could be
> brought back as a debug option for driver development.
>
> Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> [mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased and reworded the commit message]
> Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> ---
>   drivers/iommu/intel-iommu.c | 73 ++++++++++++++++++++++-----------------------
>   drivers/iommu/iova.c        |  8 ++---
>   include/linux/iova.h        |  2 +-
>   3 files changed, 40 insertions(+), 43 deletions(-)

[...]

> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index fa0adef..9009ce6 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -267,7 +267,7 @@ EXPORT_SYMBOL_GPL(iova_cache_put);
>    * flag is set then the allocated address iova->pfn_lo will be naturally
>    * aligned on roundup_power_of_two(size).
>    */
> -struct iova *
> +unsigned long
>   alloc_iova(struct iova_domain *iovad, unsigned long size,
>   	unsigned long limit_pfn,
>   	bool size_aligned)
> @@ -277,17 +277,17 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
>
>   	new_iova = alloc_iova_mem();
>   	if (!new_iova)
> -		return NULL;
> +		return 0;
>
>   	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn,
>   			new_iova, size_aligned);
>
>   	if (ret) {
>   		free_iova_mem(new_iova);
> -		return NULL;
> +		return 0;
>   	}
>
> -	return new_iova;
> +	return new_iova->pfn_lo;
>   }
>   EXPORT_SYMBOL_GPL(alloc_iova);
>
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 92f7177..efecee0 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -75,7 +75,7 @@ struct iova *alloc_iova_mem(void);
>   void free_iova_mem(struct iova *iova);
>   void free_iova(struct iova_domain *iovad, unsigned long pfn);
>   void __free_iova(struct iova_domain *iovad, struct iova *iova);
> -struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
> +unsigned long alloc_iova(struct iova_domain *iovad, unsigned long size,
>   	unsigned long limit_pfn,
>   	bool size_aligned);
>   struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,

Making the internals more efficient is no bad thing, but changing the 
external interface to the IOVA library like this breaks at least 
dma-iommu.c, thus stops arm64 from building.

Robin.
