Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49223D1
	for <iommu@lists.linux.dev>; Sat,  1 Oct 2022 09:31:53 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id a8so10165700lff.13
        for <iommu@lists.linux.dev>; Sat, 01 Oct 2022 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aii+1xRQiFdmSud1Epdrtmy2A14HX4EldZ4/DuVxcqA=;
        b=Ww0npKCPlLN9z7TCf10hqTFnY5Y/SrVYnPKePOZzAye4KvJCScPpURYT77pK3aFZ/s
         rE8C7cJMXKC80v9o6UXxkW0Ip06ykdS+bq4jXD9Gk3SWOtrcCcgrQPXsoSu2QoVKaBb2
         9tL6cC1WOJkUah5ueERHBH1xeVSsaqSWnIN2uU5ToXVXVAcr4Zb1bjcCNMqVvVyGh+US
         7VflkgcHUkZyrT4atXN+1xVDAdFM8LHCqI3vUY3Jk4FU3pWiIHpmaxKSCijmdk1D8npC
         iLOPWn53J7iRUEOJ2yPmWo3bYabpzselP4DJ//M1M2vgCAH60KQN7jKb/cQDzqO+PCGU
         TI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aii+1xRQiFdmSud1Epdrtmy2A14HX4EldZ4/DuVxcqA=;
        b=rTPhKN5fQknjUsdZt6Cddsb6YwX7ZZH4zLdvKYEq8/yq3Sb8jpJk2ONfYM1iHxEItN
         qkNizpQ6lFpjZBUhgSe+PewZpIBY6X4ZVcJTQOLTTVggGcGKh6NceF46CY65MwcW9bo5
         rObnT4Qn/njtn3vnH3SNky7RNHrETbxoC0yTJXTp6yeQedIXjqN+3kptHmRJuBWmS2Tn
         B6h8GGgYjBh0Cq4zmS40c1OU9buHGS/J5wyfHcnBXuECv9cJrouFto+kmDjG9/Xq2ib6
         he8nc8lWA0J1HikxoCtx+8RPIAZ84EsxD+cHqX/w7So4rcAq613qYLJH/kHDgqDOoSty
         33Yg==
X-Gm-Message-State: ACrzQf1iLwyOHUS43GoyBvehC3NvICqhu2P5RLhPBAOGBCcyFLAjkyTP
	yzmZ716ly0oxcnfxf0frKng+Ig==
X-Google-Smtp-Source: AMsMyM4KxhgR//pVV35Y1++UWyWkt0ioN/B6mDDINOeGKg0Atww/SjKTrdSsjScFs3bonah11z2u5Q==
X-Received: by 2002:a05:6512:3116:b0:49f:4eca:fe07 with SMTP id n22-20020a056512311600b0049f4ecafe07mr4324067lfb.442.1664616711437;
        Sat, 01 Oct 2022 02:31:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651210d000b0049f53d53235sm707224lfg.50.2022.10.01.02.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:31:50 -0700 (PDT)
Message-ID: <4ea2b04a-c328-ec24-1231-33895607233e@linaro.org>
Date: Sat, 1 Oct 2022 11:31:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu
 implementation
Content-Language: en-US
To: Melody Olvera <quic_molvera@quicinc.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030615.29135-1-quic_molvera@quicinc.com>
 <20221001030615.29135-3-quic_molvera@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030615.29135-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2022 05:06, Melody Olvera wrote:
> Add compatible for Qualcomm QDU1000 and QRU1000 SoCs to add iommu
> support for them.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index b2708de25ea3..2b9a3c917aae 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -439,6 +439,8 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sm8250-smmu-500" },
>  	{ .compatible = "qcom,sm8350-smmu-500" },
>  	{ .compatible = "qcom,sm8450-smmu-500" },
> +	{ .compatible = "qcom,qdu1000-smmu-500" },
> +	{ .compatible = "qcom,qru1000-smmu-500" },

Again wrong order...

Best regards,
Krzysztof

