From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/1] use documented cmpxchg api
Date: Thu, 05 Jun 2014 20:34:29 -0400
Message-ID: <53910C95.7000808@hurleysoftware.com>
References: <5390ED07.2070009@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5390ED07.2070009@gatech.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Pranith Kumar <pranith@gatech.edu>, dwmw2@infradead.org, joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 06/05/2014 06:19 PM, Pranith Kumar wrote:
> use the documented atomic_cmpxchg instead of __cmpxchg64
>
> This kills the last user of said API in drivers code.
>
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>   drivers/iommu/intel-iommu.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6bb3277..270113f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -293,7 +293,7 @@ static inline u64 dma_pte_addr(struct dma_pte *pte)
>   	return pte->val & VTD_PAGE_MASK;
>   #else
>   	/* Must have a full atomic 64-bit read */
> -	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
> +	return  atomic_cmpxchg(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;

This is not equivalent.

The __cmpxchg64() is specifically being used in this case
when !CONFIG_64BIT for a full 64-bit RMW, whereas atomic_cmpxchg()
uses ints which would be 32-bit RMW.

Regards,
Peter Hurley
