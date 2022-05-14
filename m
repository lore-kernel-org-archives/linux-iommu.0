Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487CCC43219
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 14:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9BD260E22;
	Sat, 14 May 2022 14:15:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GuUZcAK1nBMM; Sat, 14 May 2022 14:15:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B47E660BB3;
	Sat, 14 May 2022 14:15:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 786C6C0032;
	Sat, 14 May 2022 14:15:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E631DC002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 14:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6A6740C72
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 14:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SK3U_I3K1Opb for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 14:15:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 054B5400A6
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 14:15:38 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-e93bbb54f9so13942271fac.12
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=V0UWMw+8IC5/blrDj2MNiuz1nnIEdolub0ud2xnX3wc=;
 b=dkxvJMEFx6NNgw1tH/UOFEVkB83/cvgCoN2PlMfOTAvFF3YrqCpWz24cv5z8xQwuP7
 BcwvEsuFTuyE8yjru1Pi9Q9cgXnx/x9R5X1crekVv9DRnAcrnELwo3xV1+gyUaEzYXqH
 2VUhW79PlCNlREYwLWgPacsLZpLg/SR1rbTxCrHKruvIDmJ15NRQ1aWlUpvb1oblcA6c
 U16dqcZxJxDVmmhhEtOaqJlvLnZm618xa4XDWfp31YWmyoDpO6YqqvqeDNcXATzvnLdr
 AjTjqn6W2vguXwB/Unl/2mEHV4UkX8F6g+4VT6wc7OouhdHE7n3go4ycJIu1c2LG90Js
 AvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=V0UWMw+8IC5/blrDj2MNiuz1nnIEdolub0ud2xnX3wc=;
 b=ZD9YImu5RZ1xzo6PIsO4kxyE0xvbGIGSpdB02q+98XRCLTMlEvLpqv/VJ4ioSyiTt8
 6vOyIfuuIisK2AGyGK0b04b4bq3Qevq3SKDHU0FOtRXeRLCE4nWr0dDkvNTwyWEY1GGG
 kfJqDgvIesc2hBc+D0b63f+PR2Uhk5hpDk3k7/cCA3kW5LhhjfTopwDvWVzvTt18kDXg
 xEvdXwTapiVMTxS7wqbXm4/DniaJiD4JxtkNf2fyKZbo+zSTVZ1wpVUNCkTvdiIJZs5Y
 zYk1NoMAr9d1+qjHCLMEZ0L3Fc5hScznkwrj3FVZLglT4RZePhnIOCdn3XoBsu9AikMF
 g1rg==
X-Gm-Message-State: AOAM533FodHf7oRxVYc82LQR3NNxj78QZ22ehm0x5YiMrJbdgkADeZR1
 IPdLrxdxmtxoDASAlrLBtvg=
X-Google-Smtp-Source: ABdhPJxIh4A6RDGJLkqD3wI+SAa3lP6jsUbrzhaqHnQbP/kqqs6hM/AP18eGNJmYYJxAgVXlsnJ15A==
X-Received: by 2002:a05:6871:70c:b0:ed:e6c2:e599 with SMTP id
 f12-20020a056871070c00b000ede6c2e599mr5088966oap.70.1652537737907; 
 Sat, 14 May 2022 07:15:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n39-20020a05687055a700b000e686d1389dsm2401199oao.55.2022.05.14.07.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 May 2022 07:15:37 -0700 (PDT)
Date: Sat, 14 May 2022 07:15:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 7/7] dt-bindings: watchdog: renesas,wdt: R-Car V3U is
 R-Car Gen4
Message-ID: <20220514141536.GA1319284@roeck-us.net>
References: <cover.1651497024.git.geert+renesas@glider.be>
 <2882a6de3905a57ae62d91060d27521af43c4068.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2882a6de3905a57ae62d91060d27521af43c4068.1651497024.git.geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, iommu@lists.linux-foundation.org,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Will Deacon <will@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
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

On Mon, May 02, 2022 at 03:34:59PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> index 77ee7c4b8067f506..1fa243052327bffe 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -59,11 +59,11 @@ properties:
>                - renesas,r8a77980-wdt     # R-Car V3H
>                - renesas,r8a77990-wdt     # R-Car E3
>                - renesas,r8a77995-wdt     # R-Car D3
> -              - renesas,r8a779a0-wdt     # R-Car V3U
>            - const: renesas,rcar-gen3-wdt # R-Car Gen3 and RZ/G2
>  
>        - items:
>            - enum:
> +              - renesas,r8a779a0-wdt     # R-Car V3U
>                - renesas,r8a779f0-wdt     # R-Car S4-8
>            - const: renesas,rcar-gen4-wdt # R-Car Gen4
>  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
