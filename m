From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/8] MT2712 IOMMU SUPPORT
Date: Mon, 21 Aug 2017 19:00:13 +0800
Message-ID: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cloud.zhou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patchset mainly adds support for M4U of mt2712.

The M4U in mt2712 is MTK's generation2 M4U which use the ARM
Short-descriptor like mt8173. The main difference is that there are 2
M4Us and 2 smi-commons in mt2712, while there is only 1 M4U and 1
smi-common in mt8173. The purpose is for balance the bandwidth.

The mt2712 M4U-SMI HW diagram is as below:

                            EMI
                             |
              ------------------------------------
              |                                  |
             M4U0                              M4U1
              |                                  |
         smi-common0                        smi-common1
              |                                  |
  -------------------------       --------------------------------
  |     |     |     |     |       |         |        |     |     |
  |     |     |     |     |       |         |        |     |     |
larb0 larb1 larb2 larb3 larb6    larb4    larb5    larb7 larb8 larb9
disp0 vdec  cam   venc   jpg  mdp1/disp1 mdp2/disp2 mdp3 vdo/nr tvd

This patchset is based on v4.13-rc1, Also it base on Robin's[1],
Honghui[2],Arvind[3], all have been applied. Currently it don't contain
the dtsi part.

The patch 1 adds the binding for MT2712 IOMMU, the patch 2 is a
prepared patch for mt2712, the patch 3 adds the MT2712 IOMMU support.
the patch 4/5 improve the m4u flow for mt2712,
the last patch 6/7/8 mainly fix bug or improve code.

[1]:https://patchwork.kernel.org/patch/9828671/
[2]:https://patchwork.kernel.org/patch/9880223/
[3]:https://patchwork.kernel.org/patch/9892759/

change log:
v2:
 1) Add larb8 and larb9 in the HW diagram. larb8 and larb9 are called
    by the bdpsys larb, they are a little special, their mmu_en register
    offset is different from the normal larb. Fortunately, their mmu_en
    register is enabled defaultly, we don't need set again.
    After adding larb8 and larb9, the larb number is over 8, therefore,
    MTK_LARB_NR_MAX also is increased.
 2) Add a prepared patch that moving the MTK_M4U_TO_LARB/PORT into the
    c file.
 3) Discard the original patch[7/8] which was only a cleanup for SMI,
    It's unnecessary for this patch-set.
 4) Use subsys_initcall instead of IOMMU_OF_DECLARE according to
    Robin's suggestion. Also, Improve some coding format, like using
    for_each_set_bit and changing the definition of
    F_MMU_TF_PROTECT_SEL.

v1:
https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023664.html

Yong Wu (8):
  dt-bindings: mediatek: Add binding for mt2712 IOMMU and SMI
  iommu/mediatek: Move MTK_M4U_TO_LARB/PORT into mtk_iommu.c
  iommu/mediatek: Add mt2712 IOMMU support
  iommu/mediatek: Merge 2 M4U HWs into one iommu domain
  iommu/mediatek: Move pgtable allocation into domain_alloc
  iommu/mediatek: Disable iommu clock when system suspend
  iommu/mediatek: Enlarge the validate PA range for 4GB mode
  memory: mtk-smi: Degrade SMI init to module_init

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |   6 +-
 .../memory-controllers/mediatek,smi-common.txt     |   6 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   5 +-
 drivers/iommu/mtk_iommu.c                          | 214 +++++++++++++--------
 drivers/iommu/mtk_iommu.h                          |   9 +
 drivers/memory/mtk-smi.c                           |  65 ++++++-
 include/dt-bindings/memory/mt2712-larb-port.h      | 102 ++++++++++
 include/dt-bindings/memory/mt8173-larb-port.h      |   4 -
 include/soc/mediatek/smi.h                         |   2 +-
 9 files changed, 314 insertions(+), 99 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h

-- 
1.9.1
