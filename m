From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 0/6] MT8173 IOMMU SUPPORT
Date: Mon, 3 Aug 2015 18:21:13 +0800
Message-ID: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch set adds support for m4u(Multimedia Memory Management Unit),
Currently it only support the m4u with 2 levels of pagetable on mt8173.

  It's based on Robin Murphy's arm64 DMA-v5[1] and Robin's allow DMA API use in
io-pgtable-arm[2]. The dsti is based on MTK clock patch[3].
 
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
control for each local. So we add a special driver for smi and locate
it drivers/memory.

v4:
-use only one iommu domain here based on the Robin's DMA-v5.
-remove flush_pgtable.
-change writel to writel_relaxed.
-about Short-descriptor: move dma_map_single into io-pgtable-arm-short.
 Improve the flow of free pgtable and add NO_XN+NO_PERMS quirk following
 Will's suggestion.
-Change two sytle issues in dtsi according to Daniel's suggestion.

v3: http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013632.html
-rebased onto v4.2-rc1
-improve iommu flow based on the Robin's DMA v3[4].
-change mtk iommu-cells from 1 to 2.
-about Short-descriptor: add split function; add self-test; add some other bits like nG,
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

[1]: http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013900.html
[2]: http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013876.html
[3]: http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001800.html
[4]: http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013597.html

Yong Wu (6):
  dt-bindings: iommu: Add binding for mediatek IOMMU
  dt-bindings: mediatek: Add smi dts binding
  iommu: add ARM short descriptor page table allocator.
  memory: mediatek: Add SMI driver
  iommu/mediatek: Add mt8173 IOMMU driver
  dts: mt8173: Add iommu/smi nodes for mt8173

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  61 ++
 .../memory-controllers/mediatek,smi-larb.txt       |  25 +
 .../bindings/memory-controllers/mediatek,smi.txt   |  24 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  81 ++
 drivers/iommu/Kconfig                              |  31 +
 drivers/iommu/Makefile                             |   2 +
 drivers/iommu/io-pgtable-arm-short.c               | 811 +++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                     |   3 -
 drivers/iommu/io-pgtable.c                         |   4 +
 drivers/iommu/io-pgtable.h                         |  14 +
 drivers/iommu/mtk_iommu.c                          | 714 ++++++++++++++++++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mtk-smi.c                           | 285 ++++++++
 include/dt-bindings/memory/mt8173-larb-port.h      | 105 +++
 include/soc/mediatek/smi.h                         |  60 ++
 16 files changed, 2226 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt
 create mode 100644 drivers/iommu/io-pgtable-arm-short.c
 create mode 100644 drivers/iommu/mtk_iommu.c
 create mode 100644 drivers/memory/mtk-smi.c
 create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h
 create mode 100644 include/soc/mediatek/smi.h

-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
