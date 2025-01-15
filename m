Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65357156F57
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976773; cv=none; b=ENRFwg6DaFgzT3g1w7Lo2btO3HSKzmxiy1Nrh3VCUMkVjg8bMYE2OOlpHzwPbKwvCnjAKsfeKGEJVd0HEKg6g3uDLYPf62iNTlT0sH9kVAsxnbL/rqw5X+Tx9y5PhqzJo4rHZEgFMDJ5tnDkdP79NmT+epYzxixd8aqq4OnYbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976773; c=relaxed/simple;
	bh=xfVcxboLDkb5oZmKvDyJjMSe6ST+XRAmXk0LZL27bCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aXieZuqf/MbQVYtHZCSdRd6pC3UmuEd8NDD2+r4ADJTuGYVWoJFfuG+t9QPaYf+VsnhzobkCekqnufuZWF4/FOWUPwJLCvX6gR+5f/aw2TqUNPZWhggq1fSAD/jYXclWKoyghHkHWVxVV3s9AQWgns2hxSdtYrAN0d7xPW8Myoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED8111FB;
	Wed, 15 Jan 2025 13:33:16 -0800 (PST)
Received: from [10.57.4.211] (unknown [10.57.4.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C09D3F673;
	Wed, 15 Jan 2025 13:32:45 -0800 (PST)
Message-ID: <896f03f9-4878-4d20-9992-ef3f39253acc@arm.com>
Date: Wed, 15 Jan 2025 21:32:43 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/riscv: add RISC-V IOMMU PMU support
To: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org,
 tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, luxu.kernel@bytedance.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org
References: <20250115030306.29735-1-zong.li@sifive.com>
 <20250115030306.29735-2-zong.li@sifive.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250115030306.29735-2-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-15 3:03 am, Zong Li wrote:
> Support for the RISC-V IOMMU hardware performance monitor includes
> both counting and sampling modes.
> 
> The specification does not define an event ID for counting the
> number of clock cycles, meaning there is no associated `iohpmevt0`.
> However, we need an event for counting cycle, so we reserve the
> maximum event ID for this purpose.

Why not use an extra config bit to encode cycles events completely 
independently of the regular eventID space? Or even just use 0 since by 
definition that cannot overlap a valid eventID?

> Signed-off-by: Zong Li <zong.li@sifive.com>
> Tested-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>   drivers/iommu/riscv/Makefile     |   2 +-
>   drivers/iommu/riscv/iommu-bits.h |  16 +
>   drivers/iommu/riscv/iommu-pmu.c  | 486 +++++++++++++++++++++++++++++++
>   drivers/iommu/riscv/iommu.h      |   8 +
>   4 files changed, 511 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/iommu/riscv/iommu-pmu.c
> 
> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
> index f54c9ed17d41..d36625a1fd08 100644
> --- a/drivers/iommu/riscv/Makefile
> +++ b/drivers/iommu/riscv/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
> +obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o iommu-pmu.o
>   obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
> index 98daf0e1a306..60523449f016 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -17,6 +17,7 @@
>   #include <linux/types.h>
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/perf_event.h>
>   
>   /*
>    * Chapter 5: Memory Mapped register interface
> @@ -207,6 +208,7 @@ enum riscv_iommu_ddtp_modes {
>   /* 5.22 Performance monitoring event counters (31 * 64bits) */
>   #define RISCV_IOMMU_REG_IOHPMCTR_BASE	0x0068
>   #define RISCV_IOMMU_REG_IOHPMCTR(_n)	(RISCV_IOMMU_REG_IOHPMCTR_BASE + ((_n) * 0x8))
> +#define RISCV_IOMMU_IOHPMCTR_COUNTER	GENMASK_ULL(63, 0)
>   
>   /* 5.23 Performance monitoring event selectors (31 * 64bits) */
>   #define RISCV_IOMMU_REG_IOHPMEVT_BASE	0x0160
> @@ -250,6 +252,20 @@ enum riscv_iommu_hpmevent_id {
>   	RISCV_IOMMU_HPMEVENT_MAX        = 9
>   };
>   
> +/* Use maximum event ID for cycle event */
> +#define RISCV_IOMMU_HPMEVENT_CYCLE	GENMASK_ULL(14, 0)

It's also horribly confusing to use GENMASK for something which is not 
actually a mask at all.

> +#define RISCV_IOMMU_HPM_COUNTER_NUM	32
> +
> +struct riscv_iommu_pmu {
> +	struct pmu pmu;
> +	void __iomem *reg;
> +	int num_counters;
> +	u64 mask_counter;
> +	struct perf_event *events[RISCV_IOMMU_IOHPMEVT_CNT + 1];
> +	DECLARE_BITMAP(used_counters, RISCV_IOMMU_IOHPMEVT_CNT + 1);

Hmm, from experience I would expect these variables to be 
number-of-counters related, but I guess there must be some special 
cleverness going on since that number-of-counters looking 
RISCV_IOMMU_HPM_COUNTER_NUM definition is conspicuously not used, so it 
must be significant that these are instead related to the number of...

[ goes off to search code... ]

...event selectors? But with a magic +1 for reasons so obvious they 
clearly don't need explaining.

> +};
> +
>   /* 5.24 Translation request IOVA (64bits) */
>   #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
>   #define RISCV_IOMMU_TR_REQ_IOVA_VPN	GENMASK_ULL(63, 12)
> diff --git a/drivers/iommu/riscv/iommu-pmu.c b/drivers/iommu/riscv/iommu-pmu.c
> new file mode 100644
> index 000000000000..74eb1525cd32
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-pmu.c
> @@ -0,0 +1,486 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 SiFive
> + *
> + * Authors
> + *	Zong Li <zong.li@sifive.com>
> + */
> +
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +
> +#include "iommu.h"
> +#include "iommu-bits.h"
> +
> +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
> +
> +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)			\
> +	static inline u32 get_##_name(struct perf_event *event)		\
> +	{								\
> +		return FIELD_GET(_mask, event->attr.config);		\
> +	}								\
> +
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEVT_DMASK);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_PSCID);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_GSCID);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEVT_PV_PSCV);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEVT_DV_GSCV);
> +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_IDT);
> +
> +/* Formats */
> +PMU_FORMAT_ATTR(event, "config:0-14");
> +PMU_FORMAT_ATTR(partial_matching, "config:15");
> +PMU_FORMAT_ATTR(pid_pscid, "config:16-35");
> +PMU_FORMAT_ATTR(did_gscid, "config:36-59");
> +PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
> +PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
> +PMU_FORMAT_ATTR(filter_id_type, "config:62");
> +
> +static struct attribute *riscv_iommu_pmu_formats[] = {
> +	&format_attr_event.attr,
> +	&format_attr_partial_matching.attr,
> +	&format_attr_pid_pscid.attr,
> +	&format_attr_did_gscid.attr,
> +	&format_attr_filter_pid_pscid.attr,
> +	&format_attr_filter_did_gscid.attr,
> +	&format_attr_filter_id_type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group riscv_iommu_pmu_format_group = {
> +	.name = "format",
> +	.attrs = riscv_iommu_pmu_formats,
> +};
> +
> +/* Events */
> +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);

