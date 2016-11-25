From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 00/12] Fix kdump faults on system with amd iommu
Date: Fri, 25 Nov 2016 13:13:07 +0800
Message-ID: <1480050799-1237-1-git-send-email-bhe@redhat.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is v7 post.

The principle of the fix is similar to intel iommu. Just defer the assignment
of device to domain to device driver init. In this version of post, a new
call-back is_attach_deferred is added to iommu-ops, it's used to check whether
we need defer the domain attach/detach in iommu-core code.

v5:
    bnx2 NIC can't reset itself during driver init. Post patch to reset
    it during driver init. IO_PAGE_FAULT can't be seen anymore.

    Below is link of v5 post.
    https://lists.linuxfoundation.org/pipermail/iommu/2016-September/018527.html

v5->v6:
    According to Joerg's comments made several below main changes:
    - Add sanity check when copy old dev tables.

    - If a device is set up with guest translations (DTE.GV=1), then don't
      copy that information but move the device over to an empty guest-cr3
      table and handle the faults in the PPR log (which just answer them
      with INVALID).

v6->v7:
    Two main changes are made according to Joerg's suggestion:
    - Add is_attach_deferred call-back to iommu-ops. With this domain
      can be deferred to device driver init cleanly.

    - Allocate memory below 4G for dev table if translation pre-enabled.
      AMD engineer pointed out that it's unsafe to update the device-table
      while iommu is enabled. device-table pointer update is split up into
      two 32bit writes in the IOMMU hardware. So updating it while the IOMMU
      is enabled could have some nasty side effects.

Baoquan He (12):
  iommu/amd: Detect pre enabled translation
  iommu/amd: add several helper function
  iommu/amd: Define bit fields for DTE particularly
  iommu/amd: Add function copy_dev_tables
  iommu/amd: copy old trans table from old kernel
  iommu: Add is_attach_deferred call-back to iommu-ops
  iommu/amd: Use is_attach_deferred call-back
  iommu/amd: Add sanity check of irq remap information of old dev table
    entry
  iommu/amd: Don't copy GCR3 table root pointer
  iommu/amd: Clear out the GV flag when handle deferred domain attach
  iommu: Assign the direct mapped domain to group->domain
  iommu/amd: Allocate memory below 4G for dev table if translation
    pre-enabled

 drivers/iommu/amd_iommu.c       |  78 +++++++++-------
 drivers/iommu/amd_iommu_init.c  | 201 +++++++++++++++++++++++++++++++++++++---
 drivers/iommu/amd_iommu_proto.h |   2 +
 drivers/iommu/amd_iommu_types.h |  53 ++++++++++-
 drivers/iommu/amd_iommu_v2.c    |  18 +++-
 drivers/iommu/iommu.c           |   9 ++
 include/linux/iommu.h           |   1 +
 7 files changed, 313 insertions(+), 49 deletions(-)

-- 
2.5.5
