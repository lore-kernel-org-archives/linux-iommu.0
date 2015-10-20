From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/12] AMD IOMMU alias handling cleanups and code removal
Date: Tue, 20 Oct 2015 17:33:33 +0200
Message-ID: <1445355225-17557-1-git-send-email-joro@8bytes.org>
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

This patch-set cleans up the alias handling code in the AMD
IOMMU driver. Most of the alias handling is done already in
the IOMMU group code. Only the handling of request-ids that
are not backed by a 'struct pci_dev' still needs to happen
in the AMD IOMMU driver, as the IOMMU group code has no way
of handling that.

A few other cleanups which accumulated during implemented
this are also included in this patch-set.


Regards,

	Joerg


Joerg Roedel (12):
  iommu/amd: Do not BUG_ON in __detach_device()
  iommu/amd: Do not iterate over alias-list in __[attach|detach]_device
  iommu/amd: Don't disable IRQs in __detach_device
  iommu/amd: WARN when __[attach|detach]_device are called with irqs
    enabled
  iommu/amd: Set alias DTE in do_attach/do_detach
  iommu/amd: Remove old alias handling code
  iommu/amd: Align DTE flag definitions
  iommu/amd: Remove cmd_buf_size and evt_buf_size from struct amd_iommu
  iommu/amd: Cleanup buffer allocation
  iommu/amd: Initialize amd_iommu_last_bdf for DEV_ALL
  iommu/amd: Remove first/last_device handling
  iommu/amd: Remove find_last_devid_on_pci()

 drivers/iommu/amd_iommu.c       | 172 +++++++++-------------------------------
 drivers/iommu/amd_iommu_init.c  | 111 ++++++--------------------
 drivers/iommu/amd_iommu_types.h |  13 +--
 3 files changed, 64 insertions(+), 232 deletions(-)

-- 
1.9.1
