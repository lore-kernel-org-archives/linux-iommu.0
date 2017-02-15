From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v10 0/9] perf/amd/iommu: Enable multi-IOMMU support
Date: Wed, 15 Feb 2017 14:56:16 -0600
Message-ID: <1487192185-31272-1-git-send-email-Suravee.Suthikulpanit@amd.com>
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

    https://github.com/ssuthiku/linux.git  perf-iommu-v10

Changes from V9 (https://lkml.org/lkml/2017/2/7/105)
  * Since each IOMMU PMU in a system functions independently from 
    one another, the amd_iommu_pc_init() function has been modified
    to allow certain IOMMU PMU initialization to fail w/o disabling
    the others (patch 9/9).
  * Define a static pmu (iommu_pmu), and stuct assignment directly.
    (per Boris)
  * Refactor code clean up into a separate patch (4/9) (per Boris)

Changes from V8 (https://lkml.org/lkml/2017/1/16/48)
  * Rebase to v4.10
  * Do not use hwc->idx as pmu index. Instead, include pointers
    to struct amd_iommu in the perf_amd_iommu.
  * Do not remove local64_cmpxchg() in perf_iommu_read().
  * Fix incorrect bitfield when using GENMASK_ULL().

Changes from V7 (https://lkml.org/lkml/2017/1/9/917)
  * Re-order patches to clean up first before introducing new stuff.
  * Always use amd_iommu_get_num_iommus() to access amd_iommus_present
    variable now.
  * Fix Perf IOMMU sysfs attributes initialization.
  * Miscellaneous clean up 

Thanks,
Suravee

Suravee Suthikulpanit (9):
  perf/amd/iommu: Declare pr_fmt and remove unnecessary pr_debug
  perf/amd/iommu: Clean up bitwise operations
  perf/amd/iommu: Clean up perf_iommu_read()
  iommu/amd: Clean up iommu_pc_get_set_reg()
  iommu/amd: Introduce amd_iommu_get_num_iommus()
  perf/amd/iommu: Modify functions to query max banks and counters
  perf/amd/iommu: Modify amd_iommu_pc_get_set_reg_val() to      allow
    specifying IOMMU
  perf/amd/iommu: Fix sysfs perf attribute groups
  perf/amd/iommu: Enable support for multiple IOMMUs

 arch/x86/events/amd/iommu.c     | 259 +++++++++++++++++++---------------------
 arch/x86/events/amd/iommu.h     |  18 ++-
 drivers/iommu/amd_iommu.c       |   6 +-
 drivers/iommu/amd_iommu_init.c  | 101 +++++++++-------
 drivers/iommu/amd_iommu_proto.h |   8 +-
 drivers/iommu/amd_iommu_types.h |   3 -
 6 files changed, 198 insertions(+), 197 deletions(-)

-- 
1.8.3.1
