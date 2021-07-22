Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57F9C6377D
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:38:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BFF6127C
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BFF6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26CDB60633;
	Thu, 22 Jul 2021 06:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pBlANb3qx9jw; Thu, 22 Jul 2021 06:38:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 190B960AD3;
	Thu, 22 Jul 2021 06:38:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE748C001A;
	Thu, 22 Jul 2021 06:38:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62439C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 522108294A
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNYDKiKJY5Yh for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:38:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B4AA828F8
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:44 +0000 (UTC)
X-UUID: 9c7c97a1869a4b10bdc9567cbf05ab5a-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=W5iu4yn7qNOz8O4L5niY76z7dUrVPoTbT38cQYHyaGE=; 
 b=BsWI1Hd7SbxRaMAXdov9QsxTyPV6BzFs5VDH04IK0r9b4xYMEQpeb/vN2AmR5j7uxy9TYCKZ9jPCOSnt9uOhcZ98l2E/7n7c5YdAC7OU6A02CyIePAqWmBIbSwimgy3uay0fgp8cINwZA91z3s2kul1rkciS2RWIi7VYlkcitB8=;
X-UUID: 9c7c97a1869a4b10bdc9567cbf05ab5a-20210722
Received: from mtkmrs31.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1951434667; Thu, 22 Jul 2021 14:38:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 22 Jul 2021 14:38:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 14:38:33 +0800
Message-ID: <1626935913.27875.8.camel@mhfsdcap03>
Subject: Re: [PATCH v2 10/11] memory: mtk-smi: mt8195: Add initial setting
 for smi-common
From: Yong Wu <yong.wu@mediatek.com>
To: Ikjoon Jang <ikjn@chromium.org>
Date: Thu, 22 Jul 2021 14:38:33 +0800
In-Reply-To: <CAATdQgDOGW7nudDoR5UPbax+d3e9omhPstrNd_FCPLd+96ZC9w@mail.gmail.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-11-yong.wu@mediatek.com>
 <CAATdQgDOGW7nudDoR5UPbax+d3e9omhPstrNd_FCPLd+96ZC9w@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 09C7E65E6584ADFA42B61DD670F9B1049F10F210E285069CFBA433B0E7C4F5862000:8
X-MTK: N
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, yi.kuo@mediatek.com,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, "moderated list:ARM/Mediatek SoC support"
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

On Wed, 2021-07-21 at 20:54 +0800, Ikjoon Jang wrote:
> On Thu, Jul 15, 2021 at 8:25 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > To improve the performance, add initial setting for smi-common.
> > some register use some fix setting(suggested from DE).
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 42 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 38 insertions(+), 4 deletions(-)

[...]

> >  static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
> > @@ -530,15 +558,21 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
> >  static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> >  {
> >         struct mtk_smi *common = dev_get_drvdata(dev);
> > -       u32 bus_sel = common->plat->bus_sel;
> > -       int ret;
> > +       const struct mtk_smi_reg_pair *init = common->plat->init;
> > +       u32 bus_sel = common->plat->bus_sel; /* default is 0 */
> > +       int ret, i;
> >
> >         ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
> >         if (ret)
> >                 return ret;
> >
> > -       if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
> > -               writel(bus_sel, common->base + SMI_BUS_SEL);
> > +       if (common->plat->type != MTK_SMI_GEN2)
> > +               return 0;
> > +
> > +       for (i = 0; i < SMI_COMMON_INIT_REGS_NR && init && init[i].offset; i++)
> > +               writel_relaxed(init[i].value, common->base + init[i].offset);
> 
> I'm not sure this array for register settings could be applied to other
> platforms in future or only applied to mt8195. If it's only for mt8195,

The other platforms have the nearly same setting.

> I think taking callback function instead of mtk_smi_reg_pair[] as init member
> would be better:
> 
> if (common->plat->init)
>     common->plat->init(...);
> 
> > +
> > +       writel(bus_sel, common->base + SMI_BUS_SEL);
> >         return 0;
> >  }
> >
> > --
> > 2.18.0
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
