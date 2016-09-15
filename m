From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 0/8] Fix kdump faults on system with amd iommu
Date: Thu, 15 Sep 2016 23:03:18 +0800
Message-ID: <1473951806-25511-1-git-send-email-bhe@redhat.com>
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

This is v5 post. In fact in v3 the solution is correct. Just unluckily 
I got a AMD machine with bnx2 NIC which can't reset itself during driver
init. It made me very unconfident with my understanding about the fix.
Now with below fix the AMD machine with bnx2 NIC can also work well
to dump and there's no IO_PAGE_FAULT seen any more. Now network maintainer
has picked it up.

bnx2: Reset device during driver initialization
https://www.mail-archive.com/netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg127336.html

The principle of the fix is similar to intel iommu. Just defer the assignment
of device to domain to device driver init. But there's difference than
intel iommu. AMD iommu create protection domain and assign device to
domain in iommu driver init stage. So in this patchset I just allow the
assignment of device to domain in software level, but defer updating the
domain info, especially the pte_root to dev table entry to device driver
init stage.


Baoquan He (8):
  iommu/amd: Detect pre enabled translation
  iommu/amd: add early_enable_iommu() wrapper function
  iommu/amd: Define bit fields for DTE particularly
  iommu/amd: Add function copy_dev_tables
  iommu/amd: copy old trans table from old kernel
  iommu/amd: Do not re-enable dev table entries in kdump
  iommu/amd: Don't update domain info to dte entry at iommu init stage
  iommu/amd: Update domain into to dte entry during device driver init

 drivers/iommu/amd_iommu.c       |  49 +++++++++++++--
 drivers/iommu/amd_iommu_init.c  | 135 ++++++++++++++++++++++++++++++++++++----
 drivers/iommu/amd_iommu_proto.h |   1 +
 drivers/iommu/amd_iommu_types.h |  23 +++++--
 4 files changed, 187 insertions(+), 21 deletions(-)

-- 
2.5.5
