From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] perf/x86/amd: AMD IOMMU PC PERF uncore PMU
	implementation
Date: Tue, 28 May 2013 14:18:50 +0200
Message-ID: <20130528121850.GC2575@8bytes.org>
References: <1368819813-6481-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1368819813-6481-3-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368819813-6481-3-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 17, 2013 at 02:43:32PM -0500, Suthikulpanit, Suravee wrote:
> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> index b0684e4..fcbd3b8 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
>  obj-$(CONFIG_PERF_EVENTS)		+= perf_event.o
>  
>  ifdef CONFIG_PERF_EVENTS
> -obj-$(CONFIG_CPU_SUP_AMD)		+= perf_event_amd.o perf_event_amd_uncore.o
> +obj-$(CONFIG_CPU_SUP_AMD)		+= perf_event_amd.o perf_event_amd_uncore.o perf_event_amd_iommu.o

This should also depend on CONFIG_AMD_IOMMU. If no IOMMU driver is
compiled in it doesn't make sense to have that PMU.

> +static int perf_iommu_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_amd_iommu *perf_iommu;
> +	u64 config, config1;
> +
> +	/* test the event attr type check for PMU enumeration */
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * IOMMU counters are shared across all cores.
> +	 * Therefore, it does not support per-process mode.
> +	 * Also, it does not support event sampling mode.
> +	 */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	/* IOMMU counters do not have usr/os/guest/host bits */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_host || event->attr.exclude_guest)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	perf_iommu = &__perf_iommu;
> +
> +	if (event->pmu != &perf_iommu->pmu)
> +		return -ENOENT;
> +
> +	if (perf_iommu) {
> +		config = event->attr.config;
> +		config1 = event->attr.config1;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	/* integrate with iommu base devid (0000), assume one iommu */
> +	perf_iommu->max_banks =
> +		amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID);
> +	perf_iommu->max_counters =
> +		amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID);
> +
> +	/* update the hw_perf_event struct with the iommu config data */
> +	hwc->config = config;
> +	hwc->extra_reg.config = config1;
> +
> +	return 0;
> +}

That implementation is very basic. Any reason for not using the event
reporting mechanism of the IOMMU? You could implement a nice perf
iommutop or something to see which devices do the most transactions or
something like that.


	Joerg
