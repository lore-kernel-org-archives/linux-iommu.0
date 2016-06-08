From: <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 0/5] MT2701 iommu support
Date: Wed, 8 Jun 2016 17:50:56 +0800
Message-ID: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

  Mediatek's m4u(Multimedia Memory Management Unit) and SMI(Smart
Multimedia Interface)have two generations HW. They basically sharing the
same hardware block diagram, but have some difference as below:

  Generation one m4u only supports one layer, flat pagetable addressing,
and only supports 4K size page mapping. While generation two m4u supports 2
levels of pagetable which uses the ARM short-descriptor translation table
format for address translation.
They have slight different register base and register offset.
They have very different HW ports defines.

  Generaion one SMI has additional "async" clock which transform the smi
clock into emi clock domain, this clock should be prepared and enabled for
SMI generation one HW.
The register which control the iommu need to translation the address or not
for a particular port is located at smi ao base(smi always on register
base) for generation one SMI HW, but located at each larb's register base
for generation two HW.

This patch set add mt2701 iommu support, it's based on 4.7-rc1 and James
Liao's "Add clock support for Mediatek MT2701 v8[1]" and "Mediatek MT2701
SCPSYS power domain support v7[2]" patch.

v4:
-Rebase on 4.7-rc1.
-Do not call of_node_put call in mtk_iommu_create_mapping.

v3: https://lists.linuxfoundation.org/pipermail/iommu/2016-May/017179.html
-Rebase on "of: Implement iterator for phandles[3]" and take use of
 of_for_each_phandle.
-Forward-declare mtk_iommu_domain and implement the struct separately.
-Free the pagetable memory in mtk_iommu_domain_free
-Roll back the mapping in error case.
-Minor cleanups.

v2: https://lists.linuxfoundation.org/pipermail/iommu/2016-May/017068.html
-Fix syntax errors in dt-bindings.
-Use dma_alloc/free_coherent to allocate pagetable memory and reduce the
 streaming DMA stuff.
-Make the mtk_iommu_ops.pgsize_bitmap as ~0UL << MT2701_IOMMU_PAGE_SHIFT.
-Use macro instead of variable to indicate the pagetable size.
-Change some macro name from MTK_XXX to MT2701_XXX.

v1: http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005301.html
-initial version

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005439.html
[2] http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005429.html
[3] https://lists.linuxfoundation.org/pipermail/iommu/2016-April/016300.html

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
 drivers/iommu/Kconfig                              |  18 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/mtk_iommu.c                          |  48 +-
 drivers/iommu/mtk_iommu.h                          |  77 +++
 drivers/iommu/mtk_iommu_v1.c                       | 727 +++++++++++++++++++++
 drivers/memory/mtk-smi.c                           | 167 ++++-
 include/dt-bindings/memory/mt2701-larb-port.h      |  85 +++
 11 files changed, 1139 insertions(+), 73 deletions(-)
 create mode 100644 drivers/iommu/mtk_iommu.h
 create mode 100644 drivers/iommu/mtk_iommu_v1.c
 create mode 100644 include/dt-bindings/memory/mt2701-larb-port.h

-- 
1.8.1.1.dirty
