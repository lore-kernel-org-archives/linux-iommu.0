From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [RFC/PATCH 0/7] Add MSM SMMUv1 support
Date: Mon, 30 Jun 2014 09:51:49 -0700
Message-ID: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

These patches add support for Qualcomm MSM SMMUv1 hardware. The first patch
renames the files for the existing MSM IOMMU driver to align with the SMMU
hardware revision (v1 is ARM SMMUv1 spec). The second patch adds back
map_range/unmap_range APIs. These APIs allows SMMU driver implementations to
optimize mappings of scatter-gather list of physically contiguous chunks of
memory. The third patch adds common macros to allow device drivers to poll
memory mapped registers. The fourth and fifth patch is the actual MSM SMMUv1
driver which supports the following:

	- ARM V7S and V7L page table format independent of ARM CPU page table
	  format
	- 4K/64K/1M/16M mappings (V7S)
	- 4K/64K/2M/32M/1G mappings (V7L)
	- ATOS used for unit testing of driver
	- Sharing of page tables among SMMUs
	- Verbose context bank fault reporting
	- Verbose global fault reporting
	- Support for clocks and GDSC
	- map/unmap range
	- Domain specific enabling of coherent Hardware Table Walk (HTW)

The last patch adds a new IOMMU domain attribute allowing us to set whether
hardware table walks should go to cache or not.

Matt Wagantall (1):
  iopoll: Introduce memory-mapped IO polling macros

Olav Haugan (6):
  iommu: msm: Rename iommu driver files
  iommu-api: Add map_range/unmap_range functions
  iommu: msm: Add MSM IOMMUv1 driver
  iommu: msm: Add support for V7L page table format
  defconfig: msm: Enable Qualcomm SMMUv1 driver
  iommu-api: Add domain attribute to enable coherent HTW

 .../devicetree/bindings/iommu/msm,iommu_v1.txt     |   60 +
 arch/arm/configs/qcom_defconfig                    |    3 +-
 drivers/iommu/Kconfig                              |   57 +-
 drivers/iommu/Makefile                             |    8 +-
 drivers/iommu/iommu.c                              |   24 +
 drivers/iommu/{msm_iommu.c => msm_iommu-v0.c}      |    2 +-
 drivers/iommu/msm_iommu-v1.c                       | 1529 +++++++++++++
 drivers/iommu/msm_iommu.c                          |  771 +------
 .../iommu/{msm_iommu_dev.c => msm_iommu_dev-v0.c}  |    2 +-
 drivers/iommu/msm_iommu_dev-v1.c                   |  345 +++
 .../{msm_iommu_hw-8xxx.h => msm_iommu_hw-v0.h}     |    0
 drivers/iommu/msm_iommu_hw-v1.h                    | 2322 ++++++++++++++++++++
 drivers/iommu/msm_iommu_pagetable.c                |  600 +++++
 drivers/iommu/msm_iommu_pagetable.h                |   33 +
 drivers/iommu/msm_iommu_pagetable_lpae.c           |  717 ++++++
 drivers/iommu/msm_iommu_priv.h                     |   65 +
 include/linux/iommu.h                              |   25 +
 include/linux/iopoll.h                             |  114 +
 include/linux/qcom_iommu.h                         |  221 ++
 19 files changed, 6236 insertions(+), 662 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt
 copy drivers/iommu/{msm_iommu.c => msm_iommu-v0.c} (99%)
 create mode 100644 drivers/iommu/msm_iommu-v1.c
 rename drivers/iommu/{msm_iommu_dev.c => msm_iommu_dev-v0.c} (99%)
 create mode 100644 drivers/iommu/msm_iommu_dev-v1.c
 rename drivers/iommu/{msm_iommu_hw-8xxx.h => msm_iommu_hw-v0.h} (100%)
 create mode 100644 drivers/iommu/msm_iommu_hw-v1.h
 create mode 100644 drivers/iommu/msm_iommu_pagetable.c
 create mode 100644 drivers/iommu/msm_iommu_pagetable.h
 create mode 100644 drivers/iommu/msm_iommu_pagetable_lpae.c
 create mode 100644 drivers/iommu/msm_iommu_priv.h
 create mode 100644 include/linux/iopoll.h
 create mode 100644 include/linux/qcom_iommu.h

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
