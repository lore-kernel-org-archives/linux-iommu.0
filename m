From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V3 0/5] perf/amd/iommu: Enable multi-IOMMU support
Date: Wed, 10 Feb 2016 01:08:52 +0100
Message-ID: <20160210000852.GI4119@pd.tnic>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 09, 2016 at 04:53:50PM -0600, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> This patch series modifies the existing perf_event_amd_iommu driver
> to support systems with multiple IOMMUs. It introduces new AMD IOMMU APIs,
> which will are used by the AMD IOMMU Perf driver to access performance
> counters in multiple IOMMUs.
> 
> In addition, this series should also fix current AMD IOMMU PMU driver
> initialization issue in some existing KV and CZ platform.
> 
> Note that this patch also fixes the issue where IOMMU driver fails
> to write to IOMMU perf counter as reported by Andreas Hartmann here
> (http://comments.gmane.org/gmane.linux.kernel.pci/49147).
> 
> Git branch containing this patch series is available here:
> 
>     https://github.com/ssuthiku/linux.git  perf-iommu-v3
> 
> Changes from V2 ( https://lkml.org/lkml/2016/1/1/141)
>   * Ported to 4.5.0-rc2
>   * Add reviewed by Joerg for patch 1 and 2
>   * Remove EXPORT_SYMBOL from patch 3 (per Joerg suggestion)
>   * Merge patch 4/6 and 6/6 from V2 into 5/5 in V3 and add
>     more description in the commit message and in code comment.
>   * Patch 5: modify the logic to update counts to get rid off
>     un-necessary local64_cmpxchg().
> 
> Changes from V1 (https://lkml.org/lkml/2015/12/22/535):
>   * Update patch3 and 6 to use amd_iommus_present instead of introducing
>     amd_iommu_cnt static variable since they are the same thing
> 
> Suravee Suthikulpanit (5):
>   perf/amd/iommu: Consolidate and move perf_event_amd_iommu header
>   perf/amd/iommu: Modify functions to query max banks and counters
>   iommu/amd: Introduce amd_iommu_get_num_iommus()
>   perf/amd/iommu: Introduce get_iommu_bnk_cnt_evt_idx
>   perf/amd/iommu: Enable support for multiple IOMMUs
> 
>  arch/x86/kernel/cpu/perf_event_amd_iommu.c | 164 ++++++++++++++++++++---------
>  arch/x86/kernel/cpu/perf_event_amd_iommu.h |  40 -------

You probably want to redo those against latest tip/master:

http://git.kernel.org/tip/5b26547dd7faa84e1293baa144a0f3e74ed7d4c7

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
