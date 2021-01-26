Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C90C433E0
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 06:12:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77F422B3B
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 06:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77F422B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34D9487024;
	Tue, 26 Jan 2021 06:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t+cN7t4rOteI; Tue, 26 Jan 2021 06:12:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7A3EF8701B;
	Tue, 26 Jan 2021 06:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60E16C08A1;
	Tue, 26 Jan 2021 06:12:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56201C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C6CD8681A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:12:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40SdEourekWX for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 06:12:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 71AE586817
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:12:47 +0000 (UTC)
X-UUID: 9c99fcd34f814aa088a45e48dfc6c84a-20210126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=2hSKPuelvgSnXJYZEXWh9wgPzMnweZ+FfzYCevNXc1E=; 
 b=LlRFfdTTXboe/PRIPzD4V1rdiw98ADeknhH1DEpOscPqtRrTFP2tBBGfKzJMcSq6yy08NXdB1z+nYSmJY8yJ0Xjcss21SnNgUH9QhFELJLDgmzzvidcPgpPS1VyDsg7hn9/ybBPyHszLfyEyeNTjNyVIt5it+EcRx8kMZxMyqjg=;
X-UUID: 9c99fcd34f814aa088a45e48dfc6c84a-20210126
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1287511789; Tue, 26 Jan 2021 14:12:09 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 26 Jan 2021 14:12:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 14:12:04 +0800
Message-ID: <1611641524.5302.10.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 26 Jan 2021 14:12:04 +0800
In-Reply-To: <20210125104033.2ewzumhmagmouvo5@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
 <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
 <1611557381.3184.21.camel@mhfsdcap03>
 <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
 <1611566885.5302.4.camel@mhfsdcap03>
 <20210125104033.2ewzumhmagmouvo5@kozik-lap>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8CD6A93D9A786D93DC46E5015D38F6B1D57C4AF0878B687D987EA2D78D9546862000:8
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

On Mon, 2021-01-25 at 11:40 +0100, Krzysztof Kozlowski wrote:
> On Mon, Jan 25, 2021 at 05:28:05PM +0800, Yong Wu wrote:
> > On Mon, 2021-01-25 at 09:40 +0100, Krzysztof Kozlowski wrote:
> > > On Mon, Jan 25, 2021 at 02:49:41PM +0800, Yong Wu wrote:
> > > > On Fri, 2021-01-22 at 22:34 +0100, Krzysztof Kozlowski wrote:
> > > > > On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> > > > > > The config MTK_SMI always depends on MTK_IOMMU which is built-in
> > > > > > currently. Thus we don't have module_exit before. This patch adds
> > > > > > module_exit and module_license. It is a preparing patch for supporting
> > > > > > MTK_SMI could been built as a module.
> > > > > > 
> > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > ---
> > > > > >  drivers/memory/mtk-smi.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > > > > index e2aebd2bfa8e..aa2a25abf04f 100644
> > > > > > --- a/drivers/memory/mtk-smi.c
> > > > > > +++ b/drivers/memory/mtk-smi.c
> > > > > > @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
> > > > > >  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > > > >  }
> > > > > >  module_init(mtk_smi_init);
> > > > > > +
> > > > > > +static void __exit mtk_smi_exit(void)
> > > > > > +{
> > > > > > +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > > > > +}
> > > > > > +module_exit(mtk_smi_exit);
> > > > > > +
> > > > > > +MODULE_DESCRIPTION("MediaTek SMI driver");
> > > > > > +MODULE_ALIAS("platform:MediaTek-SMI");
> > > > > 
> > > > > Drivers do not use capital letters, so I have doubts whether this alias
> > > > > is correct.
> > > > 
> > > > I didn't care the upper/lower-case. I will change to lower case in next
> > > > time.
> > > 
> > > Then why do you need the alias? The name does not match driver name, so
> > > what's the purpose of this alias/
> > 
> > I think it is not so necessary for us. I will delete this line in next
> > version.
> > 
> > Only curious what's alias is fit in our case? normally it should be the
> > file name: mtk-smi?
> 
> If autoloading of your module works, then remove it. The alias is
> necessary for some cases when a device table is missing (e.g. platform
> driver is matched via devicetree but not having the platform_device_id
> table) or matching is done via different method (e.g. driver is matched
> from MFD via devicetree compatible even though there is a
> platform_device_id table).

Thanks for explaination so detailly. v2 is sent just now.

> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
