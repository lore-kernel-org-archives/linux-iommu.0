Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C60C4332F
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 13:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFCA180BE3;
	Tue,  3 May 2022 13:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FW4Um2aqS-jQ; Tue,  3 May 2022 13:01:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D6BC680BD7;
	Tue,  3 May 2022 13:01:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80AFAC0032;
	Tue,  3 May 2022 13:01:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EAAAC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E464404D8
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JZ_3-Pxm6sje for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 13:01:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88CCB4013A
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:01:37 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id p4so19836728edx.0
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=gG0dwpdZEvdDBuvEs96CRkJ96qnrRXLRezy0ryDW5k4=;
 b=ALFTAYUx97uyNKW+lAnYdzjZir2++CoTgHbyUjF7Tyu8FB355br9ymFrLHz0yjDrvH
 DrBwdFc3LklD9yrRb89qLlvZA45swTSbmHuxKgldKlCxDB9G9Bd/rTJMgy2E5BhuXpNG
 yb3uDyAd0RZWZOAzkIzno8BwG1U9FqEA2iDDfvFQdY1zAtE4mcYmqd0IK3E8B6WW5z6O
 Il7T85auivSNN1fPpuxtB8GmcDN5yYpug0AHyoO9xlmN/aBKvPJd2Lo3lmc7T3UxTryT
 aSyIBP9yrCWMYKMi9FYlBuxD7LnSgPuAOlxYmPFIuuY5zYNOFH/jYeetXY4nPgZt1+cp
 4lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gG0dwpdZEvdDBuvEs96CRkJ96qnrRXLRezy0ryDW5k4=;
 b=5JQ8SSXKPwXKh0VyNsBiv49n677s5jb9bhXzIcuXW7Tos4bC68Iuh1BZ4UxSz/y7fM
 NnzdnPcPm7ZHRGYcI995MwnRuwW0Aj1PJlHMEISf44jInfA9WerCW4SNt+oCfVQ72nPF
 3F6vdM+L5tm3yAo8XEFhFv838WapyS5WxoKATTJ0jP/0wbqTXpsCRmdTfy6ClT0NXEZm
 BjphgLr/rN2mOd6+iN798LLkimATS7rgUpV/YGzXVhmGzvBYLrXMssW6gBFu4nhrKzJ7
 0o2RbiEM1s6RiWY5h10BkTXmYRBKcCpzyWiZDTm7Dy551bJ0lzaqljCu4d3SudcbHSU8
 KrRw==
X-Gm-Message-State: AOAM5304NEAi6SVwzDwJ3YPUH037oW4JGTOHkRKfaj5GSb+KCdkTfhuU
 iIPLasEV2zh222RoGbX/GT64uQ==
X-Google-Smtp-Source: ABdhPJx2Srwjeq9nawpv4x1JuljzsyhT5QkLcbjVFz2bgafQYS+1B1AShuziH+AsAOVKPNcC8AG0zA==
X-Received: by 2002:aa7:c0c4:0:b0:425:c776:6f17 with SMTP id
 j4-20020aa7c0c4000000b00425c7766f17mr17610108edp.131.1651582895443; 
 Tue, 03 May 2022 06:01:35 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 hy10-20020a1709068a6a00b006f3ef214dd4sm4687649ejc.58.2022.05.03.06.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 06:01:34 -0700 (PDT)
Message-ID: <9d7514fd-511e-6596-5eb0-6001ead5a081@linaro.org>
Date: Tue, 3 May 2022 15:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/7] dt-bindings: gpio: renesas,rcar-gpio: R-Car V3U is
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
 <5628a862688bd9d3b4f6c66cb338671211058641.1651497024.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5628a862688bd9d3b4f6c66cb338671211058641.1651497024.git.geert+renesas@glider.be>
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


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
