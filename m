From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v10 1/9] perf/amd/iommu: Declare pr_fmt and remove
 unnecessary pr_debug
Date: Wed, 15 Feb 2017 16:45:11 -0800
Message-ID: <1487205911.6214.71.camel@perches.com>
References: <1487192185-31272-1-git-send-email-Suravee.Suthikulpanit@amd.com>
         <1487192185-31272-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487192185-31272-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: bp@alien8.de, peterz@infradead.org, joro@8bytes.org, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Wed, 2017-02-15 at 14:56 -0600, Suravee Suthikulpanit wrote:
> Declare pr_fmt for perf/amd_iommu and remove unnecessary pr_debug.
[]
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
[]
> @@ -11,6 +11,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#define pr_fmt(fmt)	"perf/amd_iommu: " fmt
> +
>  #include <linux/perf_event.h>
>  #include <linux/init.h>
>  #include <linux/cpumask.h>
[]
> @@ -444,24 +440,24 @@ static __init int _init_perf_amd_iommu(
>  
>  	raw_spin_lock_init(&perf_iommu->lock);
>  
> -	/* Init format attributes */
>  	perf_iommu->format_group = &amd_iommu_format_group;
>  
>  	/* Init cpumask attributes to only core 0 */
>  	cpumask_set_cpu(0, &iommu_cpumask);
>  	perf_iommu->cpumask_group = &amd_iommu_cpumask_group;
>  
> -	/* Init events attributes */
> -	if (_init_events_attrs(perf_iommu) != 0)
> -		pr_err("perf: amd_iommu: Only support raw events.\n");
> +	ret = _init_events_attrs(perf_iommu);
> +	if (ret) {
> +		pr_err("Error initializing AMD IOMMU perf events.\n");
> +		return ret;
> +	}
>  
> -	/* Init null attributes */
>  	perf_iommu->null_group = NULL;
>  	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
>  
>  	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
>  	if (ret) {
> -		pr_err("perf: amd_iommu: Failed to initialized.\n");
> +		pr_err("Error initializing AMD IOMMU perf counters.\n");
>  		amd_iommu_pc_exit();
>  	} else {
>  		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",

You should remove the now unnecessary internal prefixes
in the other pr_<level> uses like the pr_info above.
