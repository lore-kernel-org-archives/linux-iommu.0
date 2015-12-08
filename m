From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 0/5] MT8173 IOMMU SUPPORT
Date: Tue, 8 Dec 2015 17:49:08 +0800
Message-ID: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

  This patch set adds support for m4u(Multimedia Memory Management Unit),
Currently it only support the m4u with 2 levels of pagetable on mt8173.

  It's based on Robin Murphy's reposting Short-descriptor[1].
 
  Please check the hardware block diagram of Mediatek IOMMU.
 
              m4u (Multimedia Memory Management Unit)
               |
           SMI Common(Smart Multimedia Interface Common)
               |
       +----------------+-------
       |                |
       |                |
   SMI larb0        SMI larb1   ... SoCs have several SMI local arbiter(larb).
   (display)         (vdec)
       |                |
       |                |
 +-----+-----+     +----+----+
 |     |     |     |    |    |
 |     |     |...  |    |    |  ... There are different ports in each larb.
 |     |     |     |    |    |
OVL0 RDMA0 WDMA0  MC   PP   VLD

  As above, The Multimedia HW will go through SMI and M4U while it
access EMI. SMI is a brige between m4u and the Multimedia HW. It contain
smi local arbiter and smi common. It will control whether the Multimedia
HW should go though the m4u for translation or bypass it and talk
directly with EMI. And also SMI help control the power domain and clocks for
each local arbiter.
  Normally we specify a local arbiter(larb) for each multimedia HW
like display, video decode, and camera. And there are different ports
in each larb. Take a example, There are many ports like MC, PP, VLD in the
video decode local arbiter, all these ports are according to the video HW.

[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-December/015088.html

v6:
-rebase onto v4.4-rc1.
-Use Robin's reposting Short-decriptor.
-Add component for m4u and smi since m4u should depend on smi-larb.
 The master device is the m4u device, and the client one is the smi-larb device. 
-Change mtk iommu-cells from 2 to 1 since the mapping between larb and port is
 fixed. Compare this with v2, we redefine MTK_M4U_ID following this register
 REG_MMU_INT_ID.
-About SMI: Add some help funcion and rename some function and struction for
 more readable. 
 These three above are according to Daniel Kurtz's suggestion.

v5: http://lists.linuxfoundation.org/pipermail/iommu/2015-October/014586.html
-rebase onto v4.3-rc1.
-About MTK iommu: don't return the same domain while domain_alloc, change the
 domain's flow according to the M4U HW.
-About Short-descriptor: Improve many error-handles, NO_PERMS quirk, and 
 add TLBI_MAP quirk following Will's Suggestion; Add io-pgtable don't use 
 dma_to_phys; Add a loop in arm_short_unmap since iommu_unmap don't care the 
 physical address align.
-About SMI driver: Add a help funcion for some similar code. Add PROPRE_DEFER
 for power-domain as MTK SCPSYS is module_init currently.

v4: http://lists.linuxfoundation.org/pipermail/iommu/2015-August/013903.html
-use only one iommu domain here based on the Robin's DMA-v5:
 http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013900.html
-remove flush_pgtable.
-change writel to writel_relaxed.
-about Short-descriptor: move dma_map_single into io-pgtable-arm-short.
 Improve the flow of free pgtable and add NO_XN+NO_PERMS quirk following
 Will's suggestion.
-Change two sytle issues in dtsi according to Daniel's suggestion.

v3: http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013632.html
-rebased onto v4.2-rc1
-improve iommu flow based on the Robin's DMA v3:
 http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013597.html
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

Yong Wu (5):
  dt-bindings: iommu: Add binding for mediatek IOMMU
  dt-bindings: mediatek: Add smi dts binding
  memory: mediatek: Add SMI driver
  iommu/mediatek: Add mt8173 IOMMU driver
  dts: mt8173: Add iommu/smi nodes for mt8173

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  68 ++
 .../memory-controllers/mediatek,smi-common.txt     |  24 +
 .../memory-controllers/mediatek,smi-larb.txt       |  25 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  81 +++
 drivers/iommu/Kconfig                              |  15 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/mtk_iommu.c                          | 752 +++++++++++++++++++++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mtk-smi.c                           | 297 ++++++++
 include/dt-bindings/memory/mt8173-larb-port.h      | 111 +++
 include/soc/mediatek/smi.h                         |  53 ++
 12 files changed, 1436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
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
