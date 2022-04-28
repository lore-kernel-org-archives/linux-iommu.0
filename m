Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BE3C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 07:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 733A64189B;
	Thu, 28 Apr 2022 07:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uzLvO6E2ObYd; Thu, 28 Apr 2022 07:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BF1C241860;
	Thu, 28 Apr 2022 07:19:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B185C0032;
	Thu, 28 Apr 2022 07:19:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C72BC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32BB541866
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sKkqO8Gk3PSf for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 07:19:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C02E41860
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:19:28 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id i27so7708374ejd.9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 00:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=hAwV6IwbsKz6TK9I885ngU6STlgFg8jvqLzasreFMNs=;
 b=WWwtGR1t+tANDRVUo2TR9pMIModlr36I6OZLqGl0IETtQs0/rjC/uYLMlRDkNsP/eV
 2LXgsWIHL4XoHJpA14V2wkclfUNarpzbFHOEz5wVWsgrP4nikVJrpJCNjE8mKDsGTFLw
 uK2Raf8hS5WSmUAFPOeazZauXSjK7IF23+ltIA782RBeUZ3fAXByLWdr9VCPokU8LL0b
 XWv6Q4h0jEO0vu8zL62L2mTknqmb9UlvmCWNrshhxplOVVfLIttvt+RvTujsEVk+ZSQ2
 u1GIGtOx5ShFMR94uP8k6dKaqrvTsFRmr1ufo8PNJf6HZTqRkEFSLXKsDhE2TfcRIDSL
 muYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hAwV6IwbsKz6TK9I885ngU6STlgFg8jvqLzasreFMNs=;
 b=U4CSOT7lcsQfhvI5ymPFXu3uAJAqXXDejOxymzDTmr882LnZ9P3Ev/z3W0VWIgqrmI
 6AXRiQqTgFvFXb1oEb5EFcV51Oy5w3+6uWkiCQ5aY07Y4DDwJjW05YRstb3tA+7gCmok
 2IOvi8lfKET8QfSVGcH2sOxUkN87t5Nb+NiWhNYdc4ShY4Rct4YgeDi6hLhEwxSEVP7E
 E+ol+CppUScr/OOj4NuSSr0CKl7Jzg/S3v5C1uT1IxP9AeL8mkZoN2+ZtCFXz20Ky0uE
 OgQY+ThCwRL+NqXUjmqHWs9CwQZMuAP6EhVJzCeSGFTZwLoBLl+zCmYengney9FRcnbf
 qaCA==
X-Gm-Message-State: AOAM533pAaUBEloy9U4qIVE4wgn0TlsbiYZkWC8Im2d3aVL0fpXg+qLL
 eBrs1FPtbB62FSKcFxoqYyie2g==
X-Google-Smtp-Source: ABdhPJzKq+YlOiDMLykatXEFb35oBzrQM8EqzSpwuebdQwET0rBneBiC/nW+dHlQKkRccdp/GtUgfg==
X-Received: by 2002:a17:907:1623:b0:6e8:8678:640d with SMTP id
 hb35-20020a170907162300b006e88678640dmr30461002ejc.189.1651130366356; 
 Thu, 28 Apr 2022 00:19:26 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 l2-20020a1709060cc200b006d3d91e88c7sm7892815ejh.214.2022.04.28.00.19.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Apr 2022 00:19:25 -0700 (PDT)
Message-ID: <9dab1216-83fd-fd05-abe2-57371e365027@linaro.org>
Date: Thu, 28 Apr 2022 09:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] dt-bindings: iommu: sun50i: Add compatible for
 Allwinner D1
Content-Language: en-US
To: Samuel Holland <samuel@sholland.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20220428010401.11323-1-samuel@sholland.org>
 <20220428010401.11323-2-samuel@sholland.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428010401.11323-2-samuel@sholland.org>
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

On 28/04/2022 03:03, Samuel Holland wrote:

Thank you for your patch. There is something to discuss/improve.

> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - allwinner,sun50i-h6-iommu
> +
> +then:
> +  required:
> +    - resets

else:
  properties:
    resets: false

>  


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
