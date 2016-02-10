From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/3] iommu/io-pgtable: Add ARMv7 short descriptor
	support
Date: Wed, 10 Feb 2016 15:48:16 +0000
Message-ID: <20160210154815.GO1052@arm.com>
References: <cover.1453723096.git.robin.murphy@arm.com>
	<066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tue, Jan 26, 2016 at 05:13:13PM +0000, Robin Murphy wrote:
> Add a nearly-complete ARMv7 short descriptor implementation, omitting
> only a few legacy and CPU-centric aspects which shouldn't be necessary
> for IOMMU API use anyway.
> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig              |  19 +
>  drivers/iommu/Makefile             |   1 +
>  drivers/iommu/io-pgtable-arm-v7s.c | 849 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c         |   3 +
>  drivers/iommu/io-pgtable.h         |  14 +-
>  5 files changed, 885 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c

This looks good to me, with one minor comment below.

> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 36673c8..aa57073 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -1,5 +1,6 @@
>  #ifndef __IO_PGTABLE_H
>  #define __IO_PGTABLE_H
> +#include <linux/bitops.h>
>  
>  /*
>   * Public API for use by IOMMU drivers
> @@ -9,6 +10,7 @@ enum io_pgtable_fmt {
>  	ARM_32_LPAE_S2,
>  	ARM_64_LPAE_S1,
>  	ARM_64_LPAE_S2,
> +	ARM_V7S,
>  	IO_PGTABLE_NUM_FMTS,
>  };
>  
> @@ -45,7 +47,9 @@ struct iommu_gather_ops {
>   *                 page table walker.
>   */
>  struct io_pgtable_cfg {
> -	#define IO_PGTABLE_QUIRK_ARM_NS	(1 << 0)	/* Set NS bit in PTEs */
> +	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0) /* Set NS bit in PTEs */
> +	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1) /* No AP/XN bits */
> +	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2) /* TLB Inv. on map */

We should either try to keep these generic or add _ARM_ in the names. I
don't see why we couldn't have them as generic quicks, but that means
you should fix the AP/XN comment to be architecture agnostic and also
hack the lpae iopgtable alloc code to reject a cfg with unsupported
quirks.

With that change, I'm happy to queue this via my tree or whatever is
easiest for Yong/Joerg.

Will
