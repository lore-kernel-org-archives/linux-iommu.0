From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v8 3/9] perf/amd/iommu: Misc fix up perf_iommu_read
Date: Thu, 19 Jan 2017 11:01:48 +0100
Message-ID: <20170119100148.vvmi7m2kpmtd6ylz@pd.tnic>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484551416-5440-4-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

> Subject: Re: [PATCH v8 3/9] perf/amd/iommu: Misc fix up perf_iommu_read

Please be a bit more thorough when writing your commit messages. What is
a "misc fix up"? Perhaps it is ok for a quick'n'dirty local patch but
not when it is for upstream.

Also, function names end with "()" to denote they're functions.

On Mon, Jan 16, 2017 at 01:23:30AM -0600, Suravee Suthikulpanit wrote:
> * Fix overflow handling since u64 delta would lose the MSB sign bit.
> * Remove unnecessary local64_cmpxchg().
> * Coding style and make use of GENMASK_ULL macro.

That last one doesn't read like a sentence.

> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 1aa25d8..3f1c18a 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -320,9 +320,8 @@ static void perf_iommu_start(struct perf_event *event, int flags)
>  
>  static void perf_iommu_read(struct perf_event *event)
>  {
> -	u64 count = 0ULL;
> -	u64 prev_raw_count = 0ULL;
> -	u64 delta = 0ULL;
> +	u64 count, prev;
> +	s64 delta;
>  	struct hw_perf_event *hwc = &event->hw;
>  
>  	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
> @@ -330,18 +329,20 @@ static void perf_iommu_read(struct perf_event *event)
>  				IOMMU_PC_COUNTER_REG, &count, false);
>  
>  	/* IOMMU pc counter register is only 48 bits */
> -	count &= 0xFFFFFFFFFFFFULL;
> +	count &= GENMASK_ULL(48, 0);

GENMASK_ULL(48, 0) gives 0x1ffffffffffff, however. Which is 49 bits.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
