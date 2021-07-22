Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626B0C63793
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:38:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2901F6127C
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2901F6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9F8140168;
	Thu, 22 Jul 2021 06:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etdgfRjIfoE9; Thu, 22 Jul 2021 06:38:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D62EB400C2;
	Thu, 22 Jul 2021 06:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAF3EC001A;
	Thu, 22 Jul 2021 06:38:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F652C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E747828F8
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GIJtza0ITSwS for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:38:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F37F82670
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:33 +0000 (UTC)
X-UUID: ea3b0ad1d7ae491e9e3dbd38de65456e-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=E0/21i/rjqYJSvlRFf3hf7vSNWScyQPpeAG8uBlbP3o=; 
 b=AzDdA2JmY3JXcQjf4KRlTgeOVef8J0NRQ3sCNkds955AhMpRPyKxdWAhlLsv2RR1Soao421TCNDa6m/3HxVde2JN8NhwO/j2H6bjU8xgSbLame2sHJLVCQlfJ90zMzYmDqDsl4y9RRKw383zRBumVdSWM6JEaeqUSsvGykRM+To=;
X-UUID: ea3b0ad1d7ae491e9e3dbd38de65456e-20210722
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 715036884; Thu, 22 Jul 2021 14:38:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs07n1.mediatek.inc
 (172.21.101.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 22 Jul 2021 14:38:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 14:38:22 +0800
Message-ID: <1626935902.27875.7.camel@mhfsdcap03>
Subject: Re: [PATCH v2 11/11] memory: mtk-smi: mt8195: Add initial setting
 for smi-larb
From: Yong Wu <yong.wu@mediatek.com>
To: Ikjoon Jang <ikjn@chromium.org>
Date: Thu, 22 Jul 2021 14:38:22 +0800
In-Reply-To: <CAATdQgAfo9oNR5=ogEottHajODngi1ahvKUnEOUczzjreYpPcQ@mail.gmail.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-12-yong.wu@mediatek.com>
 <CAATdQgAfo9oNR5=ogEottHajODngi1ahvKUnEOUczzjreYpPcQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

On Wed, 2021-07-21 at 21:40 +0800, Ikjoon Jang wrote:
> On Thu, Jul 15, 2021 at 8:23 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > To improve the performance, We add some initial setting for smi larbs.
> > there are two part:
> > 1), Each port has the special ostd(outstanding) value in each larb.
> > 2), Two general setting for each larb.
> >
> > In some SoC, this setting maybe changed dynamically for some special case
> > like 4K, and this initial setting is enough in mt8195.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
[...]
> >  struct mtk_smi {
> > @@ -213,12 +228,22 @@ static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> >  static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> >  {
> >         struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > -       u32 reg;
> > +       u32 reg, flags_general = larb->larb_gen->flags_general;
> > +       const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> >         int i;
> >
> >         if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
> >                 return;
> >
> > +       if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_THRT_EN))
> > +               writel_relaxed(SMI_LARB_THRT_EN, larb->base + SMI_LARB_CMD_THRT_CON);
> > +
> > +       if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_SW_FLAG))
> > +               writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
> > +
> > +       for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
> > +               writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));
> 
> All other mtk platform's larbs have the same format for SMI_LARB_OSTDL_PORTx()
> registers at the same offset? or is this unique feature for mt8195?

All the other Platform's larbs have the same format at the same offset.

> 
> > +
> >         for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> >                 reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
> >                 reg |= F_MMU_EN;
> > @@ -227,6 +252,51 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> >         }
> >  }
> >

[...]

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
