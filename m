Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6CFC433EF
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 13:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC65F81A6F;
	Tue,  3 May 2022 13:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZLoS9JAoz1c4; Tue,  3 May 2022 13:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD30881A9C;
	Tue,  3 May 2022 13:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94B75C0032;
	Tue,  3 May 2022 13:02:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA9EFC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A98DB81A4E
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j2VItkVMcvKL for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 13:02:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EA0D81A6F
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:29 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id a21so19763682edb.1
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=iV4tVGnh7QHG+PfLI7Q0mYHuyjPaEc/xG5BZIpO4pGA=;
 b=vlfeNENfF1eD8fgkOGVOtjFsvzln7tEDY/uEOryyt3IHcK5bc03CduITlrE+RmjT9t
 HkAcbdG/F1yq25CW01RMJG7ZegtpUArT99f7TXV4enR2D5bIaMgR0oSP347XArZCCdpS
 qGSVQMoY0pywrhjAmsy+EyIiVd3XrNGmKpA7wEeUYOj3/GPonpwV6l21NY2iA4ja9oML
 7h3cupaTpNJ/0caFjvOLT2aAtApxXPpQt20omxMugYYxJRyy81Lq5aRFR8DbbG6dyOnM
 90GXzqKSr8WPkPU3me/B2ilh5xwXh6CrlYYYdpjNUcY33g6ag+ddd5hhIfNbf8ogTk8i
 v/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iV4tVGnh7QHG+PfLI7Q0mYHuyjPaEc/xG5BZIpO4pGA=;
 b=PuCdS9l7AUUsFOtwRxE0YynmLStuS04HIxjYwilbO8AAmBfzQOwF6VNm9UpJOSovQh
 NGxTGfP1EGMivF4a+wzsckR+d+pB+JWJjsOJku6wRUEx54d7ZRF6yZu9EV5OfyElC44F
 04wZ7VbS718eSWImKu/9Hk3hh0e7Ql8Aib5TMIU1XxETchXuSRaxj30qO5KJO1y+9Yma
 5thvDoTIR/xx81Q2XMN4sB0nIo/WeviieLuRZsIeMZzM7YBPd1odI7JvZKkPu8GB5lHO
 aIq0jH4opqKJSNUE7/QdYOGj/CwAesivv5wJ08EmcmX5sQaJX+9i/FoCs5hNE9kcaPu7
 zG8Q==
X-Gm-Message-State: AOAM533E1Ewn7k/PGyeEpK51mznbbFreflJbjJ66CCxqV2FZYzV2i0WO
 MHYgw5TuldB7Q1GxlaIKx9G56A==
X-Google-Smtp-Source: ABdhPJwIvyRvYCHNzuAJACjjuKhS9C3I9YB94dUMYFyGqf8a7sXjPP+2fhc+RFrOulXQwqT8A5V5tQ==
X-Received: by 2002:a05:6402:5107:b0:427:ded9:9234 with SMTP id
 m7-20020a056402510700b00427ded99234mr4223009edd.275.1651582947612; 
 Tue, 03 May 2022 06:02:27 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 hg1-20020a1709072cc100b006f3ef214e72sm4579481ejc.216.2022.05.03.06.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 06:02:26 -0700 (PDT)
Message-ID: <7dec1fb4-1803-838e-291f-10f56b9fe10e@linaro.org>
Date: Tue, 3 May 2022 15:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/7] dt-bindings: renesas,rcar-dmac: R-Car V3U is R-Car
 Gen4
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <cover.1651497024.git.geert+renesas@glider.be>
 <e6e4cf701f3a43b061b9c3f7f0adc4d6addd4722.1651497024.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e6e4cf701f3a43b061b9c3f7f0adc4d6addd4722.1651497024.git.geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, dmaengine@vger.kernel.org
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

On 02/05/2022 15:34, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/dma/renesas,rcar-dmac.yaml     | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
