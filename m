From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v9 0/8] perf/amd/iommu: Enable multi-IOMMU support
Date: Tue, 7 Feb 2017 02:40:28 -0600
Message-ID: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
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

    https://github.com/ssuthiku/linux.git  perf-iommu-v9

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

Changes from V6 (https://lkml.org/lkml/2016/12/23/134)
  * Renamed function parameters from devid to idx (per Joerg).
  * Removed unnecessary function declarations from amd_iommu_proto.h
    (per Joerg).

Changes from V5 (https://lkml.org/lkml/2016/2/23/370)
  * Rebased onto v4.9.
  * Remove the patch which consolidates function delclarations since
    we have not yet agreed on the appropriate place for the new header file.

Thanks,
Suravee

Suravee Suthikulpanit (8):
  perf/amd/iommu: Declare pr_fmt and remove unnecessary pr_debug
  perf/amd/iommu: Clean up bitwise operations
  perf/amd/iommu: Clean up perf_iommu_read()
  iommu/amd: Introduce amd_iommu_get_num_iommus()
  perf/amd/iommu: Modify functions to query max banks and counters
  perf/amd/iommu: Modify amd_iommu_pc_get_set_reg_val() to allow
    specifying IOMMU
  perf/amd/iommu: Fix sysfs perf attribute groups
  perf/amd/iommu: Enable support for multiple IOMMUs

 arch/x86/events/amd/iommu.c     | 258 +++++++++++++++++++---------------------
 arch/x86/events/amd/iommu.h     |  18 ++-
 drivers/iommu/amd_iommu.c       |   6 +-
 drivers/iommu/amd_iommu_init.c  | 104 +++++++++-------
 drivers/iommu/amd_iommu_proto.h |   8 +-
 drivers/iommu/amd_iommu_types.h |   3 -
 6 files changed, 203 insertions(+), 194 deletions(-)

-- 
1.8.3.1
