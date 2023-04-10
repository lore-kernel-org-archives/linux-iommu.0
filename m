Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9893C04
	for <iommu@lists.linux.dev>; Mon, 10 Apr 2023 15:30:35 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id ud9so13106504ejc.7
        for <iommu@lists.linux.dev>; Mon, 10 Apr 2023 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681140634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Itkfx/SKWmTgvLKHAD1AdOCobJxj9e9oDbXIhOz5Grk=;
        b=Soklrh6KjQhWPbFfaBnFO5reP5hGWsaazUyTUoMePLaBh/KHj/BM2NMXEUvbGQzM4Y
         mul5E1svfxf+7g85Kpf5DWc2ug5mnF9wTntDKgl37P4tfS5PC09gC6M3drJmNHiYA+ek
         nLHQD77Gk4Ge4LusG7Wgg2layKERLzNbdfpW1C7s8DUpRcl1zTzN1Dzc9XLopAytsyPH
         y6QT2mDvRSuWNkCwnqpFvNY/PgknOVasHcfZzTLUdnta+zOrMBZ3vjctjVJGMkMjHKx0
         isGhGs2gB4rZFbUuNDKJIsO+LzlBLU9CCjciSE+lbJAwfwk5uT8YZb37Zf9m8CNZZWXK
         CEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Itkfx/SKWmTgvLKHAD1AdOCobJxj9e9oDbXIhOz5Grk=;
        b=i+A0dxoZjDpDzbQwqSRJOLV5l3Xu9+jzb0hXWIwYCKUlXgZxnEsurC+NJDBhvYbh30
         Z/ohytYM5CJuUQzFst+trQF0Bpavp0tsRAeTocxt4vY0gKTOkJom2SnmdMTsCnPKx2n3
         QwwXSGJLU9wmOpmLOku/zhJ4LkiOiTR7VSEXvxJwhb0tg/7ilGV0VZeoub1o3Z/SAbGz
         onOuzUuPuiEPHFv70V/MCogdE2jvuTp+2XRq3B3c49KHYbLjoq3chqqz1Gno6GCaxp7H
         dAGBWHRyzugrrYpABb1H11tWj0I1z+E85Uv3Ck/NT92X/+vv61T9RzYOxXRMa0N02uwo
         7lkQ==
X-Gm-Message-State: AAQBX9fPRvSgNkOOJQFHRNG9jALdiQmoiPCfHhoMzzh/OF2t6GmXGRW6
	CjH7ar0JM1tSqcW6FaVaDLUyvA==
X-Google-Smtp-Source: AKy350YOl6LmnKef1jR9aqU4sERFWWSnDuFwHk4cC7wGrdApNE4eG/tOeHTBsxeVq5DBEqq0wJL0AA==
X-Received: by 2002:a17:907:a395:b0:94a:6e08:fec5 with SMTP id se21-20020a170907a39500b0094a6e08fec5mr4377644ejc.29.1681140633994;
        Mon, 10 Apr 2023 08:30:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eacd:ffa4:1df7:3870? ([2a02:810d:15c0:828:eacd:ffa4:1df7:3870])
        by smtp.gmail.com with ESMTPSA id s27-20020a1709060c1b00b009475bd8f441sm5168414ejf.60.2023.04.10.08.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:30:33 -0700 (PDT)
Message-ID: <92f8fa5c-7753-865a-83a3-2a53c2c3a8f6@linaro.org>
Date: Mon, 10 Apr 2023 17:30:31 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/7] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230406200723.552644-1-brgl@bgdev.pl>
 <20230406200723.552644-5-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406200723.552644-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/04/2023 22:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The KGSL iommu will require the clocks property to be set. Enable it for
> sa8775p in the bindings.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++--


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

