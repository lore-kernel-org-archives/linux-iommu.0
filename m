From: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Subject: Re: [Patch v4 7/9] iommu/amd: copy old trans table from old kernel
Date: Sat, 28 May 2016 21:25:16 +0800
Message-ID: <23334ff3-1560-c8b4-2730-67253cb05730@iommu.org>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
	<1464157735-8865-8-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464157735-8865-8-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: vincent.wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



-------- Original Message --------
> From: Baoquan HE <bhe-sa4SJRhfYT7yzlqKoElxGh/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
>
> Here several things need be done:
> 1) Initialize amd_iommu_dev_table because it was set several times
>    since kdump kernel reboot. We don't need the set because we will
>    copy the content from old kernel.
> 2) Re-enable event/cmd buffer
> 3) Install the DTE table to reg
> 4) Flush all caches
>
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu_init.c | 47 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 71c7ac9..66a1fa5 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -35,7 +35,7 @@
>  #include <asm/iommu_table.h>
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
> -
> +#include <linux/crash_dump.h>
>  #include "amd_iommu_proto.h"
>  #include "amd_iommu_types.h"
>  #include "irq_remapping.h"
> @@ -675,7 +675,7 @@ static int copy_dev_tables(void)
>  	static int copied;
>
>          for_each_iommu(iommu) {
> -		if (!translation_pre_enabled()) {
> +		if (!translation_pre_enabled(iommu)) {
>  			pr_err("IOMMU:%d is not pre-enabled!/n", iommu->index);
>  			return -1;
>  		}
> @@ -1160,8 +1160,13 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
>  	iommu->int_enabled = false;
>
>  	init_translation_status(iommu);
> +	if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
> +                        clear_translation_pre_enabled(iommu);
> +                        pr_warn("Translation was enabled for IOMMU:%d but we are not in kdump mode\n",
> +                                iommu->index);
> +                }
>
> -	if (translation_pre_enabled())
> +	if (translation_pre_enabled(iommu))
>  		pr_warn("Translation is already enabled - trying to copy translation structures\n");
>
>  	ret = init_iommu_from_acpi(iommu, h);
> @@ -1730,9 +1735,41 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>  static void early_enable_iommus(void)
>  {
>  	struct amd_iommu *iommu;
> +	bool is_pre_enabled=false;
>
> -	for_each_iommu(iommu)
> -		early_enable_iommu(iommu);
> +	for_each_iommu(iommu) {
> +		if ( translation_pre_enabled(iommu) ) {
> +			is_pre_enabled = true;
> +			break;
> +		}
> +	}

I wonder if you consider multi-iommus condition for your those series 
patches?

> +
> +	if ( !is_pre_enabled) {

Why not use translation_pre_enabled(iommu) to judge pre-enable directly?

> +		for_each_iommu(iommu)
> +			early_enable_iommu(iommu);
> +	} else {
> +		if (copy_dev_tables()) {
> +			pr_err("Failed to copy translation tables from previous kernel.\n");
> +			/*
> +			 * If failed to copy dev tables from old kernel, continue to proceed
> +			 * as it does in normal kernel.
> +			 */
> +			for_each_iommu(iommu) {
> +				clear_translation_pre_enabled(iommu);
> +				early_enable_iommu(iommu);
> +			}
> +		} else {
> +			pr_info("Copied translation tables from previous kernel.\n");
> +			for_each_iommu(iommu) {
> +				iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
> +		                iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
> +		                iommu_enable_command_buffer(iommu);
> +		                iommu_enable_event_buffer(iommu);
> +		                iommu_set_device_table(iommu);
> +		                iommu_flush_all_caches(iommu);
> +			}
> +		}
> +	}
>  }
>
>  static void enable_iommus_v2(void)
>
