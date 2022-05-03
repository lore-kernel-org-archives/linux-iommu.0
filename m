Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1272C433EF
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 13:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A26281AF4;
	Tue,  3 May 2022 13:02:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id adIbaZgQAOSQ; Tue,  3 May 2022 13:02:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5FC9D81A6F;
	Tue,  3 May 2022 13:02:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27AABC0032;
	Tue,  3 May 2022 13:02:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66896C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4ADFB40202
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lwD2xrEtSb8M for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 13:02:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 571B4414E5
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 13:02:53 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id kq17so33311447ejb.4
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qbnGzeiR9n+jtdORIFMoIldw5poAE5Ic2SlWDsgrYLI=;
 b=D6ODiYiIAOq4680jRE0r6sz7NBgVaflE38879YIgVcTq+BgzTIur3abMKZRHdw4Pc0
 AHy3ffkeh2yYA6wAyommfVjIplN9+s1tgWJ5yCVxBB/ANFRBIToGgh0enXTPLE/lCKFH
 DRt23I3yJRpZatTL62UWKmBJ6izyAV6D6qDwQtlhanCwo8qXs6S3pj5nZvl+aCDQf41x
 RHFiQsHUog0on2w5ATGEsU9tIUqDSTg0vfpVyr7csPbAASD116vtblzcOOhgYevR7xBf
 yllAmtumhEcMX/P4+BGW/zxR4S8aDzH9CXu9BVobIghNMvhEa8hfva1Bf9bMDhCZQ0ib
 3ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qbnGzeiR9n+jtdORIFMoIldw5poAE5Ic2SlWDsgrYLI=;
 b=uHMVDgG9F2A64A9sk0WLz+sLjA4yidc3iD6/Y+TuApGkZq6nmWKA2Fdb049Iqztz0M
 tW7xwGJMn9oWadc+vl2Rn8PYy7oNRRZwqbwKYWOxjChe2lK2vikQX3nuD4GXwzrH+Jpe
 DDrQPDM1gYbVFSq4oeOPXUQDfVS1ijh/YHp3bKb6q+oKYBYxT/pcgi6dwttC8yC3RwgC
 mf8pVaqlCr87qKRUo5Be4a3IOGBIkkrVBJh3yAD3m9l66KTSwZjdYQF8IsGT4oKPXIdZ
 4/cufF0gx51W5AZUR+b/8JswSi9y9v6DZwV0TtSj0rDtMRRsXt0rdb2/Y6CXcPQj1V5R
 Vjig==
X-Gm-Message-State: AOAM530xV4OBDhxByqVm+sfSJAAev5Mfk++S5xVJBrl+c4LvkKq6wMNG
 ubm0nVN6lGJ1qBCkMa9JDFZbyg==
X-Google-Smtp-Source: ABdhPJzx5OTqy0DzCPuoSuaGWR/+9NH7Kk5UphcTdkN6WB1lmvnQYczzFaoz4B92b11pSHYTnAvakg==
X-Received: by 2002:a17:907:161f:b0:6f4:378a:c2d8 with SMTP id
 hb31-20020a170907161f00b006f4378ac2d8mr11365067ejc.289.1651582971502; 
 Tue, 03 May 2022 06:02:51 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 qs24-20020a170906459800b006f3ef214e19sm4598147ejc.127.2022.05.03.06.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 06:02:51 -0700 (PDT)
Message-ID: <8d375385-3114-d372-4aa1-a5da9b740d53@linaro.org>
Date: Tue, 3 May 2022 15:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/7] dt-bindings: serial: renesas, scif: R-Car V3U is R-Car
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
 <c57ed00e85778380776330be6183c6861d843c22.1651497024.git.geert+renesas@glider.be>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c57ed00e85778380776330be6183c6861d843c22.1651497024.git.geert+renesas@glider.be>
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


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
