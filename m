From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Don't be too aggressive when clearing one
	context entry
Date: Wed, 30 Aug 2017 08:50:25 -0700
Message-ID: <20170830085025.7027c9f8@jacob-builder>
References: <1503929789-26698-1-git-send-email-sironi@amazon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503929789-26698-1-git-send-email-sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Filippo Sironi via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Filippo Sironi <sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 28 Aug 2017 16:16:29 +0200
Filippo Sironi via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org> wrote:

> Previously, we were invalidating context cache and IOTLB globally when
> clearing one context entry.  This is a tad too aggressive.
> Invalidate the context cache and IOTLB for the interested device only.
> 
> Signed-off-by: Filippo Sironi <sironi-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
> Cc: David Woodhouse <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>
> Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/iommu/intel-iommu.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3e8636f1220e..4bf3e59b0929 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2351,13 +2351,32 @@ static inline int domain_pfn_mapping(struct
> dmar_domain *domain, unsigned long i 
>  static void domain_context_clear_one(struct intel_iommu *iommu, u8
> bus, u8 devfn) {
> +	unsigned long flags;
> +	struct context_entry *context;
> +	u16 did_old;
> +
>  	if (!iommu)
>  		return;
>  
> +	spin_lock_irqsave(&iommu->lock, flags);
> +	context = iommu_context_addr(iommu, bus, devfn, 0);
> +	if (!context) {
> +		spin_unlock_irqrestore(&iommu->lock, flags);
> +		return;
> +	}
perhaps check with device_context_mapped()?

> +	did_old = context_domain_id(context);
> +	spin_unlock_irqrestore(&iommu->lock, flags);
>  	clear_context_table(iommu, bus, devfn);
> -	iommu->flush.flush_context(iommu, 0, 0, 0,
> -					   DMA_CCMD_GLOBAL_INVL);
> -	iommu->flush.flush_iotlb(iommu, 0, 0, 0,
> DMA_TLB_GLOBAL_FLUSH);
> +	iommu->flush.flush_context(iommu,
> +				   did_old,
> +				   (((u16)bus) << 8) | devfn,
> +				   DMA_CCMD_MASK_NOBIT,
> +				   DMA_CCMD_DEVICE_INVL);
> +	iommu->flush.flush_iotlb(iommu,
> +				 did_old,
> +				 0,
> +				 0,
> +				 DMA_TLB_DSI_FLUSH);
>  }
>  
>  static inline void unlink_domain_info(struct device_domain_info
> *info)

[Jacob Pan]