sysfs_emit()

> +}
> +
> +PMU_EVENT_ATTR(cycle, event_attr_cycle,
> +	       RISCV_IOMMU_HPMEVENT_CYCLE, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(dont_count, event_attr_dont_count,
> +	       RISCV_IOMMU_HPMEVENT_INVALID, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(untranslated_req, event_attr_untranslated_req,
> +	       RISCV_IOMMU_HPMEVENT_URQ, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(translated_req, event_attr_translated_req,
> +	       RISCV_IOMMU_HPMEVENT_TRQ, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(ats_trans_req, event_attr_ats_trans_req,
> +	       RISCV_IOMMU_HPMEVENT_ATS_RQ, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(tlb_miss, event_attr_tlb_miss,
> +	       RISCV_IOMMU_HPMEVENT_TLB_MISS, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(ddt_walks, event_attr_ddt_walks,
> +	       RISCV_IOMMU_HPMEVENT_DD_WALK, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(pdt_walks, event_attr_pdt_walks,
> +	       RISCV_IOMMU_HPMEVENT_PD_WALK, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(s_vs_pt_walks, event_attr_s_vs_pt_walks,
> +	       RISCV_IOMMU_HPMEVENT_S_VS_WALKS, riscv_iommu_pmu_event_show);
> +PMU_EVENT_ATTR(g_pt_walks, event_attr_g_pt_walks,
> +	       RISCV_IOMMU_HPMEVENT_G_WALKS, riscv_iommu_pmu_event_show);
> +
> +static struct attribute *riscv_iommu_pmu_events[] = {
> +	&event_attr_cycle.attr.attr,
> +	&event_attr_dont_count.attr.attr,
> +	&event_attr_untranslated_req.attr.attr,
> +	&event_attr_translated_req.attr.attr,
> +	&event_attr_ats_trans_req.attr.attr,
> +	&event_attr_tlb_miss.attr.attr,
> +	&event_attr_ddt_walks.attr.attr,
> +	&event_attr_pdt_walks.attr.attr,
> +	&event_attr_s_vs_pt_walks.attr.attr,
> +	&event_attr_g_pt_walks.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group riscv_iommu_pmu_events_group = {
> +	.name = "events",
> +	.attrs = riscv_iommu_pmu_events,
> +};
> +
> +static const struct attribute_group *riscv_iommu_pmu_attr_grps[] = {
> +	&riscv_iommu_pmu_format_group,
> +	&riscv_iommu_pmu_events_group,
> +	NULL,
> +};

You also need a "cpumask" attribute to tell userspace this is a 
system/uncore PMU.

> +
> +/* PMU Operations */
> +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u32 idx,
> +					u64 value)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> +
> +	if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))

One of those conditions is literally impossible, the other should 
already be avoided by construction.

> +		return;
> +
> +	if (idx == 0)
> +		value = (value & ~RISCV_IOMMU_IOHPMCYCLES_OF) |
> +			 (readq(addr) & RISCV_IOMMU_IOHPMCYCLES_OF);

I don't think you need this - as best I can tell, you never initialise a 
counter without also (re)enabling the interrupt (which is logical), so 
since "value" for the cycle counter should always implicitly have OF=0 
anyway, it should work to just write it like the other counters.

> +	writeq(FIELD_PREP(RISCV_IOMMU_IOHPMCTR_COUNTER, value), addr + idx * 8);

Is RISCV_IOMMU_IOHPMCTR_COUNTER honestly useful? Or is it actively 
hurting readability by obfuscating that we are in fact just using the 
full 64-bit value in all those places?

> +}
> +
> +static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> +	u64 value;
> +
> +	if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> +		return -EINVAL;
> +
> +	value = readq(addr + idx * 8);

Might be worth leaving a comment just in case anyone does try to enable 
this for 32-bit that the io-64-nonatomic readq() isn't enough to work 
properly here.

> +
> +	if (idx == 0)
> +		return FIELD_GET(RISCV_IOMMU_IOHPMCYCLES_COUNTER, value);
> +
> +	return FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, value);
> +}
> +
> +static u64 riscv_iommu_pmu_get_event(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE;
> +
> +	if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> +		return 0;
> +
> +	/* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> +	if (idx == 0)
> +		return 0;
> +
> +	return readq(addr + (idx - 1) * 8);
> +}

That's a wonderfully expensive way to spell "pmu->events[idx]->hw.config"...

> +
> +static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32 idx,
> +				      u64 value)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE;
> +
> +	if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> +		return;
> +
> +	/* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> +	if (idx == 0)
> +		return;
> +
> +	writeq(value, addr + (idx - 1) * 8);
> +}
> +
> +static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 value = readl(addr);
> +
> +	writel(value & ~BIT(idx), addr);
> +}
> +
> +static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 value = readl(addr);
> +
> +	writel(value | BIT(idx), addr);
> +}
> +
> +static void riscv_iommu_pmu_enable_ovf_intr(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	u64 value;
> +
> +	if (get_event(pmu->events[idx]) == RISCV_IOMMU_HPMEVENT_CYCLE) {

And that's a very creative way to spell "if (idx == 0)".

> +		value = riscv_iommu_pmu_get_counter(pmu, idx) & ~RISCV_IOMMU_IOHPMCYCLES_OF;
> +		writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES);

(and as above, I think you can make this a no-op for the cycle counter)

> +	} else {
> +		value = riscv_iommu_pmu_get_event(pmu, idx) & ~RISCV_IOMMU_IOHPMEVT_OF;
> +		writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE + (idx - 1) * 8);
> +	}
> +}
> +
> +static void riscv_iommu_pmu_disable_ovf_intr(struct riscv_iommu_pmu *pmu, u32 idx)
> +{
> +	u64 value;
> +
> +	if (get_event(pmu->events[idx]) == RISCV_IOMMU_HPMEVENT_CYCLE) {
> +		value = riscv_iommu_pmu_get_counter(pmu, idx) | RISCV_IOMMU_IOHPMCYCLES_OF;
> +		writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES);
> +	} else {
> +		value = riscv_iommu_pmu_get_event(pmu, idx) | RISCV_IOMMU_IOHPMEVT_OF;
> +		writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE + (idx - 1) * 8);
> +	}
> +}

TBH I'd be inclined to just leave out all the dead cleanup code if the 
PMU driver is tied to the IOMMU driver and can never realistically be 
removed.

> +static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu)
> +{
> +	int idx;
> +
> +	for_each_set_bit(idx, pmu->used_counters, pmu->num_counters) {
> +		riscv_iommu_pmu_enable_ovf_intr(pmu, idx);

Surely this should only touch the counter(s) that overflowed and have 
been handled? It might be cleaner to keep that within the IRQ handler 
itself.

> +		riscv_iommu_pmu_enable_counter(pmu, idx);

This needs to start all active counters together, not one-by-one.

> +	}
> +}
> +
> +static void riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
> +{
> +	writel(GENMASK_ULL(pmu->num_counters - 1, 0),
> +	       pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
> +}
> +
> +/* PMU APIs */
> +static int riscv_iommu_pmu_set_period(struct perf_event *event)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	s64 left = local64_read(&hwc->period_left);
> +	s64 period = hwc->sample_period;
> +	u64 max_period = pmu->mask_counter;
> +	int ret = 0;
> +
> +	if (unlikely(left <= -period)) {
> +		left = period;
> +		local64_set(&hwc->period_left, left);
> +		hwc->last_period = period;
> +		ret = 1;
> +	}
> +
> +	if (unlikely(left <= 0)) {
> +		left += period;
> +		local64_set(&hwc->period_left, left);
> +		hwc->last_period = period;
> +		ret = 1;
> +	}

None of this is relevant or necessary. This is not a CPU PMU, so it 
can't support sampling because it doesn't have a meaningful context to 
sample.

> +	/*
> +	 * Limit the maximum period to prevent the counter value
> +	 * from overtaking the one we are about to program. In
> +	 * effect we are reducing max_period to account for
> +	 * interrupt latency (and we are being very conservative).
> +	 */
> +	if (left > (max_period >> 1))
> +		left = (max_period >> 1);
> +
> +	local64_set(&hwc->prev_count, (u64)-left);
> +	riscv_iommu_pmu_set_counter(pmu, hwc->idx, (u64)(-left) & max_period);
> +	perf_event_update_userpage(event);
> +
> +	return ret;
> +}
> +
> +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;

You first need to validate that the event is for this PMU at all, and 
return -ENOENT if not.

> +	hwc->idx = -1;
> +	hwc->config = event->attr.config;
> +
> +	if (!is_sampling_event(event)) {

As above, you can't support sampling events anyway, so you should reject 
them with -EINVAL.

You also need to validate event groups to ensure they don't contain more 
events than could ever be scheduled at once.

> +		/*
> +		 * For non-sampling runs, limit the sample_period to half
> +		 * of the counter width. That way, the new counter value
> +		 * is far less likely to overtake the previous one unless
> +		 * you have some serious IRQ latency issues.
> +		 */
> +		hwc->sample_period = pmu->mask_counter >> 1;
> +		hwc->last_period = hwc->sample_period;
> +		local64_set(&hwc->period_left, hwc->sample_period);
> +	}
> +
> +	return 0;
> +}
> +
> +static void riscv_iommu_pmu_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	u64 delta, prev, now;
> +	u32 idx = hwc->idx;
> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +		now = riscv_iommu_pmu_get_counter(pmu, idx);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
> +
> +	delta = FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, now - prev) & pmu->mask_counter;
> +	local64_add(delta, &event->count);
> +	local64_sub(delta, &hwc->period_left);
> +}
> +
> +static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> +		return;
> +
> +	if (flags & PERF_EF_RELOAD)
> +		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> +
> +	hwc->state = 0;
> +	riscv_iommu_pmu_set_period(event);
> +	riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> +	riscv_iommu_pmu_enable_ovf_intr(pmu, hwc->idx);

