Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C78C63793
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:38:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BD261279
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 06:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BD261279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F066F828F8;
	Thu, 22 Jul 2021 06:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZMBP4n3-NVp0; Thu, 22 Jul 2021 06:38:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B149F82670;
	Thu, 22 Jul 2021 06:38:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 651B7C001A;
	Thu, 22 Jul 2021 06:38:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC5EBC000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F86140253
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBK0TW0Rzww7 for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:38:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B0B540221
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 06:38:26 +0000 (UTC)
X-UUID: a1ef19bdfe614e53811cdbc983ebc4ad-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=oaxYxn3IILWuJbREf8SCmDPb7cFpjJSu+Lb7BiUbx7g=; 
 b=XysRMbWJ8wjQ0Y3UXTNNFa/3mPg/H/hhOL1RrKpA3cZspA0ZB1jUfflXXqC2ToTCCZBkCoqqieXJFH7o0jkRBYdv14RQpeYSXiknWg1xTAHWWgwESewWoIVZKBADmI8S2Z4jUgVgsOpEeO9rW81EdFw5UbdE0AXRHYcEE37HDnY=;
X-UUID: a1ef19bdfe614e53811cdbc983ebc4ad-20210722
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 407174073; Thu, 22 Jul 2021 14:38:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 22 Jul 2021 14:38:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 14:38:14 +0800
Message-ID: <1626935894.27875.6.camel@mhfsdcap03>
Subject: Re: [PATCH v2 07/11] memory: mtk-smi: Add smi sub common support
From: Yong Wu <yong.wu@mediatek.com>
To: Ikjoon Jang <ikjn@chromium.org>
Date: Thu, 22 Jul 2021 14:38:14 +0800
In-Reply-To: <CAATdQgBDsPHcuPYd=a+fjjTuqwXdJ-1GuSkj47cH1Ju5geqSLg@mail.gmail.com>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-8-yong.wu@mediatek.com>
 <CAATdQgBDsPHcuPYd=a+fjjTuqwXdJ-1GuSkj47cH1Ju5geqSLg@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8C9462D89BEED59F465508FE8E285B0DAFEB43CE951A7B5CDA310B4B06BC23302000:8
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

Hi Ikjoon,

Thanks very much for your help reviewing..

On Wed, 2021-07-21 at 19:43 +0800, Ikjoon Jang wrote:
> On Thu, Jul 15, 2021 at 8:25 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > In mt8195, there are some larbs connect with the smi-sub-common, then
> > connect with smi-common.
> 
> Not critical but I suggest to describe what is smi-sub-common.
> e.g. "some larbs are not directly connected to smi-common,
> they are connected to smi-sub-common which is a bridge(?) interface to..."

OK. I will add some brief description about this sub-common in next
version.

> 
> >
> > Before we create device link between smi-larb with smi-common. If we have
> > sub-common, we should use device link the smi-larb and smi-sub-common,
> > then use device link between the smi-sub-common with smi-common. This is
> > for enabling clock/power automatically.
> >
> > Move the device link code to a new interface for reusing.
> >
> > There is no SW extra setting for smi-sub-common.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

Thanks.

> 
> > ---
> >  drivers/memory/mtk-smi.c | 75 +++++++++++++++++++++++++++-------------
> >  1 file changed, 51 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index e68cbb51dd12..ee49bb50f5f5 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -60,7 +60,8 @@

[snip..]

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
