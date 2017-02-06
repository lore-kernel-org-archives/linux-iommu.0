From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/10 v2] Let IOMMU core know about individual IOMMUs
Date: Mon,  6 Feb 2017 17:10:19 +0100
Message-ID: <1486397429-29327-1-git-send-email-joro@8bytes.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Changes since v1:

	* Rebased to v4.10-rc7
	* Fixed build failures found by the
	  kbuild test robot

Hi,

the IOMMU core code already has two ways of representing
individual hardware IOMMUs. One is the sysfs code and the
other is the newer iommu_register_instance interface. These
two interfaces are special purpose and can be unified.

This unification is attempted in this patch-set. It
introduces an extensible 'struct iommu_device' which
represents a hardware IOMMU in the IOMMU core code.

For now the struct contains a pointer to the iommu_ops, which
is a step to get rid of the per-bus iommu_ops, and a pointer
to a firmware-node structure.

The patches have been tested on x86 hardware and an AMD Seattle
ARM64 system.

Please review, test and provide feedback!

Thanks a lot,

       Joerg

Joerg Roedel (10):
  iommu: Rename iommu_get_instance()
  iommu: Rename struct iommu_device
  iommu: Introduce new 'struct iommu_device'
  iommu: Add sysfs bindings for struct iommu_device
  iommu: Make iommu_device_link/unlink take a struct iommu_device
  iommu/arm-smmu: Make use of the iommu_register interface
  iommu/msm: Make use of iommu_device_register interface
  iommu/mediatek: Make use of iommu_device_register interface
  iommu/exynos: Make use of iommu_device_register interface
  iommu: Remove iommu_register_instance interface

 drivers/acpi/arm64/iort.c       |  2 +-
 drivers/iommu/amd_iommu.c       | 18 ++++++----
 drivers/iommu/amd_iommu_init.c  |  9 +++--
 drivers/iommu/amd_iommu_types.h |  4 +--
 drivers/iommu/arm-smmu-v3.c     | 21 ++++++++++--
 drivers/iommu/arm-smmu.c        | 31 ++++++++++++++++-
 drivers/iommu/dmar.c            | 20 +++++++----
 drivers/iommu/exynos-iommu.c    | 18 ++++++++--
 drivers/iommu/intel-iommu.c     | 19 ++++++-----
 drivers/iommu/iommu-sysfs.c     | 61 +++++++++++++++-------------------
 drivers/iommu/iommu.c           | 68 +++++++++++++++++---------------------
 drivers/iommu/msm_iommu.c       | 73 ++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/msm_iommu.h       |  3 ++
 drivers/iommu/mtk_iommu.c       | 27 ++++++++++++++-
 drivers/iommu/mtk_iommu.h       |  2 ++
 include/linux/intel-iommu.h     |  3 +-
 include/linux/iommu.h           | 65 ++++++++++++++++++++++++------------
 include/linux/of_iommu.h        |  8 +----
 18 files changed, 316 insertions(+), 136 deletions(-)

-- 
1.9.1
