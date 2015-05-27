From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/3] iommu/arm=smmu: Add driver for ARM SMMUv3 devices
Date: Wed, 27 May 2015 17:25:57 +0100
Message-ID: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
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
Cc: Mark.Rutland-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

This is version two of the patches I originally posted here:

  http://www.spinics.net/lists/arm-kernel/msg416881.html

Changes since version one include:

  - Lazy allocation of the level-2 stream table on device-add
  - Limit stream table size based on SIDSIZE (maximum 21-bit atm)
  - Fixed detection of linear stream table
  - Fixed typo in RECINVSID CR2 field
  - Added cmdline option for changing default bypass behaviour to fault
  - Check IDR0.HYP before EL2 TLBI
  - Reworked stream table so that each level-2 entry resolves 256 SIDs
    (i.e. a PCI bus)

All feedback welcome,

Will

--->8

Will Deacon (3):
  Documentation: dt-bindings: Add device-tree binding for ARM SMMUv3
    IOMMU
  iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices
  drivers/vfio: Allow type-1 IOMMU instantiation on top of an ARM SMMUv3

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   37 +
 MAINTAINERS                                        |    3 +-
 drivers/iommu/Kconfig                              |   13 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/arm-smmu-v3.c                        | 2670 ++++++++++++++++++++
 drivers/vfio/Kconfig                               |    2 +-
 6 files changed, 2724 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
 create mode 100644 drivers/iommu/arm-smmu-v3.c

-- 
2.1.4
