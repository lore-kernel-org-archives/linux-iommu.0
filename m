Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AC6C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 05:31:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7937C239FC
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 05:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7937C239FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 245F086A70;
	Fri, 15 Jan 2021 05:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lj2RBIqIp3xx; Fri, 15 Jan 2021 05:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3ABE286A1A;
	Fri, 15 Jan 2021 05:31:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10780C088B;
	Fri, 15 Jan 2021 05:31:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37909C013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 05:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1A89B86A09
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 05:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7SgOSdiGFtQJ for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 05:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by whitealder.osuosl.org (Postfix) with ESMTP id DE1E0869C1
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 05:31:34 +0000 (UTC)
X-UUID: 24067ff830cf4529bc716d71bc9e2947-20210115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=8Xzi4Jk1vwim8FSqpSrcJwUMLUAt5CxpsEAeeSgDR/A=; 
 b=PK0jmoLWR1BxE3osY8lzT6Um7Kk6obLEEprp0Kb//ACrnXkZRBG4wYmCjDanxe0vfxHJrw6xU5RvkZ7UgjHjDI3vQuTiHXrtNVFMfKmp7Zz0waeRwAex8g/AWAUpaxgsW/rRTSzwXQNsRzSv7mE9rsNGDAQZ/kZja+BbEjbP6OA=;
X-UUID: 24067ff830cf4529bc716d71bc9e2947-20210115
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 851705744; Fri, 15 Jan 2021 13:30:33 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 15 Jan 2021 13:30:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Jan 2021 13:30:26 +0800
Message-ID: <1610688626.4578.1.camel@mhfsdcap03>
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
From: Yong Wu <yong.wu@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Fri, 15 Jan 2021 13:30:26 +0800
In-Reply-To: <20210114192732.GA3401278@robh.at.kernel.org>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
 <20210114192732.GA3401278@robh.at.kernel.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 84A856FA60FFA5913CE06B0A418092BC787D34670283D643131FDFCEE268D07C2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

On Thu, 2021-01-14 at 13:27 -0600, Rob Herring wrote:
> On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
> > "dev->dma_range_map" contains the devices' dma_ranges information,
> > This patch moves dma_range_map before of_iommu_configure. The iommu
> > driver may need to know the dma_address requirements of its iommu
> > consumer devices.
> > 
> > CC: Rob Herring <robh+dt@kernel.org>
> > CC: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/of/device.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index aedfaaafd3e7..1d84636149df 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
> >  	dev_dbg(dev, "device is%sdma coherent\n",
> >  		coherent ? " " : " not ");
> >  
> > +	dev->dma_range_map = map;
> >  	iommu = of_iommu_configure(dev, np, id);
> >  	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
> >  		kfree(map);
> > +		dev->dma_range_map = NULL;
> 
> Not really going to matter, but you should probably clear dma_range_map 
> before what it points to is freed.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review. I will move it before "kfree(map)" in next
version.

> 
> >  		return -EPROBE_DEFER;
> >  	}
> >  
> > @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
> >  
> >  	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> >  
> > -	dev->dma_range_map = map;
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > -- 
> > 2.18.0
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
