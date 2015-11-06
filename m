From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v2 0/9] Fix AMD IOMMU faults in kdump kernel
Date: Fri,  6 Nov 2015 20:10:42 +0800
Message-ID: <1446811851-20623-1-git-send-email-bhe@redhat.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is v2 draft patch set. It mainly functions as the following steps:

1. Checking if it's in kdump kernel and previously enabled
2. If yes do below operatons:
    a. Do not disable amd iommu and do not touch dev tables before coping old dev tables
    b. Copy dev table from old kernel and set the old domain id in amd_iommu_pd_alloc_bitmap
    c. Copy irq tables from old kernel
    d. Copy command buffer and event buffer
    e. Don't call update_domain() to set domain->pt_root to dev entries before device driver initialization.
    f. Reset the pre-enabled status in case IOMMU_DMA_OPS of state_next(). 

Existed problems:

1. It always prints the following message whenever do a flush:

	"AMD-Vi: Completion-Wait loop timed out"

2. Maybe there's someing wrong with the old irq remapping handling, the hard disk can't be brought up
successfully. You can check the attached kdump kernel boot log with this patchset applied.

Baoquan He (9):
  iommu/amd: Use standard bitmap operation to set bitmap
  iommu/amd: Detect pre enabled translation
  iommu/amd: make several functions global
  iommu/amd: add copy_irq_table function
  iommu/amd: Add function copy_dev_tables
  iommu/amd: Add functions copy_command_buffer/copy_event_buffer
  iommu/amd: copy old tables and do not update dev tables before driver
    init
  iommu/amd: Do not update the information of domain to devtables before
    device driver init
  iommu/amd: Clear the iommu pre enabled setting

 drivers/iommu/amd_iommu.c       |  27 +++---
 drivers/iommu/amd_iommu_init.c  | 208 +++++++++++++++++++++++++++++++++-------
 drivers/iommu/amd_iommu_proto.h |   6 ++
 drivers/iommu/amd_iommu_types.h |   4 +
 4 files changed, 198 insertions(+), 47 deletions(-)

-- 
2.4.0
