From: <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [RFC PATCH 0/5] MT8173 IOMMU support
Date: Fri, 6 Mar 2015 18:48:15 +0800
Message-ID: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
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
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

  This is based on Robin Murphy's arm64: IOMMU-backed DMA mapping[1]. 
This patch adds support for m4u(Multimedia Memory Management Unit),
Currently it only support the m4u with 2 levels of page table on mt8173.

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
  MC   PP   VLD  OVL0 RDMA0 WDMA0  ... 
  
  Normally we specify a local arbiter(larb) for each multimedia hardware like
display, video decode, video encode and camera. And there are different ports in
each larb. Take a example, there are some ports like MC, PP, UFO, VLD, AVC_MV,
PRED_RD, PRED_WR in video larb, all the ports are according to the video hardware.

	From the diagram, all the multimedia module connect with m4u via smi.
SMI is responsible to enable/disable iommu and control the clocks of each local
arbiter. If we should enable the iommu of video decode, it should config the 
video's ports. And if the video hardware work wether enable/disable iommu, 
it should enable the clock of its larb's clock. So we add a special driver for smi.

[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-February/012236.html

Yong Wu (5):
  soc: mediatek: Add SMI driver
  iommu/mediatek: Add mt8173 IOMMU driver
  dt-bindings: mediatek: Add smi dts binding
  dt-bindings: iommu: Add binding for mediatek IOMMU
  dts: mt8173: Add iommu/smi nodes for mt8173

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  41 ++
 .../bindings/soc/mediatek/mediatek,smi.txt         |  17 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  60 ++
 drivers/iommu/Kconfig                              |  11 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/mtk_iommu.c                          | 754 +++++++++++++++++++++
 drivers/iommu/mtk_iommu.h                          |  73 ++
 drivers/iommu/mtk_iommu_pagetable.c                | 439 ++++++++++++
 drivers/iommu/mtk_iommu_pagetable.h                |  49 ++
 drivers/soc/mediatek/Kconfig                       |   7 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mt8173-smi.c                  | 143 ++++
 include/dt-bindings/iommu/mt8173-iommu-port.h      | 127 ++++
 include/linux/mtk-smi.h                            |  40 ++
 14 files changed, 1763 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
 create mode 100644 drivers/iommu/mtk_iommu.c
 create mode 100644 drivers/iommu/mtk_iommu.h
 create mode 100644 drivers/iommu/mtk_iommu_pagetable.c
 create mode 100644 drivers/iommu/mtk_iommu_pagetable.h
 create mode 100644 drivers/soc/mediatek/mt8173-smi.c
 create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h
 create mode 100644 include/linux/mtk-smi.h

-- 
1.8.1.1.dirty
