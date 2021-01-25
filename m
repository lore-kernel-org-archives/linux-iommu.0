Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B3C433E6
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 06:50:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97574224DE
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 06:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97574224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 39B75272E3;
	Mon, 25 Jan 2021 06:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QlhD+flgge9u; Mon, 25 Jan 2021 06:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4E05E23115;
	Mon, 25 Jan 2021 06:50:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 172ECC1E70;
	Mon, 25 Jan 2021 06:50:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE0EC0FA7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 06:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 02D0487377
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 06:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W1qo4PJrnPY4 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 06:50:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by hemlock.osuosl.org (Postfix) with ESMTP id 294988709B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 06:50:10 +0000 (UTC)
X-UUID: fd0e93103f1d4f8aa52a818e05d5f6e2-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=chRfsW5UPIrsCGcAQg3ddEyEhCQ/dYzTCA0hmQUJvJM=; 
 b=rMrwSTwP2W56HGFPRjZmlZq/VLfheKcS+MDIESU2q1A6ZEZDmiosT7W0VznAkk7StXa+S2Sz2sQQadLpXZFrDKro8DYdRe4wrEsjuHDtULew9ab+3u60u0PWrHybXPGGHIY5uY63Bfxnuf2FwV8WI+8pQXcpiKAqka6QBE2XqV8=;
X-UUID: fd0e93103f1d4f8aa52a818e05d5f6e2-20210125
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 3668096; Mon, 25 Jan 2021 14:49:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 25 Jan 2021 14:49:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 14:49:41 +0800
Message-ID: <1611557381.3184.21.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 25 Jan 2021 14:49:41 +0800
In-Reply-To: <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
 <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1FA87B06CC3B3754A9FB2810156820CA7B9663E05E7BC37A175827580DDF19EC2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 yi.kuo@mediatek.com, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

On Fri, 2021-01-22 at 22:34 +0100, Krzysztof Kozlowski wrote:
> On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> > The config MTK_SMI always depends on MTK_IOMMU which is built-in
> > currently. Thus we don't have module_exit before. This patch adds
> > module_exit and module_license. It is a preparing patch for supporting
> > MTK_SMI could been built as a module.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index e2aebd2bfa8e..aa2a25abf04f 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
> >  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> >  }
> >  module_init(mtk_smi_init);
> > +
> > +static void __exit mtk_smi_exit(void)
> > +{
> > +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > +}
> > +module_exit(mtk_smi_exit);
> > +
> > +MODULE_DESCRIPTION("MediaTek SMI driver");
> > +MODULE_ALIAS("platform:MediaTek-SMI");
> 
> Drivers do not use capital letters, so I have doubts whether this alias
> is correct.

I didn't care the upper/lower-case. I will change to lower case in next
time.

MODULE_ALIAS("platform:MediaTek-smi")

> 
> Adding all these should be squashed with changing Kconfig into tristate.
> It does not have sense on its own.

Thanks  very much for review.

Only confirm: Squash whole this patch or only squash the MODULE_x into
the next patch?

> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
