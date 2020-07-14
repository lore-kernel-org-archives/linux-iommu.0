Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44BCC433E3
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 09:33:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B6C208C3
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 09:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I0lhH+Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B6C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 30B6620364;
	Tue, 14 Jul 2020 09:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUWPO+utVFOE; Tue, 14 Jul 2020 09:33:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3B2C82014A;
	Tue, 14 Jul 2020 09:33:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D840C0891;
	Tue, 14 Jul 2020 09:33:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2F34C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 09:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DF048883D7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 09:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DJzbfh9HSH6Z for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 09:33:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C08D988384
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 09:33:53 +0000 (UTC)
X-UUID: 03cb09f6c67347d4bd174cae1c380851-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=k1s7sjnnsRye1CFdb6q0XzdF7nQsqyfBB1IhxQ2urWM=; 
 b=I0lhH+SgvmpVYRsa1E8cdyHfe2AuG/Qfq59D7x4V0Xq7oNnoXNT5Z+MVFpgFPN3M5eyulToc4tuqz1y4YHjhZwKmiBMIQG24M+WGajW4otv82ZBmBuEz3X77+92ieROMdmh3OGIh+9dXBLvgYT/4yIUnthElkq7mdi5YyidF3/Y=;
X-UUID: 03cb09f6c67347d4bd174cae1c380851-20200714
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 220981910; Tue, 14 Jul 2020 17:33:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 14 Jul 2020 17:33:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 17:33:45 +0800
Message-ID: <1594719177.16172.33.camel@mhfsdcap03>
Subject: Re: [PATCH 12/21] iommu/mediatek: Add iova reserved function
From: Yong Wu <yong.wu@mediatek.com>
To: Pi-Hsun Shih <pihsun@chromium.org>
Date: Tue, 14 Jul 2020 17:32:57 +0800
In-Reply-To: <CANdKZ0d8CSWQepCj9RFFxrvYq8K8G=oZCnskRiA3aY3gY-DD=w@mail.gmail.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-13-yong.wu@mediatek.com>
 <CANdKZ0d8CSWQepCj9RFFxrvYq8K8G=oZCnskRiA3aY3gY-DD=w@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DEC085A44EA7D3545BF3F8F5EDD48DA486042A01F90A9595EFE295D355A786BF2000:8
X-MTK: N
Cc: Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?=
 <youlin.pei@mediatek.com>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 cui.zhang@mediatek.com, Hao Chao <hao.chao@mediatek.com>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

On Mon, 2020-07-13 at 15:33 +0800, Pi-Hsun Shih wrote:
> On Sat, Jul 11, 2020 at 2:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > For multiple iommu_domains, we need to reserve some iova regions, so we
> > will add mtk_iommu_iova_region structure. It includes the base address
> > and size of the range.
> > This is a preparing patch for supporting multi-domain.
> >
> > Signed-off-by: Anan sun<anan.sun@mediatek.com>
> > Signed-off-by: Hao Chao<hao.chao@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 37 +++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/mtk_iommu.h |  5 +++++
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 03a6d66f4bef..fdfdb75706e0 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -151,6 +151,11 @@ static LIST_HEAD(m4ulist); /* List all the M4U HWs */
> > ...
> > +
> > +static void mtk_iommu_put_resv_regions(struct device *dev,
> > +                                      struct list_head *head)
> > +{
> > +       struct iommu_resv_region *entry, *next;
> > +
> > +       list_for_each_entry_safe(entry, next, head, list)
> > +               kfree(entry);
> > +}
> > +
> 
> This is the same as generic_iommu_put_resv_regions, use that as the
> .put_resv_regions callback instead?

Thanks very much for the review.

Yes. I will fix it in next version.

> 
> > ...
> > --
> > 2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
