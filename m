From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
Date: Thu, 14 Feb 2019 21:31:46 +0000
Message-ID: <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
References: <20190214204433.155715-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190214204433.155715-1-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Doug,

On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> Right now the only way to disable the iommu bypass for the ARM SMMU is
> with the kernel command line parameter 'arm-smmu.disable_bypass'.
> 
> In general kernel command line parameters make sense for things that
> someone would like to tweak without rebuilding the kernel or for very
> basic communication between the bootloader and the kernel, but are
> awkward for other things.  Specifically:
> * Human parsing of the kernel command line can be difficult since it's
>    just a big runon space separated line of text.
> * If every bit of the system was configured via the kernel command
>    line the kernel command line would get very large and even more
>    unwieldly.
> * Typically there are not easy ways in build systems to adjust the
>    kernel command line for config-like options.
> 
> Let's introduce a new config option that allows us to disable the
> iommu bypass without affecting the existing default nor the existing
> ability to adjust the configuration via kernel command line.

I say let's just flip the default - for a while now it's been one of 
those "oh yeah, we should probably do that" things that gets instantly 
forgotten again, so some 3rd-party demand is plenty to convince me :)

There are few reasons to allow unmatched stream bypass, and even fewer 
good ones, so I'd be happy to shift the command-line burden over to the 
esoteric cases at this point, and consider the config option in future 
if anyone from that camp pops up and screams hard enough.

Cheers,
Robin.

> 
> Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> 
>   drivers/iommu/Kconfig    | 22 ++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c |  3 ++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 46fcd75d4364..c614beab08f8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -359,6 +359,28 @@ config ARM_SMMU
>   	  Say Y here if your SoC includes an IOMMU device implementing
>   	  the ARM SMMU architecture.
>   
> +config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> +	bool "Default to disabling bypass on ARM SMMU v1 and v2"
> +	depends on ARM_SMMU
> +	default n
> +	help
> +	  Say Y here to (by default) disable bypass streams such that
> +	  incoming transactions from devices that are not attached to
> +	  an iommu domain will report an abort back to the device and
> +	  will not be allowed to pass through the SMMU.
> +
> +	  Historically the ARM SMMU v1 and v2 driver has defaulted
> +	  to allow bypass by default but it could be disabled with
> +	  the parameter 'arm-smmu.disable_bypass'.  The parameter is
> +	  still present and can be used to override this config
> +	  option, but this config option allows you to disable bypass
> +	  without bloating the kernel command line.
> +
> +	  Disabling bypass is more secure but presumably will break
> +	  old systems.
> +
> +	  Say N if unsure.
> +
>   config ARM_SMMU_V3
>   	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>   	depends on ARM64
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..930c07635956 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -110,7 +110,8 @@ static int force_stage;
>   module_param(force_stage, int, S_IRUGO);
>   MODULE_PARM_DESC(force_stage,
>   	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
> -static bool disable_bypass;
> +static bool disable_bypass =
> +	IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT);
>   module_param(disable_bypass, bool, S_IRUGO);
>   MODULE_PARM_DESC(disable_bypass,
>   	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> 
