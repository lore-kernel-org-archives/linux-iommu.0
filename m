Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F1C433EB
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 07:35:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B129D207BB
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 07:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B129D207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9CAC28AF72;
	Tue, 14 Jul 2020 07:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrnYF6oIaYfv; Tue, 14 Jul 2020 07:35:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A8E238AF6D;
	Tue, 14 Jul 2020 07:35:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A222FC0888;
	Tue, 14 Jul 2020 07:35:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA7E9C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B6FB98AA21
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:35:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6a7hXmebFFU5 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 07:35:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7B5908AA1F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:35:34 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id h1so12281323otq.12
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 00:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NZcIe/n8EL1l/9gxEVLtkEGOYa9jYbE3R0xJVcLLVWo=;
 b=BH47jE5qYFNsxrm94uj98EH/X4g07Q3nxVH2Lmrx1BGMbu+mxC8UT3f7jDZiYsNPHF
 u+klDg09JUc2AcDppBQOs81BwvgG6iaXPnu1U57ETl24qvd/t+8AMunjOMSRoNM/Hum7
 GKSrEK2/h/uRd7tYGRQazHyuvV1nm2cybFLpID31vb3wjQIYO1+KdSBlu/IWD9gaVXZU
 3Eg9D8aaJebqujk7PN0DC2WoYiDrL0DnxQp30udQKxEEhkqFGEnBfqyZrqenxNK75k1i
 vBOqMFxEDSy0NDWj81kIlWd5+uLPS0K9qi4Dg2D8GwvZySh4lFrCngtzdTHIBI6I5ybk
 t0Hw==
X-Gm-Message-State: AOAM533eGBT1t29MWk51V7qW+dLwCaZmlT9+af5n9SgPNmmYxSML/YZx
 A7ByJFajdfpB+TpGRV/VXQLGODXP1uqy7IehHbE=
X-Google-Smtp-Source: ABdhPJzA6FPp5jleEWzm/FeVEe/oRoGYj9B6NSxQuasfiLs2MoznFs7U6TgH+op0h6Q480AB2MO5mvvOiAIGabzifls=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr2793065otb.107.1594712133696; 
 Tue, 14 Jul 2020 00:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594676120-5862-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2020 09:35:22 +0200
Message-ID: <CAMuHMdX2w+N4=UNEbK_yELvgs0BZ4rXM=QdAwvgWbZokHN+s0Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: iommu: renesas,
 ipmmu-vmsa: Add r8a774e1 support
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
> Document RZ/G2H (R8A774E1) SoC bindings.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> @@ -32,6 +32,7 @@ properties:
>            - enum:
>                - renesas,ipmmu-r8a774a1 # RZ/G2M
>                - renesas,ipmmu-r8a774b1 # RZ/G2N
> +              - renesas,ipmmu-r8a774e1 # RZ/G2H
>                - renesas,ipmmu-r8a774c0 # RZ/G2E

Please preserve alphabetical sort order.

>                - renesas,ipmmu-r8a7795  # R-Car H3
>                - renesas,ipmmu-r8a7796  # R-Car M3-W

With the above fixed:
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
