Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3FEC433E6
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:09:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B467217A0
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B467217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DBCAB204F4;
	Tue, 14 Jul 2020 08:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mAvSbymvHi5m; Tue, 14 Jul 2020 08:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C0D88203D4;
	Tue, 14 Jul 2020 08:09:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0202C0891;
	Tue, 14 Jul 2020 08:09:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11570C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BEF5F20497
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T2xuq4b4Xhtf for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 08:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 86D0A203D4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:09:37 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id k6so13228478oij.11
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 01:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kQd/3+NgYL5ETBCqN/I6t615NftKK//t8YpCv8X+l+8=;
 b=TTHuYe+L3SKgeazZV+9oWMBdNBqVxrw3Peoh6qEzTL/XWyF9RPefg5NiDNO7h0Fma/
 SICFdvSxHqsAfeG6oxzujU3gjsoFAaSwFqmM6seBTPfSKlCPEvWvk4SzgihGokOBnV52
 FOv4PTIdc8MKzv5dK6FafRNIpanmFscQ/NJ59BVRZDNUcC81xG3YEbE2ILu3Xjgdw57Y
 dbXGw99pdUKkPxoq8sFHkC3ygNJhS6Iju7j6gH6wNmjHYIurNLNOqYQ+6H+wVqnxe7h4
 gYKifZ8AVPtGbUhIxdoR1fC6t7DATDAPTwQuxZEjKxuRP4jPeSLNviP8H0sQqHi8JCaD
 Slxw==
X-Gm-Message-State: AOAM532zNA7bixZxxYwxkfDZJcLh6faOanNB5GBpwpkJR6XqK9/o9uV6
 1EkaBWE9bpQPQYMma2/rkD88jFst3xVz2b5riT0=
X-Google-Smtp-Source: ABdhPJz7hdIV/baG1FFq5NebTyyKrvGlXKfMdm90XT59CL4jYHtqaTc+X/vLw/NAnF5ngIMw26ZC9YKmVtr4fJbw2xI=
X-Received: by 2002:aca:ac10:: with SMTP id v16mr2565069oie.153.1594714176638; 
 Tue, 14 Jul 2020 01:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594676120-5862-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2020 10:09:25 +0200
Message-ID: <CAMuHMdV4zzrk_=-2Cmgq8=PKTeU457iveJ58gYekJ-Z8SXqaCQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Prabhakar <prabhakar.csengg@gmail.com>,
 dmaengine <dmaengine@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Prabhakar,

On Mon, Jul 13, 2020 at 11:35 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> Add support for RZ/G2H (R8A774E1) SoC IPMMUs.
>
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -751,6 +751,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
>  static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
>         { .soc_id = "r8a774b1", },
>         { .soc_id = "r8a774c0", },
> +       { .soc_id = "r8a774e1", },

Adding an entry to soc_rcar_gen3_whitelist[] doesn't do anything, unless
you also add the same entry to soc_rcar_gen3[].

>         { .soc_id = "r8a7795", .revision = "ES3.*" },
>         { .soc_id = "r8a77961", },
>         { .soc_id = "r8a77965", },
> @@ -963,6 +964,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
>         }, {
>                 .compatible = "renesas,ipmmu-r8a774c0",
>                 .data = &ipmmu_features_rcar_gen3,
> +       }, {
> +               .compatible = "renesas,ipmmu-r8a774e1",
> +               .data = &ipmmu_features_rcar_gen3,
>         }, {
>                 .compatible = "renesas,ipmmu-r8a7795",
>                 .data = &ipmmu_features_rcar_gen3,

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
