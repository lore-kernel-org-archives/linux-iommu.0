Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A7C76190
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 02:37:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDF322389
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 02:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDF322389
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 392C2C7C;
	Tue, 23 Jul 2019 02:37:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 92DA2C75
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 02:36:59 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A14FF102
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 02:36:58 +0000 (UTC)
X-UUID: 6bcc48428b9048dda51d398fa812f6a7-20190723
X-UUID: 6bcc48428b9048dda51d398fa812f6a7-20190723
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(mhqrelay.mediatek.com ESMTP with TLS)
	with ESMTP id 2016696171; Tue, 23 Jul 2019 10:31:51 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
	mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Tue, 23 Jul 2019 10:31:49 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Tue, 23 Jul 2019 10:31:49 +0800
Message-ID: <1563849109.27558.14.camel@mtksdaap41>
Subject: Re: [PATCH v2 00/12] Clean up "mediatek,larb" after adding device_link
From: CK Hu <ck.hu@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>
Date: Tue, 23 Jul 2019 10:31:49 +0800
In-Reply-To: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi, Yong:

I've added log  in mtk_smi_clk_enable() and mtk_smi_clk_disable(), and I
boot MT8183 with display, the log is

[    4.020340] mtk-smi-common 14019000.smi: mtk_smi_clk_enable()
[    4.331371] mtk-smi-common 14019000.smi: mtk_smi_clk_disable()
[    4.429578] mtk-smi-common 14019000.smi: mtk_smi_clk_enable()
[    4.719743] mtk-smi-common 14019000.smi: mtk_smi_clk_disable()
[    5.084770] mtk-smi-common 14019000.smi: mtk_smi_clk_enable()
[    5.904310] mtk-smi-common 14019000.smi: mtk_smi_clk_disable()

From the log, the clock is finally turned off, but the display works
normally. This is because scpsys has turn the clock on,

		scpsys: syscon@10006000 {
			compatible = "mediatek,mt8183-scpsys", "syscon";
			#power-domain-cells = <1>;
			reg = <0 0x10006000 0 0x1000>;
			clocks = <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
				 <&mmsys CLK_MM_SMI_COMMON>,
				 <&mmsys CLK_MM_GALS_COMM0>,
				 <&mmsys CLK_MM_GALS_COMM1>,
			clock-names = "audio","mm-0",
				      "mm-1", "mm-2";
		}

I'm worried that for MT8173, scpsys would not turn on subsys clock, this
series would let display work abnormally, so I think smi common should
not depend on scpsys to turn on the clock.

You could simply remove the clock parameter in scpsys device node, and
you would see the display works abnormally.

Regards,
CK


On Mon, 2019-06-10 at 20:55 +0800, Yong Wu wrote:
> MediaTek IOMMU block diagram always like below:
> 
>         M4U
>          |
>     smi-common
>          |
>   -------------
>   |         |  ...
>   |         |
> larb1     larb2
>   |         |
> vdec       venc
> 
> All the consumer connect with smi-larb, then connect with smi-common.
> 
> MediaTek IOMMU don't have its power-domain. When the consumer works,
> it should enable the smi-larb's power which also need enable the smi-common's
> power firstly.
> 
> Thus, Firstly, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
> 
> After adding the device_link, then "mediatek,larb" property can be removed.
> the iommu consumer don't need call the mtk_smi_larb_get/put to enable
> the power and clock of smi-larb and smi-common.
> 
> This patchset depends on "MT8183 IOMMU SUPPORT"[1].
> 
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2019-June/036552.html
> 
> Change notes:
> v2:
>    1) rebase on v5.2-rc1.
>    2) Move adding device_link between the consumer and smi-larb into
> iommu_add_device from Robin.
>    3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
>    4) Remove the shutdown callback in iommu.   
> 
> v1: https://lists.linuxfoundation.org/pipermail/iommu/2019-January/032387.html
> 
> Yong Wu (12):
>   dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
>   iommu/mediatek: Add probe_defer for smi-larb
>   iommu/mediatek: Add device_link between the consumer and the larb
>     devices
>   memory: mtk-smi: Add device-link between smi-larb and smi-common
>   media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
>   media: mtk-mdp: Get rid of mtk_smi_larb_get/put
>   media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
>   drm/mediatek: Get rid of mtk_smi_larb_get/put
>   memory: mtk-smi: Get rid of mtk_smi_larb_get/put
>   iommu/mediatek: Use builtin_platform_driver
>   arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
>   arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes
> 
>  .../bindings/display/mediatek/mediatek,disp.txt    |  9 -----
>  .../bindings/media/mediatek-jpeg-decoder.txt       |  4 --
>  .../devicetree/bindings/media/mediatek-mdp.txt     |  8 ----
>  .../devicetree/bindings/media/mediatek-vcodec.txt  |  4 --
>  arch/arm/boot/dts/mt2701.dtsi                      |  1 -
>  arch/arm/boot/dts/mt7623.dtsi                      |  1 -
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 15 -------
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 11 -----
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        | 26 ------------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  1 -
>  drivers/iommu/mtk_iommu.c                          | 45 +++++++--------------
>  drivers/iommu/mtk_iommu_v1.c                       | 39 +++++++-----------
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    | 22 ----------
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h    |  2 -
>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c      | 38 -----------------
>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.h      |  2 -
>  drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |  1 -
>  .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  | 21 ----------
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  3 --
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  1 -
>  .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 47 ----------------------
>  drivers/memory/mtk-smi.c                           | 31 ++++----------
>  include/soc/mediatek/smi.h                         | 20 ---------
>  23 files changed, 36 insertions(+), 316 deletions(-)
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
