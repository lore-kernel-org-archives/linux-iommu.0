From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V4 5/6] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Thu, 18 Feb 2016 14:18:53 +0100
Message-ID: <20160218131853.GU6357@twins.programming.kicks-ass.net>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1455182127-17551-6-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455182127-17551-6-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: joro@8bytes.org, bp@alien8.de, mingo@redhat.com, acme@kernel.org, andihartmann@freenet.de, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 11, 2016 at 04:15:26PM +0700, Suravee Suthikulpanit wrote:
>  static void perf_iommu_read(struct perf_event *event)
>  {
> +	int i;
>  	u64 delta = 0ULL;
>  	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_amd_iommu *perf_iommu = container_of(event->pmu,
> +							 struct perf_amd_iommu,
> +							 pmu);
>  
> +	if (amd_iommu_pc_get_counters(_GET_BANK(event), _GET_CNTR(event),
> +				      amd_iommu_get_num_iommus(),
> +				      perf_iommu_cnts))
>  		return;
>  
> +	/*
> +	 * Now we re-aggregating event counts and prev-counts
> +	 * from all IOMMUs
> +	 */
> +	local64_set(&hwc->prev_count, 0);
> +
> +	for (i = 0; i < amd_iommu_get_num_iommus(); i++) {
> +		int indx = get_iommu_bnk_cnt_evt_idx(perf_iommu, i,
> +						     _GET_BANK(event),
> +						     _GET_CNTR(event));
> +		u64 prev_raw_count = local64_read(&perf_iommu->prev_cnts[indx]);
> +
> +		/* IOMMU pc counter register is only 48 bits */
> +		perf_iommu_cnts[i] &= GENMASK_ULL(48, 0);
> +
> +		/*
> +		 * Since we do not enable counter overflow interrupts,
> +		 * we do not have to worry about prev_count changing on us
> +		 */
> +		local64_set(&perf_iommu->prev_cnts[indx], perf_iommu_cnts[i]);
> +		local64_add(prev_raw_count, &hwc->prev_count);
> +
> +		/* Handle 48-bit counter overflow */
> +		delta = (perf_iommu_cnts[i] << COUNTER_SHIFT) - (prev_raw_count << COUNTER_SHIFT);
> +		delta >>= COUNTER_SHIFT;
> +		local64_add(delta, &event->count);
> +	}
>  }

So I really don't have time to review new muck while I'm hunting perf
core fail, but Boris made me look at this.

This is crazy, if you have multiple IOMMUs then create an event per
IOMMU, do _NOT_ fold them all into a single event.

In any case, the reason Boris asked me to look at this is that your
overflow handling is broken, you want delta to be s64. Otherwise:

	delta >>= COUNTER_SHIFT;

ends up as a SHR and you loose the MSB sign bits.
