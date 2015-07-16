From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v3 0/6] MT8173 IOMMU SUPPORT
Date: Thu, 16 Jul 2015 17:04:29 +0800
Message-ID: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, cloud.chou@mediatek.com, frederic.chen@mediatek.com, yong.wu@mediatek.com
List-Id: iommu@lists.linux-foundation.org

This patch adds support for m4u(Multimedia Memory Management Unit),
Currently it only support the m4u with 2 levels of pagetable on mt8173.

  It is based on Robin Murphy's arm64 DMA v3: IOMMU-backed DMA mapping[1]. 
 
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
PRED_RD in video larb, all the ports are according to the video hardware.
 
  From the diagram, all the multimedia module connect with m4u via smi.
SMI is responsible to enable/disable iommu and control the clocks for each local
arbiter. If we should enable the iommu of video decode, it should config the
video's ports. And if the video hardware work whether enable/disable iommu, 
it should enable the clock of its larb's clock. And smi also help bandwidth
control for each local arbiter. So we add a special driver for smi and locate
it drivers/memory.
 
[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013597.html

v3:
-rebased onto v4.2-rc1
-improve iommu flow based on the Robin's DMA v3.
-change mtk iommu-cells from 1 to 2.
-about Short-Descriptor: add split function; add self-test; add some other bits like nG,
 XN according to the spec; add SUPERSECTION and MTK quirk; move io_pgtable_ops_to_pgtable
 out from LPAE to the header file.
-about SMI: move from driver/soc/mediatek to driver/memory; change the clocks from
 clk[2] to clk_apb and clk_smi; add pm.
-add iommu suspend/resume to backup/restore register.

v2: http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013028.html
-add arm short descriptor support.
-seperate smi common from smi and change the clock-names according
 to smi HW.
-delete the hardcode of the port-names in mt8173.
 replace this with larb-portes-nr in dtsi.
-fix some coding style issues.

v1: http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html
-initial version.

Yong Wu (6):
  dt-bindings: iommu: Add binding for mediatek IOMMU
  dt-bindings: mediatek: Add smi dts binding
  iommu: add ARM short descriptor page table allocator.
  memory: mediatek: Add SMI driver
  iommu/mediatek: Add mt8173 IOMMU driver
  dts: mt8173: Add iommu/smi nodes for mt8173

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |   61 ++
 .../memory-controllers/mediatek,smi-larb.txt       |   25 +
 .../bindings/memory-controllers/mediatek,smi.txt   |   24 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   81 +++
 drivers/iommu/Kconfig                              |   31 +
 drivers/iommu/Makefile                             |    2 +
 drivers/iommu/io-pgtable-arm-short.c               |  742 ++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                     |    3 -
 drivers/iommu/io-pgtable.c                         |    4 +
 drivers/iommu/io-pgtable.h                         |   13 +
 drivers/iommu/mtk_iommu.c                          |  725 +++++++++++++++++++
 drivers/memory/Kconfig                             |    8 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/mtk-smi.c                           |  285 ++++++++
 include/dt-bindings/memory/mt8173-larb-port.h      |  105 +++
 include/soc/mediatek/smi.h                         |   60 ++
 16 files changed, 2167 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt
 create mode 100644 drivers/iommu/io-pgtable-arm-short.c
 create mode 100644 drivers/iommu/mtk_iommu.c
 create mode 100644 drivers/memory/mtk-smi.c
 create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h
 create mode 100644 include/soc/mediatek/smi.h

-- 
1.7.9.5
