From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/3] iommu/arm-smmu: Add driver for ARM SMMUv3 devices
Date: Fri,  8 May 2015 19:00:43 +0100
Message-ID: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

SMMUv3 is a significant departure from previous ARM SMMU designs in that
the majority of the configuration data has been moved from MMIO registers
to in-memory data structures, with communication between the CPU and the
SMMU being mediated via in-memory circular queues. It also has native
support for MSI generation, PCI masters (e.g. ATS, PRI, PASIDs), ARM 8.1
architectural extensions (e.g. hardware translation table updates) and
optional RAS extensions. It is designed for large numbers of masters and
consequently uses a 32-bit StreamID.

This patch series adds an initial driver for ARM SMMUv3 devices, which
enables dma-mapping and VFIO for PCI masters. Unfortunately, there is
not yet any documentation available for the hardware, but I have tested
this successfully on internal simulation. Having the driver available at
this early stage is useful for ARM partners building implementations and
provides a common upstream base on which the driver can be developed.

Future work will look at:

  - DMA to paged memory using PRI (for now we send a PRI_DENY response
    and dump the transaction to the console)

  - MSI generation from the SMMU (requires generic changes to the
    irqdomain code)

  - Support for non-PCI masters (pending core of_xlate rework as
    discussed on linux-arm-kernel)

There's also the nested translation angle, but we should work out what
we're doing on SMMUv2 before implementing anything here.

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
 drivers/iommu/arm-smmu-v3.c                        | 2599 ++++++++++++++++++++
 drivers/vfio/Kconfig                               |    2 +-
 6 files changed, 2653 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
 create mode 100644 drivers/iommu/arm-smmu-v3.c

-- 
2.1.4
