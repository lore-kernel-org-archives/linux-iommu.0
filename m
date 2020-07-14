Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E0C433E1
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 07:39:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE9320857
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 07:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE9320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CFF9A2E4F5;
	Tue, 14 Jul 2020 07:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oMSOmjwROqCJ; Tue, 14 Jul 2020 07:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 539CC2DE9A;
	Tue, 14 Jul 2020 07:39:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DDABC08A0;
	Tue, 14 Jul 2020 07:39:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4927C0888
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D5CCA8AFF2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zADQLYofgMOF for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 07:39:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 33F928AFF4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:39:40 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id l63so13176511oih.13
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 00:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dCYnWiBfrUG0V4QV9bfy3mtM9Gw/6z5cymsRyqfOxPU=;
 b=MKvaCaUyf2tQ9HkN2DcMnnASwNG3lHG8fjDN6UKMLIwnqb2XAQMMiIcZhGp+5oc6nG
 SAPhnjqD+ezYuIWeumA/ODgtr3pU4V1erFH3B5sStheWJ/NKySuBMRDZy9gl2B0yZfcm
 h547U4eYl+FgXfjzLF7/Nqt49wNZbHVNMjqRZSu1aKnOXTre1VPO6uKzckOLbf7vPN78
 yP2vcQaNvXtkQei5i6oGtph9zCmj3p87fBIwCLukRLZLjMm3ZzEG1kTO+AXcAfP3G/3z
 FXCWU9pcpQpGIiiUX1S9yd9iQhQVqh+ECJ9dWL3wqeyJDLIYCU5abkti6fEHJyHLD38x
 YUsQ==
X-Gm-Message-State: AOAM531+wqpmuJbUiB3GKpHq7bEwqNKdsZqoSG904H+cOsHhAQKF9jZH
 vBMGdD9h8zKnHu64hSO2glYTqMyG92qLVp2KU34=
X-Google-Smtp-Source: ABdhPJx5dphEyeiFZMm6iXlEYQPyjm7HBBuh4FxBXEBpFTIMln0CZySUEMQ/80bez3KevRXtht7yiFFsC0OTtXhX8oU=
X-Received: by 2002:aca:5c41:: with SMTP id q62mr2546599oib.148.1594712379512; 
 Tue, 14 Jul 2020 00:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594676120-5862-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2020 09:39:28 +0200
Message-ID: <CAMuHMdVyJTZ2-YS-WvjAr0ca_EfNdLk3+PEOSK8L5vShd97VWg@mail.gmail.com>
Subject: Re: [PATCH 4/9] dt-bindings: dma: renesas,rcar-dmac: Document
 R8A774E1 bindings
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

On Mon, Jul 13, 2020 at 11:35 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/G2H (R8A774E1) SoC also has the R-Car gen3 compatible
> DMA controllers, therefore document RZ/G2H specific bindings.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

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
