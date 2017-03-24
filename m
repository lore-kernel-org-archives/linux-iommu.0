From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v12 09/10] perf/amd/iommu: Introduce amd_iommu-specific
	struct in struct hw_perf_event
Date: Fri, 24 Mar 2017 18:53:56 +0100
Message-ID: <20170324175356.q2k7g64uqbk72y3y@pd.tnic>
References: <1490166162-10002-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1490166162-10002-10-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490166162-10002-10-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Wed, Mar 22, 2017 at 02:02:41AM -0500, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Current AMD IOMMU Perf PMU inappropriately uses hardware struct
> inside the union inside the struct hw_perf_event, mainly the use of
> extra_reg.
> 
> Instead, introduce amd_iommu-specific struct with required
> parameters to be programmed onto the IOMMU performance counter
> control register.
> 
> Also update the pasid field from 16 to 20 bits.
> 
> Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> ---
>  arch/x86/events/amd/iommu.c | 102 +++++++++++++++++++-------------------------
>  include/linux/perf_event.h  |   7 +++
>  2 files changed, 52 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index 7ac8138..915a20c 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
> @@ -23,17 +23,16 @@
>  
>  #define COUNTER_SHIFT		16
>  
> -#define _GET_BANK(ev)       ((u8)(ev->hw.extra_reg.reg >> 8))
> -#define _GET_CNTR(ev)       ((u8)(ev->hw.extra_reg.reg))
> -
> -/* iommu pmu config masks */
> -#define _GET_CSOURCE(ev)    ((ev->hw.config & 0xFFULL))
> -#define _GET_DEVID(ev)      ((ev->hw.config >> 8)  & 0xFFFFULL)
> -#define _GET_PASID(ev)      ((ev->hw.config >> 24) & 0xFFFFULL)
> -#define _GET_DOMID(ev)      ((ev->hw.config >> 40) & 0xFFFFULL)
> -#define _GET_DEVID_MASK(ev) ((ev->hw.extra_reg.config)  & 0xFFFFULL)
> -#define _GET_PASID_MASK(ev) ((ev->hw.extra_reg.config >> 16) & 0xFFFFULL)
> -#define _GET_DOMID_MASK(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFULL)
> +/* iommu pmu conf masks */
> +#define GET_CSOURCE(x)     (x->conf & 0xFFULL)

You need to prevent the macro arg from potentially wrong precedence
rules/multiple eval:

#define GET_CSOURCE(x)     ((x)->conf & 0xFFULL)
			    ^^^

I fixed them up when applying.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
