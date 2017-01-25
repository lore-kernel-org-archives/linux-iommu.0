From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v8 9/9] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Wed, 25 Jan 2017 10:46:53 +0100
Message-ID: <20170125094653.GO6515@twins.programming.kicks-ass.net>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-10-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-10-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 01:23:36AM -0600, Suravee Suthikulpanit wrote:

> +	pi = container_of(event->pmu, struct perf_amd_iommu, pmu);
> +	hwc->idx              = pi->idx;
> +	hwc->config           = event->attr.config;
> +	hwc->extra_reg.config = event->attr.config1;

>  static void perf_iommu_enable_event(struct perf_event *ev)
>  {
> +	struct hw_perf_event *hwc = &ev->hw;
>  	u8 csource = _GET_CSOURCE(ev);
>  	u16 devid = _GET_DEVID(ev);
>  	u8 bank = _GET_BANK(ev);
> @@ -253,30 +248,34 @@ static void perf_iommu_enable_event(struct perf_event *ev)
>  	u64 reg = 0ULL;
>  
>  	reg = csource;
> -	amd_iommu_pc_set_reg(0, bank, cntr,
> +	amd_iommu_pc_set_reg(hwc->idx, bank, cntr,
>  			     IOMMU_PC_COUNTER_SRC_REG, &reg);

Please explain about this IOMMU crud, this looks like fail.

hwc->idx should be the counter, not a random pmu index.

But instead it looks like you get the counter form:

  #define _GET_CNTR(ev)       ((u8)(ev->hw.extra_reg.reg))

Which is absolutely insane.
