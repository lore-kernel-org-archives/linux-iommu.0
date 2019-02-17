From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v6 00/22] MT8183 IOMMU SUPPORT
Date: Sun, 17 Feb 2019 17:04:38 +0800
Message-ID: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, anan.sun-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patchset mainly adds support for mt8183 IOMMU and SMI.

mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
uses ARM Short-Descriptor translation table format.

The mt8183 M4U-SMI HW diagram is as below:

                          EMI
                           |
                          M4U
                           |
                       ----------
                       |        |
                   gals0-rx   gals1-rx
                       |        |
                       |        |
                   gals0-tx   gals1-tx
                       |        |
                      ------------
                       SMI Common
                      ------------
                           |
  +-----+-----+--------+-----+-----+-------+-------+
  |     |     |        |     |     |       |       |
  |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
  |     |     |        |     |     |       |       |
  |     |     |        |     |     |       |       |
  |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
  |     |     |        |     |     |       |       |
larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
disp  vdec   img     cam    venc   img    cam

All the connections are HW fixed, SW can NOT adjust it.

Compared with mt8173, we add a GALS(Global Async Local Sync) module
between SMI-common and M4U, and additional GALS between larb2/3/5/6
and SMI-common. GALS can help synchronize for the modules in different
clock frequency, it can be seen as a "asynchronous fifo".

GALS can only help transfer the command/data while it doesn't have
the configuring register, thus it has the special "smi" clock and it
doesn't have the "apb" clock. From the diagram above, we add "gals0"
and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.

>From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
Control Unit) is connected with smi-common directly, we can take them
as "larb2", "larb3" and "larb7", and their register spaces are
different with the normal larb.

This is the general purpose of each patch in this patchset:
the patch 1..13 add the iommu/smi support for mt8183;
the patch 14..16 add mmu1 support;
the last patches contain some minor changes:
   -patch 17 cleanup some smi codes(delete need_larbid).
   -patch 18 fix a issue(fix vld_pa_rng).
   -patch 19 improve the code flow(add shutdown).   
   -patch 20/21 improve the 4GB mode.
   -patch 22 switch to SPDX license.
The dtsi was included at [1] since it should depend on power-domain
and ccf nodes.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016539.html

Change notes:

v6: 1) rebase on v5.0-rc1.
    2) About the register name (VLD_PA_RNG), Keep consistent in all the patches.
    3) In the 4GB mode, Always add MTK_4GB_quirk.
    4) Reword some commit message helped from Evan. like common->smi_ao_base is
       completely different from common->base; STANDARD_AXI_MODE reg is completely
       different from CTRL_MISC; commit in the shutdown patch.
    5) Add 2 new patches again:
       iommu/mediatek: Rename enable_4GB to dram_is_4gb
       iommu/mediatek: Fix iova_to_phys PA start for 4GB mode

v5: https://lists.linuxfoundation.org/pipermail/iommu/2019-January/032387.html
    1) Remove this patch "iommu/mediatek: Constify iommu_ops" from here as it
       was applied for v5.0.
    2) Again, add 3 preparing patches. Move two property into the plat_data.
       iommu/mediatek: Move vld_pa_rng into plat_data
       iommu/mediatek: Move reset_axi into plat_data
       iommu/mediatek: Refine protect memory definition
    3) Add shutdown callback for mtk_iommu_v1 in patch[19/20].

v4: http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016205.html
    1) Add 3 preparing patches. Seperate some minor meaningful code into
       a new patch according to Matthias's suggestion.
       memory: mtk-smi: Add gals support         
       iommu/mediatek: Add larb-id remapped support 
       iommu/mediatek: Add bclk can be supported optionally       
    2) rebase on "iommu/mediatek: Make it explicitly non-modular"
       which was applied.
       https://lore.kernel.org/patchwork/patch/1020125/
    3) add some comment about "mediatek,larb-id" in the commit message of
       the patch "mtk-smi: Get rid of need_larbid".
    4) Fix bus_sel value.

v3: https://lists.linuxfoundation.org/pipermail/iommu/2018-November/031121.html
    1) rebase on v4.20-rc1.
    2) In the dt-binding, add a minor string "mt7623" which also use gen1
       since Matthias added it in v4.20.
    3) About v7s:
       a) for paddr_to_pte, change the param from "arm_v7s_io_pgtable" to
          "arm_pgtable_cfg", according to Robin suggestion.
       b) Don't use CONFIG_PHYS_ADDR_T_64BIT.
       c) add a little comment(pgtable address still don't over 4GB) in the
          commit message of the patch "Extend MediaTek 4GB Mode".
    4) add "iommu/mediatek: Constify iommu_ops" into this patchset. this may
       be helpful for review and merge.
       https://lists.linuxfoundation.org/pipermail/iommu/2018-October/030637.html

v2: https://lists.linuxfoundation.org/pipermail/iommu/2018-September/030164.html
    1) Fix typo in the commit message of dt-binding.
    2) Change larb2/larb3 to the special larbs.
    3) Refactor the larb-id remapped array(larbid_remapped), then we
    don't need add the new function(mtk_iommu_get_larbid).
    4) Add a new patch for v7s two helpers(paddr_to_iopte and
    iopte_to_paddr).
    5) Change some comment for MTK 4GB mode.

v1: base on v4.19-rc1.
http://lists.infradead.org/pipermail/linux-mediatek/2018-September/014881.html

Yong Wu (22):
  dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
  iommu/mediatek: Use a struct as the platform data
  memory: mtk-smi: Use a general config_port interface
  memory: mtk-smi: Use a struct for the platform data for smi-common
  iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
    helpers
  iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
  iommu/mediatek: Add bclk can be supported optionally
  iommu/mediatek: Add larb-id remapped support
  iommu/mediatek: Refine protect memory definition
  iommu/mediatek: Move reset_axi into plat_data
  iommu/mediatek: Move vld_pa_rng into plat_data
  memory: mtk-smi: Add gals support
  iommu/mediatek: Add mt8183 IOMMU support
  iommu/mediatek: Add mmu1 support
  memory: mtk-smi: Invoke pm runtime_callback to enable clocks
  memory: mtk-smi: Add bus_sel for mt8183
  memory: mtk-smi: Get rid of need_larbid
  iommu/mediatek: Fix VLD_PA_RNG register backup when suspend
  iommu/mediatek: Add shutdown callback
  iommu/mediatek: Rename enable_4GB to dram_is_4gb
  iommu/mediatek: Fix iova_to_phys PA start for 4GB mode
  iommu/mediatek: Switch to SPDX license identifier

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  30 ++-
 .../memory-controllers/mediatek,smi-common.txt     |  12 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   4 +
 drivers/iommu/io-pgtable-arm-v7s.c                 |  72 ++++--
 drivers/iommu/io-pgtable.h                         |   7 +-
 drivers/iommu/mtk_iommu.c                          | 172 ++++++++-----
 drivers/iommu/mtk_iommu.h                          |  27 ++-
 drivers/iommu/mtk_iommu_v1.c                       |  18 +-
 drivers/memory/mtk-smi.c                           | 270 ++++++++++++++-------
 include/dt-bindings/memory/mt2701-larb-port.h      |  10 +-
 include/dt-bindings/memory/mt8173-larb-port.h      |  10 +-
 include/dt-bindings/memory/mt8183-larb-port.h      | 130 ++++++++++
 include/soc/mediatek/smi.h                         |  11 +-
 13 files changed, 545 insertions(+), 228 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h

-- 
1.9.1 
