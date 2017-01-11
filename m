From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v7 1/7] perf/amd/iommu: Misc fix up perf_iommu_read
Date: Wed, 11 Jan 2017 11:32:38 +0100
Message-ID: <20170111103238.zhs5e7mkahmp73qn@pd.tnic>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484019227-11473-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484019227-11473-2-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Mon, Jan 09, 2017 at 09:33:41PM -0600, Suravee Suthikulpanit wrote:
> This patch contains the following minor fixup:

For the future: never say "this patch" in the commit message - just
explain *why* the patch is needed.

>   * Fixed overflow handling since u64 delta would lose the MSB sign bit.

Past tense also reads funnily: "Fix overflow handling ..." sounds much
better.

>   * Remove unnecessary local64_set().

But you don't remove it - you add it. Huh?

>   * Coding style and make use of GENMASK_ULL macro.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index b28200d..f387baf 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -319,29 +319,30 @@ static void perf_iommu_start(struct perf_event *event, int flags)
>  
>  static void perf_iommu_read(struct perf_event *event)
>  {
> -	u64 count = 0ULL;
> -	u64 prev_raw_count = 0ULL;
> -	u64 delta = 0ULL;
> +	u64 cnt, prev;

"count" was fine.

> +	s64 delta;
>  	struct hw_perf_event *hwc = &event->hw;
>  	pr_debug("perf: amd_iommu:perf_iommu_read\n");

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
