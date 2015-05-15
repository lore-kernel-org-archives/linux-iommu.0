From: Yong Wu <yong.wu@mediatek.com>
Subject: [RFC v2 PATCH 0/6] MT8173 IOMMU SUPPORT
Date: Fri, 15 May 2015 17:43:23 +0800
Message-ID: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, k.zhang@mediatek.com, youhua.li@mediatek.com
List-Id: iommu@lists.linux-foundation.org

  This patch adds support for m4u(Multimedia Memory Management Unit),
Currently it only support the m4u with 2 levels of page table on mt8173.

  It is based on Robin Murphy's arm64: IOMMU-backed DMA mapping[1]. 
 
  Please check the hardware block diagram of Mediatek IOMMU.
 
              EMI (External Memory Interface)
               |
              m4u (Multimedia Memory Management Unit)
               |
              smi (Smart Multimedia Interface)
               |
        +---------------+-------
        |               |
        |               |
    vdec larb       disp larb      ... SoCs have different local arbiter(larb).
        |               |
        |               |
   +----+----+    +-----+-----+
   |    |    |    |     |     |    ...
   |    |    |    |     |     |    ...
   |    |    |    |     |     |    ...
  MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
  
  Normally we specify a local arbiter(larb) for each multimedia hardware like
display, video decode, video encode and camera. And there are different ports in
each larb. Take a example, there are some ports like MC, PP, UFO, VLD, AVC_MV,
PRED_RD, PRED_WR in video larb, all the ports are according to the video hardware.
 
  From the diagram, all the multimedia module connect with m4u via smi.
SMI is responsible to enable/disable iommu and control the clocks for each local
arbiter. If we should enable the iommu of video decode, it should config the 
video's ports. And if the video hardware work wether enable/disable iommu, 
it should enable the clock of its larb's clock. So we add a special driver for smi.
 
[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-February/012236.html

v2:
-add arm short descriptor support.
-seperate smi common from smi and change the clock-names according
 to smi HW.
-delete the hardcode of the port-names in mt8173.
 replace this with larb-portes-nr in dtsi.
-fix some coding style issues.

v1:
http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html

Yong Wu (6):
  dt-bindings: iommu: Add binding for mediatek IOMMU
  dt-bindings: mediatek: Add smi dts binding
  iommu: add ARM short descriptor page table allocator.
  iommu/mediatek: Add mt8173 IOMMU driver
  soc: mediatek: Add SMI driver
  dts: mt8173: Add iommu/smi nodes for mt8173

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  51 ++
 .../bindings/soc/mediatek/mediatek,smi-larb.txt    |  24 +
 .../bindings/soc/mediatek/mediatek,smi.txt         |  22 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  79 +++
 drivers/iommu/Kconfig                              |  18 +
 drivers/iommu/Makefile                             |   2 +
 drivers/iommu/io-pgtable-arm-short.c               | 490 +++++++++++++++
 drivers/iommu/io-pgtable.c                         |   4 +
 drivers/iommu/io-pgtable.h                         |   6 +
 drivers/iommu/mtk_iommu.c                          | 657 +++++++++++++++++++++
 drivers/soc/mediatek/Kconfig                       |   6 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mt8173-smi.c                  | 298 ++++++++++
 include/dt-bindings/iommu/mt8173-iommu-port.h      | 112 ++++
 include/linux/mtk-smi.h                            |  39 ++
 15 files changed, 1809 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
 create mode 100644 drivers/iommu/io-pgtable-arm-short.c
 create mode 100644 drivers/iommu/mtk_iommu.c
 create mode 100644 drivers/soc/mediatek/mt8173-smi.c
 create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h
 create mode 100644 include/linux/mtk-smi.h

-- 
1.8.1.1.dirty
