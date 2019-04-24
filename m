From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.2
Date: Wed, 24 Apr 2019 12:52:52 +0100
Message-ID: <20190424115252.GB14829@fuggles.cambridge.arm.com>
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
Cc: marc.w.gonzalez-GANU6spQydw@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please can you pull these ARM SMMU updates for 5.2? The highlight is ATS
support in the SMMUv3 driver from Jean-Philippe. I have collected the
appropriate Acks from the PCI and IORT sides.

There is a trivial conflict with your api-features branch due to the diff
context in linux/iommu.h.

Cheers,

Will

--->8

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to bc580b56cb7888d1f09fff8a50270228fb834ae8:

  iommu/arm-smmu: Log CBFRSYNRA register on context fault (2019-04-23 12:23:16 +0100)

----------------------------------------------------------------
Douglas Anderson (1):
      iommu/arm-smmu: Break insecure users by disabling bypass by default

Jean-Philippe Brucker (9):
      PCI: Move ATS declarations outside of CONFIG_PCI
      PCI: Add a stub for pci_ats_disabled()
      ACPI/IORT: Check ATS capability in root complex nodes
      iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
      iommu/arm-smmu-v3: Store SteamIDs in master
      iommu/arm-smmu-v3: Add a master->domain pointer
      iommu/arm-smmu-v3: Link domains and devices
      iommu/arm-smmu-v3: Add support for PCI ATS
      iommu/arm-smmu-v3: Disable tagged pointers

Vivek Gautam (1):
      iommu/arm-smmu: Log CBFRSYNRA register on context fault

Will Deacon (1):
      iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel

 drivers/acpi/arm64/iort.c     |  11 ++
 drivers/iommu/Kconfig         |  25 +++
 drivers/iommu/arm-smmu-regs.h |   2 +
 drivers/iommu/arm-smmu-v3.c   | 355 +++++++++++++++++++++++++++++++++---------
 drivers/iommu/arm-smmu.c      |  11 +-
 include/linux/iommu.h         |   4 +
 include/linux/pci.h           |  31 ++--
 7 files changed, 344 insertions(+), 95 deletions(-)
