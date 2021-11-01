Return-Path: <SRS0=fO5g=PU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3DEC433EF
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 10:41:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0672960524
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 10:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0672960524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF107401D6;
	Mon,  1 Nov 2021 10:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRTKGQUpxzmE; Mon,  1 Nov 2021 10:41:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2730640010;
	Mon,  1 Nov 2021 10:41:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C7EAC0019;
	Mon,  1 Nov 2021 10:41:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6485C000E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 10:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8795C60592
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 10:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MeX9Ty4lCu3W for <iommu@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 10:41:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9076660591
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 10:41:01 +0000 (UTC)
X-UUID: 66bb92f5f0c74b52954d9f3d793eb446-20211101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=0yNRMy91uWzpVLqngjuJ072kcSyVfPnPyUeqGNc4EY0=; 
 b=XmxLfBfMTgKVUbsXbSZ52y2ZhsMdHCrO5NS23ZQDEa8JI/mphaIc08rVKsaE/vmTlawY+C8zQltUz9zPR//ZABAZbq2uXvkF+I0ZXBd2LBnBcilDgAZTTIzsxl1lxXDudS7pv82NdmfAq6ic745mnDVh4ksXrAYzQHteZKnr564=;
X-UUID: 66bb92f5f0c74b52954d9f3d793eb446-20211101
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 276154276; Mon, 01 Nov 2021 18:40:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Mon, 1 Nov 2021 18:40:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 1 Nov 2021 18:40:55 +0800
Message-ID: <45cc8d0e25bdb73d8262f59166cac6ea3c80770b.camel@mediatek.com>
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Mon, 1 Nov 2021 18:40:53 +0800
In-Reply-To: <82835e3d-11a3-32e4-0782-d827a5e3d78e@canonical.com>
References: <20211028055056.26378-1-yong.wu@mediatek.com>
 <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
 <9e4f327511fd85ba8613ec27644fbc29bc4ddb6b.camel@mediatek.com>
 <82835e3d-11a3-32e4-0782-d827a5e3d78e@canonical.com>
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

On Mon, 2021-11-01 at 09:45 +0100, Krzysztof Kozlowski wrote:
> On 01/11/2021 07:09, Yong Wu wrote:
> > On Fri, 2021-10-29 at 19:35 +0200, Krzysztof Kozlowski wrote:
> > > On 28/10/2021 07:50, Yong Wu wrote:
> > > > We add the ostd setting for mt8195. It introduces a abort for
> > > > the
> > > > previous SoC which doesn't have ostd setting. This is the log:
> > > > 
> > > > Unable to handle kernel NULL pointer dereference at virtual
> > > > address
> > > > 0000000000000080
> > > > ...
> > > > pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> > > > lr : mtk_smi_larb_resume+0x54/0x98
> > > > ...
> > > > Call trace:
> > > >  mtk_smi_larb_config_port_gen2_general+0x64/0x130
> > > >  pm_generic_runtime_resume+0x2c/0x48
> > > >  __genpd_runtime_resume+0x30/0xa8
> > > >  genpd_runtime_resume+0x94/0x2c8
> > > >  __rpm_callback+0x44/0x150
> > > >  rpm_callback+0x6c/0x78
> > > >  rpm_resume+0x310/0x558
> > > >  __pm_runtime_resume+0x3c/0x88
> > > > 
> > > > In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> > > > if "larb->larb_gen->ostd" is null, the "larbostd" is the
> > > > offset, it
> > > > is
> > > > also a valid value, thus, use the larb->larb_gen->ostd as the
> > > > condition
> > > > inside the "for" loop.
> > > 
> > > You need to write more clearly, what you are fixing here.
> > > 
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > > Hi Krzysztof,
> > > > Could you help review and conside this as a fix for the mt8195
> > > > patchset?
> > > > The mt8195 patchset are not in mainline, thus, I don't know its
> > > > sha-id,
> > > > and don't add Fixes tag.
> > > > Thanks
> > > > ---
> > > >  drivers/memory/mtk-smi.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-
> > > > smi.c
> > > > index b883dcc0bbfa..0262a59a2d6e 100644
> > > > --- a/drivers/memory/mtk-smi.c
> > > > +++ b/drivers/memory/mtk-smi.c
> > > > @@ -257,7 +257,7 @@ static void
> > > > mtk_smi_larb_config_port_gen2_general(struct device *dev)
> > > >  	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
> > > >  		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base +
> > > > SMI_LARB_SW_FLAG);
> > > >  
> > > > -	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd &&
> > > > !!larbostd[i]; i++)
> > > > +	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen-
> > > > >ostd &&
> > > > !!larbostd[i]; i++)
> > > >  		writel_relaxed(larbostd[i], larb->base +
> > > > SMI_LARB_OSTDL_PORTx(i));
> > > 
> > > The code does not look good. You have already a dereference at
> > > line
> > > 244:
> > > 
> > > 	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> > 
> > if larb->larb_gen->ostd is null, larbostd is the offset, e.g. 0x80
> > in
> > the log above. thus, we can not use "larbostd[i]" in the "for"
> > loop.
> > 
> > sorry for the unreadable. In this case, is the change ok?
> 
> No, it's ok, I did not check the type of ostd and it's confusing a
> bit
> that it is defined as a pointer to an array but you actually use it
> as
> array of pointers to 32-elemenet arrays... Anyway I was mistaken and
> there will be indeed no dereference at the assignment, but for code
> clarity I would still prefer to do the check earlier, so:
> 
> > 
> > or like this:
> > 
> > -const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> > +const u8 *larbostd = larb->larb_gen->ostd ? larb->larb_gen-
> > ostd[larb-
> > > larbid] : NULL;
> 
> Although I think now the proper type should be explicit.
> mtk_smi_larb_mt8195_ostd is an 28-element array of
> SMI_LARB_PORT_NR_MAX-element u8 arrays, therefore struct
> mtk_smi_larb_gen should be:
> 	const u8 (*ostd)[][SMI_LARB_PORT_NR_MAX];

mt8195_ostd only is a 2 dimensional array,
static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX];

If using this, it will cause build fail:

.../drivers/memory/mtk-smi.c:359:23: error: initialization from
incompatible pointer type [-Werror=incompatible-pointer-types]
  .ostd              = mtk_smi_larb_mt8195_ostd,
                       ^~~~~~~~~~~~~~~~~~~~~~~~

More background about this 2 dimensional array:
The platform have many larbs(up to MTK_LARB_NR_MAX), each a larb have
many ports(up to SMI_LARB_PORT_NR_MAX). In the
function(*_config_port_gen2_general), we will update the value for each
a port inside a larb, thus we need a pointer point to the line of that
larb.

If I miss something, please tell me. or how to manage this will be
better.

Thanks.

> 
> Right?
> 
> 
> Best regards,
> Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
