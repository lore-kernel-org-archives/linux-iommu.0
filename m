Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8AC433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 21:34:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61C420684
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 21:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61C420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 831B4873D4;
	Fri, 22 Jan 2021 21:34:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1oZAGRHfc1ZX; Fri, 22 Jan 2021 21:34:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9980B873D5;
	Fri, 22 Jan 2021 21:34:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8751FC08A1;
	Fri, 22 Jan 2021 21:34:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C39CC013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 575DD8711F
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Naz9adkGBj7I for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 21:34:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 59D638711B
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:34:31 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id ox12so9754197ejb.2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UUV29RpxjVNGedVCZG35UzFCrYjLETYa/Rl1PkWj6Ks=;
 b=g2uV30Cj8RU7u1/fmJb2oKsS45+hgXjmeS3clkHH8erBniOaQh6Jtf/wuP7CZO+0kN
 jivcdt3qW2f0lUKmscXViHQ3YYb+HB94tgnq07u0pUEzjBXcCMBgHrRwY9aX92uYrZEw
 pnsMUEdSIETxAuMeGvMD/5JZvzwcMqS5XPqjqawRCqM9jbFRHRa47d7u/SuVxlkXDYz/
 xgViFtJ9PHuA5hZAcp8J/DogPnWpfJKT43QtoTeX1+N2h9U79IJvelWue4qSiN54PJQ9
 mbrLoLHQ664WIJIO6eEofetMIvE1H9L+def2lALFukZF7bWORxqkBv3bkmZc7E0BBXxu
 /hQQ==
X-Gm-Message-State: AOAM530z/CHPSP7a8Idu3KQ5vfkDHd4dnPS8/CkKIIhQeP81uZFEC0VZ
 7ddc+VFM69WJbWATAK/wiT4=
X-Google-Smtp-Source: ABdhPJxHt80Jvb/lOspEpWGHk4RR9X1vDlMGLNUVWPiSLSr9iaYR9oS1vVzvVNzhfl428fLAzdYDOQ==
X-Received: by 2002:a17:907:932:: with SMTP id
 au18mr4214890ejc.91.1611351269791; 
 Fri, 22 Jan 2021 13:34:29 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id i15sm5321214ejj.28.2021.01.22.13.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 13:34:28 -0800 (PST)
Date: Fri, 22 Jan 2021 22:34:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
Message-ID: <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121062429.26504-3-yong.wu@mediatek.com>
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

On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> The config MTK_SMI always depends on MTK_IOMMU which is built-in
> currently. Thus we don't have module_exit before. This patch adds
> module_exit and module_license. It is a preparing patch for supporting
> MTK_SMI could been built as a module.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e2aebd2bfa8e..aa2a25abf04f 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
>  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
>  }
>  module_init(mtk_smi_init);
> +
> +static void __exit mtk_smi_exit(void)
> +{
> +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> +}
> +module_exit(mtk_smi_exit);
> +
> +MODULE_DESCRIPTION("MediaTek SMI driver");
> +MODULE_ALIAS("platform:MediaTek-SMI");

Drivers do not use capital letters, so I have doubts whether this alias
is correct.

Adding all these should be squashed with changing Kconfig into tristate.
It does not have sense on its own.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
