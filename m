Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F5CC4167B
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 13:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F27B404D8;
	Tue,  3 May 2022 13:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OKjSV3bshpPg; Tue,  3 May 2022 13:02:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CF3A4013A;
	Tue,  3 May 2022 13:02:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4A67C0032;
	Tue,  3 May 2022 13:02:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1C97C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFB86404D8
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WfjofNzH8Gsn for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 13:02:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4D854013A
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:43 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id gh6so33387727ejb.0
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=wjuyFMi3EftK+wExgb79hTBMB0k+0b/v8BwPvQxw7y4=;
 b=ewo04wJHjJ26IyHukQuan08cFZWOZ7IDAC+rphPmISbWSJd0i7v3ydWkWRbJ4mr7Ir
 oZY274wqWX45dwJ5aPdkSSK8pPqMMQo4ZOGhI9o5qQ2aDJ5qP0hdW/BlyBUw8jZwPs3d
 SOFA6kOq+ru/zHs/BJjJT1nJpDCVqg8mRMSB1EYvyPpQQDymST5pAkIAzQLfhTv+fAwu
 eThs6VpM6H8m0MkjAdQvsUEzXZa9ss9qkrkJz5tUBqMhJpEx63XHJZ9Z+9xgIwfijEuZ
 /Fvtj3PsqngNq8kFBbxK0YvvreqgxpWJ5oRc82770+h+mdqefxw4D9hk4YSmX8vYz0fl
 chIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=wjuyFMi3EftK+wExgb79hTBMB0k+0b/v8BwPvQxw7y4=;
 b=Adaw94/fB4q/G9b9MeZlMXtHINImiEim6lMk1bwaV4G1+vzVQyHsm69/2yYMqKId9Z
 RwhoeAiES4UZFa5TLLNKDFzSsmcvp9fYvTdp0TWwdxw14ZQ/gOSG2GBla7LpgZjkj1qc
 Wh0eAUUadzvLnZ0pm+GQuCqUtPRmvSdXcgpRDiiSWXupEyijaWW5epGYOjmSyKcb8Nfm
 Z2qcnk1Rh4GnNAhQWz0WYgB1QxhOJATzncmOCM69YlSMdlcttQM+68ErMU2TKkiBF9nE
 GnUIVw2Wr353ZcqFvpbfNEnEw94il9+YQKaq6oKtZD/rz5jRLiSOqaUoX3un/B+Zk+Ip
 /d6g==
X-Gm-Message-State: AOAM533GSlT8k2qPs8SEhdFD6gGw5iVnIJDrz9bEJ52kM78Gc/Vi7oDo
 GQ9wUZnFO3ZuS95rFZfRCkQ1YA==
X-Google-Smtp-Source: ABdhPJxWgTe6ERgukBkZ++ex9vxpB+SWDPBIHrtqfv1/46KOzrlx42JkXeG5wZwA4KLrDpdY8UXEeA==
X-Received: by 2002:a17:907:c0d:b0:6f3:ed89:d9c with SMTP id
 ga13-20020a1709070c0d00b006f3ed890d9cmr15463845ejc.502.1651582962080; 
 Tue, 03 May 2022 06:02:42 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 hz22-20020a1709072cf600b006f3ef214df2sm4600317ejc.88.2022.05.03.06.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 06:02:41 -0700 (PDT)
Message-ID: <5ca8b4d2-5edc-0962-9b26-6701515a26cc@linaro.org>
Date: Tue, 3 May 2022 15:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/7] dt-bindings: serial: renesas,hscif: R-Car V3U is
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
 <dd734aaa4e5e0b32864b038b79eafe72907fb99f.1651497024.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dd734aaa4e5e0b32864b038b79eafe72907fb99f.1651497024.git.geert+renesas@glider.be>
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
