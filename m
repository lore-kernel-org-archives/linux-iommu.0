From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/8] MT2712 IOMMU SUPPORT
Date: Fri, 11 Aug 2017 17:56:09 +0800
Message-ID: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patchset mainly adds support for M4U of mt2712.

The M4U in mt2712 is MTK's generation2 M4U which use the
Short-descriptor like mt8173. The main difference is that there are 2
M4Us and 2 smi-commons in mt2712, while there is only 1 M4U and 1
smi-common in mt8173. The purpose is for balance the bandwidth.

The mt2712 M4U-SMI HW diagram is as below:

                            EMI
                             |
              -------------------------------
              |                             |
             M4U0                          M4U1
              |                             |
         smi-common0                   smi-common1
              |                             |
  -------------------------       --------------------
  |     |     |     |     |       |         |        |
  |     |     |     |     |       |         |        |
larb0 larb1 larb2 larb3 larb6    larb4    larb5     larb7
disp0 vdec  cam   venc   jpg  mdp1/disp1 mdp2/disp2  mdp3->larb names

This patchset is based on v4.13-rc1, Also it base on Robin's[1],
Honghui[2],Arvind[3]. Currently it don't contain the dtsi part
as the ccf/power-domain has not been ready.

The patch 1/2 adds the support of MT2712 IOMMU support,
the patch 3/4 improve the m4u flow for mt2712,
the last patch 5/6/7/8 mainly fix bug or improve code.

[1]:https://patchwork.kernel.org/patch/9828671/
[2]:https://patchwork.kernel.org/patch/9880223/
[3]:https://patchwork.kernel.org/patch/9892759/

Yong Wu (8):
  dt-bindings: mediatek: Add binding for mt2712 IOMMU and SMI
  iommu/mediatek: Add mt2712 IOMMU support
  iommu/mediatek: Merge 2 M4U HWs into one iommu domain
  iommu/mediatek: Move pgtable allocation into domain_alloc
  iommu/mediatek: Disable iommu clock when system suspend
  iommu/mediatek: Enlarge the validate PA range for 4GB mode
  memory: mtk-smi: Rearrange some function position alphabetically
  memory: mtk-smi: Degrade SMI init to module_init

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |   6 +-
 .../memory-controllers/mediatek,smi-common.txt     |   6 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   5 +-
 drivers/iommu/mtk_iommu.c                          | 184 ++++++++++++++-------
 drivers/iommu/mtk_iommu.h                          |   9 +
 drivers/memory/mtk-smi.c                           | 108 +++++++-----
 include/dt-bindings/memory/mt2712-larb-port.h      |  91 ++++++++++
 7 files changed, 305 insertions(+), 104 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h

-- 
1.9.1
