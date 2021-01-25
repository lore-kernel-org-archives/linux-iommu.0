Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ACBC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 08:41:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9038922511
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 08:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9038922511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 10E2020509;
	Mon, 25 Jan 2021 08:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fte-3LrVr6-d; Mon, 25 Jan 2021 08:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DCE3E2010D;
	Mon, 25 Jan 2021 08:40:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7915C0FA7;
	Mon, 25 Jan 2021 08:40:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99C3EC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7E9C720509
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NedkgICHa4tn for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 08:40:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by silver.osuosl.org (Postfix) with ESMTPS id 200522010D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:40:55 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id f16so847680wmq.5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 00:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mZo7aKwXK5deoAcrsXLP1GP5WkzKfPSS28ocvilrOE8=;
 b=fbp3n2UMAOUTlGsagh5Jhp6ckcDtJCd3AOH/5ui55U183hUDf1oxSsMJSvapkJ4DLh
 e6p7UOmbNxCcZVJRK3WoS2ZtI3PCfo+oscsQOMvzvHNg0SV6TGSYTWcgSfEeSf5i6Kup
 Yhnl5ejeUQHL87v/K5vRA+Fs4cex7Zsm0qPYlp2TxH1WxsyWpH1KAnJ+tgXHX2Mr1J1h
 F484TtUCSsFBv6PgPEI0s0a1gdoOhyP5kTXt1zkWxszKcdVqUstkJuYTX5ezMLvK5a4l
 lfIEloOHDJuxrBOBzldMDLZXYPpmfVmLsEifyc7pNBrUXf3rLuQUjbKL5hGdErqtDpTM
 9/FA==
X-Gm-Message-State: AOAM531getRqVYeOgDzk+8NWYkUJZh1BuY3tXlUko8zCNivbwhNksFM4
 7MX6zvCm+Wq98rl6e9wejp4=
X-Google-Smtp-Source: ABdhPJzqtyNCKS2sng7AvV/KuXwIGCg36ChTNZfCr5oRaLPx4r2cb6HVrQPNF1aJsw7Pq4EawQNxdA==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr14774541wmm.79.1611564053570; 
 Mon, 25 Jan 2021 00:40:53 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id n193sm20346055wmb.0.2021.01.25.00.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 00:40:52 -0800 (PST)
Date: Mon, 25 Jan 2021 09:40:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
Message-ID: <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
 <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
 <1611557381.3184.21.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1611557381.3184.21.camel@mhfsdcap03>
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

On Mon, Jan 25, 2021 at 02:49:41PM +0800, Yong Wu wrote:
> On Fri, 2021-01-22 at 22:34 +0100, Krzysztof Kozlowski wrote:
> > On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> > > The config MTK_SMI always depends on MTK_IOMMU which is built-in
> > > currently. Thus we don't have module_exit before. This patch adds
> > > module_exit and module_license. It is a preparing patch for supporting
> > > MTK_SMI could been built as a module.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/memory/mtk-smi.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > index e2aebd2bfa8e..aa2a25abf04f 100644
> > > --- a/drivers/memory/mtk-smi.c
> > > +++ b/drivers/memory/mtk-smi.c
> > > @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
> > >  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > >  }
> > >  module_init(mtk_smi_init);
> > > +
> > > +static void __exit mtk_smi_exit(void)
> > > +{
> > > +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > +}
> > > +module_exit(mtk_smi_exit);
> > > +
> > > +MODULE_DESCRIPTION("MediaTek SMI driver");
> > > +MODULE_ALIAS("platform:MediaTek-SMI");
> > 
> > Drivers do not use capital letters, so I have doubts whether this alias
> > is correct.
> 
> I didn't care the upper/lower-case. I will change to lower case in next
> time.

Then why do you need the alias? The name does not match driver name, so
what's the purpose of this alias/

> 
> MODULE_ALIAS("platform:MediaTek-smi")
> 
> > 
> > Adding all these should be squashed with changing Kconfig into tristate.
> > It does not have sense on its own.
> 
> Thanks  very much for review.
> 
> Only confirm: Squash whole this patch or only squash the MODULE_x into
> the next patch?

This entire patch 2/3 should be with 3/3.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
