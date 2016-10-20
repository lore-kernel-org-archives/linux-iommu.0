From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 0/9] Fix kdump faults on system with amd iommu
Date: Thu, 20 Oct 2016 19:37:11 +0800
Message-ID: <1476963440-23039-1-git-send-email-bhe@redhat.com>
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
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is v6 post. 

The principle of the fix is similar to intel iommu. Just defer the assignment
of device to domain to device driver init. But there's difference than
intel iommu. AMD iommu create protection domain and assign device to
domain in iommu driver init stage. So in this patchset I just allow the
assignment of device to domain in software level, but defer updating the
domain info, especially the pte_root to dev table entry to device driver
init stage.

v5: 
    bnx2 NIC can't reset itself during driver init. Post patch to reset
    it during driver init. IO_PAGE_FAULT can't be seen anymore.
    
    Below is link of v5 post.
    https://lists.linuxfoundation.org/pipermail/iommu/2016-September/018527.html

v5->v6:
    According to Joerg's comments made several below main changes:
    - Add sanity check when copy old dev tables. 

    - Discard the old patch 6/8.

    - If a device is set up with guest translations (DTE.GV=1), then don't
      copy that information but move the device over to an empty guest-cr3
      table and handle the faults in the PPR log (which just answer them
      with INVALID).

Issues need be discussed:
    - Joerg suggested hooking the behaviour that updates domain info into
      dte entry into the set_dma_mask call-back. I tried, but on my local
      machine with amd iommu v2, an ohci pci device doesn't call set_dma_mask.
      Then IO_PAGE_FAULT printing flooded.

      00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI Controller (rev 11)

    - About GCR3 root pointer copying issue, I don't know how to setup the
      test environment and haven't tested yet. Hope Joerg or Zongshun can
      tell what steps should be taken to test it, or help take a test in your
      test environemnt.
 
Baoquan He (9):
  iommu/amd: Detect pre enabled translation
  iommu/amd: add several helper function
  iommu/amd: Define bit fields for DTE particularly
  iommu/amd: Add function copy_dev_tables
  iommu/amd: copy old trans table from old kernel
  iommu/amd: Don't update domain info to dte entry at iommu init stage
  iommu/amd: Update domain into to dte entry during device driver init
  iommu/amd: Add sanity check of irq remap information of old dev table
    entry
  iommu/amd: Don't copy GCR3 table root pointer

 drivers/iommu/amd_iommu.c       |  93 +++++++++++++-------
 drivers/iommu/amd_iommu_init.c  | 189 +++++++++++++++++++++++++++++++++++++---
 drivers/iommu/amd_iommu_proto.h |   2 +
 drivers/iommu/amd_iommu_types.h |  53 ++++++++++-
 drivers/iommu/amd_iommu_v2.c    |  18 +++-
 5 files changed, 307 insertions(+), 48 deletions(-)

-- 
2.5.5
