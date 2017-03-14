From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/9] iommu: add qcom_iommu for early "B" family devices (v2)
Date: Tue, 14 Mar 2017 11:18:02 -0400
Message-ID: <20170314151811.17234-1-robdclark@gmail.com>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

An iommu driver for Qualcomm "B" family devices which do not completely
implement the ARM SMMU spec.  These devices have context-bank register
layout that is similar to ARM SMMU, but no global register space (or at
least not one that is accessible).

There are a couple vaguely unrelated patches to add venus and gpu dt nodes,
so that we have something to wire up the iommu to.

These patches apply on top of some in-flight patches to support IOMMU
probe deferral.  You can find full branch on top of linux-next here:

   git://people.freedesktop.org/~robclark/linux  next-20170307-db410c-qcom-smmu-3-venus

or github if you prefer:

   https://github.com/freedreno/kernel-msm/commits/next-20170307-db410c-qcom-smmu-3-venus

Compared to previous patchset, there have been some (mostly binding related)
cleanups.  Also fixed some other-config related build issues that kbuild
robot spotted.

Rob Clark (6):
  firmware/qcom: add qcom_scm_restore_sec_cfg()
  Docs: dt: document qcom iommu bindings
  iommu: arm-smmu: split out register defines
  iommu: add qcom_iommu
  ARM64: DT: add gpu for msm8916
  ARM64: DT: add iommu for msm8916

Stanimir Varbanov (3):
  firmware: qcom_scm: add two scm calls for iommu secure page table
  iommu: qcom: initialize secure page table
  ARM64: DT: add video codec devicetree node

 .../devicetree/bindings/iommu/qcom,iommu.txt       | 113 +++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 108 +++
 drivers/firmware/qcom_scm-32.c                     |  18 +
 drivers/firmware/qcom_scm-64.c                     |  58 ++
 drivers/firmware/qcom_scm.c                        |  18 +
 drivers/firmware/qcom_scm.h                        |  11 +
 drivers/iommu/Kconfig                              |  10 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/arm-smmu-regs.h                      | 227 ++++++
 drivers/iommu/arm-smmu.c                           | 200 +----
 drivers/iommu/qcom_iommu.c                         | 882 +++++++++++++++++++++
 include/linux/qcom_scm.h                           |   6 +
 12 files changed, 1453 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/qcom_iommu.c

-- 
2.9.3
