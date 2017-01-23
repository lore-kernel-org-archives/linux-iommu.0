From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 3/9] perf/amd/iommu: Misc fix up perf_iommu_read
Date: Mon, 23 Jan 2017 13:33:30 +0100
Message-ID: <20170123123330.GY6485@twins.programming.kicks-ass.net>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1484551416-5440-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, bp@alien8.de, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 01:23:30AM -0600, Suravee Suthikulpanit wrote:
>  static void perf_iommu_read(struct perf_event *event)
>  {
> -	u64 count = 0ULL;
> -	u64 prev_raw_count = 0ULL;
> -	u64 delta = 0ULL;
> +	u64 count, prev;
> +	s64 delta;

I did send that email where I told I was mistaken with that suggestion,
right? Since the counter always increments (it does, right), a negative
delta does not make sense.

>  	struct hw_perf_event *hwc = &event->hw;
>  
>  	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
> @@ -330,18 +329,20 @@ static void perf_iommu_read(struct perf_event *event)
>  				IOMMU_PC_COUNTER_REG, &count, false);
>  
>  	/* IOMMU pc counter register is only 48 bits */
> -	count &= 0xFFFFFFFFFFFFULL;
> +	count &= GENMASK_ULL(48, 0);

Why do you need that at all? If the counter is only 48 bits, what does
the hardware do with the upper bits?

>  
> -	prev_raw_count =  local64_read(&hwc->prev_count);
> -	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> -					count) != prev_raw_count)
> -		return;
> +	prev = local64_read(&hwc->prev_count);

I'm still not convinced you can do away with that cmpxchg.

>  
> -	/* Handling 48-bit counter overflowing */
> -	delta = (count << COUNTER_SHIFT) - (prev_raw_count << COUNTER_SHIFT);
> +	/*
> +	 * Since we do not enable counter overflow interrupts,
> +	 * we do not have to worry about prev_count changing on us.
> +	 */
> +	local64_set(&hwc->prev_count, count);
> +
> +	/* Handle 48-bit counter overflow */
> +	delta = (count << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
>  	delta >>= COUNTER_SHIFT;
>  	local64_add(delta, &event->count);
> -
>  }
>  
>  static void perf_iommu_stop(struct perf_event *event, int flags)
> -- 
> 1.8.3.1
> 
