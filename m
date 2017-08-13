From: Rob Clark <robdclark@gmail.com>
Subject: [pull] iommu: qcom_iommu for v4.14
Date: Sun, 13 Aug 2017 10:27:36 -0400
Message-ID: <CAF6AEGuNqQtJBhLAFu3NdUAjKJrVvR9WtHL-eCRN0H1Di6_4mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

These patches have been on list for quite some time now.  The bindings
have r-b from Rob Herring, and the patch touching arm-smmu has Will's
a-b.  And all the review comments on the driver patches have been
addressed (despite no one stepping up w/ a r-b tag).  Please consider
merging this pull request for v4.14

BR,
-R

The following changes since commit 60110f262d408c3155e578359812c80fd1f786f9:

  Merge branches 'iommu/fixes', 'arm/exynos', 'arm/renesas',
'arm/rockchip', 'arm/omap', 'arm/mediatek', 'x86/vt-d' and 'core' into
next (2017-08-11 17:09:23 +0200)

are available in the git repository at:

  git://people.freedesktop.org/~robclark/linux

for you to fetch changes up to 8a4342ede167b8c095961846e908b9ac1c884650:

  iommu: qcom: initialize secure page table (2017-08-12 11:50:35 -0400)

----------------------------------------------------------------
Rob Clark (3):
      Docs: dt: document qcom iommu bindings
      iommu: arm-smmu: split out register defines
      iommu: add qcom_iommu

Stanimir Varbanov (1):
      iommu: qcom: initialize secure page table

 .../devicetree/bindings/iommu/qcom,iommu.txt       | 121 +++
 drivers/iommu/Kconfig                              |  10 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/arm-smmu-regs.h                      | 220 +++++
 drivers/iommu/arm-smmu.c                           | 211 +----
 drivers/iommu/qcom_iommu.c                         | 932 +++++++++++++++++++++
 6 files changed, 1293 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/qcom_iommu.c
