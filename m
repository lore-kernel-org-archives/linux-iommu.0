From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/7] iommu/arm-smmu: Support buggy implementations where
	all config accesses are secure
Date: Thu, 10 Oct 2013 16:47:27 +0100
Message-ID: <20131010154726.GB8528@mudshark.cambridge.arm.com>
References: <1381358286-27065-1-git-send-email-andreas.herrmann@calxeda.com>
	<1381358286-27065-5-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381358286-27065-5-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 09, 2013 at 11:38:03PM +0100, Andreas Herrmann wrote:
> In such a case we have to use secure aliases of some non-secure
> registers.
> 
> This handling is switched on by DT property
> "arm,smmu-secure-config-access" for an SMMU node.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c |   30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f877d02..91316a8 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -51,6 +51,7 @@
>  /* Driver options */
>  #define ARM_SMMU_OPT_ISOLATE_DEVICES		(1 << 0)
>  #define ARM_SMMU_OPT_MASK_STREAM_IDS		(1 << 1)
> +#define ARM_SMMU_OPT_SECURE_CONFIG_ACCESS	(1 << 2)
>  
>  /* Maximum number of stream IDs assigned to a single device */
>  #define MAX_MASTER_STREAMIDS		8
> @@ -65,6 +66,15 @@
>  #define ARM_SMMU_GR0(smmu)		((smmu)->base)
>  #define ARM_SMMU_GR1(smmu)		((smmu)->base + (smmu)->pagesize)
>  
> +/*
> + * SMMU global address space with conditional offset to access secure aliases of
> + * non-secure registers (e.g. nsCR0: 0x400, nsGFSR: 0x448, nsGFSYNR0: 0x450)
> + */
> +#define ARM_SMMU_GR0_NS(smmu)						\
> +	((smmu)->base +							\
> +		((smmu->options & ARM_SMMU_OPT_SECURE_CONFIG_ACCESS)	\
> +			? 0x400 : 0))

You have a slight issue with the ordering of your patches, as this macro is
used by the stream masking patch, but this patch is based on top of the
latter.

Can you introduce this patch first please? I think it's ok for merging, but
I still have reservations with the other one.

Will
