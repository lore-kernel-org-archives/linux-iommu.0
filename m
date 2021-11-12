Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5666C433F5
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 01:17:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F9761247
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 01:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61F9761247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D1034054A;
	Fri, 12 Nov 2021 01:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gsem8NxVXeKC; Fri, 12 Nov 2021 01:17:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C13B40549;
	Fri, 12 Nov 2021 01:17:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9008C0019;
	Fri, 12 Nov 2021 01:17:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7F87C000E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 01:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C1F781D11
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 01:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new); dkim=neutral
 reason="invalid (public key: DNS error: SERVFAIL)"
 header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2XRM6Xy8OW0 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 01:17:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54C5181C46
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 01:17:37 +0000 (UTC)
X-UUID: 8bef31ca734f4c7db15d5148442fd4cd-20211112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=J89u8ajOE7RnIe0Hf+cMtrKrCMlq2XyJUXaOQVwayHQ=; 
 b=L3B38oRthqNSBzsV/ntQFDtKu8+u2+Usm+oFm+a8yw8z4Dg4QCEZS4nA02StJMQVK3bKby7dmZBOV+QCInQEm02ONMg+jaRgQ7DcHLdjyJatXuxycBJ965eCd2Eb1qYvdPRbPhIbwlaNlWUcNT2BzB8jv8F1bPBuhGU90RLPyjo=;
X-UUID: 8bef31ca734f4c7db15d5148442fd4cd-20211112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 824726951; Fri, 12 Nov 2021 09:17:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 12 Nov 2021 09:17:29 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 09:17:28 +0800
Message-ID: <36653ae5c1e1babe314eabf070f3220a603d55c7.camel@mediatek.com>
Subject: Re: [PATCH v2] memory: mtk-smi: Fix a null dereference for the ostd
From: Yong Wu <yong.wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Fri, 12 Nov 2021 09:17:28 +0800
In-Reply-To: <1d72bac8-eb79-6f34-79ca-4c5c38d6d2bf@collabora.com>
References: <20211108082429.15080-1-yong.wu@mediatek.com>
 <1d72bac8-eb79-6f34-79ca-4c5c38d6d2bf@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
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

Hi AngeloGioacchino,

Thanks very much for your help review.

On Thu, 2021-11-11 at 14:41 +0100, AngeloGioacchino Del Regno wrote:
> Il 08/11/21 09:24, Yong Wu ha scritto:
> > We add the ostd setting for mt8195. It introduces a KE for the
> > previous SoC which doesn't have ostd setting. This is the log:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000000000080
> > ...
> > pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> > lr : mtk_smi_larb_resume+0x54/0x98
> > ...
> > Call trace:
> >   mtk_smi_larb_config_port_gen2_general+0x64/0x130
> >   pm_generic_runtime_resume+0x2c/0x48
> >   __genpd_runtime_resume+0x30/0xa8
> >   genpd_runtime_resume+0x94/0x2c8
> >   __rpm_callback+0x44/0x150
> >   rpm_callback+0x6c/0x78
> >   rpm_resume+0x310/0x558
> >   __pm_runtime_resume+0x3c/0x88
> > 
> > In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> > if "larb->larb_gen->ostd" is null, the "larbostd" is the
> > offset(e.g.
> > 0x80 above), it's also a valid value, then accessing "larbostd[i]"
> > in the
> > "for" loop will cause the KE above. To avoid this issue, initialize
> > "larbostd" to NULL when the SoC doesn't have ostd setting.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > change note: Reword the commit message to show why it KE. and
> > update the
> > solution via initializing "larbostd" is NULL explicitly in the non-
> > ostd
> > case.
> > ---
> >   drivers/memory/mtk-smi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> This commit needs a Fixes tag. Please add the proper one.

This should fix this one:

fe6dd2a4017d ("memory: mtk-smi: mt8195: Add initial setting for smi-
larb")

But the commit id comes from linux-next. I'm not sure if the sha-id
will be changed again when enter mainline. so I didn't add it.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
