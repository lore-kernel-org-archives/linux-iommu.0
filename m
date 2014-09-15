From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH v3 3/7] iommu: add new iommu_ops callback for adding an
	OF device
Date: Mon, 15 Sep 2014 13:57:38 +0200
Message-ID: <5416D432.8020107@samsung.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1410539695-29128-4-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-09-12 18:34, Will Deacon wrote:
> This patch adds a new function to the iommu_ops structure to allow an
> OF device to be added to a specific IOMMU instance using the recently
> merged generic devicetree binding for IOMMUs. The callback (of_xlate)
> takes a struct device representing the master and an of_phandle_args
> representing the IOMMU and the correspondong IDs for the new master.
>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>   include/linux/iommu.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4256f3ce1673..821eb0bd9f6c 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -21,6 +21,7 @@
>   
>   #include <linux/errno.h>
>   #include <linux/err.h>
> +#include <linux/of.h>
>   #include <linux/types.h>
>   #include <trace/events/iommu.h>
>   
> @@ -140,6 +141,10 @@ struct iommu_ops {
>   	/* Get the numer of window per domain */
>   	u32 (*domain_get_windows)(struct iommu_domain *domain);
>   
> +#ifdef CONFIG_OF_IOMMU
> +	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> +#endif


If I understand correctly, this callback is intended to do per-master 
initialization
of the iommu structures required by the given iommu driver (I stored them in
dev->archdata.iommu). However I really don't get what is the meaning of 
the return
value. Is it a boolean value? It is used only by of_iommu_configure to 
check if
the parse loop should be terminated...

> +
>   	unsigned long pgsize_bitmap;
>   };

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
