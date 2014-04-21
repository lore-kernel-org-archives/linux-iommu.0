From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/9] iommu/ipmmu-vmsa: Define driver-specific page
	directory sizes
Date: Mon, 21 Apr 2014 23:05:00 +0400
Message-ID: <53556BDC.6040705@cogentembedded.com>
References: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1398089589-9181-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398089589-9181-4-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello.

On 04/21/2014 06:13 PM, Laurent Pinchart wrote:

> The PTRS_PER_(PGD|PMD|PTE) macros evaluate to different values depending
> on whether LPAE is enabled. The IPMMU driver uses a long descriptor
> format regardless of LPAE, making those macros mismatch the IPMMU
> configuration on non-LPAE systems.

> Replace the macros by driver-specific versions that always evaluate to
> the right value.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 1ae97d8..7c8c21e 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -210,6 +210,10 @@ static LIST_HEAD(ipmmu_devices);
>   #define ARM_VMSA_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
>   #define ARM_VMSA_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
>
> +#define IPMMU_PTRS_PER_PTE		512
> +#define IPMMU_PTRS_PER_PMD		512
> +#define IPMMU_PTRS_PER_PGD		4
> +
[...]
> @@ -487,7 +491,7 @@ static void ipmmu_free_puds(pgd_t *pgd)
>   	unsigned int i;
>
>   	pud = pud_base;
> -	for (i = 0; i < PTRS_PER_PUD; ++i) {
> +	for (i = 0; i < IPMMU_PTRS_PER_PUD; ++i) {

    I don't see where you #define IPMMU_PTRS_PER_PUD...

[...]

WBR, Sergei