This does nothing, since set_event has just implicitly written OF=0.

...unless, that is, the user was mischievous and also set bit 63 in 
event->attr.config, since you never sanitised the input ;)

> +	riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	riscv_iommu_pmu_set_event(pmu, hwc->idx, RISCV_IOMMU_HPMEVENT_INVALID);
> +	riscv_iommu_pmu_disable_counter(pmu, hwc->idx);
> +
> +	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE))
> +		riscv_iommu_pmu_update(event);
> +
> +	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	unsigned int num_counters = pmu->num_counters;
> +	int idx;
> +
> +	/* Reserve index zero for iohpmcycles */
> +	if (get_event(event) == RISCV_IOMMU_HPMEVENT_CYCLE)
> +		idx = 0;
> +	else
> +		idx = find_next_zero_bit(pmu->used_counters, num_counters, 1);
> +
> +	if (idx == num_counters)
> +		return -EAGAIN;

But stomping a cycles event on top of an existing cycles event is fine?

> +	set_bit(idx, pmu->used_counters);
> +
> +	pmu->events[idx] = event;
> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (flags & PERF_EF_START)
> +		riscv_iommu_pmu_start(event, flags);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static void riscv_iommu_pmu_read(struct perf_event *event)
> +{
> +	riscv_iommu_pmu_update(event);
> +}
> +
> +static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
> +	int idx = hwc->idx;
> +
> +	riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> +	pmu->events[idx] = NULL;
> +	clear_bit(idx, pmu->used_counters);
> +	perf_event_update_userpage(event);
> +}
> +
> +irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu)
> +{
> +	struct perf_sample_data data;
> +	struct pt_regs *regs;
> +	u32 ovf = readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> +	int idx;
> +
> +	if (!ovf)
> +		return IRQ_NONE;
> +
> +	riscv_iommu_pmu_stop_all(pmu);
> +
> +	regs = get_irq_regs();

What do these regs represent? If you look at the perf_event_open ABI, 
you'll see that events can target various combinations of CPU and/or 
pid, but there is no encoding for "whichever CPU takes the IOMMU PMU 
interrupt". Thus whatever you get here is more than likely not what the 
user asked for, and this is why non-CPU PMUs cannot reasonably support 
sampling ;)

