Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DAC43462
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 12:36:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50C061106
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 12:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50C061106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A479184816;
	Fri,  9 Apr 2021 12:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nn2H1whDdZb7; Fri,  9 Apr 2021 12:36:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 841F58483E;
	Fri,  9 Apr 2021 12:36:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B03CC000B;
	Fri,  9 Apr 2021 12:36:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76938C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64611607CA
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fB4naBmVAzLA for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 12:36:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16DC96071D
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 12:36:06 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id u10so6260412lju.7
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tg6sgY5o6KJ5S57CRLT5oBYc675XGvjvO0a75IDhy4M=;
 b=tD/+WsHQQWYusIiNpWcK7bwWVSNKlMLnyRF8CoJ3CZhMIHxMdvtXVATkH2bY6CsvV6
 4EeqLJcMu8Lx6dXjIGijM9Z71Ysw7FoPhIt4pVwzFK6l7vQQG0p8gmVQcZtmvl5D6mmc
 vnQ4vXPZDk4T7ERYAIs5HJIK9/rMwsb/PGlIkgHlPxrLJNQV9qOSD2eFT+qGhgN9rW/v
 i+5TnZ7zezyrlf0LjEA3nkURPCbcKV3D0THgJHWfMYiU94A6/Dnr2CLqYXHUaZSeUV9C
 jYnvEDTnSyDvM2CCXvtBaB8N7OxfbX9Umv48J+Clvg4cWNbqEuv5MYIvFfkzoLNaHZdC
 sk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tg6sgY5o6KJ5S57CRLT5oBYc675XGvjvO0a75IDhy4M=;
 b=gIxy7sz/zgGKX520dANfH3KIo+Abfqdp5nHwm8PLcsKrmB1L57OIcWJTB+/aScQ14t
 19g0isAdGHOq/Cfvu5HlduOSlc6XUQN1VHQydeNlgzTW3ZO/2beKBFa99hVOWYJOXZBb
 SV71RJp1miOKwcb18QMMmZZ+cs/N/HzBqZ12jtIf0kwmsYjScOjB1HTtr9IkvuvzFe2T
 RnJ/DV8h6zdt6P7teQTU9RpbIkBiIIArCNWb6BABPEEwSyDwXS0NzKkXNfQBM3E7r89Q
 BY6IlfnXeCqbjSuKkPGnBmLnmFCeXVDnRiC6B0nRsmZ0oifPrHsOqX1rGKleL3hF6Bh1
 0o7w==
X-Gm-Message-State: AOAM53121kdOwdXsWDcttlWz9Ih0gswBIXCxPAmDOJaPgkluSEHQpCh6
 MPRmCk7/C5ChePEV6u9jg0t7mhRinBjlz5o979nWXA==
X-Google-Smtp-Source: ABdhPJxh1RNVQiQp5bCHRakekzyhAZR4aqS7papfBzgGL0DdgK61i7YYHDZZLT+jLT3UuH+d/zlCtwSkkzSHByUlUhw=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr9682701ljw.74.1617971763963;
 Fri, 09 Apr 2021 05:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210409112035.27221-1-david@redhat.com>
In-Reply-To: <20210409112035.27221-1-david@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Apr 2021 14:35:52 +0200
Message-ID: <CACRpkdb_eQrcCFV9Q9uho8E6HO4X0dRJp1qAdJBcT82=sZ1v7A@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: introduce and use WANT_DMA_CMA for soft
 dependencies on DMA_CMA
To: David Hildenbrand <david@redhat.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linux-aspeed <linux-aspeed@lists.ozlabs.org>, David Airlie <airlied@linux.ie>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
 Eric Anholt <eric@anholt.net>, Christoph Hellwig <hch@lst.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joel Stanley <joel@jms.id.au>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 The etnaviv authors <etnaviv@lists.freedesktop.org>,
 Maxime Ripard <mripard@kernel.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Jeffery <andrew@aj.id.au>, linux-kernel <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>
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

On Fri, Apr 9, 2021 at 1:20 PM David Hildenbrand <david@redhat.com> wrote:

> Random drivers should not override a user configuration of core knobs
> (e.g., CONFIG_DMA_CMA=n). Applicable drivers would like to use DMA_CMA,
> which depends on CMA, if possible; however, these drivers also have to
> tolerate if DMA_CMA is not available/functioning, for example, if no CMA
> area for DMA_CMA use has been setup via "cma=X". In the worst case, the
> driver cannot do it's job properly in some configurations.

Looks good to me. At least a lot better than what we have.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Let's see if this approach is better for soft dependencies (and if we
> actually have some hard dependencies in there). This is the follow-up
> of
>   https://lkml.kernel.org/r/20210408092011.52763-1-david@redhat.com
>   https://lkml.kernel.org/r/20210408100523.63356-1-david@redhat.com

You can just add these to the commit message with Link:
when applying so people can easily find the discussion from the
commit.

> I was wondering if it would make sense in some drivers to warn if either
> CONFIG_DMA_CMA is not available or if DRM_CMA has not been configured
> properly - just to give people a heads up that something might more likely
> go wrong; that would, however, be future work.

I think the frameworks  (DRM_*_CMA_HELPER)
should pr_info something about it so the individual drivers
don't have to sanity check their entire world.

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
