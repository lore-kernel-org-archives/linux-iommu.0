From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 0/6] perf/amd/iommu: Enable multi-IOMMU support
Date: Fri, 1 Jan 2016 12:13:34 -0600
Message-ID: <1451672020-2150-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch series modifies the existing perf_event_amd_iommu driver
to support systems with multiple IOMMUs. It introduces new AMD IOMMU APIs,
which will are used by the AMD IOMMU Perf driver to access performance
counters in multiple IOMMUs.

In addition, this series should also fix current AMD IOMMU PMU driver
initialization issue in some existing CZ platform.

Changes from V1 (https://lkml.org/lkml/2015/12/22/535):
  * Update patch3 and 6 to use amd_iommus_present instead of introducing
    amd_iommu_cnt static variable since they are the same thing

Suravee Suthikulpanit (6):
  perf/amd/iommu: Consolidate and move perf_event_amd_iommu header
  perf/amd/iommu: Modify functions to query max banks and counters
  iommu/amd: Introduce amd_iommu_get_num_iommus()
  perf/amd/iommu: Introduce data structure for tracking prev count.
  perf/amd/iommu: Introduce get_iommu_bnk_cnt_evt_idx
  perf/amd/iommu: Enable support for multiple IOMMUs

 arch/x86/kernel/cpu/perf_event_amd_iommu.c | 145 +++++++++++++++++++----------
 arch/x86/kernel/cpu/perf_event_amd_iommu.h |  40 --------
 drivers/iommu/amd_iommu_init.c             | 117 +++++++++++++++++++----
 drivers/iommu/amd_iommu_proto.h            |   7 --
 include/linux/perf/perf_event_amd_iommu.h  |  43 +++++++++
 5 files changed, 239 insertions(+), 113 deletions(-)
 delete mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommu.h
 create mode 100644 include/linux/perf/perf_event_amd_iommu.h

-- 
1.9.1
