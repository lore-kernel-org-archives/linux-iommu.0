From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V5 00/10] perf/amd/iommu: Enable multi-IOMMU support
Date: Tue, 23 Feb 2016 08:12:34 -0600
Message-ID: <1456236764-1569-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, bp@alien8.de, peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc: andihartmann@freenet.de, vw@iommu.org, labbott@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

This is a two-part patch series:

Part1: 1-4 :
Introduce a workaround for the current AMD IOMMU perf initialization issue
in some existing KV and CZ platforms, where it fails to write to IOMMU
perf counter as reported by Andreas Hartmann here
(http://comments.gmane.org/gmane.linux.kernel.pci/49147).

Part2: 5-10: Enable multi-IOMMU support 
Cleans up the AMD IOMMU perf, and modifies the existing driver
to support systems with multiple IOMMUs by exposing IOMMU an amd_iommu
PMU instance per IOMMU. This allows users to specify performance events
separately for each IOMMU.

Git branch containing this patch series is available here:

    https://github.com/ssuthiku/linux.git  perf-iommu-v5

Changes from V4 (https://lkml.org/lkml/2016/2/11/79)
  * Re-order the patch series to split patches into two parts,
    and I have tried to clean up as much as I could before adding
    new stuff.
  * Based on Boris's feedback:
    * Clean up several coding style and spelling errors.
  * Based on Peter's feedback:
    * Implement per-IOMMU PMU

Changes from V3 (https://lkml.org/lkml/2016/2/9/845)
  * Rebase the code to tip/master per Boris suggestion
  * Most changes are in patch 5/6:
    * Fix several spelling and styling issues per Boris review comment
    * Remove unnecessary pr_debug in the perf amd iommu driver (per Boris)
    * Rename several function to make it less confusing (per Boris)
    * Properly handle errors when fails to set registers/counters
      on multiple IOMMUs. (per Boris)

Changes from V2 ( https://lkml.org/lkml/2016/1/1/141)
  * Ported to 4.5.0-rc2
  * Add reviewed by Joerg for patch 1 and 2
  * Remove EXPORT_SYMBOL from patch 3 (per Joerg suggestion)
  * Merge patch 4/6 and 6/6 from V2 into 5/5 in V3 and add
    more description in the commit message and in code comment.
  * Patch 5: modify the logic to update counts to get rid off
    un-necessary local64_cmpxchg().

Changes from V1 (https://lkml.org/lkml/2015/12/22/535):
  * Update patch3 and 6 to use amd_iommus_present instead of introducing
    amd_iommu_cnt static v
Suravee Suthikulpanit (10):
  perf/amd/iommu: Misc fix up perf_iommu_read
  perf/amd/iommu: Consolidate and move perf_event_amd_iommu header
  perf/amd/iommu: Modify functions to query max banks and counters
  perf/amd/iommu: Modify IOMMU API to allow specifying IOMMU index
  perf/amd/iommu: Declare pr_fmt and remove unnecessary pr_debug
  perf/amd/iommu: Clean up perf_iommu_enable_event
  perf/amd/iommu: Clean up get_next_available_iommu_bnk_cntr
  perf/amd/iommu: Rename struct perf_amd_iommu to perf_iommu
  iommu/amd: Introduce amd_iommu_get_num_iommus()
  perf/amd/iommu: Enable support for multiple IOMMUs

 arch/x86/events/amd/iommu.c           | 274 +++++++++++++++++-----------------
 arch/x86/events/amd/iommu.h           |  40 -----
 arch/x86/include/asm/perf/amd/iommu.h |  43 ++++++
 drivers/iommu/amd_iommu_init.c        | 111 +++++++++++---
 drivers/iommu/amd_iommu_proto.h       |   7 -
 5 files changed, 263 insertions(+), 212 deletions(-)
 delete mode 100644 arch/x86/events/amd/iommu.h
 create mode 100644 arch/x86/include/asm/perf/amd/iommu.h

-- 
1.9.1
