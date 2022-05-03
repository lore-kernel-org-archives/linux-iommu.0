Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17165C41535
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 13:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95B7960A99;
	Tue,  3 May 2022 13:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GT53dTf2gBYm; Tue,  3 May 2022 13:02:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7254760D80;
	Tue,  3 May 2022 13:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43E3AC0032;
	Tue,  3 May 2022 13:02:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AB57C007E
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37E4260D4F
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AVdp1libX7m2 for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 13:02:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1109F60D80
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:04 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id k23so33324272ejd.3
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=wjuyFMi3EftK+wExgb79hTBMB0k+0b/v8BwPvQxw7y4=;
 b=oOvQhBmRi4yPVLzZLUCYGs+BVsIOuNPmOP7zuAv3LXMD5ryY+jr8t0qhKx9q+F29WQ
 BFUMY9tC0t8775IV0zq6ZGatAqZ8vb+XQPoD5u8WlFYXY9Uh+p91xkYsKG1i6AMM+dea
 QjUYneOUmX+FKsXrxfDeRI0ClPGkjLAM7MA2UhERQfXsNikqp61+ZKvyowpZMAVC1kcc
 IE+J4noOuFayzwmzRnfXx3bb+i4h+LEFOJSnIgygLWD/q1uU/+Jj/KuwQbLrnbyGdnyL
 bI29AB4FWa5i4EPxR51jt+dA0JJVySxiPs/gI4T72agQLr11VJ9FxB4fZ4IyFzsXoqlV
 6vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=wjuyFMi3EftK+wExgb79hTBMB0k+0b/v8BwPvQxw7y4=;
 b=FDtITZHEGAeMe2/3mKkv5L+gUxs0zY/6DpYdY7fT1C3s/C02MxyIi2AiyKkHQGOz34
 jWk9zKiqb1hnga1XkFYptZ6Sizb3Lxw+wu1HJV33zd1LaMP35khyC64qeVXbfG93Pfd3
 4W1AxLVMBvwCz45FPsRdS3ree7pCx8EqYfUdQH+VjVYP/D02S9HIsF4uyfX4PkUIEzTF
 PhrZsy1MrcMruPUMsZ95WK145YqpSWJxFNbA4py7Qx5z4dbanNAbs3C7xZdl/qSrnhxZ
 59OKjwEP+z+FOBEf/KuP2Pcak/5qWZxLg+ho5wjqW7B4/4V1alpIW8hg20596WKLW0qR
 THGg==
X-Gm-Message-State: AOAM530722PvOMtCWzS1G1pD4pP0+2rGZjO85C9+7hM/rDDJa33jbjpl
 T+MovEBuF/bJUPUQ1PHK9LigeA==
X-Google-Smtp-Source: ABdhPJxwG4sLoDPShcHTI6lbe5nIz0+kudelkrlQymVFFYb3TDP1oKvJEVUWereTSbkBgJoKAqV1MA==
X-Received: by 2002:a17:907:6e28:b0:6f4:6428:6ee8 with SMTP id
 sd40-20020a1709076e2800b006f464286ee8mr6584030ejc.608.1651582918486; 
 Tue, 03 May 2022 06:01:58 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 jz26-20020a17090775fa00b006f3ef214e49sm4580080ejc.175.2022.05.03.06.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 06:01:57 -0700 (PDT)
Message-ID: <b854c7b1-b0b5-b921-e6bf-ee88472d2f66@linaro.org>
Date: Tue, 3 May 2022 15:01:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/7] dt-bindings: iommu: renesas, ipmmu-vmsa: R-Car V3U is
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
 <d351ca12724d5b306119bd8dcd9bfac09ba2a925.1651497024.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d351ca12724d5b306119bd8dcd9bfac09ba2a925.1651497024.git.geert+renesas@glider.be>
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
