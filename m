Return-Path: <SRS0=Ihqs=MD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15163C07E96
	for <iommu@archiver.kernel.org>; Sun, 11 Jul 2021 08:25:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CD661179
	for <iommu@archiver.kernel.org>; Sun, 11 Jul 2021 08:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CD661179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A7E3401B6;
	Sun, 11 Jul 2021 08:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMCdslQjBs0Q; Sun, 11 Jul 2021 08:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 88592400C3;
	Sun, 11 Jul 2021 08:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 665CBC001A;
	Sun, 11 Jul 2021 08:25:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3949C000E
 for <iommu@lists.linux-foundation.org>; Sun, 11 Jul 2021 08:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC698400F7
 for <iommu@lists.linux-foundation.org>; Sun, 11 Jul 2021 08:25:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VtzDsChY_nUQ for <iommu@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 08:24:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B113400C3
 for <iommu@lists.linux-foundation.org>; Sun, 11 Jul 2021 08:24:50 +0000 (UTC)
X-UUID: 0d2c36d8a8c24bf3ad6a7ad3e43786aa-20210711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=q0F3BMX9DhrivUfCw8fXy37GhI3a19wIIbjYly0hYiw=; 
 b=BFc3Z1+WkZUSuRj7r2D0vceekqVFDOPW6OQtLw8SUPJc6wAPt+WYWwbm4RsLNaK1UbqGXWoo3rUuS7Adjx3EN5VViSl7zGvWEwmG+090Z++JCFu4vWw/KQ3T+zDw+XlgOJt7pLafZn6hdCqd1Q0yckX37Ab0tcksKUpMbf58W/A=;
X-UUID: 0d2c36d8a8c24bf3ad6a7ad3e43786aa-20210711
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 658732960; Sun, 11 Jul 2021 16:24:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 11 Jul 2021 16:24:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Jul 2021 16:24:41 +0800
Message-ID: <1625991881.22309.9.camel@mhfsdcap03>
Subject: Re: [PATCH 1/9] dt-bindings: memory: mediatek: Add mt8195 smi binding
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Sun, 11 Jul 2021 16:24:41 +0800
In-Reply-To: <6e512d15-3acc-2097-1fd1-e021552fdc8d@canonical.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-2-yong.wu@mediatek.com>
 <6e512d15-3acc-2097-1fd1-e021552fdc8d@canonical.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 20D1DC0E5D2AB0B038420097B719AD1457E17388391A66EBA32555C39061F2FD2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, 2021-07-08 at 11:26 +0200, Krzysztof Kozlowski wrote:
> On 16/06/2021 13:43, Yong Wu wrote:
> > This patch adds mt8195 smi supporting in the bindings.
> > 
> > In mt8195, there are two smi-common HW, one is for vdo(video output),
> > the other is for vpp(video processing pipe). They connects with different
> > smi-larbs, then some setting(bus_sel) is different. Differentiate them
> > with the compatible string.
> > 
> > Something like this:
> > 
> >     IOMMU(VDO)          IOMMU(VPP)
> >        |                   |
> >   SMI_COMMON_VDO      SMI_COMMON_VPP
> >   ---------------     ----------------
> >   |      |   ...      |      |     ...
> > larb0 larb2  ...    larb1 larb3    ...
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 +++++-
> >  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 3 +++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> 
> I cannot find it on devicetree list, it seems you did not Cc it. Please
> use scripts/get_maintainer.pl.

My fault. I will add in the next version.

> 
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
