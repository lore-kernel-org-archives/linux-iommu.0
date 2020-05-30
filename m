Return-Path: <SRS0=Olas=7M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C788C433E0
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:17:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D437F2070E
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cxIr4GaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D437F2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A56DD89297;
	Sat, 30 May 2020 08:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUF9WAGV32qD; Sat, 30 May 2020 08:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EC94A880E2;
	Sat, 30 May 2020 08:17:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDCC2C0863;
	Sat, 30 May 2020 08:17:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5018C016F
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B243F883DD
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:17:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tQNxvdy31Y-X for <iommu@lists.linux-foundation.org>;
 Sat, 30 May 2020 08:17:26 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3D20088432
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:17:26 +0000 (UTC)
X-UUID: 8a8b99a1de5645d48ccc77bfa68a829c-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=V8yQ0GxXRXQMXl/iXHArWIMs4HfP9plBlPfYP2LJor0=; 
 b=cxIr4GaEPMjVfBXN/wfzcG1r9RRPXSXNhlpW9fnLqATEEm2zOKK04MHNCZSXSC3NKhIAfEO4EfuMytDxRz1bSr2nNr2eH+aNgIr/E4tfN9ZwEGILehZZuI4Yys2oHpWsYfCeBOI5/7WGsrb2GoGkupDx5xru6nJTjU7rWgiu6cg=;
X-UUID: 8a8b99a1de5645d48ccc77bfa68a829c-20200530
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1813244251; Sat, 30 May 2020 16:12:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:12:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:12:18 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 00/17] Clean up "mediatek,larb" after adding device_link
Date: Sat, 30 May 2020 16:10:01 +0800
Message-ID: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 eizan@chromium.org, srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 acourbot@chromium.org, linux-arm-kernel@lists.infradead.org
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

MediaTek IOMMU don't have its power-domain. When the consumer works,
it should enable the smi-larb's power which also need enable the smi-common's
power firstly.

Thus, Firstly, use the device link connect the consumer and the
smi-larbs. then add device link between the smi-larb and smi-common.

After adding the device_link, then "mediatek,larb" property can be removed.
the iommu consumer don't need call the mtk_smi_larb_get/put to enable
the power and clock of smi-larb and smi-common.

This patchset depends on v5.7-rc1 and several patchset. Mainly venc and MDP
adjust their flow, then this patchset can work successfully.

a) IOMMU depend on [1][2].
b) MDP depend on [3][4][5].
c) VENC depend on [6].

[1] iommu: Move iommu_group setup to IOMMU core code
   https://lore.kernel.org/linux-iommu/20200429133712.31431-1-joro@8bytes.org/
[2] iommu/mediatek-v1: Fix a build warning for a unused variable 'data'
   https://lore.kernel.org/linux-iommu/1589875064-662-1-git-send-email-yong.wu@mediatek.com/
[3] arm64: dts: mt8173: fix mdp aliases property name
   https://lore.kernel.org/linux-mediatek/20200414030815.192104-1-hsinyi@chromium.org/
[4] MTK MDP driver cleanups to prep for futher work
    https://lore.kernel.org/linux-mediatek/20200507102345.81849-1-eizan@chromium.org/
[5] Refactor MDP driver and add dummy component driver
    https://lore.kernel.org/linux-mediatek/20200506084039.249977-1-eizan@chromium.org/
[6] media: mtk-vcodec: venc: support for MT8183
    https://lore.kernel.org/linux-mediatek/20200520082723.96136-1-acourbot@chromium.org/

[1][2][3] have already been in lastest linux-next.

Change notes:

v4: base on v5.7-rc1.
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
   
v2: http://lists.infradead.org/pipermail/linux-mediatek/2019-June/020440.html
   1) rebase on v5.2-rc1.
   2) Move adding device_link between the consumer and smi-larb into
iommu_add_device from Robin.
   3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
   4) Remove the shutdown callback in iommu.   

v1: https://lists.linuxfoundation.org/pipermail/iommu/2019-January/032387.html

Irui Wang (1):
  arm64: dts: mt8173: Separate mtk-vcodec-enc node

Maoguang Meng (2):
  media: dt-binding: mtk-vcodec: Separating mtk-vcodec encode node.
  media: mtk-vcodec: separate mtk-vcodec-enc node.

Yong Wu (13):
  dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
  iommu/mediatek: Add probe_defer for smi-larb
  iommu/mediatek: Add device_link between the consumer and the larb
    devices
  memory: mtk-smi: Add device-link between smi-larb and smi-common
  media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
  media: mtk-mdp: Get rid of mtk_smi_larb_get/put
  media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
  drm/mediatek: Get rid of mtk_smi_larb_get/put
  memory: mtk-smi: Get rid of mtk_smi_larb_get/put
  iommu/mediatek: Use module_platform_driver
  memory: mtk-smi: Use device_is_bound to check if smi-common is ready
  arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
  arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes

Yongqiang Niu (1):
  drm/mediatek: Add pm runtime support for ovl and rdma

 .../bindings/display/mediatek/mediatek,disp.txt    |   9 --
 .../bindings/media/mediatek-jpeg-decoder.txt       |   4 -
 .../devicetree/bindings/media/mediatek-mdp.txt     |   8 --
 .../devicetree/bindings/media/mediatek-vcodec.txt  |  58 +++++-----
 arch/arm/boot/dts/mt2701.dtsi                      |   1 -
 arch/arm/boot/dts/mt7623.dtsi                      |   1 -
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  72 +++++-------
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |   9 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |   9 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  19 +--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  21 +---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   2 +-
 drivers/iommu/mtk_iommu.c                          |  44 ++++---
 drivers/iommu/mtk_iommu_v1.c                       |  39 +++++--
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    |  22 ----
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h    |   2 -
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c      |  44 +------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h      |   2 -
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |   1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  |  19 ---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  13 +--
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  24 +++-
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 127 +++++++++------------
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  |  56 ---------
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h  |   1 -
 .../media/platform/mtk-vcodec/venc/venc_vp8_if.c   |   4 +-
 drivers/memory/mtk-smi.c                           |  41 +++----
 include/soc/mediatek/smi.h                         |  20 ----
 28 files changed, 246 insertions(+), 426 deletions(-)

-- 
1.9.1 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
