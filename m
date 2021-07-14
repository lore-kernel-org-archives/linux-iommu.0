Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85819C07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:18:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E464613B7
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E464613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0926A415BC;
	Wed, 14 Jul 2021 11:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Uf5Tj3W5l6R; Wed, 14 Jul 2021 11:18:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5EDEB41485;
	Wed, 14 Jul 2021 11:18:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AA35C0010;
	Wed, 14 Jul 2021 11:18:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 898BAC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BB2A60B19
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m3ft2Y7mpoD9 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:18:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B2CD605D1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:18:13 +0000 (UTC)
X-UUID: e407e2ac5fec4e0193e6630b3ba88c6a-20210714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=a4Si3eZ7fDNKZHOBuXgUAIl76gjFv4ziTHlX+W08HKg=; 
 b=UgGg34EEhZjZ4hiNx67e4QOArgcFOmzpq7SYoy0YOw5bLwG+aLufcZOlMW8zbPA2pRyTi2OiUgMH0UUYYyVZtEA78qCrYeRwoRrWNtGsvdjMJnL831+oWdrkouecIn01D8dwsBcH7cfpRC/dfG0tCEYEbPfm4BxnNGpLCdFdxQU=;
X-UUID: e407e2ac5fec4e0193e6630b3ba88c6a-20210714
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2030586173; Wed, 14 Jul 2021 19:18:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 14 Jul 2021 19:18:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 19:18:03 +0800
Message-ID: <1626261483.14352.15.camel@mhfsdcap03>
Subject: Re: [PATCH v6 00/11] Clean up "mediatek,larb"
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date: Wed, 14 Jul 2021 19:18:03 +0800
In-Reply-To: <672ef386-aa95-da45-0f17-acb398a1f6e0@collabora.com>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
 <672ef386-aa95-da45-0f17-acb398a1f6e0@collabora.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 66096B7167E68897C718A8E5F5E93D30A09BFA4E16795181519114E5CFBA39B52000:8
X-MTK: N
Cc: Xia Jiang <xia.jiang@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 David Airlie <airlied@linux.ie>, Will
 Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Evan Green <evgreen@chromium.org>, Eizan
 Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Tiffany Lin <tiffany.lin@mediatek.com>,
 yi.kuo@mediatek.com, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com, Mauro
 Carvalho Chehab <mchehab@kernel.org>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
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

On Wed, 2021-07-14 at 10:56 +0200, Dafna Hirschfeld wrote:
> Hi
> 
> Thanks for the patchset.
> 
> I tested it on mt8173 (elm) with chromeos userspace.
> Before that patchset, the test:
> 
> tast -verbose run -build=false 10.42.0.175 video.DecodeAccel.h264
> 
> sometimes passed and sometimes failed with 'context deadline exceeded'.
> With this patchset it seems that the test always passes so I added tested-by:
> 
> Tested-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Thanks very much for your quick review and testing:)

