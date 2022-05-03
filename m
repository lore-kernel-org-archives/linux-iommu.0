Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8338CC4167B
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 13:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D4E060DED;
	Tue,  3 May 2022 13:02:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p2VwyYM_0HGK; Tue,  3 May 2022 13:02:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3206F60D80;
	Tue,  3 May 2022 13:02:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AFD8C0032;
	Tue,  3 May 2022 13:02:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 327E9C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 207C160DED
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsmKd4QrwbXI for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 13:02:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 022DF60D4F
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:04 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id g6so33339755ejw.1
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=gG0dwpdZEvdDBuvEs96CRkJ96qnrRXLRezy0ryDW5k4=;
 b=iiLBanpH6wybOhZdNakFRvRs/BeXfFL83n5+Lp6Hk+x8s4leUeYYMGQWoKhxdpV0J7
 1pMHBh7WBGFu2aKPfvAG8qHgzXsaxjTaUP21ZqKj2SdLil5rGETMK+rKKjik4TsIGlz4
 bStUUyeQgLTPYIQbXVH9CI+JwLohyzcNlnh0EddrVl/+5iXTis7GfrF8gXtp22jpqs6x
 Os702VOj32qcnCl6Y+AvVClQGt8Xc9lno1vKq5ntzEEQiZPBZhEw3UL/WiHPD/nCT0sR
 G+D9buwLum2kNO2Dv69bhfmEDDFTPqng8UG3245Vaof+4RALxYwzxjBGxDrOAJYiHy9l
 hdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gG0dwpdZEvdDBuvEs96CRkJ96qnrRXLRezy0ryDW5k4=;
 b=vvv/Ld9S+uUMnwoDE2MQIktbx9dG35ZToInzsLf4c4sBXi8iN2Qo9oIp9TQats2cWu
 lZzUh+ToE1NB9Q0ibvcylPlIqZUC+yBzsCdaQZfVDG0Liv/zV2QW5pQW1M38lGv7a0y9
 HOaD4DtSTy8tiu6inmYtHAde1Z8vNrbFHbf0HkOghhi0l26YHIl3x8Yis+rxlEeE8PwD
 5lM33JBJnLJjGd6F5acoIYcgjMuCDyAvtVL0A8Ee057j2DPdF/O4TltElJp3gqeOMtGk
 Ojlhi2m9LCiFRMjxAugcKJyGNgmJy5+/Nj9fcIytY/ZDbmZYHXXAO9YDFxw/uGkvYZQO
 ydwQ==
X-Gm-Message-State: AOAM531zAMTywc1vyoo/UbWvqu7pRU+YYUfSH6XdV2qImczAYAYNsWNV
 LszZh7gK+TKUZAEAoWFdePtUdA==
X-Google-Smtp-Source: ABdhPJzUs71nSjzDp07qt341z8RRJvmbCI1x3IOR5rmNgkg5GAi+ZNa6GypbybXufvf81im24u2DAA==
X-Received: by 2002:a17:907:8689:b0:6f3:de80:dc02 with SMTP id
 qa9-20020a170907868900b006f3de80dc02mr15186555ejc.331.1651582923231; 
 Tue, 03 May 2022 06:02:03 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 gv18-20020a1709072bd200b006f3ef214e50sm4503961ejc.182.2022.05.03.06.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 06:02:02 -0700 (PDT)
Message-ID: <b7a42857-cdc8-32bd-04a0-827318fb82e2@linaro.org>
Date: Tue, 3 May 2022 15:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/7] dt-bindings: watchdog: renesas,wdt: R-Car V3U is
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
 <2882a6de3905a57ae62d91060d27521af43c4068.1651497024.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2882a6de3905a57ae62d91060d27521af43c4068.1651497024.git.geert+renesas@glider.be>
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
