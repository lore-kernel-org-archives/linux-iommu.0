From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 00/13] Fix the on-flight DMA issue on system with amd iommu
Date: Fri, 21 Jul 2017 16:58:58 +0800
Message-ID: <1500627551-12930-1-git-send-email-bhe@redhat.com>
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
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When kernel panicked and jump into the kdump kernel, DMA started by the
1st kernel is not stopped, this is called on-flight DMA. In the current
code it will disable iommu and build new translation table and attach
device to it. This will cause:

 1. IO_PAGE_FAULT warning message can be seen.
 2. transfer data to or from incorrect areas of memory.

Sometime it causes the dump failure or kernel hang.

The principle of the fix is to defer the assignment of device to domain to
device driver initializtion stage. A new call-back is_attach_deferred() is
added to iommu-ops, will check whether we need defer the domain attach/detach
in iommu-core code. If defer is needed, just return directly from amd iommu
attach/detach function. The attachment will be done in device driver
initializaiton stage when calling get_domain().

Change history:
v8:v7:
    Rebase patchset v7 on the latest v4.13-rc1.

    - And re-enable printing IO_PAGE_FAULT message in kdump kernel.
    - Only disable iommu if amd_iommu=off is specified in kdump kernel.


v6->v7:
    Two main changes are made according to Joerg's suggestion:
    - Add is_attach_deferred call-back to iommu-ops. With this domain
      can be deferred to device driver init cleanly.

    - Allocate memory below 4G for dev table if translation pre-enabled.
      AMD engineer pointed out that it's unsafe to update the device-table
      while iommu is enabled. device-table pointer update is split up into
      two 32bit writes in the IOMMU hardware. So updating it while the IOMMU
      is enabled could have some nasty side effects.

v5->v6:
    According to Joerg's comments made several below main changes:
    - Add sanity check when copy old dev tables.

    - If a device is set up with guest translations (DTE.GV=1), then don't
      copy that information but move the device over to an empty guest-cr3
      table and handle the faults in the PPR log (which just answer them
      with INVALID).

v5:
    bnx2 NIC can't reset itself during driver init. Post patch to reset
    it during driver init. IO_PAGE_FAULT can't be seen anymore.

    Below is link of v5 post.
    https://lists.linuxfoundation.org/pipermail/iommu/2016-September/018527.html


Baoquan He (12):
  iommu/amd: Detect pre enabled translation
  iommu/amd: add several helper functions
  Revert "iommu/amd: Suppress IO_PAGE_FAULTs in kdump kernel"
  iommu/amd: Define bit fields for DTE particularly
  iommu/amd: Add function copy_dev_tables()
  iommu/amd: copy old trans table from old kernel
  iommu/amd: Do sanity check for irq remap of old dev table entry
  iommu: Add is_attach_deferred call-back to iommu-ops
  iommu/amd: Use is_attach_deferred call-back
  iommu/amd: Allocate memory below 4G for dev table if translation
    pre-enabled
  iommu/amd: Don't copy GCR3 table root pointer
  iommu/amd: Clear out the GV flag when handle deferred domain attach

root (1):
  iommu/amd: Disable iommu only if amd_iommu=off is specified

 drivers/iommu/amd_iommu.c       |  81 ++++++++-------
 drivers/iommu/amd_iommu_init.c  | 212 ++++++++++++++++++++++++++++++++++++----
 drivers/iommu/amd_iommu_proto.h |   2 +
 drivers/iommu/amd_iommu_types.h |  56 ++++++++++-
 drivers/iommu/amd_iommu_v2.c    |  18 +++-
 drivers/iommu/iommu.c           |   8 ++
 include/linux/iommu.h           |   1 +
 7 files changed, 315 insertions(+), 63 deletions(-)

-- 
2.5.5
