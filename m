From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/6] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000
Date: Thu, 31 Oct 2013 01:15:21 +0000
Message-ID: <20131031011521.GE28613@mudshark.cambridge.arm.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
	<1382127195-15261-6-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382127195-15261-6-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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

On Fri, Oct 18, 2013 at 09:13:14PM +0100, Andreas Herrmann wrote:
> Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/ecx-2000.dts    |   44 +++++++++++++++++++++++++++++++++++--
>  arch/arm/boot/dts/ecx-common.dtsi |    9 +++++---
>  drivers/iommu/arm-smmu.c          |    2 +-
>  include/linux/of.h                |    2 +-
>  4 files changed, 50 insertions(+), 7 deletions(-)

[...]

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 5f585fc..9fc34d1 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -55,7 +55,7 @@
>  #define ARM_SMMU_OPT_SECURE_CONFIG_ACCESS	(1 << 1)
>  
>  /* Maximum number of stream IDs assigned to a single device */
> -#define MAX_MASTER_STREAMIDS		8
> +#define MAX_MASTER_STREAMIDS		10

Maybe we should define this to be MAX_PHANDLE_ARGS instead, since we're
really bound by the DT parsing code rather than anything else.

Will

>  /* Maximum number of context banks per SMMU */
>  #define ARM_SMMU_MAX_CBS		128
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f95aee3..47f4857 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -67,7 +67,7 @@ struct device_node {
>  #endif
>  };
>  
> -#define MAX_PHANDLE_ARGS 8
> +#define MAX_PHANDLE_ARGS 10
>  struct of_phandle_args {
>  	struct device_node *np;
>  	int args_count;

This should be a separate patch.

Will
