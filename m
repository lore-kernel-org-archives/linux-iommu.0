Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1137C433E1
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 06:43:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7457B2075D
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 06:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CSaEj9xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7457B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 095AB2002B;
	Mon, 27 Jul 2020 06:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5I0fz9AAJbt8; Mon, 27 Jul 2020 06:43:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5C6E01FCB5;
	Mon, 27 Jul 2020 06:43:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C261C0050;
	Mon, 27 Jul 2020 06:43:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55834C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3DFCD87C91
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1NeaDaVhiW3 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 06:43:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id F2F0187C14
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:42:58 +0000 (UTC)
X-UUID: 7eb9876217be47ceb8d12aa6fa423a50-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=sPmuXHpH9XNlFgouHZYOVCVUIZrXlxeu/KMhxKhqoFc=; 
 b=CSaEj9xsdVGsTTGzjZNP6nk77KrP83X/JIeZRPFPAz4jC4GMhQt0kGDv8d/7pYyDSKqkOU4BZlJtjP7Qhr0L6cCkZCtIJvApQtTTbxSdmqH5GoZZdNn+u2vI/E5dFIqzN2tUR23p79URFq2gj807/goi7Fii5lZ5VVUz9OKW2+I=;
X-UUID: 7eb9876217be47ceb8d12aa6fa423a50-20200727
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 967003377; Mon, 27 Jul 2020 14:42:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 27 Jul 2020 14:42:38 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 14:42:35 +0800
Message-ID: <1595832080.16172.88.camel@mhfsdcap03>
Subject: Re: [PATCH 18/21] iommu/mediatek: Add support for multi domain
From: Yong Wu <yong.wu@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Mon, 27 Jul 2020 14:41:20 +0800
In-Reply-To: <20200723204729.GA823856@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-19-yong.wu@mediatek.com>
 <20200723204729.GA823856@bogus>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AAEEA5DEDA078252AF7983EB2F3959E34D7A075A7A10B725C05A35A5BB0517B82000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 2020-07-23 at 14:47 -0600, Rob Herring wrote:
> On Sat, Jul 11, 2020 at 02:48:43PM +0800, Yong Wu wrote:
> > Some HW IP(ex: CCU) require the special iova range. That means the
> > iova got from dma_alloc_attrs for that devices must locate in his
> > special range. In this patch, we allocate a special iova_range for
> > each a special requirement and create each a iommu domain for each
> > a iova_range.
> > 
> > meanwhile we still use one pagetable which support 16GB iova.
> > 
> > After this patch, If the iova range of a master is over 4G, the master
> > should:
> > a) Declare its special dma_ranges in its dtsi node. For example, If we
> > preassign the iova 4G-8G for vcodec, then the vcodec dtsi node should:
> > 	dma-ranges = <0x1 0x0 0x1 0x0 0x1 0x0>;  /* 4G ~ 8G */
> 
> BTW, dma-ranges should be in the parent node of the vcodec.

But the vcodec doesn't have its special parent node. Currently the
vcodec/display dtsi like this:

soc {

    ovl:{  /* display */
    /*No dma-ranges property. defaultly it is 0-4G iova range. */
    }

    vcodec_dec: { /* decode */
    dma-ranges = <0x1 0x0 0x1 0x0 0x1 0x0>; /* 4G ~ 8G*/
    };

    vcodec_enc: {  /* encode */
    dma-ranges = <0x1 0x0 0x1 0x0 0x1 0x0>; /* 4G ~ 8G*/
    };

    camera: {
    dma-ranges = <0x2 0x0 0x2 0x0 0x1 0x0>; /* 8G ~ 12G */
    };

}

If we add the parent node for vcodec, the vcodec driver flow will be
changed, and it may be incompatible with the previous dtb.

Here we don't have the actual bus concept. currently we support 16GB
dma_addr(iova) ranges. we only preassign 4-8G for vcodec, 8G-12G for
camera.

If the usage of dma-ranges here is different from the common one. then
how should I do here?

Thanks.
> 
> > b) Update the dma_mask:
> >  dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));
> 
> This should happen for you automatically. The DMA PFN offset 
> should also be 4GB here.

I may not follow here.

If the iova start at 0x1_0000_0000, phys address start at 0x4000_0000.
Do you means the dma-ranges should be <0x1 0 0x0 0x40000000 0x1 0x0>?
then dma_pfn_offset = PFN_DOWN(paddr - dma_addr) = 0xffffffff40000. this
is also ok for us. we don't call the macro regarding this
"dev->dma_pfn_offset"

The purpose that I call it here is for updating the
dev->coherent_dma_mask[1], then we could get the iova over 4GB.

[1]
https://elixir.bootlin.com/linux/v5.8-rc1/source/drivers/iommu/dma-iommu.c#L619

> 
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 49 ++++++++++++++++++++++++++++++++-------
> >  drivers/iommu/mtk_iommu.h |  3 ++-
> >  2 files changed, 42 insertions(+), 10 deletions(-)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
