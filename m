Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B378C433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 09:28:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A302223E
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 09:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A302223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CCB7C87475;
	Mon, 25 Jan 2021 09:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPFim11ZevgM; Mon, 25 Jan 2021 09:28:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5ABE38744F;
	Mon, 25 Jan 2021 09:28:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D7A3C0FA7;
	Mon, 25 Jan 2021 09:28:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D10AC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 09:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 72093203DB
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 09:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FytKRhA4URxe for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 09:28:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by silver.osuosl.org (Postfix) with ESMTP id 0D7C620031
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 09:28:15 +0000 (UTC)
X-UUID: 3fac2dd4c4fe4607bc7096152e2f7cd3-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=lhVwgct1qLRIqISTHiQUau/q2BPFUpBPawwGht04g0o=; 
 b=SKEgW8zXP0ydAJxkwqOm2wmDOtkeG8o4peHVMWbXBE8XM/dgDr4AK5zkBo6Q1nHT9S2aJH/XpSATHnSDh1Mv7qhHIMkzEzGf4i32BKe+9V6KdZ6HG2hdWTrCB3wnip0uMqgSetFq6zatzti1jQvFXI4mackqEd8EYx4O1dP1YkE=;
X-UUID: 3fac2dd4c4fe4607bc7096152e2f7cd3-20210125
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 164757872; Mon, 25 Jan 2021 17:28:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 25 Jan 2021 17:28:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 17:28:05 +0800
Message-ID: <1611566885.5302.4.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 25 Jan 2021 17:28:05 +0800
In-Reply-To: <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
 <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
 <1611557381.3184.21.camel@mhfsdcap03>
 <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CC098342C3475A3A19CA0E3E9BC4E530FBE4967BF1BA6A79FDA7BE926AEE12612000:8
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

On Mon, 2021-01-25 at 09:40 +0100, Krzysztof Kozlowski wrote:
> On Mon, Jan 25, 2021 at 02:49:41PM +0800, Yong Wu wrote:
> > On Fri, 2021-01-22 at 22:34 +0100, Krzysztof Kozlowski wrote:
> > > On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> > > > The config MTK_SMI always depends on MTK_IOMMU which is built-in
> > > > currently. Thus we don't have module_exit before. This patch adds
> > > > module_exit and module_license. It is a preparing patch for supporting
> > > > MTK_SMI could been built as a module.
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >  drivers/memory/mtk-smi.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > > index e2aebd2bfa8e..aa2a25abf04f 100644
> > > > --- a/drivers/memory/mtk-smi.c
> > > > +++ b/drivers/memory/mtk-smi.c
> > > > @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
> > > >  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > >  }
> > > >  module_init(mtk_smi_init);
> > > > +
> > > > +static void __exit mtk_smi_exit(void)
> > > > +{
> > > > +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > > +}
> > > > +module_exit(mtk_smi_exit);
> > > > +
> > > > +MODULE_DESCRIPTION("MediaTek SMI driver");
> > > > +MODULE_ALIAS("platform:MediaTek-SMI");
> > > 
> > > Drivers do not use capital letters, so I have doubts whether this alias
> > > is correct.
> > 
> > I didn't care the upper/lower-case. I will change to lower case in next
> > time.
> 
> Then why do you need the alias? The name does not match driver name, so
> what's the purpose of this alias/

I think it is not so necessary for us. I will delete this line in next
version.

Only curious what's alias is fit in our case? normally it should be the
file name: mtk-smi?

> 
> > 
> > MODULE_ALIAS("platform:MediaTek-smi")
> > 
> > > 
> > > Adding all these should be squashed with changing Kconfig into tristate.
> > > It does not have sense on its own.
> > 
> > Thanks  very much for review.
> > 
> > Only confirm: Squash whole this patch or only squash the MODULE_x into
> > the next patch?
> 
> This entire patch 2/3 should be with 3/3.

Thanks for the confirm.

> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
