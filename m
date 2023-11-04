Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21380156E4
	for <iommu@lists.linux.dev>; Sat,  4 Nov 2023 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5qXWcXa"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9dd98378a39so155414966b.0
        for <iommu@lists.linux.dev>; Sat, 04 Nov 2023 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699097455; x=1699702255; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ViIC/HSzRl49SaVz7Ic3OZfsB5CjZfB5vtLnKKRw0ic=;
        b=R5qXWcXapEAWb8yri4izlaOB4hfNGHjliFYNGXuPq6oCHbmmQYpz4XgKbdyh2Rk7GN
         dnCwTp3F798MKWEJyzaQWN6viecy9H3KWnNnrbvCiKqvJbKdp/EcFnkAoTeagyviHd9R
         av2oBME9FnLH2xjiiSriura96zbNml6rCH16k2lY5UkaCLfd6/d+pAB78TEFqKZ+44Fq
         WTn0+RGvj8vqPOrjdaII6wqeFGv7cvX2I0wlMmncF2ZNGNJKGUyNc6DzAAQ2D4k9NXr1
         9/whXSvO4BJMU7xur+CSkcRzGR/Z9MxpM3jMsgqlQ6OWRyNYblMdPA5OSTxlYbU4JSmy
         n7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699097455; x=1699702255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViIC/HSzRl49SaVz7Ic3OZfsB5CjZfB5vtLnKKRw0ic=;
        b=e0NKy8ksy5vxVYbvczfmMV0Z8aN+Sq0bnodYfpXLXADP+qEN7vYypy2iFrobLSllmd
         M6m+6j5MUD6xBZb1oCKcLMgpKA9beIvO1lxD8VHKnSacnG3IDRSctPMYWPB5l7mRJyuz
         vX2J7N7WoFum0qpMASfDmtIO55aT1bbdIBGxgN3BX15ZotoSkJF1pljpqth4ikd8uL8B
         hOTBp85kH5Bv8KZVTPETqjiQ3QQ1nOuqKqfQIY7DPHghsWxvSJetwAQEUel0mYJ/ExzN
         yEQzYuzKtQYy3hoLKHMA3H9CZh1uQCBA4YMcJ18gKflc7HE0/CWIvxzpfJwP+ftxB6s8
         X0oA==
X-Gm-Message-State: AOJu0Ywd3tRBR+NdhZhth9P5zFeQxNX3Azj4wzUJb1KF5o5HGEK2JfRQ
	vEXNkg7Jn6eINjPW4dTnradzDw==
X-Google-Smtp-Source: AGHT+IG7+PVg2+j7nGj7tYNTi4rQ5slXe9O1zzNFrQ+IoKAC5ivvACWeQEyqrrRa0PtPlKH+b4ylJQ==
X-Received: by 2002:a17:907:70b:b0:9d2:20ee:b18b with SMTP id xb11-20020a170907070b00b009d220eeb18bmr8758416ejb.42.1699097455299;
        Sat, 04 Nov 2023 04:30:55 -0700 (PDT)
Received: from [192.168.0.153] (178235177017.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.17])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b009c7608eb499sm1878707ejq.94.2023.11.04.04.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 04:30:55 -0700 (PDT)
Message-ID: <26af3ecc-8b3f-4b10-b594-eae57de501cb@linaro.org>
Date: Sat, 4 Nov 2023 12:30:54 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 a39.skl@gmail.com, quic_saipraka@quicinc.com, quic_pkondeti@quicinc.com,
 quic_molvera@quicinc.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-4-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231103215124.1095-4-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/23 22:51, Bibek Kumar Patro wrote:
> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> through SoC specific reset ops, which is disabled in the default MMU-500
> reset ops, but is expected for context banks using ACTLR register to
> retain the prefetch value during reset and runtime suspend.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 590b7c285299..f342b4778cf1 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -457,11 +457,29 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>   	return match ? IOMMU_DOMAIN_IDENTITY : 0;
>   }
> 
> +#define ARM_MMU500_ACTLR_CPRE          BIT(1)
> +
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +	int i;
> +	u32 reg;
> +
> +	arm_mmu500_reset(smmu);
> +
> +		for (i = 0; i < smmu->num_context_banks; ++i) {
This loop deserves a comment above it like

/* Re-enable context caching after reset */

Konrad
