Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C2C433E3
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 06:53:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2722020663
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 06:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P6yD1jK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2722020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D88948954E;
	Mon, 13 Jul 2020 06:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ttEQeQwgzvKu; Mon, 13 Jul 2020 06:53:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 30A2789531;
	Mon, 13 Jul 2020 06:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F15C0C0894;
	Mon, 13 Jul 2020 06:53:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 404F8C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 06:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 276B0871C3
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 06:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZ7iomJ_M7AY for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 06:53:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4E574871C1
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 06:53:00 +0000 (UTC)
X-UUID: 582f5c57478b4a80bcb48956f6a3a476-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=/O8b95ILqstFIgFUi/t1yv/IWDQZ/y0hmoi2/61jPNE=; 
 b=P6yD1jK/2TDrIjPFxMR0YTBlV+IWP8ekI2X4Si87kWwy8oy/33u2LEzKrj7pedVwr5n1XENvFYUtYyOwil+PyKKeAatWnY20L8vmIKwdUe6NTvxiFh4hx6TwfJy1LJnOjPJCrn+I4cH8PfpQEDJQCid/yI0FPuZAbsI75MnT1sk=;
X-UUID: 582f5c57478b4a80bcb48956f6a3a476-20200713
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1774102177; Mon, 13 Jul 2020 14:52:56 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 13 Jul 2020 14:52:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 14:52:54 +0800
Message-ID: <1594623128.16172.27.camel@mhfsdcap03>
Subject: Re: [PATCH 06/21] iommu/io-pgtable-arm-v7s: Use ias to check the
 valid iova in unmap
From: Yong Wu <yong.wu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Date: Mon, 13 Jul 2020 14:52:08 +0800
In-Reply-To: <CANMq1KAhFCWfywV=OiHgW00pof8K8TdwC6Hzgyj=QWSiWBf1ag@mail.gmail.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-7-yong.wu@mediatek.com>
 <CANMq1KAhFCWfywV=OiHgW00pof8K8TdwC6Hzgyj=QWSiWBf1ag@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F3CF35EF42678060759801117619B4C940E2D810BF19205DF4368001F842ACB22000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, Devicetree List <devicetree@vger.kernel.org>,
 cui.zhang@mediatek.com, srv_heupstream <srv_heupstream@mediatek.com>,
 chao.hao@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 lkml <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
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

On Mon, 2020-07-13 at 08:38 +0800, Nicolas Boichat wrote:
> On Sat, Jul 11, 2020 at 2:50 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > As title.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 4272fe4e17f4..01f2a8876808 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -717,7 +717,7 @@ static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> >  {
> >         struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
> >
> > -       if (WARN_ON(upper_32_bits(iova)))
> > +       if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
> 
> This is a little odd as iova is unsigned long and 1ULL is unsigned long long.
> 
> Would it be better to keep the spirit of the previous test and do
> something like:
>  if (WARN_ON(iova >> data->iop.cfg.ias)) ?

Yes. Thanks. I will change it like this in next version.

Also change this in arm_v7s_map by the way.

> 
> >                 return 0;
> >
> >         return __arm_v7s_unmap(data, gather, iova, size, 1, data->pgd);
> > --
> > 2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
