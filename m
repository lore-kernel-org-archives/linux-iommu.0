From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.12
Date: Fri, 7 Apr 2017 17:02:12 +0100
Message-ID: <20170407160212.GR19342@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull these arm-smmu updates for 4.12. Highlights include:

  * TLB sync optimisations for SMMUv2
  * Support for using an IDENTITY domain in conjunction with DMA ops
  * Support for SMR masking
  * Support for 16-bit ASIDs (was previously broken)

Thanks,

Will

--->8

The following changes since commit c02ed2e75ef4c74e41e421acb4ef1494671585e8:

  Linux 4.11-rc4 (2017-03-26 14:15:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 022f4e4f31fea69702f3ec810dc567af6a6d86d8:

  iommu/io-pgtable-arm: Avoid shift overflow in block size (2017-04-06 16:06:44 +0100)

----------------------------------------------------------------
Robert Richter (1):
      iommu/arm-smmu: Print message when Cavium erratum 27704 was detected

Robin Murphy (7):
      iommu: Better document the IOMMU_PRIV flag
      iommu/arm-smmu: Simplify ASID/VMID handling
      iommu/arm-smmu: Tidy up context bank indexing
      iommu/arm-smmu: Use per-context TLB sync as appropriate
      iommu/arm-smmu: Poll for TLB sync completion more effectively
      iommu/arm-smmu: Add global SMR masking property
      iommu/io-pgtable-arm: Avoid shift overflow in block size

Sunil Goutham (1):
      iommu/arm-smmu: Fix 16-bit ASID configuration

Will Deacon (5):
      iommu/arm-smmu: Restrict domain attributes to UNMANAGED domains
      iommu/arm-smmu: Install bypass S2CRs for IOMMU_DOMAIN_IDENTITY domains
      iommu/arm-smmu-v3: Make arm_smmu_install_ste_for_dev return void
      iommu/arm-smmu-v3: Install bypass STEs for IOMMU_DOMAIN_IDENTITY domains
      iommu: Allow default domain type to be set on the kernel command line

 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 .../devicetree/bindings/iommu/arm,smmu.txt         |  28 +++
 drivers/iommu/arm-smmu-v3.c                        |  76 +++---
 drivers/iommu/arm-smmu.c                           | 259 +++++++++++++--------
 drivers/iommu/io-pgtable-arm.c                     |   2 +-
 drivers/iommu/iommu.c                              |  28 ++-
 include/linux/iommu.h                              |  11 +-
 7 files changed, 281 insertions(+), 129 deletions(-)
