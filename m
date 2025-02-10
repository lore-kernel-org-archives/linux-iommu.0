Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA61B6CE1
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185292; cv=none; b=Hq6mkWa//juFsKgLM1FQOidsbIb4p8aWiVS9FPiGHCUUEwzDTjxUT/T6rg2qrUfIQukB4k3kWH7n/sBp6F6eGkTn+rGhJ7gfc0eku4U6FellajoaSavUIM4BkWE2DpcHkSsj5sw0YB4s0SoNPRYOq6mB+ddm49k5bWdmPelBmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185292; c=relaxed/simple;
	bh=WgW6ZEWyu81z7BrqyHmBRuGMtk2zuQXDhJEjREDVx6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBV8vohqVQfRqpO0OMeylK5GZL4EdbUJmIX5SwJGD8fcBWgmKiMHvsy3JB/IL9N7rQW7VZrxtraVpT6Oev1jdis4hphiAiCDH4/t77HCu7vmfX8vah4cVWWm63COUa/2p9lCMy5BLnnpuGjV4AvDVOLTzwwT9AUPwdeTSJ7WisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QjZqTsiT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjZqTsiT"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-545097ff67cso1121948e87.2
        for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739185289; x=1739790089; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtTBVwp4J9apExhc56rvDYwcShHHaMo1N7lDCxauzzY=;
        b=QjZqTsiTcO5XwgzUY0lQvThXd+egK2KyVZT8oLhgx2/f/+FRrkt778DG35Elhv6OsU
         3DCLrzKnjfcYm8gLP/MKDm6MFczgngypo9yn1hq9rFyFkvwSc1S5WMNV9DPMdzIKrMc2
         uyVzwuxN/EKAw3puE09NNdzqxzNDduYVWRQcCvHcaJYnbkcicQ/yKakvDFqt0GxqD8Y8
         vsN4AF5ao50fahCsHCcgPago6kgCvNFKz4YW0qpjmiMCog4nw32iiz/t+TOGsytljApn
         T3n01v7ejEiOzjvpWjoyjaO5XQV/XLsTCBevM7mo3UZXe7Q1twKsWrC36/4gDN6hoUUx
         lHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185289; x=1739790089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtTBVwp4J9apExhc56rvDYwcShHHaMo1N7lDCxauzzY=;
        b=Qaw4yWwfOUWuFFAWoCNat6R+kTjsumVvjIEoQ95tW9lK1D5phEjzN6HM7sTWjz00Zv
         P9DZbl2Ra2NvyWnBLVMBqObD8Q6OAjL+Co4V/hP1grC0P0kdfUlCjsWWKV5mSxhgH/Fa
         Da/4eGnwd1rj/b/a2X+b6o9XU8ZFhuj4TbkVfouEl+oK4NGKhreWaaOYbaMDaZDr12OW
         veP2/tEwL3C74bhzUBu1iNBTf1//LWzt7XExRZLMcBhyQGz9L/d109JASVelwjYYzlFk
         2qMfP3mbSzmgOx+qMWGBwRuKZfvPbYTLV9qi6jhyX6otDehBceabiCoto1gU3OQnp0Sa
         sxEg==
X-Forwarded-Encrypted: i=1; AJvYcCUFjNvuOTLhCAaKtQ4L/P/5EKjgZxxTJPbGqW4R/9UFLNgsqKItJFZ0dECnx1G8WD1p7jFPeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwajIfhrNB4d40gL8FPPaTfdnV7v0RmIDkJnayj9QQZLMfrqBFZ
	4fk/ybplLkmynj37mrS4FVxTDVNXD5bjW90h3Yi3d2OOsl8qPwSo5eWRtB1veL4=
X-Gm-Gg: ASbGncup/RA4tJfJZPg9PmQ8nKdoOY7kI+CCl/hpQ7xYKAVIioPuL37e1Bmgkn1svYE
	sgZBLns4eYdSyxXqeskwwuCV4jVf3TN3HCbHMdqOw/NmN+aS19MOCkzxyAmkyeLIKjLeINQUFU1
	X2N5Nax1T7OaOIimsTV7Qouo1AszGMdEG1b6hpSdORR982s110XawM9yN4RJB98NpBQsJI9qJah
	HEOsTbh9zsBJ4+MRyf46WHdB9zeRqWP6B5AiCDBAhGFClRY9MmWh20slGrGRYsZ+D4G1t+UoN9e
	z7iOxb+RpoPlmNkKn/S3D6f74Ivrye7RE1BgJG4pSiOQ1bBA8+y0L/Z+mLU7rC5a3O3FJLQ=
X-Google-Smtp-Source: AGHT+IESGWlTJg2cuv8Kgo6v/dDQZjg10SE7StQf8S4vcvj1tAiGKln4CJ/xT6Y54Ae/tQTmSnk31g==
X-Received: by 2002:a05:6512:4022:b0:545:ae6:d740 with SMTP id 2adb3069b0e04-5450ae6d79amr1090753e87.41.1739185289056;
        Mon, 10 Feb 2025 03:01:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450c0823acsm321386e87.118.2025.02.10.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:28 -0800 (PST)
Date: Mon, 10 Feb 2025 13:01:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs8300: Add device node for
 gfx_smmu
Message-ID: <464vbzwgv44fn4iw5vj5yzpstzhcsb7rzuedf4fwl23hmdhews@d4q33ro6hxq3>
References: <20250203-b4-branch-gfx-smmu-v4-0-eaa7aa762f48@quicinc.com>
 <20250203-b4-branch-gfx-smmu-v4-2-eaa7aa762f48@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-b4-branch-gfx-smmu-v4-2-eaa7aa762f48@quicinc.com>

On Mon, Feb 03, 2025 at 11:17:02AM +0530, Pratyush Brahma wrote:
> Add the device node for gfx smmu that is required for gpu
> specific address translations.
> 
> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 4a057f7c0d9fae0ebd1b3cf3468746b382bc886b..7a8211bec139375b5aab939f123d88fca7aceff2 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -2674,6 +2674,45 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,qcs8300-smmu-500", "qcom,adreno-smmu",
> +				     "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x3da0000 0x0 0x20000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <2>;
> +
> +			interrupts = <GIC_SPI 672 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
> +				 <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_HUB_AON_CLK>;
> +
> +			 clock-names = "gcc_gpu_memnoc_gfx_clk",

Stray whitespace after the Tab symbol

> +				       "gcc_gpu_snoc_dvm_gfx_clk",
> +				       "gpu_cc_ahb_clk",
> +				       "gpu_cc_hlos1_vote_gpu_smmu_clk",
> +				       "gpu_cc_cx_gmu_clk",
> +				       "gpu_cc_hub_cx_int_clk",
> +				       "gpu_cc_hub_aon_clk";

clocks and clock-names do not match.

> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +			dma-coherent;
> +		};
> +
>  		pmu@9091000 {
>  			compatible = "qcom,qcs8300-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
>  			reg = <0x0 0x9091000 0x0 0x1000>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