> 
> Thanks,
> Dafna
> 
> 
> 
> 
> On 14.07.21 04:56, Yong Wu wrote:
> > MediaTek IOMMU block diagram always like below:
> > 
> >          M4U
> >           |
> >      smi-common
> >           |
> >    -------------
> >    |         |  ...
> >    |         |
> > larb1     larb2
> >    |         |
> > vdec       venc
> > 
> > All the consumer connect with smi-larb, then connect with smi-common.
> > 
> > When the consumer works, it should enable the smi-larb's power which also
> > need enable the smi-common's power firstly.
> > 
> > Thus, Firstly, use the device link connect the consumer and the
> > smi-larbs. then add device link between the smi-larb and smi-common.
> > 
> > After adding the device_link, then "mediatek,larb" property can be removed.
> > the iommu consumer don't need call the mtk_smi_larb_get/put to enable
> > the power and clock of smi-larb and smi-common.
> > 
> > About the MM dt-binding/dtsi patches, I guess they should go together, thus
> > I don't split them for each a MM module and each a SoC.
> > 
> > Base on v5.14-rc1, and a jpeg[1] and mdp[2] patchset.
> > 
> > [1] https://lore.kernel.org/linux-mediatek/20210702102304.3346429-1-hsinyi@chromium.org/
> > [2] https://lore.kernel.org/linux-mediatek/20210709022324.1607884-1-eizan@chromium.org/
> > 
> > Change notes:
> > v6: 1) rebase on v5.14-rc1.
> >      2) Fix the issue commented in v5 from Dafna and Hsin-Yi.
> >      3) Remove the patches about using pm_runtime_resume_and_get since they have
> >         already been merged by other patches.
> > 
> > v5: https://lore.kernel.org/linux-mediatek/20210410091128.31823-1-yong.wu@mediatek.com/
> >      1) Base v5.12-rc2.
> >      2) Remove changing the mtk-iommu to module_platform_driver patch, It have already been a
> >      independent patch.
> > 
> > v4: https://lore.kernel.org/linux-mediatek/1590826218-23653-1-git-send-email-yong.wu@mediatek.com/
> >      base on v5.7-rc1.
> >    1) Move drm PM patch before smi patchs.
> >    2) Change builtin_platform_driver to module_platform_driver since we may need
> >       build as module.
> >    3) Rebase many patchset as above.
> > 
> > v3: https://lore.kernel.org/linux-iommu/1567503456-24725-1-git-send-email-yong.wu@mediatek.com/
> >      1) rebase on v5.3-rc1 and the latest mt8183 patchset.
> >      2) Use device_is_bound to check whether the driver is ready from Matthias.
> >      3) Add DL_FLAG_STATELESS flag when calling device_link_add and explain the
> >     reason in the commit message[3/14].
> >      4) Add a display patch[12/14] into this series. otherwise it may affect
> >     display HW fastlogo even though it don't happen in mt8183.
> >     
> > v2: https://lore.kernel.org/linux-iommu/1560171313-28299-1-git-send-email-yong.wu@mediatek.com/
> >     1) rebase on v5.2-rc1.
> >     2) Move adding device_link between the consumer and smi-larb into
> > iommu_add_device from Robin.
> >     3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
> >     4) Remove the shutdown callback in iommu.
> > 
> > v1: https://lore.kernel.org/linux-iommu/1546318276-18993-1-git-send-email-yong.wu@mediatek.com/
> > 
> > Yong Wu (10):
> >    dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
> >    iommu/mediatek: Add probe_defer for smi-larb
> >    iommu/mediatek: Add device_link between the consumer and the larb
> >      devices
> >    media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
> >    media: mtk-mdp: Get rid of mtk_smi_larb_get/put
> >    drm/mediatek: Get rid of mtk_smi_larb_get/put
> >    media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
> >    memory: mtk-smi: Get rid of mtk_smi_larb_get/put
> >    arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
> >    arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes
> > 
> > Yongqiang Niu (1):
> >    drm/mediatek: Add pm runtime support for ovl and rdma
> > 
> >   .../display/mediatek/mediatek,disp.txt        |  9 ----
> >   .../bindings/media/mediatek-jpeg-decoder.yaml |  9 ----
> >   .../bindings/media/mediatek-jpeg-encoder.yaml |  9 ----
> >   .../bindings/media/mediatek-mdp.txt           |  8 ----
> >   .../bindings/media/mediatek-vcodec.txt        |  4 --
> >   arch/arm/boot/dts/mt2701.dtsi                 |  2 -
> >   arch/arm/boot/dts/mt7623n.dtsi                |  5 --
> >   arch/arm64/boot/dts/mediatek/mt8173.dtsi      | 16 -------
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  6 ---
> >   drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  9 +++-
> >   drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  9 +++-
> >   drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 19 ++++----
> >   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   | 36 +--------------
> >   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  1 -
> >   drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  5 +-
> >   drivers/iommu/mtk_iommu.c                     | 24 +++++++++-
> >   drivers/iommu/mtk_iommu_v1.c                  | 22 ++++++++-
> >   .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 45 +-----------------
> >   .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  2 -
> >   drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 46 +------------------
> >   drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 -
> >   drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
> >   .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 ++-------------
> >   .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
> >   .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
> >   .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 44 ++----------------
> >   drivers/memory/mtk-smi.c                      | 14 ------
> >   include/soc/mediatek/smi.h                    | 20 --------
> >   28 files changed, 85 insertions(+), 323 deletions(-)
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
