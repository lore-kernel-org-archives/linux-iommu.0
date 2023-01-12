Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F72746A
	for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 13:53:24 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id jo4so44945720ejb.7
        for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEgIlBDAlGQZBmVyuD6cEhuOAp963SNPIrPu8S2m7Vk=;
        b=rtr/ms2QeM19t/CC5LQNPz+qCEqjtAZFEBCUJBLkWw8nQ2+upZtbD6lP7G+rjXpXeS
         k4XKYsz6/F9dCNQIGMCryE7fKSbbIR9G3P4AAYV1NbmSM4QoLSd1T+H1lvgmzi3thdtO
         PmorFRYc1zsnRLB6OpljvjgpXHu1d23Vozqg273RWhXuoxira27SeoFoBQ1+gWG5xWUI
         QffkiF1LiZG4v363qfZZXDOHezMb9+SmNiiF8BxTcaRVWC7b75SbCvSyhRO6C7TA08Cg
         SERMlTFT0BSTXkvOhygPmW7RmcZ+Gpj+6ZihUD0Igb91XwayD/wUiL64eP90PA7kSloH
         XFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEgIlBDAlGQZBmVyuD6cEhuOAp963SNPIrPu8S2m7Vk=;
        b=JCjau5ubDudOFTDf7cXkA4RR54VGrmfJgMqu33yiB5BQQ4SMiz3RGqdM3MQ8IAjZ2u
         62WEMQrDVp6RWwVCguzYDDr8ywoesUG0ktTuf4awuMsLgjVpXzTY5TnV9kYCPxafnnUo
         FQS6tnAXxZM5Ws1rXkRlnuY9Snp9rIi9JER/Zp8/JmMUQC+JIcpWN0on/WK9n36KZAps
         rouFkGdAAeS4Mu6/ANE/p0PKrrTOeCUntaVh/KHaS14Jsi7s/5mfXOAd4kwPVYqjjzV3
         K1EmEWWpHEzOZaTCkpZudZOsHng9Y1zZT55Bsu3DzqMDQLfyjyiFgQ50YYKo2xcMJxGe
         jmPQ==
X-Gm-Message-State: AFqh2kp8oTxVMn2guO1rEGJDl7IC4YHy9efek+sab1qFXkNP4tkRVUCf
	u10yt2qj9KcUKEs6Ut+mGtqkeA==
X-Google-Smtp-Source: AMrXdXuVTphxaYsX3dow/CtVIs2dB9/JyXdySZLqCvXp7Yywmx0bI3apUvs8Y0K/0qYa/fPcz9yLXA==
X-Received: by 2002:a17:906:99d0:b0:84d:43e4:479b with SMTP id s16-20020a17090699d000b0084d43e4479bmr15622650ejn.36.1673531603070;
        Thu, 12 Jan 2023 05:53:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906219100b008536ff0bb44sm3717696eju.109.2023.01.12.05.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 05:53:22 -0800 (PST)
Message-ID: <e2cc612a-7b1f-6c18-7d5b-1403fac77a99@linaro.org>
Date: Thu, 12 Jan 2023 14:53:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2022 10:23, Krzysztof Kozlowski wrote:
> Disallow clocks for variants other than:
> 1. SMMUs with platform-specific compatibles which list explicit clocks
>    and clock-names,
> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
>    variable clocks on different implementations.
> 
> This requires such variants with platform-specific compatible, to
> explicitly list the clocks or omit them, making the binding more
> constraint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Will, Robin, Joerg,

Anyone willing to pick up this patch?

Best regards,
Krzysztof

