From: <honghui.zhang@mediatek.com>
Subject: [PATCH 0/5] MT2701 iommu support
Date: Mon, 9 May 2016 16:00:11 +0800
Message-ID: <1462780816-5288-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, treding@nvidia.com, mark.rutland@arm.com, matthias.bgg@gmail.com
Cc: p.zabel@pengutronix.de, devicetree@vger.kernel.org, pebolle@tiscali.nl, kendrick.hsu@mediatek.com, arnd@arndb.de, srv_heupstream@mediatek.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, tfiga@google.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, djkurtz@google.com, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, youlin.pei@mediatek.com, erin.lo@mediatek.com, Honghui Zhang <honghui.zhang@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

  Mediatek's m4u(Multimedia Memory Management Unit) and SMI(Smart
Multimedia Interface)have two generations HW. They basically sharing the
same hardware block diagram, but have some difference as below:

  Generation one m4u only support one layer, flat pagetable addressing, and
only support 4K size page mapping. While generation two m4u support 2
levels of pagetable which use the ARM short-descriptor translation table
format for address translation.
They have slight different register base and register offset.
They have very different HW ports defines.

  Generaion one SMI have additional "async" clock which transform the smi
clock into emi clock domain, this clock should be prepare and enabled for
cMI generation one HW.
The register which control the iommu need to translation the address or not
for a particular port is located at smi ao base(smi always on register
base) for generation one SMI HW, but located at each larb's register base
for generation two HW.

This patch set add mt2701 iommu support, it's based on 4.6-rc1 and James
Liao's "Add clock support for Mediatek MT2701 v7[1]" and "Mediatek MT2701
SCPSYS power domain support v6[2]" patch.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-February/004030.html
[2] http://www.spinics.net/lists/arm-kernel/msg497028.html

Honghui Zhang (5):
  dt-bindings: mediatek: add descriptions for mediatek mt2701 iommu and
    smi
  iommu/mediatek: move the common struct into header file
  memory/mediatek: add support for mt2701
  iommu/mediatek: add support for mtk iommu generation one HW
  ARM: dts: mt2701: add iommu/smi dtsi node for mt2701

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  13 +-
 .../memory-controllers/mediatek,smi-common.txt     |  21 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   4 +-
 arch/arm/boot/dts/mt2701.dtsi                      |  51 ++
 drivers/iommu/Kconfig                              |  19 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/mtk_iommu.c                          |  62 +-
 drivers/iommu/mtk_iommu.h                          |  94 +++
 drivers/iommu/mtk_iommu_v1.c                       | 767 +++++++++++++++++++++
 drivers/memory/mtk-smi.c                           | 168 ++++-
 include/dt-bindings/memory/mt2701-larb-port.h      |  85 +++
 11 files changed, 1197 insertions(+), 88 deletions(-)
 create mode 100644 drivers/iommu/mtk_iommu.h
 create mode 100644 drivers/iommu/mtk_iommu_v1.c
 create mode 100644 include/dt-bindings/memory/mt2701-larb-port.h

-- 
1.8.1.1.dirty
