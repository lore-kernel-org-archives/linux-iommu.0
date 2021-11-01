Return-Path: <SRS0=fO5g=PU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2465C433F5
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 06:09:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6989660231
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 06:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6989660231
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ADEF80C7E;
	Mon,  1 Nov 2021 06:09:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VeO5lRF-KOzn; Mon,  1 Nov 2021 06:09:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA32580C66;
	Mon,  1 Nov 2021 06:09:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0FB5C0019;
	Mon,  1 Nov 2021 06:09:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61C70C000E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 06:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CA174016B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 06:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z02mX7IIT9ja for <iommu@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 06:09:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 277A14015E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 06:09:20 +0000 (UTC)
X-UUID: 42d66bd2313546df99e5b8fda1e34e51-20211101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=xVKTQc7OPGqCgUqaW4iGQjm4T5FKiIv77uCXhzrHMa4=; 
 b=CRD3SrYzD9KnCvotD60fVLwRPs3gABLwpazhe5BwqAmJyFapMvlYpLvVOGELXnh6zrk+lwEdVzAjoyzad/Lh9QX5ulwJQj9r82SYlNWBeTTS1GfRXcodE2LuyXlqO/NI7Rexm1xpFprvhmMzohJuaFaDLDI1/SBfYa/zfPHdaJw=;
X-UUID: 42d66bd2313546df99e5b8fda1e34e51-20211101
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 902528883; Mon, 01 Nov 2021 14:09:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 1 Nov 2021 14:09:15 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Nov 2021 14:09:14 +0800
Message-ID: <9e4f327511fd85ba8613ec27644fbc29bc4ddb6b.camel@mediatek.com>
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Mon, 1 Nov 2021 14:09:14 +0800
In-Reply-To: <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
References: <20211028055056.26378-1-yong.wu@mediatek.com>
 <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias
 Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 yi.kuo@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Ikjoon Jang <ikjn@chromium.org>, linux-arm-kernel@lists.infradead.org
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

On Fri, 2021-10-29 at 19:35 +0200, Krzysztof Kozlowski wrote:
> On 28/10/2021 07:50, Yong Wu wrote:
> > We add the ostd setting for mt8195. It introduces a abort for the
> > previous SoC which doesn't have ostd setting. This is the log:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000000000080
> > ...
> > pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> > lr : mtk_smi_larb_resume+0x54/0x98
> > ...
> > Call trace:
> >  mtk_smi_larb_config_port_gen2_general+0x64/0x130
> >  pm_generic_runtime_resume+0x2c/0x48
> >  __genpd_runtime_resume+0x30/0xa8
> >  genpd_runtime_resume+0x94/0x2c8
> >  __rpm_callback+0x44/0x150
> >  rpm_callback+0x6c/0x78
> >  rpm_resume+0x310/0x558
> >  __pm_runtime_resume+0x3c/0x88
> > 
> > In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> > if "larb->larb_gen->ostd" is null, the "larbostd" is the offset, it
> > is
> > also a valid value, thus, use the larb->larb_gen->ostd as the
> > condition
> > inside the "for" loop.
> 
> You need to write more clearly, what you are fixing here.
> 
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > Hi Krzysztof,
> > Could you help review and conside this as a fix for the mt8195
> > patchset?
> > The mt8195 patchset are not in mainline, thus, I don't know its
> > sha-id,
> > and don't add Fixes tag.
> > Thanks
> > ---
> >  drivers/memory/mtk-smi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index b883dcc0bbfa..0262a59a2d6e 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -257,7 +257,7 @@ static void
> > mtk_smi_larb_config_port_gen2_general(struct device *dev)
> >  	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
> >  		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base +
> > SMI_LARB_SW_FLAG);
> >  
> > -	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd &&
> > !!larbostd[i]; i++)
> > +	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen->ostd &&
> > !!larbostd[i]; i++)
> >  		writel_relaxed(larbostd[i], larb->base +
> > SMI_LARB_OSTDL_PORTx(i));
> 
> The code does not look good. You have already a dereference at line
> 244:
> 
> 	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];

if larb->larb_gen->ostd is null, larbostd is the offset, e.g. 0x80 in
the log above. thus, we can not use "larbostd[i]" in the "for" loop.

sorry for the unreadable. In this case, is the change ok?

or like this:

-const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
+const u8 *larbostd = larb->larb_gen->ostd ? larb->larb_gen-ostd[larb-
>larbid] : NULL;

or add a explicit "if":
 if (larb->larb_gen->ostd)
   larbostd = xxx.

Which one do you prefer?

Thanks.

> 
> You are not fixing the NULL pointer dereference.
> 
> >  
> >  	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> > 
> 
> 
> Best regards,
> Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
