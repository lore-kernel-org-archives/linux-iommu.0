Return-Path: <SRS0=Z7zF=N4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46907C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 15:33:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF62460E52
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 15:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF62460E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B0B2605F4;
	Mon,  6 Sep 2021 15:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uWXUMOi-JWBM; Mon,  6 Sep 2021 15:33:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61A53605F6;
	Mon,  6 Sep 2021 15:33:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45192C001C;
	Mon,  6 Sep 2021 15:33:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4094EC001B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 15:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 291CE40281
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 15:33:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id laOokPUg20M3 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 15:33:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A403F40268
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 15:33:49 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id t19so2319358vkk.2
 for <iommu@lists.linux-foundation.org>; Mon, 06 Sep 2021 08:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vurnog586LelhGKIAETgFB3SlUTlYV5Ye/u5xa1mces=;
 b=fMeorDWRlTRz4NF1OlGwWLP03aIcODsQC8Oho/ghF+OgTXhCAG+o4owakvlhQQIHxI
 gt2q231xMJdBddOwnnUZmjJyOVqZ3TOhsa4r85ElNhp0nYdxzYPLlJNfA5jrDNnCK79e
 iw1Kg1zEpZ08QQKkNZfFsMtHh49IY2lk6OI2rAjJZ9Ew28AoS3pmbYhHeEyRv1jAscWQ
 7qfHy1cnzsRo1GrvIUkASCm6RSPP+gRiH91jGyNKqjqSR/oMF7sbinkpZf0mwCbCXrrT
 gGFbZlGkltknuRe1pOLR5rDOPvg6Ge5Zvsn9sOmOnK0NVEVS1qtLbzvsDW1iOq+Xgw9Z
 mfkw==
X-Gm-Message-State: AOAM531WqIftVPyR6rJIqbl2SJT63f7Mc0xqMuIbYs+KQORmlIIUv+ZP
 0qy9AgxXujnX7aZ3bNxYzAwTZ/i+ID17HVIxTCQXh1oD
X-Google-Smtp-Source: ABdhPJwbpu6+6jutpiO40IYUpYC/LGtFpT4vQkjLQimOl6eXfUeX70f6OavLgBYdFvcp4zyAc46Ik3ygTt/BGFgGcbs=
X-Received: by 2002:a1f:fc8f:: with SMTP id a137mr5454283vki.19.1630942428209; 
 Mon, 06 Sep 2021 08:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210901102705.556093-1-yoshihiro.shimoda.uh@renesas.com>
 <20210901102705.556093-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20210901102705.556093-3-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Sep 2021 17:33:37 +0200
Message-ID: <CAMuHMdXwf0_+VKfuiFQf6roZErz-JAm06P5RBzD-Jwm1uk=p9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for r8a779a0
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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

Hi Shimoda-san,

On Wed, Sep 1, 2021 at 12:27 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add support for r8a779a0 (R-Car V3U). The IPMMU hardware design
> of this SoC differs than others. So, add a new ipmmu_features for it.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c

> @@ -922,6 +922,20 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
>         .utlb_offset_base = 0,
>  };
>
> +static const struct ipmmu_features ipmmu_features_r8a779a0 = {
> +       .use_ns_alias_offset = false,
> +       .has_cache_leaf_nodes = true,
> +       .number_of_contexts = 8,

Shouldn't this be 16?
Or do you plan to add support for more than 8 contexts later, as that
would require increasing IPMMU_CTX_MAX, and updating ipmmu_ctx_reg()
to handle the second bank of 8 contexts?

Regardless, I assume this will still work when when limiting to 8
contexts, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
