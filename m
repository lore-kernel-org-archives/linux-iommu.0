Return-Path: <SRS0=AIYf=GB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B5AC433E6
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:02:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473E420825
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473E420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9ADD5203ED;
	Tue, 29 Dec 2020 11:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGF97TMHbMqM; Tue, 29 Dec 2020 11:02:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 72A952037E;
	Tue, 29 Dec 2020 11:02:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51838C088B;
	Tue, 29 Dec 2020 11:02:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01E6CC0174
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DCA5786C4A
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gcBkxI9LqKf3 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 11:02:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A29286132
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:02:49 +0000 (UTC)
X-UUID: 68d9bcd55862430491e5a0946e429603-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=+tQiRgFVs1ecSRTznh8zWZJajSaxb1w3A0hIkVSyae4=; 
 b=n/UI6MboHADW2FQSsUHlHdjWIrXq+Sxe5kdG/k6qclB8szLc/DbiUfqpWOo69QgmuHvy2sCCXdSXRKinxGTlVqIPk80mL0I6yAo/jjvPcJQqn021vwGuKzKOfqBo1eTTDK5YK+Gx68pJ+272vloCV/Lel4XN1p1pARwl/1KmNLY=;
X-UUID: 68d9bcd55862430491e5a0946e429603-20201229
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1009512425; Tue, 29 Dec 2020 19:02:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 29 Dec 2020 19:01:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:00:20 +0800
Message-ID: <1609239620.26323.288.camel@mhfsdcap03>
Subject: Re: [PATCH v5 15/27] iommu/mediatek: Add fail handle for sysfs_add
 and device_register
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 29 Dec 2020 19:00:20 +0800
In-Reply-To: <X+L+97OBxC6I5pUv@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-16-yong.wu@mediatek.com>
 <X+L+97OBxC6I5pUv@chromium.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9BAE3647D5E474D2917586CBBFB4911DB1B0897182843908B89A805325F57F062000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
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

On Wed, 2020-12-23 at 17:25 +0900, Tomasz Figa wrote:
> On Wed, Dec 09, 2020 at 04:00:50PM +0800, Yong Wu wrote:
> > Add fail handle for iommu_device_sysfs_add and iommu_device_register.
> > 
> > Fixes: b16c0170b53c ("iommu/mediatek: Make use of iommu_device_register interface")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 39478cfbe0f1..09c8c58feb78 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -746,7 +746,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  
> >  	ret = iommu_device_register(&data->iommu);
> >  	if (ret)
> > -		return ret;
> > +		goto out_sysfs_remove;
> >  
> >  	spin_lock_init(&data->tlb_lock);
> >  	list_add_tail(&data->list, &m4ulist);
> > @@ -754,7 +754,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  	if (!iommu_present(&platform_bus_type))
> >  		bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
> >  
> > -	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> > +	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> > +	if (ret)
> > +		goto out_dev_unreg;
> > +	return ret;
> > +
> > +out_dev_unreg:
> 
> Shouldn't other operations be undone as well? I can see that above
> bus_set_iommu() is set and an entry is added to m4ulist.

Oh. Yes. I will add them. and remove the fixes tag since they are not
introduced by it. these error handle are not added in the first version.

> 
> > +	iommu_device_unregister(&data->iommu);
> > +out_sysfs_remove:
> > +	iommu_device_sysfs_remove(&data->iommu);
> > +	return ret;
> >  }
> >  
> >  static int mtk_iommu_remove(struct platform_device *pdev)
> > -- 
> > 2.18.0
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
