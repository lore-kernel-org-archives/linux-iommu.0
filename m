Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6851C433F5
	for <iommu@archiver.kernel.org>; Sat, 22 Jan 2022 08:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 281D9401B1;
	Sat, 22 Jan 2022 08:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dig__Wow79Bv; Sat, 22 Jan 2022 08:40:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 96CAC400D7;
	Sat, 22 Jan 2022 08:40:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B7A4C0039;
	Sat, 22 Jan 2022 08:40:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8CF6C002F
 for <iommu@lists.linux-foundation.org>; Sat, 22 Jan 2022 08:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C082940126
 for <iommu@lists.linux-foundation.org>; Sat, 22 Jan 2022 08:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xr4VTtdxBMid for <iommu@lists.linux-foundation.org>;
 Sat, 22 Jan 2022 08:40:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8916400D7
 for <iommu@lists.linux-foundation.org>; Sat, 22 Jan 2022 08:40:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0AF7AB80761;
 Sat, 22 Jan 2022 08:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08149C004E1;
 Sat, 22 Jan 2022 08:40:45 +0000 (UTC)
Message-ID: <7af52d61-47c7-581d-62ed-76a7f8315b16@xs4all.nl>
Date: Sat, 22 Jan 2022 09:40:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: Linux Media Mailing List <linux-media@vger.kernel.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.18] Clean up "mediatek,larb"
Cc: Joerg Roedel <jroedel@suse.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
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

Hi Mauro,

This is the PR of v10 of this series, minus patches 12 and 13 (Matthias will take those
once this is merged for 5.18):

https://patchwork.linuxtv.org/project/linux-media/cover/20220117070510.17642-1-yong.wu@mediatek.com/

The first two patches are from:

https://patchwork.linuxtv.org/project/linux-media/patch/20211206130425.184420-1-hsinyi@chromium.org/
https://patchwork.linuxtv.org/project/linux-media/patch/20211206130425.184420-2-hsinyi@chromium.org/

since the v10 series depends on that yaml conversion.

This series touches on several subsystems. I believe I have all the relevant Acks etc.
It made the most sense to merge this through the media subsystem since that's the main
target for these changes.

Regards,

	Hans


The following changes since commit 216a6d4965287400d40227601abb6cedcd2addd3:

  media: mtk-vcodec: Remove mtk_vcodec_release_enc_pm (2022-01-21 12:23:48 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.18g

for you to fetch changes up to ae04f1335521a2d8b917c0e4708280e9819ed0e9:

  memory: mtk-smi: Get rid of mtk_smi_larb_get/put (2022-01-22 09:20:30 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hsin-Yi Wang (2):
      dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml
      dt-bindings: mediatek: Add mediatek, mt8183-jpgenc compatible

Yong Wu (10):
      dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
      iommu/mediatek-v1: Free the existed fwspec if the master dev already has
      iommu/mediatek: Return ENODEV if the device is NULL
      iommu/mediatek: Add probe_defer for smi-larb
      iommu/mediatek: Add device_link between the consumer and the larb devices
      media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
      media: mtk-mdp: Get rid of mtk_smi_larb_get/put
      drm/mediatek: Get rid of mtk_smi_larb_get/put
      media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
      memory: mtk-smi: Get rid of mtk_smi_larb_get/put

Yongqiang Niu (1):
      drm/mediatek: Add pm runtime support for ovl and rdma

 Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt |  9 ------
 Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml |  7 -----
 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml |  8 ------
 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt    | 38 ------------------------
 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml   | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt    | 35 ----------------------
 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml   | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/media/mediatek-mdp.txt             |  8 ------
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c                              |  8 +++++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c                             |  9 +++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                              | 15 +++++-----
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c                          | 36 ++---------------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h                          |  1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                               |  5 +---
 drivers/iommu/mtk_iommu.c                                            | 34 ++++++++++++++++++++++
 drivers/iommu/mtk_iommu_v1.c                                         | 42 ++++++++++++++++++++++++++-
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c                      | 45 ++---------------------------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h                      |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c                        | 40 --------------------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h                        |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c                        |  1 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c               |  2 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c                |  1 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c                | 41 ++++----------------------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h                   |  3 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c                   |  1 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c               |  2 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c                | 45 ++++-------------------------
 drivers/memory/mtk-smi.c                                             | 14 ---------
 include/soc/mediatek/smi.h                                           | 20 -------------
 30 files changed, 267 insertions(+), 359 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
