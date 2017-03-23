From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu/iova: cut down judgement times
Date: Thu, 23 Mar 2017 12:11:56 +0000
Message-ID: <2884b8d1-72d4-dc41-75c1-92cfa19d77ae@arm.com>
References: <1490164067-12552-1-git-send-email-thunder.leizhen@huawei.com>
	<1490164067-12552-3-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490164067-12552-3-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 22/03/17 06:27, Zhen Lei wrote:
> Below judgement can only be satisfied at the last time, which produced 2N
> judgements(suppose N times failed, 0 or 1 time successed) in vain.
> 
> if ((pfn >= iova->pfn_lo) && (pfn <= iova->pfn_hi)) {
> 	return iova;
> }

For me, GCC (6.2.1 AArch64) seems to do a pretty good job of this
function already, so this change only saves two instructions in total
(pfn is compared against pfn_lo only once instead of twice), which I
wouldn't expect to see a noticeable performance effect from.

Given the improvement in readability, though, I don't even care about
any codegen differences :)

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/iova.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 8ba8b496..1c49969 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -312,15 +312,12 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
>  	while (node) {
>  		struct iova *iova = rb_entry(node, struct iova, node);
>  
> -		/* If pfn falls within iova's range, return iova */
> -		if ((pfn >= iova->pfn_lo) && (pfn <= iova->pfn_hi)) {
> -			return iova;
> -		}
> -
>  		if (pfn < iova->pfn_lo)
>  			node = node->rb_left;
> -		else if (pfn > iova->pfn_lo)
> +		else if (pfn > iova->pfn_hi)
>  			node = node->rb_right;
> +		else
> +			return iova;	/* pfn falls within iova's range */
>  	}
>  
>  	return NULL;
> 
