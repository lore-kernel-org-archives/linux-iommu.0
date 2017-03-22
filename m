From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v12 00/10] perf/amd/iommu: Enable multi-IOMMU support
Date: Wed, 22 Mar 2017 02:02:32 -0500
Message-ID: <1490166162-10002-1-git-send-email-Suravee.Suthikulpanit@amd.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

This patch series modifies the existing IOMMU and Perf drivers to support
systems with multiple IOMMUs by allocating an amd_iommu PMU per IOMMU instance.
This allows users to specify performance events and filters separately for each
IOMMU.

This has been tested on the new family17h-based server w/ multiple IOMMUs.

Git branch containing this patch series is available here:

    https://github.com/ssuthiku/linux.git  perf-iommu-v12

Changes from V11 (https://lkml.org/lkml/2017/2/24/114)
  * Cleaning up in patch 9 and 10 per Boris' suggestions.

Changes from V10 (https://lkml.org/lkml/2017/2/15/1202)
  * Introduce amd_iommu specific struct in struct hw_perf_event
    (patch 9/10).
  * Minor clean up on pr_info (patch 1/10 per Joe Perches).

Changes from V9 (https://lkml.org/lkml/2017/2/7/105)
  * Since each IOMMU PMU in a system functions independently from 
    one another, the amd_iommu_pc_init() function has been modified
    to allow certain IOMMU PMU initialization to fail w/o disabling
    the others (patch 9/9).
  * Define a static pmu (iommu_pmu), and stuct assignment directly.
    (per Boris)
  * Refactor code clean up into a separate patch (4/9) (per Boris)

Thanks,
Suravee

Suravee Suthikulpanit (10):
  perf/amd/iommu: Declare pr_fmt and remove unnecessary pr_debug
  perf/amd/iommu: Clean up bitwise operations
  perf/amd/iommu: Clean up perf_iommu_read()
  iommu/amd: Clean up iommu_pc_get_set_reg()
  iommu/amd: Introduce amd_iommu_get_num_iommus()
  perf/amd/iommu: Modify functions to query max banks and counters
  perf/amd/iommu: Modify amd_iommu_pc_get_set_reg_val() to allow
    specifying IOMMU
  perf/amd/iommu: Fix sysfs perf attribute groups
  perf/amd/iommu: Introduce amd_iommu-specific struct in struct
    hw_perf_event
  perf/amd/iommu: Enable support for multiple IOMMUs

 arch/x86/events/amd/iommu.c     | 321 +++++++++++++++++++---------------------
 arch/x86/events/amd/iommu.h     |  18 ++-
 drivers/iommu/amd_iommu.c       |   6 +-
 drivers/iommu/amd_iommu_init.c  | 101 ++++++++-----
 drivers/iommu/amd_iommu_proto.h |   8 +-
 drivers/iommu/amd_iommu_types.h |   3 -
 include/linux/perf_event.h      |   7 +
 7 files changed, 237 insertions(+), 227 deletions(-)

-- 
1.8.3.1
