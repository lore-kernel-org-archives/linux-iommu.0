From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/8] iommu/arm-smmu: fix the values of
	ARM64_TCR_IRGN0_SHIFT and ARM64_TCR_ORGN0_SHIFT
Date: Mon, 29 Jun 2015 18:25:32 +0100
Message-ID: <20150629172531.GJ17474@arm.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
	<1435307584-9812-4-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435307584-9812-4-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 26, 2015 at 09:32:59AM +0100, Zhen Lei wrote:
> In context descriptor, the offset of IR0 is 8, the offset of OR0 is 10.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2a5f810..43120ad 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -269,10 +269,10 @@
>  #define ARM64_TCR_TG0_SHIFT		14
>  #define ARM64_TCR_TG0_MASK		0x3UL
>  #define CTXDESC_CD_0_TCR_IRGN0_SHIFT	8
> -#define ARM64_TCR_IRGN0_SHIFT		24
> +#define ARM64_TCR_IRGN0_SHIFT		8
>  #define ARM64_TCR_IRGN0_MASK		0x3UL
>  #define CTXDESC_CD_0_TCR_ORGN0_SHIFT	10
> -#define ARM64_TCR_ORGN0_SHIFT		26
> +#define ARM64_TCR_ORGN0_SHIFT		10
>  #define ARM64_TCR_ORGN0_MASK		0x3UL
>  #define CTXDESC_CD_0_TCR_SH0_SHIFT	12
>  #define ARM64_TCR_SH0_SHIFT		12

I don't understand this patch.

The ARM64_* definitions correspond to the CPU architecture, whilst the
CTXDESC_* definitions correspond to the SMMUv3 CD description.

What problem are you seeing?

Will
