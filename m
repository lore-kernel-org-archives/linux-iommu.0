From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 2/2 V4] perf/x86/amd: AMD IOMMU PC PERF uncore PMU
	implementation
Date: Mon, 3 Jun 2013 11:16:38 +0200
Message-ID: <20130603091638.GC8770@twins.programming.kicks-ass.net>
References: <1369781112-2198-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1369781112-2198-3-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369781112-2198-3-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 28, 2013 at 05:45:12PM -0500, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> +static void perf_iommu_start(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	pr_debug("perf: amd_iommu:perf_iommu_start\n");
> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> +		return;
> +
> +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> +	hwc->state = 0;
> +
> +	if (flags & PERF_EF_RELOAD) {
> +		u64 prev_raw_count =  local64_read(&hwc->prev_count);
> +		amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
> +				_GET_BANK(event), _GET_CNTR(event),
> +				IOMMU_PC_COUNTER_REG, &prev_raw_count, true);
> +	}
> +
> +	perf_iommu_enable_event(event);
> +	perf_event_update_userpage(event);
> +
> +}
> +
> +static void perf_iommu_read(struct perf_event *event)
> +{
> +	u64 count = 0ULL;
> +	u64 prev_raw_count = 0ULL;
> +	u64 delta = 0ULL;
> +	struct hw_perf_event *hwc = &event->hw;
> +	pr_debug("perf: amd_iommu:perf_iommu_read\n");
> +
> +	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
> +				_GET_BANK(event), _GET_CNTR(event),
> +				IOMMU_PC_COUNTER_REG, &count, false);
> +
> +	/* IOMMU pc counter register is only 48 bits */
> +	count &= 0xFFFFFFFFFFFFULL;
> +
> +	prev_raw_count =  local64_read(&hwc->prev_count);
> +	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> +					count) != prev_raw_count)
> +		return;
> +
> +	delta = count - prev_raw_count;
> +	local64_add(delta, &event->count);
> +
> +}

OK, so it looks like you have the event as a free-running counter; that
is, I don't see it being reset anywhere.

Combined with the fact that you're only 48bit wide, it looks like you
have a problem.

perf_iommu_read()'s delta is wrong. Imagine we've just wrapped and
prev_raw_count = 0xFFFFFFFFFFFFUL and count = 0x1. Then we do a 64bit
subtraction and end up with delta = 0xffff000000000002 or
18446462598732840962 instead of 2.

(also there's trailing whitespace in that function)

> +
> +static void perf_iommu_stop(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 config;
> +
> +	pr_debug("perf: amd_iommu:perf_iommu_stop\n");
> +
> +	if (hwc->state & PERF_HES_UPTODATE)
> +		return;
> +
> +	perf_iommu_disable_event(event);
> +	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> +	hwc->state |= PERF_HES_STOPPED;
> +
> +	if (hwc->state & PERF_HES_UPTODATE)
> +		return;
> +
> +	config = hwc->config;
> +	perf_iommu_read(event);
> +	hwc->state |= PERF_HES_UPTODATE;
> +}
