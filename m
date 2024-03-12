Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E678370
	for <iommu@lists.linux.dev>; Tue, 12 Mar 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202829; cv=none; b=XyHdihELJA291CSWm8H+W+d2yX8B2Kwroi5fhxfyzk37MrV1n5cuko+FcBlyxgdcKCRXCET22jo5CvSnFbP6dGjBkt4rZpfNRR5DavC/GuPp6BTilLF07x4T31ImXYoLNqPolZYSuigaCEmgvD+xXll2pbUT0gWefF0GuGRGZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202829; c=relaxed/simple;
	bh=qOWrAr6bPBzvoLLPTAz0C9dXtVXWGeptHGJUKAp80jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ee/NofHZsGGRUQ17ParfIyoZ8PFg+f+kSCPT4OzgaJt4LIsDv/gMLTQcjhOwHdpwl7cyFd5ktd2eEg2OWSiINJBhcv7pxBlwtM62lID6RZvvTZsUXqIF43oq4kGS/ni9yQdLNQkZg8wGe5MLINAUue0fZHRtQi4z7OvRVr9R83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OHk67HVw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHk67HVw"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512b3b04995so3873444e87.3
        for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710202825; x=1710807625; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Qj+d193V6vAwzUIxkG37xPPAUPTTqW49/CnKjXQd8=;
        b=OHk67HVw6xOOvPICk+74Tkyxr1DoGS3A+kv5wdrnTdt4YIxbk730WSAYO1K8JfOJ91
         Y/KRkDNgVxRgfu+uHy4RPBxOBuuGPrR/zQAdDhKXLeD/BZ+Q1212YnneRTa8NXiyT47P
         mpwmv9Jzc8iyBv5+o6FhGGQRrIcYBDtkSzaufO9dm4VSqgofIsLU+8V/FGjPuRuTfaDy
         kgVGbxKqiTXJSwxCP3j4FEA7U0Lqg90sj3IjN0FoGaSHCNfb/WCNGNKKDaw1lOVZ71E2
         mC9Cy5QsHJXtcVumrzKVHf2VF6KVT6o8L8kweF7Bek0DHBo+MyJXS/dHSfXIpkm21Jtz
         XZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710202825; x=1710807625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Qj+d193V6vAwzUIxkG37xPPAUPTTqW49/CnKjXQd8=;
        b=KhaaAc+b3y87Nv3yLknkdZQhUNvlrq3ficCzujTmWa9U8SRhbdVe85qGZfr69xjG6R
         4t4Ddg7BWpggudy3kD0qGf5m5vGE5bpcE9FTyFy0VBsnIX8Y1/0ePl8QO9Y4l+joSz5v
         D2gzfyn59WOwlbfz/IDmsV64mm1dTPxDQ+KfiazkU7195PR+Oe9fBb+LfpId6rZev9+K
         A9ngm82sVWgvkz/fQibo+hI+d1djCWKmzYmqr6Et9Rb5rp/VEpjrVAP2ZsZ3rLjZYPnx
         k9wgbntTNWLmACWCFeQRDJXDyKmYgHgi9PbFZ13JVhblIwFuM/efQm9g1QGSK7sFjGNF
         lFWg==
X-Forwarded-Encrypted: i=1; AJvYcCUavYVQ5Pjr0UwRCLXWqTdrOMVCJxV05umw2YDA7e3ZfjPgSx/C5vB/hdGp/ExgbyYYcNaVujYsWwbz+S2bPZmy23Jfb6o=
X-Gm-Message-State: AOJu0YzYN8iP/esOq48G4BJSYtAaWwz+PJe+Rl3HYm68kHovIoXUxEyQ
	Fc4WWDIfEWBhR9E93vsjRB84pi2nY7P4Dlz72a4hDp8XKQOv+C/ToAJXwfpAa0Q=
X-Google-Smtp-Source: AGHT+IECykpsirV8o3fAnfpG+ZqnLDETPl8qxRjl1ccJmT0u7F6lmAy4sP57NbpxufW8iWZ12UsN4w==
X-Received: by 2002:ac2:485c:0:b0:513:c3:1d94 with SMTP id 28-20020ac2485c000000b0051300c31d94mr4909736lfy.52.1710202825462;
        Mon, 11 Mar 2024 17:20:25 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512221200b0051354f006b9sm1316460lfu.56.2024.03.11.17.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:20:25 -0700 (PDT)
Message-ID: <58d5b209-94f6-43be-89e0-b14f5e30fd8c@linaro.org>
Date: Tue, 12 Mar 2024 01:20:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arm64: dts: qcom: sm8650: add GPU nodes
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
 <20240216-topic-sm8650-gpu-v3-6-eb1f4b86d8d3@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240216-topic-sm8650-gpu-v3-6-eb1f4b86d8d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/16/24 12:03, Neil Armstrong wrote:
> Add GPU nodes for the SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 166 +++++++++++++++++++++++++++++++++++
>   1 file changed, 166 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 62e6ae93a9a8..27dcef27b6ad 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2589,6 +2589,128 @@ tcsr: clock-controller@1fc0000 {
>   			#reset-cells = <1>;
>   		};
>   
> +		gpu: gpu@3d00000 {
> +			compatible = "qcom,adreno-43051401", "qcom,adreno";
> +			reg = <0x0 0x03d00000 0x0 0x40000>,
> +			      <0x0 0x03d9e000 0x0 0x1000>,
> +			      <0x0 0x03d61000 0x0 0x800>;
> +			reg-names = "kgsl_3d0_reg_memory",
> +				    "cx_mem",
> +				    "cx_dbgc";
> +
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			iommus = <&adreno_smmu 0 0x0>,
> +				 <&adreno_smmu 1 0x0>;
> +
> +			operating-points-v2 = <&gpu_opp_table>;
> +
> +			qcom,gmu = <&gmu>;
> +
> +			status = "disabled";
> +
> +			zap-shader {
> +				memory-region = <&gpu_micro_code_mem>;
> +			};
> +
> +			/* Speedbin needs more work on A740+, keep only lower freqs */
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-680000000 {
> +					opp-hz = /bits/ 64 <680000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +				};

I got a memo from krzk that we should be sorting OPPs low-to-high,
could you please reorder these (and under gmu)?

Otherwise lgtm

Konrad
