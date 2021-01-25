Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC6C433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 06:50:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3665224DE
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 06:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3665224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 563FC272E0;
	Mon, 25 Jan 2021 06:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ns+Dcml6VoEt; Mon, 25 Jan 2021 06:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E44362107A;
	Mon, 25 Jan 2021 06:50:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3C63C0FA7;
	Mon, 25 Jan 2021 06:50:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9146CC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 06:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 02A8487366
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 06:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DejqcKdmN5Kb for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 06:50:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6BC2187331
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 06:50:13 +0000 (UTC)
X-UUID: f9fd92f00151428f8fc1a03ad778b973-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=3sZdh7RRXxrc49QzROkGUluZgplDjz302X96USm+z90=; 
 b=Z0qG9f2xZMR7M2KmGP08ZfOPOR1IamN8WAyd6HDThOBMf5ut41BVkXNCPslTTgXJD+KxreKqc5zTUWv9hdYJrPVKsoPX/EMz7wvjPcvZHxaOb3dpike6rwf9iIyIH+dmrrbaQKHbaPqO7NWzX8yHfTuyySV0vJc7+yXQl7O6wSs=;
X-UUID: f9fd92f00151428f8fc1a03ad778b973-20210125
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 296833013; Mon, 25 Jan 2021 14:49:52 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 25 Jan 2021 14:49:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 14:49:44 +0800
Message-ID: <1611557384.3184.22.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 25 Jan 2021 14:49:44 +0800
In-Reply-To: <20210122213558.qnboqc4obdmipxs4@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-4-yong.wu@mediatek.com>
 <20210122213558.qnboqc4obdmipxs4@kozik-lap>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1D28C57D2118177B6DC247476BBB989F212A870F3047A08E71A51B66345267EE2000:8
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

On Fri, 2021-01-22 at 22:35 +0100, Krzysztof Kozlowski wrote:
> On Thu, Jan 21, 2021 at 02:24:29PM +0800, Yong Wu wrote:
> > This patch switches MTK_SMI to tristate. Support it could be 'm'.
> > 
> > Meanwhile, Fix a build issue while MTK_SMI is built as module.
> 
> s/Fix/fix.
> 
> What error is being fixed here? How can I reproduce it? Aren't you just
> adjusting it to being buildable by module?

Sorry, I didn't copy the fail log here. This is the build log:

In file included from .../drivers/iommu/mtk_iommu.c:34:0:
.../drivers/iommu/mtk_iommu.h:84:28: error: array type has incomplete
element type 'struct mtk_smi_larb_iommu'
  struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];

Our iommu driver will use this structure. but it was contained by
"#ifdef CONFIG_MTK_SMI". thus I change it to "#if
IS_ENABLED(CONFIG_MTK_SMI)"

If reproducing it, we should change mtk-iommu to module_init[1]. and
switch kconfig MTK_IOMMU to tristate, then change the CONFIG_MTK_IOMMU
to m. we could get the fail log.

In this case, Should I squash this change into this patch? I though this
is a preparing patch and the fail is caused by MTK_SMI. thus I squash
that into this patch. or change it as a independent patch and send when
I change MTK_IOMMU to tristate?

[1]
https://lore.kernel.org/linux-mediatek/1590826218-23653-14-git-send-email-yong.wu@mediatek.com/


> 
> Best regards,
> Krzysztof
> 
> 
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > This patch has a little conflict with the mt8192 iommu patch which
> > delete the MTK_LARB_NR_MAX in smi.h(It's still reviewing).
> > This patch rebase on the clean v5.11-rc1.
> > ---
> >  drivers/memory/Kconfig     | 2 +-
> >  include/soc/mediatek/smi.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > index 3ea6913df176..d5f0f4680880 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -173,7 +173,7 @@ config JZ4780_NEMC
> >  	  memory devices such as NAND and SRAM.
> >  
> >  config MTK_SMI
> > -	bool "Mediatek SoC Memory Controller driver" if COMPILE_TEST
> > +	tristate "Mediatek SoC Memory Controller driver" if COMPILE_TEST
> >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> >  	help
> >  	  This driver is for the Memory Controller module in MediaTek SoCs,
> > diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> > index 5a34b87d89e3..29e2fb8f33d6 100644
> > --- a/include/soc/mediatek/smi.h
> > +++ b/include/soc/mediatek/smi.h
> > @@ -9,7 +9,7 @@
> >  #include <linux/bitops.h>
> >  #include <linux/device.h>
> >  
> > -#ifdef CONFIG_MTK_SMI
> > +#if IS_ENABLED(CONFIG_MTK_SMI)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
