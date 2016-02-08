From: Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH v2 0/4] iommu/arm-smmu: misc fixes for SMMUv1/SMMUv2
Date: Mon,  8 Feb 2016 10:47:28 +0530
Message-ID: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree <devicetree@vger.kernel.org>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ray Jui <rjui@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Vikram Prakash <vikramp@broadcom.com>, Rob Herring <robh+dt@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Kumar Gala <galak@codeaurora.org>, Anup Patel <anup.patel@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

The intention behind this patchset is to allow usage of IOMMU based
DMA mappings for 32bit devices. It is based on '4.5-rc3' tag of linux
mainline tree and Robin's SMMU patchset "[PATCH 0/4] Miscellaneous
ARM SMMU patches".

This patchset and its dependent patches are available in smmu_v2
branch of https://github.com/Broadcom/arm64-linux.git

All patches have been tested on Broadcom SoCs having SMMU-500.

Anup Patel (3):
  iommu/arm-smmu: Invoke DT probe from arm_smmu_of_setup()
  of: iommu: Increment DT node refcount in of_iommu_set_ops()
  iommu/arm-smmu: Add stub of_xlate() operation in SMMUv1/SMMUv2 driver

Sricharan R (1):
  iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE

 drivers/iommu/arm-smmu.c | 52 ++++++++++++++++++++++++++++++++++++------------
 drivers/iommu/of_iommu.c |  1 +
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
1.9.1
