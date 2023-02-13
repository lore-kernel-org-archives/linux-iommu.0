Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69922256F
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 11:13:59 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso10990166wms.5
        for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 03:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DC7PNhEXzA2bTr1kLiLOYy2/RflLZLk44uc5OBrkDU=;
        b=NhsfQn9M+LQfHXjtLuyMn+rbwSANp21Nrv2vCtpxpiRP3TAs4Pe5JtiKCKWRdK7Neo
         yh1bEbreLT9t7gqhI2r6PQYkd44lns5uvBPjI9bmzx5SDBz/tW5/fSJoqZJVntoVGYn1
         UahBuQ6sDZQ35tXCa09Z6PXrtwlKFmItyHLZZfb0T+QymWzxnaNrciZgGppzd3YP/MAO
         cgFZ6OsQI9uznZQ14IOZSwvNyuxdNlAP3JcIBbld8vce0FD8ITdODm5tdZAf+MJVtqsM
         wW9PtyM8JWy4Osr9ir16CfjzHDeSIB8vYTktLRYQxLmS23hknl3tkx79wlhXopgijmIX
         Z00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DC7PNhEXzA2bTr1kLiLOYy2/RflLZLk44uc5OBrkDU=;
        b=Wds+OqW+jbehMoAgXa6Bcev9jFPm1qny5+18jz/q5M1526x39l08ekD109wbRKATLX
         1j82azU3GYxboGQ5Zj6nSmnmNXjweOak4I+0kcU4hIAI6IGuRtNE8QQv06v2ZlChYGtr
         0ic6Ut4RpYI6agZfdS0zeJLs9eIXPExC03JtJUL/tK5fqPt+0SBtYYLvLZPWlG5UflB2
         sxU0XIqjbRkuz/+2812/W2FGtsLfP1N7w1cGYka6KixMKd0xY1GiZkRGVisVN6j6mCRD
         tKIMFiauxhVDR9s2cQBxwep11XMKkpXhaOsgDf6cj7/JwxU9bIfSXRvZYZ87L+nV6Hcn
         wb6Q==
X-Gm-Message-State: AO0yUKWiRtEu2MlvScXIEGM3IIwpaganrrD8wC+89u4czT2E5nkn6hIw
	+xgKcWrfQS3JUHv7QXEnkWoxbQ==
X-Google-Smtp-Source: AK7set8oaYgKuifU2vnMqa/UyN+qhFOxV+HTfzbIYnI0rfevBi+VqDzI0c19eTP++f607dQNSoioXw==
X-Received: by 2002:a05:600c:16c4:b0:3dc:1f90:35b with SMTP id l4-20020a05600c16c400b003dc1f90035bmr22771879wmn.34.1676286837823;
        Mon, 13 Feb 2023 03:13:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm16737485wmm.40.2023.02.13.03.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:13:57 -0800 (PST)
Message-ID: <6e18ab3a-512e-ffe2-1c88-9b57bd1d3960@linaro.org>
Date: Mon, 13 Feb 2023 12:13:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/17] dt-bindings: iommu: apple,sart: Add
 apple,t8112-sart compatible string
Content-Language: en-US
To: Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-7-cb5442d1c229@jannau.net>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-7-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2023 16:41, Janne Grunau wrote:
> "apple,t8112-sart" as found on the Apple M2 SoC appears to be SART3 as
> well. To allow for later discovered incompatibilities use
> '"apple,t8112-sart", "apple,t6000-sart"' as compatible string.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> This trivial dt-bindings update should be merged through the asahi-soc
> tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> series.

Same comment as in other cases.

> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> index 1524fa3094ef..07d2d68a87df 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> @@ -28,9 +28,14 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - apple,t6000-sart
> -      - apple,t8103-sart
> +    oneOf:
> +      - items:
> +          - const: apple,t8112-sart
> +          - const: apple,t6000-sart
> +      - items:

Drop items.

> +          enum:
> +            - apple,t6000-sart
> +            - apple,t8103-sart
>  
>    reg:
>      maxItems: 1
> 

Best regards,
Krzysztof

