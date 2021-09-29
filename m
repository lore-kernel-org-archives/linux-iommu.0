Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4955BC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 01:37:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D84613C8
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 01:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5D84613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAB9C60688;
	Wed, 29 Sep 2021 01:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sM7WDy9ZhKPo; Wed, 29 Sep 2021 01:37:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 58113605EF;
	Wed, 29 Sep 2021 01:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F907C000F;
	Wed, 29 Sep 2021 01:37:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8FF8C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDEB0829AF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vD26S3hB-94j for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:37:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4C52829A9
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:37:30 +0000 (UTC)
X-UUID: 387354b2a8f24c17838d5d53d5f74665-20210929
X-UUID: 387354b2a8f24c17838d5d53d5f74665-20210929
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1576674533; Wed, 29 Sep 2021 09:37:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 29 Sep 2021 09:37:22 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Sep 2021 09:37:21 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v8 00/12] Clean up "mediatek,larb"
Date: Wed, 29 Sep 2021 09:37:07 +0800
Message-ID: <20210929013719.25120-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Frank Wunderlich <frank-w@public-files.de>, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

MediaTek IOMMU block diagram always like below:

        M4U
         |
    smi-common
         |
  -------------
  |         |  ...
  |         |
larb1     larb2
  |         |
vdec       venc

All the consumer connect with smi-larb, then connect with smi-common.

When the consumer works, it should enable the smi-larb's power which also
need enable the smi-common's power firstly.

Thus, Firstly, use the device link connect the consumer and the
smi-larbs. then add device link between the smi-larb and smi-common.

After adding the device_link, then "mediatek,larb" property can be removed.
the iommu consumer don't need call the mtk_smi_larb_get/put to enable
the power and clock of smi-larb and smi-common.

About the MM dt-binding/dtsi patches, I guess they should go together, thus
I don't split them for each a MM module and each a SoC.

Base on a jpeg dtbing patchset[1] that already got the necessary R-b.

[1] https://lore.kernel.org/linux-mediatek/20210702102304.3346429-1-hsinyi@chromium.org/

Change notes:
v8: 1) Rebase on v5.15-rc1.
    2) Don't rebase the below mdp patchset that may still need more discuss.
    https://lore.kernel.org/linux-mediatek/20210709022324.1607884-1-eizan@chromium.org/
    3) Add Frank's Tested-by. Remove Dafna's Tested-by as he requested.

v7: https://lore.kernel.org/linux-mediatek/20210730025238.22456-1-yong.wu@mediatek.com/
    1) Fix a arm32 boot fail issue. reported from Frank.
    2) Add a return fail in the mtk drm. suggested by Dafna.

v6: https://lore.kernel.org/linux-mediatek/20210714025626.5528-1-yong.wu@mediatek.com/
    1) rebase on v5.14-rc1.
    2) Fix the issue commented in v5 from Dafna and Hsin-Yi.
    3) Remove the patches about using pm_runtime_resume_and_get since they have
       already been merged by other patches.

v5: https://lore.kernel.org/linux-mediatek/20210410091128.31823-1-yong.wu@mediatek.com/
    1) Base v5.12-rc2.
    2) Remove changing the mtk-iommu to module_platform_driver patch, It have already been a
    independent patch.

v4: https://lore.kernel.org/linux-mediatek/1590826218-23653-1-git-send-email-yong.wu@mediatek.com/ 
    base on v5.7-rc1.
  1) Move drm PM patch before smi patchs.
  2) Change builtin_platform_driver to module_platform_driver since we may need
     build as module.
  3) Rebase many patchset as above.

v3: https://lore.kernel.org/linux-iommu/1567503456-24725-1-git-send-email-yong.wu@mediatek.com/
    1) rebase on v5.3-rc1 and the latest mt8183 patchset.
    2) Use device_is_bound to check whether the driver is ready from Matthias.    
    3) Add DL_FLAG_STATELESS flag when calling device_link_add and explain the
   reason in the commit message[3/14].
    4) Add a display patch[12/14] into this series. otherwise it may affect
   display HW fastlogo even though it don't happen in mt8183.
   
v2: https://lore.kernel.org/linux-iommu/1560171313-28299-1-git-send-email-yong.wu@mediatek.com/
   1) rebase on v5.2-rc1.
   2) Move adding device_link between the consumer and smi-larb into
iommu_add_device from Robin.
   3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
   4) Remove the shutdown callback in iommu.   

v1: https://lore.kernel.org/linux-iommu/1546318276-18993-1-git-send-email-yong.wu@mediatek.com/

Yong Wu (11):
  dt-binding: mediatek: Get rid of mediatek, larb for multimedia HW
  iommu/mediatek-v1: Free the existed fwspec if the master dev already
    has
  iommu/mediatek: Add probe_defer for smi-larb
  iommu/mediatek: Add device_link between the consumer and the larb
    devices
  media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
  media: mtk-mdp: Get rid of mtk_smi_larb_get/put
  drm/mediatek: Get rid of mtk_smi_larb_get/put
  media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
  memory: mtk-smi: Get rid of mtk_smi_larb_get/put
  arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
  arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes

Yongqiang Niu (1):
  drm/mediatek: Add pm runtime support for ovl and rdma

 .../display/mediatek/mediatek,disp.txt        |  9 ----
 .../bindings/media/mediatek-jpeg-decoder.yaml |  9 ----
 .../bindings/media/mediatek-jpeg-encoder.yaml |  9 ----
 .../bindings/media/mediatek-mdp.txt           |  8 ----
 .../bindings/media/mediatek-vcodec.txt        |  4 --
 arch/arm/boot/dts/mt2701.dtsi                 |  2 -
 arch/arm/boot/dts/mt7623n.dtsi                |  5 ---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      | 16 -------
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  6 ---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  8 +++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  9 +++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 15 ++++---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   | 36 +--------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  5 +--
 drivers/iommu/mtk_iommu.c                     | 24 +++++++++-
 drivers/iommu/mtk_iommu_v1.c                  | 31 ++++++++++++-
 .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 45 +------------------
 .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  2 -
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 40 -----------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 -
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
 .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 +++------------
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 44 +++---------------
 drivers/memory/mtk-smi.c                      | 14 ------
 include/soc/mediatek/smi.h                    | 20 ---------
 28 files changed, 90 insertions(+), 316 deletions(-)

-- 
2.18.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
