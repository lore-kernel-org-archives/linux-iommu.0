From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/2 v2] perf/x86/amd: IOMMU Performance Counter Support
Date: Mon, 13 May 2013 16:42:42 -0500
Message-ID: <1368481362-5562-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: steven.kinney-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is the rework of the original patch set here:

http://lists.linuxfoundation.org/pipermail/iommu/2013-January/005075.html

These patches implement the AMD IOMMU Performance Counter functionality
via custom perf PMU and implement static counting for various IOMMU
translations.

    1) Extend the AMD IOMMU initialization to include performance
       counter enablement.

    2) The perf AMD IOMMU PMU to manage performance counters, which
       interface with the AMD IOMMU core driver.

The command-line, to invoke the iommuv2 PMU, is:

    perf stat -e amd_iommu/config=[data],config1=[data]/{u,r} [command]

The IOMMU performance counter support is available starting in the 
AMD family15h model 0x30.

For information regarding IOMMU performance counter configuration,
please see the AMD IOMMU v2.5 specification.

Steven L Kinney (2):
  IOMMU/AMD: Adding IOMMUv2 PC resource management
  IOMMU/AMD: IOMMUV2 PC PERF uncore PMU implementation

 arch/x86/kernel/cpu/Makefile                 |    2 +-
 arch/x86/kernel/cpu/perf_event_amd_iommuv2.c |  409 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/perf_event_amd_iommuv2.h |   55 ++++
 drivers/iommu/amd_iommu_init.c               |  116 +++++++-
 drivers/iommu/amd_iommu_proto.h              |    7 +
 drivers/iommu/amd_iommu_types.h              |   12 +-
 6 files changed, 594 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommuv2.c
 create mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommuv2.h

-- 
1.7.10.4
