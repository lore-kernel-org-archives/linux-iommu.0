Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72C7C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 10:49:38 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id y18so4642991ljh.12
        for <iommu@lists.linux.dev>; Thu, 08 Sep 2022 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=FO9BCtAdjl5PI944Vegw3TyVJtWAoaowtQm2TG38rZo=;
        b=kVhIpvQcg33Vr8Tvlxq4JzJdu83HxShDz+VCPW+/zVSedQfV32YodjnRDz5Q0bEtF5
         neQnsoY6HrEu7ovhqpmFBcWjyBOSh3eA9ga3BaGL6YCsiOM5noaZysSDaMmyJ5GVk9S2
         3rt401hf15pvJVJLra4u8GQmIj4jDO66Ku51LZOiijwad16dJ8Mv0L0nNclGHIOpTfAT
         NOHRfeqEGhDcb3vhWKM+oHnne/hIbesCLTmJYH4rLqsHkiBDymzob7NbKP00PDqBIN3z
         D6HBruLXKqpOyA/6RV6DEV9fbJIDayrZc7aN3MQWxynlQATz8ooxPD8Uqj51JxLgPR8M
         8WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FO9BCtAdjl5PI944Vegw3TyVJtWAoaowtQm2TG38rZo=;
        b=xv2ZRYeDhiFb8Go/4K/aI3ZPOib7YUVvJV1sj0XAih6KVpEWU0ShLLkHQsMh98NVNS
         FParVvgTCd2Nr7+ju0kSI817kNW4YjR5alb4XRkgPuBAP/Q9s/7JyMoK6J5oB9801tjV
         cWj6uyFkAzDuImJBtFsqTs2zAbApK1v7Bi0K0dvXAvCyhInI549DoqRQocnwhNyMX7QN
         NieXiR/ynqk9E8mj1HITEusqcRq5NBSltNBGm5NN2vZLIguoOntB1HuHmcXAsiTyN4OI
         PJNsoUT78kIl3VTufntkJkpfqnabpSwKMUSsYa9xYGM0oS7TpRzgizvFfaKNouaodCLJ
         4AyQ==
X-Gm-Message-State: ACgBeo0PY3H0xkJ3egOw9AACBhJiW9IBFll0kDD6AodytQVHZluEDeWG
	clChTqNd4fONVpMu6AQGst3hNQ==
X-Google-Smtp-Source: AA6agR5enzuiL7nHDIxq2vO3krABgPwQHKwYJura+/kGgktQ0R6FajdwvACAYu1/LM8XDhJ33YwGsQ==
X-Received: by 2002:a2e:be9b:0:b0:25f:e027:4999 with SMTP id a27-20020a2ebe9b000000b0025fe0274999mr2353474ljr.395.1662634176744;
        Thu, 08 Sep 2022 03:49:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b0048b0696d0b1sm2983866lfr.90.2022.09.08.03.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 03:49:36 -0700 (PDT)
Message-ID: <2e575ed1-b82c-c7bd-3ddf-ccb6022b2461@linaro.org>
Date: Thu, 8 Sep 2022 12:49:35 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To: "Chengci.Xu" <chengci.xu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
 <20220831125502.7818-2-chengci.xu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831125502.7818-2-chengci.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/08/2022 14:55, Chengci.Xu wrote:
> This patch adds descriptions for mt8188 IOMMU which also use ARM
> Short-Descriptor translation table format.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

>  
>      then:
>        required:
> diff --git a/include/dt-bindings/memory/mediatek,mt8188-memory-port.h b/include/dt-bindings/memory/mediatek,mt8188-memory-port.h
> new file mode 100644
> index 000000000000..9363e132c43a
> --- /dev/null
> +++ b/include/dt-bindings/memory/mediatek,mt8188-memory-port.h
> @@ -0,0 +1,482 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */

Why do you license it under BSD-3 clause?

Best regards,
Krzysztof
