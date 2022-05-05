Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C21DC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 13:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E16C384020;
	Thu,  5 May 2022 13:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JzdUL3_NcxyF; Thu,  5 May 2022 13:05:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BFBAC8400D;
	Thu,  5 May 2022 13:05:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 947B2C0032;
	Thu,  5 May 2022 13:05:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B2FFC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 13:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15EEC6111B
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 13:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bgdev-pl.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bY212Vkz_Ard for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 13:05:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACA9461113
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 13:05:07 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id i19so8587888eja.11
 for <iommu@lists.linux-foundation.org>; Thu, 05 May 2022 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sxVJoGvxoT/BfORhwUe0lF83tKeGUQ56jY7vzgfAHU4=;
 b=Y0K2T7eDDIErEPqMy8O6G47SIMuNV/FV2iBabtCwdZYCRksLJj+E+c7fbrSt9ZBBXD
 DaXJNvwCp8O95B7G3qBBBXd/ZY5LglYP8OcOlRsRkLkFbnOz5YGjf1+Kq+Cej6sf1PKz
 8jox3zcMMsB69mnVMtXKZEg+/RyB0rS4FojXfONdqL7k9Dw/I4yA/G/3RFFnSgWC8agR
 bsZsTNdQJo4ur+mN0mOVzXqc/pW10pVTqbvQpkdO4R2oawKCjQrPZ/LhQquGSb8INoG5
 zUIcx6Usp3yJ11Kt8LC8bG4AgtPbYUl5xx+MqNZTXX94AuUxIh18hRHgvcWzdek9DC0O
 2i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sxVJoGvxoT/BfORhwUe0lF83tKeGUQ56jY7vzgfAHU4=;
 b=2eKUf5KjOdUI/if5oBcABy5DEceXw2Wo7di8RjXFP2+2Ez4bJkJ30iw+R+5iwiLtMj
 KxA/4mlfA8FrFY2yuwQKLr5JZD+JFhu8GB9pWUPzI6tdEWNcMy9UnZx+om0OCBu1ZdaM
 V07YoXwGEHahOZdvw1z/EjynUV5/874kigxadziXkfWZRjxoqtgKtZmX0m2bosO0uJyb
 wsfO7UXGxPHNAhnSeN2hFtt2IZiXKA/fugM/pEDcfOGLiJ1eRRb6wtAyh0th1IealJem
 WSdn5ELhD1wnLI330OIGRrBOX5UTUEWZCAwQC0GISiUN+sBBMnIKHr0n3vz5/JxwK3PK
 zIug==
X-Gm-Message-State: AOAM533DK3Al4Zj2k6wbse68MG0j97qPK4QmiblT6+HJ2VqNT5z7P8Vo
 srCBq6DJ/sQLqTNNk68ZCTLrJzSkHysOQIi/58lH8A==
X-Google-Smtp-Source: ABdhPJxyNkSLwouP3OR63NyFLRxUlmDS+dFIZZqJlV9mcUABNttg9TsG8+o4n8l4yoY3YgwsQa8BiV83N6jWTpdMxkc=
X-Received: by 2002:a17:907:3e28:b0:6f4:3900:78f8 with SMTP id
 hp40-20020a1709073e2800b006f4390078f8mr21714935ejc.736.1651755905797; Thu, 05
 May 2022 06:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651497024.git.geert+renesas@glider.be>
 <5628a862688bd9d3b4f6c66cb338671211058641.1651497024.git.geert+renesas@glider.be>
In-Reply-To: <5628a862688bd9d3b4f6c66cb338671211058641.1651497024.git.geert+renesas@glider.be>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 May 2022 15:04:55 +0200
Message-ID: <CAMRc=MeQZ_T_AoHUO3qx7oW68UMC6HH9CaC041vYr7wQisqjHA@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: gpio: renesas,rcar-gpio: R-Car V3U is
 R-Car Gen4
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree <devicetree@vger.kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, iommu@lists.linux-foundation.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Will Deacon <will@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
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

On Mon, May 2, 2022 at 3:35 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml b/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml
> index 0681a4790cd62e23..75e5da6a7cc04bbd 100644
> --- a/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml
> @@ -48,11 +48,9 @@ properties:
>                - renesas,gpio-r8a77995     # R-Car D3
>            - const: renesas,rcar-gen3-gpio # R-Car Gen3 or RZ/G2
>
> -      - items:
> -          - const: renesas,gpio-r8a779a0  # R-Car V3U
> -
>        - items:
>            - enum:
> +              - renesas,gpio-r8a779a0     # R-Car V3U
>                - renesas,gpio-r8a779f0     # R-Car S4-8
>            - const: renesas,rcar-gen4-gpio # R-Car Gen4
>
> --
> 2.25.1
>

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
