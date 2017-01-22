From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v8 7/9] perf/amd/iommu: Check return value when set and
	get counter value
Date: Sun, 22 Jan 2017 20:53:45 +0100
Message-ID: <20170122195345.qxbu7b2gqfu7nxkd@pd.tnic>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-8-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-8-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 01:23:34AM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> In, perf_iommu_start(), we need to check the return value from
> amd_iommu_set_reg(). In case of failure, we should not enable the PMU.
> 
> Also, in perf_iommu_read(), we need to check the return value from
> amd_iommu_get_reg() before using the value.

So basically you wanna say:

"Add amd_iommu_{g,s}et_reg() error handling."

> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 200d2e8..cc7bea4 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -284,6 +284,7 @@ static void perf_iommu_disable_event(struct perf_event *event)
>  
>  static void perf_iommu_start(struct perf_event *event, int flags)
>  {
> +	u64 val;
>  	struct hw_perf_event *hwc = &event->hw;
>  
>  	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> @@ -292,15 +293,16 @@ static void perf_iommu_start(struct perf_event *event, int flags)
>  	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
>  	hwc->state = 0;
>  
> -	if (flags & PERF_EF_RELOAD) {
> -		u64 prev_raw_count =  local64_read(&hwc->prev_count);
> -		amd_iommu_pc_set_reg(0, _GET_BANK(event), _GET_CNTR(event),
> -				     IOMMU_PC_COUNTER_REG, &prev_raw_count);
> -	}
> +	if (!(flags & PERF_EF_RELOAD))
> +		return;

This looks wrong - you still need to do

	perf_iommu_enable_event(event);
	perf_event_update_userpage(event);

even if !PERF_EF_RELOAD.

> +	val = local64_read(&hwc->prev_count) & GENMASK_ULL(48, 0);
> +	if (amd_iommu_pc_set_reg(0, _GET_BANK(event), _GET_CNTR(event),
> +				   IOMMU_PC_COUNTER_REG, &val))
> +		return;
>  
>  	perf_iommu_enable_event(event);
>  	perf_event_update_userpage(event);
> -
>  }

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