> +
> +	for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counters) {
> +		struct perf_event *event = pmu->events[idx];
> +		struct hw_perf_event *hwc;
> +
> +		if (WARN_ON_ONCE(!event) || !is_sampling_event(event))

You still need to handle counter rollover for all events, otherwise they 
can start losing counts and rapidly turn to nonsense. Admittedly it's 
largely theoretical with full 64-bit counters, but still...

> +			continue;
> +
> +		hwc = &event->hw;
> +
> +		riscv_iommu_pmu_update(event);
> +		perf_sample_data_init(&data, 0, hwc->last_period);
> +		if (!riscv_iommu_pmu_set_period(event))
> +			continue;
> +
> +		if (perf_event_overflow(event, &data, regs))
> +			riscv_iommu_pmu_stop(event, 0);
> +	}
> +
> +	riscv_iommu_pmu_start_all(pmu);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int riscv_iommu_pmu_init(struct riscv_iommu_pmu *pmu, void __iomem *reg,
> +			 const char *dev_name)
> +{
> +	char *name;
> +	int ret;
> +
> +	pmu->reg = reg;
> +	pmu->num_counters = RISCV_IOMMU_HPM_COUNTER_NUM;
> +	pmu->mask_counter = RISCV_IOMMU_IOHPMCTR_COUNTER;

Initially this looks weird - why bother storing constants in memory if 
they're constant? - but I see the spec implies they are not necessarily 
fixed, and we can only actually assume at least one counter at least 32 
bits wide, so I guess this is really more of a placeholder? Is there a 
well-defined way we're supposed to be able to discover these, like some 
more ID register fields somewhere, or writing all 1s to various 
registers to see what sticks, or is it liable to be a mess of just 
having to know what each implementation has by matching DT compatibles 
and/or PCI IDs?

> +
> +	pmu->pmu = (struct pmu) {
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= riscv_iommu_pmu_event_init,
> +		.add		= riscv_iommu_pmu_add,
> +		.del		= riscv_iommu_pmu_del,
> +		.start		= riscv_iommu_pmu_start,
> +		.stop		= riscv_iommu_pmu_stop,
> +		.read		= riscv_iommu_pmu_read,
> +		.attr_groups	= riscv_iommu_pmu_attr_grps,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +		.module		= THIS_MODULE,
> +	};

The new thing is that you can now set pmu.parent to the IOMMU device so 
their relationship is clear in sysfs, rather than having to play tricks 
with the PMU name.

> +
> +	name = kasprintf(GFP_KERNEL, "riscv_iommu_pmu_%s", dev_name);
> +
> +	ret = perf_pmu_register(&pmu->pmu, name, -1);
> +	if (ret) {
> +		pr_err("Failed to register riscv_iommu_pmu_%s: %d\n",
> +		       dev_name, ret);
> +		return ret;
> +	}
> +
> +	/* Stop all counters and later start the counter with perf */
> +	riscv_iommu_pmu_stop_all(pmu);
> +
> +	pr_info("riscv_iommu_pmu_%s: Registered with %d counters\n",
> +		dev_name, pmu->num_counters);
> +
> +	return 0;
> +}
> +
> +void riscv_iommu_pmu_uninit(struct riscv_iommu_pmu *pmu)
> +{
> +	int idx;
> +
> +	/* Disable interrupt and functions */
> +	for_each_set_bit(idx, pmu->used_counters, pmu->num_counters) {

This will never do anything, since even if we could ever get here, it 
would not be at a time when there are any active events. Unregistering 
an in-use PMU does not end well (hence why standalone PMU drivers need 
to use suppress_bind_attrs)...

Thanks,
Robin.

> +		riscv_iommu_pmu_disable_counter(pmu, idx);
> +		riscv_iommu_pmu_disable_ovf_intr(pmu, idx);
> +	}
> +
> +	perf_pmu_unregister(&pmu->pmu);
> +}
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index b1c4664542b4..92659a8a75ae 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -60,11 +60,19 @@ struct riscv_iommu_device {
>   	unsigned int ddt_mode;
>   	dma_addr_t ddt_phys;
>   	u64 *ddt_root;
> +
> +	/* hardware performance monitor */
> +	struct riscv_iommu_pmu pmu;
>   };
>   
>   int riscv_iommu_init(struct riscv_iommu_device *iommu);
>   void riscv_iommu_remove(struct riscv_iommu_device *iommu);
>   
> +int riscv_iommu_pmu_init(struct riscv_iommu_pmu *pmu, void __iomem *reg,
> +			 const char *name);
> +void riscv_iommu_pmu_uninit(struct riscv_iommu_pmu *pmu);
> +irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu);
> +
>   #define riscv_iommu_readl(iommu, addr) \
>   	readl_relaxed((iommu)->reg + (addr))
>   

