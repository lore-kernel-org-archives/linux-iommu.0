Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D78190
	for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 15:12:42 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id s10so10239584ljg.1
        for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 07:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rn0RaW15PCbv1iZnOn7lxQD1NhmhYoptHXukfEvlnlc=;
        b=x0ru9/MG7H41Yo1GvyZQ9Uuy5hFJQZ/0bS/Z6cgyMoizdorRbA/8LxLgiqGbgv6xKe
         f/Nd8nLPv4AraPILAZqiGBCZycLVXz/3Mn9VeUML/hFHdA8Q28+U6JJuvl295mkjZooP
         nOEF5+6keQ9w2zmT4gOdWuLHSKYSzfGi1J7+m6R0/zHVT+lTYcqRUVKVVKCDmK7bbzrC
         CcHaBkp91EYZM7Vug5hmtKtEPfsl2QqCnmd1V5dijy1y3Nf01/qooMucYRh/krCeZFZM
         2Mlsuwo7/IvJa8DweXvlynyFsyPvnslfkVjsj0YPoJRdN0288r4HQ5c9IXaawcBN1OrU
         ONrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rn0RaW15PCbv1iZnOn7lxQD1NhmhYoptHXukfEvlnlc=;
        b=g8FjRWoE2t2BYO9JMq4wU+M7MP03De+A7lyk7Xr4XWxE0Gg9Q19dWRl7khoo3pBW+L
         n4cuXnRFHSe2h2kYZz9EFxJCrbTn35zbAujkvmLlpeQkdu86eCaSMQAd2lPEMQM6siPp
         82dmaGBYHhlvF0qpQ7bsH14Z3kf8srQugRS/tzRlJVEA0MocNzX7PunFsobF8E9M8tzp
         XlOPqSg/qYpu5qIi0muO/5/ImM35s5d2bf93BvOrLHV31+tz8/MBF/1pg4U7NJuuMcq2
         SlBeeMAFsW0KiD23JWVaUW9X4aJneAbzhEJc5CcYDNdejywAXsatM+66EGsLhIOFO9YE
         8eEw==
X-Gm-Message-State: ANoB5plFxs2A0s7WFbL8iuLRaj32usV0nyI2BDnrEUt0Rzjru1yQ7l3D
	Lxz1+rTGlc5pu3nBwft9d9/RKA==
X-Google-Smtp-Source: AA0mqf450ET8qyKL5V67vM4NujcATbDhymaDU8EkzcrVkIqi6ho8k0R6oYRIKx/hFZAOzih3RrEBbQ==
X-Received: by 2002:a2e:95cc:0:b0:27b:65e3:3e93 with SMTP id y12-20020a2e95cc000000b0027b65e33e93mr2883452ljh.45.1671117160247;
        Thu, 15 Dec 2022 07:12:40 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f13-20020a2eb5ad000000b00279cbcfd7dbsm861184ljn.30.2022.12.15.07.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:12:39 -0800 (PST)
Message-ID: <2e613245-26a1-c51c-cbb3-b34a88f178f9@linaro.org>
Date: Thu, 15 Dec 2022 17:12:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 4/8] dt-bindings: arm-smmu: Add compatible for Qualcomm
 SM6115
Content-Language: en-GB
To: Iskren Chernev <iskren.chernev@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Adam Skladowski <a39.skl@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-5-iskren.chernev@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221030094258.486428-5-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2022 11:42, Iskren Chernev wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
> DeviceTree binding.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9066e6df1ba1..71f8f638a1f8 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -41,6 +41,7 @@ properties:
>                 - qcom,sdm845-smmu-500
>                 - qcom,sdx55-smmu-500
>                 - qcom,sdx65-smmu-500
> +              - qcom,sm6115-smmu-500
>                 - qcom,sm6350-smmu-500
>                 - qcom,sm6375-smmu-500
>                 - qcom,sm8150-smmu-500

Please rebase on top of linux-next and use a generic compatible + SoC 
specific compatible.

-- 
With best wishes
Dmitry

