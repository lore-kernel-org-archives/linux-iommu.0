From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V6 0/7] perf/amd/iommu: Enable multi-IOMMU support
Date: Fri, 23 Dec 2016 20:38:43 +0700
Message-ID: <1482500330-5606-1-git-send-email-Suravee.Suthikulpanit@amd.com>
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
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, Suravee Suthikulpanit <ssuthiku-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <ssuthiku-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This patch series modifies the existing IOMMU and Perf drivers to support
systems with multiple IOMMUs by allocating an amd_iommu PMU per IOMMU instance.
This allows users to specify performance events and filters separately for each
IOMMU.

This has been tested on the new family17h-based server w/ multiple IOMMUs.

Git branch containing this patch series is available here:

    https://github.com/ssuthiku/linux.git  perf-iommu-v6

Changes from V5 (https://lkml.org/lkml/2016/2/23/370)
  * Rebased onto v4.9.
  * Remove the patch which consolidates function delclarations since
    we have not yet agreed on the appropriate place for the new header file.

Suravee Suthikulpanit (7):
  perf/amd/iommu: Misc fix up perf_iommu_read
  perf/amd/iommu: Modify functions to query max banks and counters
  perf/amd/iommu: Modify IOMMU API to allow specifying IOMMU index
  perf/amd/iommu: Declare pr_fmt and remove unnecessary pr_debug
  perf/amd/iommu: Clean up perf_iommu_enable_event
  iommu/amd: Introduce amd_iommu_get_num_iommus()
  perf/amd/iommu: Enable support for multiple IOMMUs

 arch/x86/events/amd/iommu.c     | 206 ++++++++++++++++++++--------------------
 arch/x86/events/amd/iommu.h     |  17 ++--
 drivers/iommu/amd_iommu_init.c  | 119 ++++++++++++++++-------
 drivers/iommu/amd_iommu_proto.h |  15 ++-
 4 files changed, 209 insertions(+), 148 deletions(-)

-- 
1.8.3.1
