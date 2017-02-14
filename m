From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v8 9/9] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Tue, 14 Feb 2017 13:31:49 +0100
Message-ID: <20170214123149.GV6515@twins.programming.kicks-ass.net>
References: <1484551416-5440-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484551416-5440-10-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170125094653.GO6515@twins.programming.kicks-ass.net>
	<af2bca1a-59a9-d36c-a700-ca5360852543@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <af2bca1a-59a9-d36c-a700-ca5360852543-5C7GfCeVMHo@public.gmane.org>
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

On Tue, Feb 07, 2017 at 08:57:52AM +0700, Suravee Suthikulpanit wrote:
> >But instead it looks like you get the counter form:
> >
> >  #define _GET_CNTR(ev)       ((u8)(ev->hw.extra_reg.reg))
> >
> >Which is absolutely insane.
> >
> 
> So, the IOMMU counters are grouped into bank, and there could be
> many banks. I use the extra_reg.reg to hold the bank and counter
> indices. This will be used to program onto the counter configuration
> register. This is handled in get_next_avail_iommu_bnk_cntr() and
> clear_avail_iommu_bnk_cntr().

But this is crazy. That's not what extra_regs are for. Also, who cares
about the banks, why is this exposed?

That is, I would very much expect a linear range of counters. You can
always decompose this counter number if you really need to somewhere
down near the hardware accessors.
