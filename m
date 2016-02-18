From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V4 0/6] perf/amd/iommu: Enable multi-IOMMU support
Date: Thu, 18 Feb 2016 09:30:36 +0700
Message-ID: <56C52CCC.5030303@amd.com>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi All,

I am wondering if there are any other concerns for this patch series.

Thanks,
Suravee

On 2/11/16 16:15, Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>
> This patch series modifies the existing perf_event_amd_iommu driver
> to support systems with multiple IOMMUs. It introduces new AMD IOMMU APIs,
> which are used by the AMD IOMMU Perf driver to access performance
> counters in multiple IOMMUs.
>
> In addition, this series should also fix current AMD IOMMU PMU driver
> initialization issue in some existing KV and CZ platform, where it fails
> to write to IOMMU perf counter as reported by Andreas Hartmann here
> (http://comments.gmane.org/gmane.linux.kernel.pci/49147).
>
> Git branch containing this patch series is available here:
>
>      https://github.com/ssuthiku/linux.git  perf-iommu-v4
>
> Changes from V3 (https://lkml.org/lkml/2016/2/9/845)
>    * Rebase the code to tip/master per Boris suggestion
>    * Most changes are in patch 5/6:
>      * Fix several spelling and styling issues per Boris review comment
>      * Remove unnecessary pr_debug in the perf amd iommu driver (per Boris)
>      * Rename several function to make it less confusing (per Boris)
>      * Properly handle errors when fails to set registers/counters
>        on multiple IOMMUs. (per Boris)
>
> Changes from V2 ( https://lkml.org/lkml/2016/1/1/141)
>    * Ported to 4.5.0-rc2
>    * Add reviewed by Joerg for patch 1 and 2
>    * Remove EXPORT_SYMBOL from patch 3 (per Joerg suggestion)
>    * Merge patch 4/6 and 6/6 from V2 into 5/5 in V3 and add
>      more description in the commit message and in code comment.
>    * Patch 5: modify the logic to update counts to get rid off
>      un-necessary local64_cmpxchg().
>
> Changes from V1 (https://lkml.org/lkml/2015/12/22/535):
>    * Update patch3 and 6 to use amd_iommus_present instead of introducing
>      amd_iommu_cnt static variable since they are the same thing
>
> Suravee Suthikulpanit (6):
>    perf/amd/iommu: Consolidate and move perf_event_amd_iommu header
>    perf/amd/iommu: Modify functions to query max banks and counters
>    iommu/amd: Introduce amd_iommu_get_num_iommus()
>    perf/amd/iommu: Introduce get_iommu_bnk_cnt_evt_idx
>    perf/amd/iommu: Enable support for multiple IOMMUs
>    perf/amd/iommu: Declar pr_fmt and remove unnecessary pr_debug
>
>   arch/x86/events/amd/iommu.c           | 197 ++++++++++++++++++++++------------
>   arch/x86/events/amd/iommu.h           |  40 -------
>   arch/x86/include/asm/perf/amd/iommu.h |  42 ++++++++
>   drivers/iommu/amd_iommu_init.c        | 136 +++++++++++++++++++----
>   drivers/iommu/amd_iommu_proto.h       |   7 --
>   5 files changed, 286 insertions(+), 136 deletions(-)
>   delete mode 100644 arch/x86/events/amd/iommu.h
>   create mode 100644 arch/x86/include/asm/perf/amd/iommu.h
>
