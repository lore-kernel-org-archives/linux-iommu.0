From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Subject: [RFC 0/5] DT property to reserve IOMMU regions
Date: Tue,  6 Mar 2018 10:29:23 +0530
Message-ID: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
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
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

ARM SoCs need a way to reserve IOMMU regions. Some address ranges used 
by devices sitting behind IOMMU are treated specially. To prevent these
ranges from getting mapped in IOVA space, use the existing framework and
code to reserve the ranges using DT properties.

This patch set is created against 4.15-rc7.

Jitendra Bhivare (5):
  dt-bindings: iommu: Add reserved-dma-region for IOMMU device
  dt-bindings: brcm: Add reserved-dma-region for iPROC
  dt-bindings: arm-smmu: Add reserved-msi-region
  iommu/of: Reserve IOMMU DMA regions using DT
  iommu/arm-smmu: Allow direct mapping for MSI region

 .../devicetree/bindings/iommu/arm,smmu.txt         |  12 +++
 Documentation/devicetree/bindings/iommu/iommu.txt  |  17 ++++
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   3 +
 drivers/iommu/arm-smmu.c                           |  14 ++-
 drivers/iommu/dma-iommu.c                          |   6 ++
 drivers/iommu/of_iommu.c                           | 100 +++++++++++----------
 include/linux/iommu.h                              |   3 +
 include/linux/of_iommu.h                           |  25 ++++--
 8 files changed, 126 insertions(+), 54 deletions(-)

-- 
2.7.4
