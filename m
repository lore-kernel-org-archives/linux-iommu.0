Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11173C433B4
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 12:34:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CDE613CA
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 12:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CDE613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6CE782D12;
	Wed, 12 May 2021 12:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2lNlw9YtrxK; Wed, 12 May 2021 12:34:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7221B82D0F;
	Wed, 12 May 2021 12:34:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47A73C000D;
	Wed, 12 May 2021 12:34:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B29E5C0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 12:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7195760A8A
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 12:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c4hga-2-hGGc for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 12:34:22 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EC6760A7B
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 12:34:21 +0000 (UTC)
X-UUID: 56acb10324ea40e2bea1352a797416fa-20210512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=ewPs1Oa6a3lyJ4v/+R+Na+4N5EnjMReDZVRwjMtKeis=; 
 b=ewEoqOKvSAWVqKqd0u9hldRL4upWs4M/EifpIJ8EQaXDgkQ3tFEDnplJWcc44suitQcRVH3My30OOlv9FVrLYXvY5Mmt5Wqwo4vJJRN/nqjCvKEWg4bzO6izgAZi/BpIqHHp4e4b1//axLcRhg4In1omHMg+L8VZUrmmL5Q0Ulg=;
X-UUID: 56acb10324ea40e2bea1352a797416fa-20210512
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 172632164; Wed, 12 May 2021 20:29:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 12 May 2021 20:29:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 May 2021 20:29:07 +0800
Message-ID: <1620822547.2983.8.camel@mhfsdcap03>
Subject: Re: [PATCH v5 13/16] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
From: Yong Wu <yong.wu@mediatek.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 12 May 2021 20:29:07 +0800
In-Reply-To: <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-14-yong.wu@mediatek.com>
 <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7780E5B9D2712AB2AE1806AA941E22A5D94145B0E8BDFD93F8EBEB7BFDD94F3E2000:8
X-MTK: N
Cc: Will Deacon <will.deacon@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 youlin.pei@mediatek.com, Irui Wang <irui.wang@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
 Devicetree List <devicetree@vger.kernel.org>, yi.kuo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, "moderated
 list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
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

On Wed, 2021-05-12 at 17:20 +0800, Hsin-Yi Wang wrote:
> On Sat, Apr 10, 2021 at 5:14 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > MediaTek IOMMU has already added the device_link between the consumer
> > and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
> > the smi-larb's pm_runtime_get_sync also be called automatically.
> >
> > CC: Tiffany Lin <tiffany.lin@mediatek.com>
> > CC: Irui Wang <irui.wang@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> > ---
> >  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 ++-------------
> >  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
> >  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
> >  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 46 ++-----------------
> >  4 files changed, 10 insertions(+), 77 deletions(-)

[...]

> > @@ -108,13 +80,6 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
> >                 }
> >         }
> >
> > -       ret = mtk_smi_larb_get(pm->larbvenc);
> > -       if (ret) {
> > -               mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
> > -               goto clkerr;
> > -       }
> > -       return;
> 
> You can't delete the return; here, otherwise vcodec_clk will be turned
> off immediately after they are turned on.

Thanks very much for your review.

Sorry for this. You are quite right.

I checked this, it was introduced in v4 when I rebase the code. I will
fix it in next time.

> 
> > -
> >  clkerr:
> >         for (i -= 1; i >= 0; i--)
> >                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
> > @@ -125,7 +90,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
> >         struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
> >         int i = 0;
> >
> > -       mtk_smi_larb_put(pm->larbvenc);
> >         for (i = enc_clk->clk_num - 1; i >= 0; i--)
> >                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
> >  }
> > --
> > 2.18.0
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
