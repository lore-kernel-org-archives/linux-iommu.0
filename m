From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/7] iommu/amd: Disable previously enabled IOMMUs at boot
Date: Fri, 16 Jun 2017 16:09:53 +0200
Message-ID: <1497622200-18188-1-git-send-email-joro@8bytes.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set refactoring the AMD IOMMU init code a
bit to make sure the IOMMUs get disabled at boot, even when
amd_iommu=off is specified on the kernel command line.

The patch-set is tested with various combinations of kernel
command-line parameters and with kexec. It applies to the
x86/amd branch of the iommu-tree.

Regards,

	Joerg

Joerg Roedel (7):
  iommu/amd: Disable IOMMUs at boot if they are enabled
  iommu/amd: Rename free_on_init_error()
  iommu/amd: Add new init-state IOMMU_CMDLINE_DISABLED
  iommu/amd: Check for error states first in iommu_go_to_state()
  iommu/amd: Set global pointers to NULL after freeing them
  iommu/amd: Free IOMMU resources when disabled on command line
  iommu/amd: Remove amd_iommu_disabled check from amd_iommu_detect()

 drivers/iommu/amd_iommu_init.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

-- 
2.7.4
