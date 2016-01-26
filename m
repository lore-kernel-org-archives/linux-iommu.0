From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v3 00/12] Fix AMD IOMMU faults in kdump kernel
Date: Tue, 26 Jan 2016 18:29:14 +0800
Message-ID: <1453804166-25646-1-git-send-email-bhe@redhat.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is v3 post. Now the situation is patchset test on amd-vi v2 machine
is OK, however still some IO_PAGE_FAULT warning is printed out on v1
machine. The log will be attached later.

I didn't figure out what caused the warning, so post them to ask for help.

The strategy is unchanged:
1) Copy old dev tables and old irq tables to kdump kernel
2) Insatll this newly copied DTE to iommu
3) Hold the updating of domain info to iommu dev, mainly the io page table
4) Update domain info to iommu dev as soon as dev is initialized


Baoquan He (12):
  iommu/amd: Use standard bitmap operation to set bitmap
  iommu/amd: Detect pre enabled translation
  iommu/amd: move dte irq macro defitions to amd_iommu_types.h
  iommu/amd: add copy_irq_table function
  iommu/amd: change IOMMU_PTE_P to IOMMU_PTE_V
  iommu/amd: Clean up the useless IOMMU_PTE_U/IOMMU_PTE_FC
  iommu/amd: Add function copy_dev_tables
  iommu/amd: set the device table and re-enable event/cmd buffer
  iommu/amd: Don't update the domain information to iommu dev before dev
    init
  iommu/amd: Update related domain info to dev when dev driver init
  iommu/amd: No need to wait iommu completion if no dte irq entry change
  iommu/amd: fix a code bug in do_attach

 drivers/iommu/amd_iommu.c       |  51 ++++++++------
 drivers/iommu/amd_iommu_init.c  | 147 ++++++++++++++++++++++++++++++++++++----
 drivers/iommu/amd_iommu_proto.h |   5 ++
 drivers/iommu/amd_iommu_types.h |  14 ++--
 4 files changed, 180 insertions(+), 37 deletions(-)

-- 
2.1.0
