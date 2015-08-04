From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 02/18] firmware: qcom_scm-32: replace open-coded call
 to __cpuc_flush_dcache_area()
Date: Tue, 04 Aug 2015 11:50:56 -0700
Message-ID: <55C10990.3090707@codeaurora.org>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk> <E1ZJhWZ-00043Z-Ft@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1ZJhWZ-00043Z-Ft-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/27/2015 05:28 AM, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> ---

Thanks!

Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

>   arch/arm/include/asm/cacheflush.h | 17 +++++++++++++++++
>   drivers/firmware/qcom_scm-32.c    |  4 +---
>   2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index c5230a44eeca..d5525bfc7e3e 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -502,4 +502,21 @@ static inline void set_kernel_text_ro(void) { }
>   void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
>   			     void *kaddr, unsigned long len);
>   
> +/**
> + * secure_flush_area - ensure coherency across the secure boundary
> + * @addr: virtual address
> + * @size: size of region
> + *
> + * Ensure that the specified area of memory is coherent across the secure
> + * boundary from the non-secure side.  This is used when calling secure
> + * firmware where the secure firmware does not ensure coherency.
> + */
> +static inline void secure_flush_area(const void *addr, size_t size)
> +{
> +	phys_addr_t phys = __pa(addr);
> +
> +	__cpuc_flush_dcache_area((void *)addr, size);
> +	outer_flush_range(phys, phys + size);
> +}
> +
>   #endif
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
> index 1bd6f9c34331..29e6850665eb 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -24,7 +24,6 @@
>   #include <linux/err.h>
>   #include <linux/qcom_scm.h>
>   
> -#include <asm/outercache.h>
>   #include <asm/cacheflush.h>
>   
>   #include "qcom_scm.h"
> @@ -219,8 +218,7 @@ static int __qcom_scm_call(const struct qcom_scm_command *cmd)
>   	 * Flush the command buffer so that the secure world sees
>   	 * the correct data.
>   	 */
> -	__cpuc_flush_dcache_area((void *)cmd, cmd->len);
> -	outer_flush_range(cmd_addr, cmd_addr + cmd->len);
> +	secure_flush_area(cmd, cmd->len);
>   
>   	ret = smc(cmd_addr);
>   	if (ret < 0)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
