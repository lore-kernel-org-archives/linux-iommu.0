Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A5C433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 10:40:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976F021D79
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 10:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976F021D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2D77885FD4;
	Mon, 25 Jan 2021 10:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UVxJrYsNOjZM; Mon, 25 Jan 2021 10:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B386485FC3;
	Mon, 25 Jan 2021 10:40:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98973C08A1;
	Mon, 25 Jan 2021 10:40:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 878A0C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 10:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 766D287414
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 10:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zCQtRUr0lQiX for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 10:40:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 522E687303
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 10:40:38 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id a9so11736214wrt.5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 02:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DsJE2zPkprb7gh+GS+eIFG0M1vuNomWHZqhGRuLhtzQ=;
 b=aVLVTLyngs1iICAyHX+MaGczt6z1NHDgCMnBnRqVirSUvRUtAxOmPnudvq1uLxZV2h
 xiK1SneV5f9QV0pW6AlUW+1IprSzuSWjn3yBTxK4avYbEa06gYehBaczr8+mz7WbFd4b
 r920DPXeJNXrzEShtqItKclpgJ8OLK1mFuwlhLT/jpb3LBqTDln9R+8yikjShHTF/D4X
 Tu2/+F1wDHHNhFYya0jgoHmNcwmDvy6NWDxA0jn7gRrBJ6X53dxyVXgJTxqpfZ7dxd3b
 wmolCPGUUeaRWewVXcYSyTltknFQNH2RublnydHjVXsknu10DbDDYq6fwA2UvqQPzcEo
 B+nA==
X-Gm-Message-State: AOAM5307tAvifojysfhKPkhUtKv5RSyxj/P1YR+ClcMs2vXh9fBLEdp/
 t3UNS/oW9IkiHIHwDVL2aR8=
X-Google-Smtp-Source: ABdhPJxFRyn+qu6XbZN8Kw3vcIaOk89MqJcinq7fckxNIcL/17AL7YibO7Tz3bhcgYseghNGX5zLzA==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr200432wru.152.1611571236869;
 Mon, 25 Jan 2021 02:40:36 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id g1sm21982339wrq.30.2021.01.25.02.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 02:40:35 -0800 (PST)
Date: Mon, 25 Jan 2021 11:40:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
Message-ID: <20210125104033.2ewzumhmagmouvo5@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
 <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
 <1611557381.3184.21.camel@mhfsdcap03>
 <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
 <1611566885.5302.4.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1611566885.5302.4.camel@mhfsdcap03>
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

On Mon, Jan 25, 2021 at 05:28:05PM +0800, Yong Wu wrote:
> On Mon, 2021-01-25 at 09:40 +0100, Krzysztof Kozlowski wrote:
> > On Mon, Jan 25, 2021 at 02:49:41PM +0800, Yong Wu wrote:
> > > On Fri, 2021-01-22 at 22:34 +0100, Krzysztof Kozlowski wrote:
> > > > On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> > > > > The config MTK_SMI always depends on MTK_IOMMU which is built-in
> > > > > currently. Thus we don't have module_exit before. This patch adds
> > > > > module_exit and module_license. It is a preparing patch for supporting
> > > > > MTK_SMI could been built as a module.
> > > > > 
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > ---
> > > > >  drivers/memory/mtk-smi.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > > > index e2aebd2bfa8e..aa2a25abf04f 100644
> > > > > --- a/drivers/memory/mtk-smi.c
> > > > > +++ b/drivers/memory/mtk-smi.c
> > > > > @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
> > > > >  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > > >  }
> > > > >  module_init(mtk_smi_init);
> > > > > +
> > > > > +static void __exit mtk_smi_exit(void)
> > > > > +{
> > > > > +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> > > > > +}
> > > > > +module_exit(mtk_smi_exit);
> > > > > +
> > > > > +MODULE_DESCRIPTION("MediaTek SMI driver");
> > > > > +MODULE_ALIAS("platform:MediaTek-SMI");
> > > > 
> > > > Drivers do not use capital letters, so I have doubts whether this alias
> > > > is correct.
> > > 
> > > I didn't care the upper/lower-case. I will change to lower case in next
> > > time.
> > 
> > Then why do you need the alias? The name does not match driver name, so
> > what's the purpose of this alias/
> 
> I think it is not so necessary for us. I will delete this line in next
> version.
> 
> Only curious what's alias is fit in our case? normally it should be the
> file name: mtk-smi?

If autoloading of your module works, then remove it. The alias is
necessary for some cases when a device table is missing (e.g. platform
driver is matched via devicetree but not having the platform_device_id
table) or matching is done via different method (e.g. driver is matched
from MFD via devicetree compatible even though there is a
platform_device_id table).

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
