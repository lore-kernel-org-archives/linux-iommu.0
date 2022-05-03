Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BC0C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 13:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52DAB41704;
	Tue,  3 May 2022 13:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CWFD2QlU0pPZ; Tue,  3 May 2022 13:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC92F416C2;
	Tue,  3 May 2022 13:01:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B073BC0032;
	Tue,  3 May 2022 13:01:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC26EC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A7F841703
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJLleESbi7f1 for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 13:01:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83219416C2
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:01:48 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id t5so9126649edw.11
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7Ds4LsGaaSrzpA9k9avFD90e+PqgmFVGpadAexhLvgE=;
 b=TdQOH2zo//QPttTudYGt81Z/yDrk3BSGIIjNieyYejqrMODsRAdwkCkxG18RvmueY6
 iHFaaqU2/gYGDutjRihcCZFaaai0E01p24AIiaL8R/CQ4n112uUATO3kkkVoKcptUI1o
 Sn+gCjKas+iRbrUB+31MZeSCs6QnEqo5T0yo0DWpz1TNP0IGP9LTJd26Fg74q/sFQWvX
 uIyzYpKYZZYkVDdC3nuHpXYj/+ApiO3w9x/b+9HpuFzGQOU0z9hI90Ah15PrgqYMaDbq
 BUwq10cb9/Nn050mB+f3Zn8of/wNnGLWFGnXKAgfBOQa17weFRGlsp2Fbxwgy7bU7bDU
 +yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7Ds4LsGaaSrzpA9k9avFD90e+PqgmFVGpadAexhLvgE=;
 b=o1wTbO9tIDkU5zcAoVv7bPxbc2vzcEeruvkmz61TaZtccePsmVWNmMsD9KOAp/ys6x
 cwnMd0gO/X4/mk9SDRdHOWELdCsaancX44Db7n2clprgDRBClT1PMmJQOVUrHmBUWLAc
 hPFSEMxLLH5mwfSAJcVAjZmTl9RCAW+urEROuCCdUhm2Wa0nWJ77L2Qjz8tOrf/WkEX7
 Hu2cf71gvLwnnKhCohmY9gWgZ1uOqDh1847Mh/vFW7OBt36bh8F00Oiw08gEdS9Fxk7B
 Gg2K3yVcM41oQ49ZGHVKaulEzU2yR1KR4TlFzCOfanfaiLIA2u5QPZWBRqBB4W1sZDVN
 dTLg==
X-Gm-Message-State: AOAM5306oRGQE3gzM85RIUf0yrXajnnj6+YA8mdvxA+3BVuiycItwjkT
 83vprSRgSZnzbf+eYeXPkdvcBQ==
X-Google-Smtp-Source: ABdhPJzXf9VagfCKbioCX60kpRy8+OaEk9krJsm0GbbDF+wR9UXDeBuW7D0hkkgWHFhOjR95J6X9Hg==
X-Received: by 2002:a05:6402:e99:b0:41d:11f2:85e0 with SMTP id
 h25-20020a0564020e9900b0041d11f285e0mr17473687eda.339.1651582906512; 
 Tue, 03 May 2022 06:01:46 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 e12-20020a170906844c00b006f3ef214e3esm4573792ejy.164.2022.05.03.06.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 06:01:45 -0700 (PDT)
Message-ID: <8adbf80b-f057-c915-954a-12bd07ee7cc8@linaro.org>
Date: Tue, 3 May 2022 15:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/7] dt-bindings: i2c: renesas,rcar-i2c: R-Car V3U is
 R-Car Gen4
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
 <a0402ff46027196953fe9c13f60576d40c5aea4c.1651497024.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a0402ff46027196953fe9c13f60576d40c5aea4c.1651497024.git.geert+renesas@glider.be>
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
> family.  I2C on R-Car V3U also supports some extra features (e.g. Slave
> Clock Stretch Select), which are supported by other R-Car Gen4 SoCs, but
> not by any other R-Car Gen3 SoC.
> 
> Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
