Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AFB3AA91
	for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 09:31:18 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b46cfde592so76519171fa.0
        for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 02:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687426276; x=1690018276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0su4etilG9DUxoAHiiXtsXNHxIThfP1qbA8hYKFV+4=;
        b=AS2CcnaQCTsVrrCP5p669RDfFRtDFV/9lb2w0L4BLRKxXV18Xc3VNg2lYDlEuB7T9x
         l1gLwir8dhDeVU7ndAVojN/mL8BTUzIw8ScyC0s85MB7GbttatCo5351X4yjRrLjWUwW
         d9KHT2XwtZpvjkSBM+29pxGLkMdV9WCCVt9sk8XhHy9J9gCfHKRpSYQP6/O/R6pfjqdO
         Kl0EL4KoAaf6EQ+6mPEYXd79ybOeoHagiHjto/RweaYmozNx3Gz8StgudIO/GiOdGzg7
         gtYt3geovHMSb55bhHQCEAFF80ILpmAq3HKMrxQSr6kTmcs1NYrhF1aGhrzi4l7tqKFv
         xuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687426276; x=1690018276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0su4etilG9DUxoAHiiXtsXNHxIThfP1qbA8hYKFV+4=;
        b=chd0SGs4ghrKhFuMXs5TPiWImGviGPmLzNa9qLbhcLxqOLQbeq4xwSANcegdb/gU0Q
         ibJAL53vR/zGaSJBIRsYCkIQUWSqqpgG9tEKioDlp0Us/gNyFkstf2EG9B8GjTOZivNq
         5QHmjnqGE3DRT3c5mZSGuVbNSd0GRiKzZA1vWSlKVy2KPrFUnLU7qYpFWzAQi6rO8nQY
         xNA5hL/otCwWRMt6DXbsamTq3bEgI1GnPFG0TdNoaZMXmCgHuH2TTDyWTyHtfIRtcLFV
         2KbVc7pHckB9cYkw+U6imktnDEKv58iG9JMCcdF6nOQjUWMEp003EokHi4TadE/R4i58
         2Yrg==
X-Gm-Message-State: AC+VfDxp1K8Q1QVqsGpfAU/UTbZCyphXoLdSZl0bgxIBlifrJip/Ttyc
	u6ctyao2n2ANljZ7wN4R8bt+Lg==
X-Google-Smtp-Source: ACHHUZ71vwoNNEacKd0FTRQZr1ek70tsPteUvGY5LcMuqNFwVZ2JS6uYFjlBXTUj1lQSIEg5pD3i+g==
X-Received: by 2002:a2e:98cf:0:b0:2b5:1b80:264b with SMTP id s15-20020a2e98cf000000b002b51b80264bmr6153288ljj.12.1687426276202;
        Thu, 22 Jun 2023 02:31:16 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id x10-20020a2e880a000000b002b2255c4950sm1240578ljh.41.2023.06.22.02.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:31:15 -0700 (PDT)
Message-ID: <0fc42dbb-3b23-70d2-b18e-92424e04418f@linaro.org>
Date: Thu, 22 Jun 2023 11:31:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/6] iommu/qcom: Use the asid read from device-tree if
 specified
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 agross@kernel.org
Cc: andersson@kernel.org, luca@z3ntu.xyz, dmitry.baryshkov@linaro.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Marijn Suijten <marijn.suijten@somainline.org>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-3-angelogioacchino.delregno@collabora.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622092742.74819-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.06.2023 11:27, AngeloGioacchino Del Regno wrote:
> As specified in this driver, the context banks are 0x1000 apart but
> on some SoCs the context number does not necessarily match this
> logic, hence we end up using the wrong ASID: keeping in mind that
> this IOMMU implementation relies heavily on SCM (TZ) calls, it is
> mandatory that we communicate the right context number.
> 
> Since this is all about how context banks are mapped in firmware,
> which may be board dependent (as a different firmware version may
> eventually change the expected context bank numbers), introduce a
> new property "qcom,ctx-asid": when found, the ASID will be forced
> as read from the devicetree.
> 
> When "qcom,ctx-asid" is not found, this driver retains the previous
> behavior as to avoid breaking older devicetrees or systems that do
> not require forcing ASID numbers.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> [Marijn: Rebased over next-20221111]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index a503ed758ec3..8face57c4180 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -531,7 +531,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	 * index into qcom_iommu->ctxs:
>  	 */
>  	if (WARN_ON(asid < 1) ||
> -	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
> +	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
> +	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
>  		put_device(&iommu_pdev->dev);
>  		return -EINVAL;
>  	}
> @@ -617,7 +618,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
>  
>  static int get_asid(const struct device_node *np)
>  {
> -	u32 reg;
> +	u32 reg, val;
> +	int asid;
>  
>  	/* read the "reg" property directly to get the relative address
>  	 * of the context bank, and calculate the asid from that:
> @@ -625,7 +627,17 @@ static int get_asid(const struct device_node *np)
>  	if (of_property_read_u32_index(np, "reg", 0, &reg))
>  		return -ENODEV;
>  
> -	return reg / 0x1000;      /* context banks are 0x1000 apart */
> +	/*
> +	 * Context banks are 0x1000 apart but, in some cases, the ASID
> +	 * number doesn't match to this logic and needs to be passed
> +	 * from the DT configuration explicitly.
> +	 */
> +	if (!of_property_read_u32(np, "qcom,ctx-asid", &val))
> +		asid = val;
> +	else
> +		asid = reg / 0x1000;
> +
> +	return asid;
>  }
>  
>  static int qcom_iommu_ctx_probe(struct platform_device *pdev)
