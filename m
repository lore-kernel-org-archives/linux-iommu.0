Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D799C48BD1
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 12:02:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CB161403
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 12:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CB161403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E72D560727;
	Thu, 10 Jun 2021 12:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CYAHzByG9Iz7; Thu, 10 Jun 2021 12:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA9C76072F;
	Thu, 10 Jun 2021 12:02:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C60AFC000D;
	Thu, 10 Jun 2021 12:02:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 039A7C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 12:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2E77405ED
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 12:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LV8jWlnEnUCk for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77CC9405EE
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 12:02:13 +0000 (UTC)
X-UUID: 34cfeea152144764869170dcd899cd94-20210610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=nqdoQ9Nvfzyjq8sKsY1fXodFn06TJLmPAimZ1WxAizs=; 
 b=mF0lGPQEXi5KMZnS+yhgKQ34FvHA8Zn9gyNv2nX4/QE4Mm/dIpRI2lAWerYELTw7UTKKIQyqvrakfQnQCYHok97VaD/zYiOVxY3Jz32F+MullAflSfuqvYKEOjE8Nyb+iTYLkNW8EcbMSp+NYmziHmlYkvx2NFHDv60U75ZxKYE=;
X-UUID: 34cfeea152144764869170dcd899cd94-20210610
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1285583454; Thu, 10 Jun 2021 20:02:11 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 10 Jun 2021 20:02:09 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Jun 2021 20:02:08 +0800
Message-ID: <1623326528.23717.20.camel@mhfsdcap03>
Subject: Re: [PATCH v5 13/16] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 10 Jun 2021 20:02:08 +0800
In-Reply-To: <c1422242-8d8c-9592-c22d-288c503cd8b1@gmail.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-14-yong.wu@mediatek.com>
 <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
 <1620822547.2983.8.camel@mhfsdcap03>
 <c1422242-8d8c-9592-c22d-288c503cd8b1@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 31E46F2F90E698D9BE899FE64F40478A92B3CBEC8E1364ECF9F19623C746B6C02000:8
X-MTK: N
Cc: Will Deacon <will.deacon@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 youlin.pei@mediatek.com, Irui Wang <irui.wang@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Evan
 Green <evgreen@chromium.org>, eizan@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>, linux-media@vger.kernel.org,
 Devicetree List <devicetree@vger.kernel.org>, yi.kuo@mediatek.com, Rob
 Herring <robh+dt@kernel.org>, "moderated
 list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Hsin-Yi Wang <hsinyi@chromium.org>, ming-fan.chen@mediatek.com,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, anan.sun@mediatek.com,
 Alexandre Courbot <acourbot@chromium.org>, srv_heupstream@mediatek.com,
 lkml <linux-kernel@vger.kernel.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Thu, 2021-06-10 at 09:53 +0200, Matthias Brugger wrote:
> Hi Yong,
> 
> On 12/05/2021 14:29, Yong Wu wrote:
> > On Wed, 2021-05-12 at 17:20 +0800, Hsin-Yi Wang wrote:
> >> On Sat, Apr 10, 2021 at 5:14 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >>>
> >>> MediaTek IOMMU has already added the device_link between the consumer
> >>> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
> >>> the smi-larb's pm_runtime_get_sync also be called automatically.
> >>>
> >>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
> >>> CC: Irui Wang <irui.wang@mediatek.com>
> >>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >>> Reviewed-by: Evan Green <evgreen@chromium.org>
> >>> Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> >>> ---
> >>>  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 ++-------------
> >>>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
> >>>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
> >>>  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 46 ++-----------------
> >>>  4 files changed, 10 insertions(+), 77 deletions(-)
> > 
> > [...]
> > 
> >>> @@ -108,13 +80,6 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
> >>>                 }
> >>>         }
> >>>
> >>> -       ret = mtk_smi_larb_get(pm->larbvenc);
> >>> -       if (ret) {
> >>> -               mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
> >>> -               goto clkerr;
> >>> -       }
> >>> -       return;
> >>
> >> You can't delete the return; here, otherwise vcodec_clk will be turned
> >> off immediately after they are turned on.
> > 
> > Thanks very much for your review.
> > 
> > Sorry for this. You are quite right.
> > 
> > I checked this, it was introduced in v4 when I rebase the code. I will
> > fix it in next time.
> > 
> 
> Please also make sure that you add all maintainers. I realized that at least for
> the media/platform drivers we miss the maintainer and the corresponding mailing
> list.
> This is especially important in this series, as it spans several subsystems.

Thanks for hint. I only added the file maintainer here. I will add
linux-media in next version.

By the way, this patchset cross several trees, then which tree should it
go through. Do you have some suggestion?

> 
> Thanks a lot,
> Matthias
> 
> >>
> >>> -
> >>>  clkerr:
> >>>         for (i -= 1; i >= 0; i--)
> >>>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
> >>> @@ -125,7 +90,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
> >>>         struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
> >>>         int i = 0;
> >>>
> >>> -       mtk_smi_larb_put(pm->larbvenc);
> >>>         for (i = enc_clk->clk_num - 1; i >= 0; i--)
> >>>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
> >>>  }
> >>> --
> >>> 2.18.0
> >>>
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
