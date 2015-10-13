From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.3-rc5
Date: Tue, 13 Oct 2015 12:09:53 +0200
Message-ID: <20151013100952.GA5834@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.3-rc5

for you to fetch changes up to 5adad9915472e180712030d730cdc476c6f8a60b:

  iommu/amd: Fix NULL pointer deref on device detach (2015-10-09 17:59:33 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.3-rc5

A few fixes piled up:

	* Fix for a suspend/resume issue where PCI probing code overwrote
	  dev->irq for the MSI irq of the AMD IOMMU.

	* Fix for a kernel crash when a 32 bit PCI device was assigned to a KVM
	  guest.

	* Fix for a possible memory leak in the VT-d driver

	* A couple of fixes for the ARM-SMMU driver

----------------------------------------------------------------
Jiang Liu (1):
      iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices

Joerg Roedel (2):
      Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/.../will/linux into iommu/fixes
      iommu/amd: Fix NULL pointer deref on device detach

Robin Murphy (1):
      iommu/io-pgtable-arm: Don't use dma_to_phys()

Sudip Mukherjee (1):
      iommu/vt-d: Fix memory leak in dmar_insert_one_dev_info()

Will Deacon (2):
      iommu/arm-smmu: Ensure IAS is set correctly for AArch32-capable SMMUs
      iommu/arm-smmu: Use correct address mask for CMD_TLBI_S2_IPA

 drivers/iommu/Kconfig          |  3 +--
 drivers/iommu/amd_iommu.c      |  9 +++++++++
 drivers/iommu/amd_iommu_init.c |  3 +++
 drivers/iommu/arm-smmu-v3.c    | 21 +++++++++++++++------
 drivers/iommu/intel-iommu.c    |  1 +
 drivers/iommu/io-pgtable-arm.c | 24 +++++++++++++-----------
 6 files changed, 42 insertions(+), 19 deletions(-)

Please pull.

Thanks,

	Joerg
