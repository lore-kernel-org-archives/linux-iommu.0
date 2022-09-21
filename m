Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7E1C27
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 07:31:48 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id f9so7777692lfr.3
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EbNzAZe8gFXbw49lbHOJxB9IrCROBBd4j9VarpK3XkM=;
        b=ueNRpW+TwE9/BMegPy5nQaPWEinFbA6WLQj7JgJNy1R1xKOL//VHuEAFyjCtMQcnhB
         rF7zylIVABKBIHB/nb2KMM8TT/XPVjpQEWyc8J0a3MtH+dV1nT1m6Aok/pejRV0sL5Vg
         3S2q7O/aN58og21gS3hFOI9eMtjOU1fqBB11wWZZiCl/47DPmkkFs+OiFo1HUWlqRwhD
         03p/Izu3tyt4kahkzJXq8kmB8UmxGRfhA+pIMjwpi2Kc3HraAO44Le6aRPHFQ3OKJDOG
         M5VpEwOPGSj2Dbi+m9j7eIFOo5Dz5puRbgCiaZ1mdHWMyCYlCPQziPHwM509eUKgTuz3
         thew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EbNzAZe8gFXbw49lbHOJxB9IrCROBBd4j9VarpK3XkM=;
        b=q4HWLQcjBcnyNVcqL8xfMcOYdQKaMjEr+ZKV8O2iLCFRhAXZc2lJ+/TjhmrVCmba7M
         R2A7gq8M4jM4/whbV38eQW4GlwSbm/sK7H8K7w6XGvPw8kxlu8FvqfXW6k+NCmjD88yW
         su3WA6GiuQTpKlQqBcVC9hC9udM+fxWI7kEOv0MY/oR/VPU27q9RyzyEjvb52/21xTxI
         OQCY8/lSUKa6kG1ZzBMe8vUJLxIoGVsD6e2QMl86aVGBi9Ud2QWd+OTCO7dlOOI0kNDa
         2dWLMVqP392yTRdAL/iwx3f5L9s/N4Sqc8slzR+ELS2GU1qnrh5/5fjg/4EeXpJHhjC8
         zc9g==
X-Gm-Message-State: ACrzQf1ft3jfL4XJzICfjHPBFMiGPw7G0n0OVaMcyCUWN9ah0qHd4va5
	V6SIOrXsi8TTYDEjxe6PKWqrpg==
X-Google-Smtp-Source: AMsMyM64KAvr9LNcx8HACnrnx0hEnaSlxW2C+W06q3xVvX2eIKTly12hAQVrRmTqs/0PCaBrLDfCEg==
X-Received: by 2002:a05:6512:3116:b0:49f:4eca:fe07 with SMTP id n22-20020a056512311600b0049f4ecafe07mr8656610lfb.442.1663745506273;
        Wed, 21 Sep 2022 00:31:46 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512070300b00498f51af149sm306443lfs.308.2022.09.21.00.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:31:45 -0700 (PDT)
Message-ID: <77b7d58f-ba85-86de-8635-6efbb1354a08@linaro.org>
Date: Wed, 21 Sep 2022 09:31:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Content-Language: en-US
To: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@chromium.org>, Sibi Sankar <sibis@codeaurora.org>,
 Loic Poulain <loic.poulain@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20220920223955.151507-1-mailingradian@gmail.com>
 <20220920223955.151507-3-mailingradian@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920223955.151507-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2022 00:39, Richard Acayan wrote:
> The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string to
> support it.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index b2708de25ea3..bf9653b9eb89 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -431,6 +431,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sc8180x-smmu-500" },
>  	{ .compatible = "qcom,sc8280xp-smmu-500" },
>  	{ .compatible = "qcom,sdm630-smmu-v2" },
> +	{ .compatible = "qcom,sdm670-smmu-500" },

Why do we keep adding compatibles to the driver for apparently
compatible devices?


Best regards,
Krzysztof
