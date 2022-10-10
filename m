Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5602F47
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 14:55:41 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id ay9so6632509qtb.0
        for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwsU1fn/1SfZtcqL1Zfll3O9hBAK2GV/zHS0qbctt9A=;
        b=vFfv1QykuX1R6T4Pv3s7wuWLMBDo5sYCAxir3KGVHEjCi0mdzbZew2vk7h7L4rix3k
         Rf9SYZNWSKxwJzDt0MinCCWk2PmF6aLaMXl9clOTRhhkSAK0KWc7C0aO7U54037TBtBp
         4WFqQ2HLFcob6z8Ev57+FwoAg7h4Bm28VhWB77XX8IRaKjbKaqyq77FLWnJ0q2FteKKn
         psQcN8rXlsCo7oPYfisgs70YCbhs13QHkG2xCSvUGtoeOKERdZN72m1KwwMTeyBq5B82
         tCIPlwoZiF7YhC9lP40IqRPJAuxZrd15FL1yLQZqZtt6u0BAhCS62zqGejhDSUBQCqv9
         rcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwsU1fn/1SfZtcqL1Zfll3O9hBAK2GV/zHS0qbctt9A=;
        b=3dSHa7mVp3JSjlYskCqx9qCaaxW819wwwViCCeL5vWXOEgtEEQCdaCUoB6pHFA5/At
         /VG8pHUL7JjvnfaOSoO6kwZUoI98ktrjKB4VrkvaoMhCMWduHkEjNWTKQoS3S+GxnJzM
         zczup/8SsE8nEVJ0ZZyMk1KAHec0MD8yNRtLT70UgziEjmcCFoq3vkoDER8RZMdM8WTC
         wd/2rxr4e1+85FAS0ufcWXR+FudC6x3l8W0GlAi0QCRrR+pcK8lo40S7F6Xu/rXhPeY3
         WGy0I5FbMBvOAmZtCx4y3Vusub4mxnoAYFYcB5/5Xr6lgUKDzmu1WRWgngYzn8/dkvEz
         Lw5g==
X-Gm-Message-State: ACrzQf1r5KmOilvx4/6ojN8BOvrKoxV1jXCCZoQ/OB977VtYKQalRFWt
	WhJcBL5LFiO65rg6MW5dV8mJ/g==
X-Google-Smtp-Source: AMsMyM4wUdL69r1gqbyekIM8UU8nT+Iwy6V3/bmUUZzogalJHEIVc9ztR+cgKUf3W7pIPUCmGyr9vg==
X-Received: by 2002:a05:622a:13c6:b0:39b:e62:cfc3 with SMTP id p6-20020a05622a13c600b0039b0e62cfc3mr2150730qtk.687.1665413740678;
        Mon, 10 Oct 2022 07:55:40 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id fp3-20020a05622a508300b0039b26d92989sm1083673qtb.86.2022.10.10.07.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 07:55:39 -0700 (PDT)
Message-ID: <1c10a474-7014-b56e-d2e1-3e422ae82401@linaro.org>
Date: Mon, 10 Oct 2022 10:55:37 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
Content-Language: en-US
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: iommu@lists.linux.dev,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>,
 linux-mediatek@lists.infradead.org
References: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
 <20221001-iommu-support-v3-1-c7b3059b0d16@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001-iommu-support-v3-1-c7b3059b0d16@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2022 08:54, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(for DT bindings and memory-controllers)

Best regards,
Krzysztof

