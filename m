Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5263AA91
	for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 09:32:53 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f955850e30so527113e87.1
        for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 02:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687426372; x=1690018372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s6TTePfFx4UahAkqH36CT2LOt9/xy+BAl43FeNd4Us=;
        b=ejcoopfASwKeuRq0dLWPyB+ShWYr+CVDR9vCSd2ksHS548Ml8OquVh1+/llOuBTCxY
         o+regOHWg5IG92yw6K+kJYTqoDDyKhl7YaCgWpHznVORrTr7LGFodRpsT057oKfahwFU
         CxM9U5cUnxLLvTgdpX+n6kgG1dcNVMXptpCTe0MO/ZJB3jI/Z8Abdq+1SPKBP+NL2gLn
         YncJptGWj6ilVLdJBkfNn6YGSYKsPiBXtvJkkk1OLUtqYHC1fpC3lAXMGuM4pzijtvYM
         DM3ufeBnBKw7LCbn4KmmwrwsNSQxtiMcAJggwTm7A0ZWVk6G4vRdfnQMUxhFCfKoKN4p
         ZIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687426372; x=1690018372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8s6TTePfFx4UahAkqH36CT2LOt9/xy+BAl43FeNd4Us=;
        b=NhMSjmrfeIZGMGXiMj1TawZa1VZO4HwtgV0qZUK0VTQ6KXKuDt/JWbEkYytjqql6xO
         CGFy44eQtU/Gn6ZG4OtX6m9B0/dO3aHn0/KgFrN5GpM2uqvFwMtBH1D7ghvEvH5wEuZK
         At5jb9FI/A6MZWmiOGruGTuGEt9soySZpXV/ac9U7dMLetV7zFKNFN8dr9B+Uyk1b7WV
         wn1ZXiVWU7fFg9cklxr9pv4ArTdgw4Ow7rYcYpMM738eprXoxDn7Svp5gvYOs0NY5D8u
         /iByUDx2KJwjPa6dKgrs+A8vlArRbizQPAR/scPhm7Y5O33V4dr477EohleH/CD0pFle
         OHDA==
X-Gm-Message-State: AC+VfDx4SkIydwGa4IYaLvOcxrI5wvYHEaW/GiDdkd7LeTFXOhAz0U15
	3kERaCUIwGFmqBrg/dAwBvd+/Q==
X-Google-Smtp-Source: ACHHUZ6DyExXq6xsJmHFTcnNbLo7gM5LGwGv8P5W6Ngz4h7z84Q/K3JrmOQ7FXpSU1pZoADuq68MaA==
X-Received: by 2002:a05:6512:108d:b0:4f9:5582:a7d3 with SMTP id j13-20020a056512108d00b004f95582a7d3mr2313298lfg.22.1687426371626;
        Thu, 22 Jun 2023 02:32:51 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e9915000000b002adb0164258sm1242072lji.112.2023.06.22.02.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:32:51 -0700 (PDT)
Message-ID: <79413af7-da90-6503-c939-a24fc6f273b4@linaro.org>
Date: Thu, 22 Jun 2023 11:32:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/6] iommu/qcom: Disable and reset context bank before
 programming
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 agross@kernel.org
Cc: andersson@kernel.org, luca@z3ntu.xyz, dmitry.baryshkov@linaro.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-4-angelogioacchino.delregno@collabora.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622092742.74819-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.06.2023 11:27, AngeloGioacchino Del Regno wrote:
> Writing	the new	TTBRs, TCRs and MAIRs on a previously enabled
> context bank may trigger a context fault, resulting in firmware
> driven AP resets: change the domain initialization programming
> sequence to disable the context bank(s) and to also clear the
> related fault address (CB_FAR) and fault status (CB_FSR)
> registers before writing new values to TTBR0/1, TCR/TCR2, MAIR0/1.
> 
> Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 8face57c4180..f1bd7c035db8 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -273,6 +273,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>  			ctx->secure_init = true;
>  		}
>  
> +		/* Disable context bank before programming */
> +		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
> +
> +		/* Clear context bank fault address fault status registers */
> +		iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
> +		iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> +
>  		/* TTBRs */
>  		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>  				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
