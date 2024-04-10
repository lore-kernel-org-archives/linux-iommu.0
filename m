Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0215B0EC
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750924; cv=none; b=nRQxEo9cMhUbqmUi+qMAqrVwEH2iz04m9ghlWPxmNhQI2WYdKJNlYd9JFScS7mZNiivIUwb8Hmmt/tvZweHV8owvfOTRWfBJ8CsZRtV4fsNQwM56R3RsbLBKs01LcgmoeK3NjbKtaWbjCNNlmC9msxiRShyVB8kmmsMymc1zXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750924; c=relaxed/simple;
	bh=jenHaOnHcbxtWDU/sjx/JJIEbosXdTyAf0Nq51UQ+ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipeORMvchsi+igk5uwA4mBfNMj0NqRsYEhlmaxped+cKE9GMkfo/TxnVr6AD16dfyNgo5TmS3rFBP+iYoa4wLuHV2Y2NAxjKhMGOwiAOvnAS6QfFj3aO+CMXhyPCl3Ak6LbCXbSuali48xFVoB8YVqrhG1GeZCtgdbqH2RFNwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J0uxmpyT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0uxmpyT"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516c97ddcd1so7976612e87.2
        for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712750920; x=1713355720; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/eIBodkkKg9gHiISFmQzqjV9vYTJz8x5fg7OEsG2PY=;
        b=J0uxmpyT+LLqIsFg9AYqMyE22+a9QkEAF/XCMBYX2qQCFBCFBYH0o8i+/LTJC+6AL8
         tm344ouhe2uQVKdgMtG6MlwJecUTU1IA52UXrjzdt8ElVobtZnZte+H4PhkwZEe0KIhQ
         9hGC6ZMfXcBH73c1AZH1EtE6GXzRUTvOeNxxPTs+wx3yD0cdCx7OrOwC9IcCu1aqpEnB
         FkFAT/DVMWBdCXrLjsXrJD+e4Q/lo1GOPt4yHpu8yfyyzXikXaj4uqkU4U+tFdML466s
         onfgtFsGM+dS1/g1lGM3u9S10SgbMkX/rdoUrCOAXHlwhylzFKoaDJMKNj5avALxDS+G
         HwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712750920; x=1713355720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/eIBodkkKg9gHiISFmQzqjV9vYTJz8x5fg7OEsG2PY=;
        b=NHyupObMLmhdIS/yT8z+ZGinIHqlzjhaghyE7i1zMz3BWBvOYgC7f2BRSItE2OV+Qg
         v51Y4N9ZDAg80kLPuOCDUkZTto4jky510Afjgw8vIuGr0kUfYUsMrX63eARehq3N2d6R
         9tL4yRb4xZDPPXOG+Kits0llHJiixZ1e83esrQY5x4EDCko3zDcC6BM/AclM5AWBqZVK
         e0zSBayu92ht7km0GXaF3yKA/7pY1OfTs3HAKWiB2hp37wfWMeqeEl7yr5DyyoNLvLht
         H1zT+BSbOyasspyz77BPiYW5zHPrme8Cuinc9yPdyuh1zgUaQtPQRSo4OdiUjLFR43Kx
         uPQg==
X-Forwarded-Encrypted: i=1; AJvYcCXAuqxQGSvy5lm1iOK/+k3brSeEpV7yg+H/uHgxWzjzgmhqpV7RxGOfU9liJLSqWy0QYQumULjTm/mjDYpNJh9ncLV9rmA=
X-Gm-Message-State: AOJu0YxbtBW5wqDfIv5IIBU4nuwRilo+EzOib3bE5zPRujWVjes8Tj8Z
	nAsBEYoYAtYne49EDQ2bYhjlw7yw4AlBQtV6Wu7hT7ByQNbftr4WpC7VgW9HS34=
X-Google-Smtp-Source: AGHT+IHWhWVUT+mJBbmOEO2cd0a3sYytqZtHgO7IW9217h6HPe6S+6voseWdDbeYpLJ8PbQDvZI58w==
X-Received: by 2002:a2e:81d2:0:b0:2d8:5fb1:4b80 with SMTP id s18-20020a2e81d2000000b002d85fb14b80mr2016525ljg.24.1712750919723;
        Wed, 10 Apr 2024 05:08:39 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id r10-20020a2eb60a000000b002d2dfe8a36csm1795293ljn.96.2024.04.10.05.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:08:39 -0700 (PDT)
Message-ID: <d21b1b9b-6f1d-4ffe-b5e3-41d0a43fb17d@linaro.org>
Date: Wed, 10 Apr 2024 14:08:37 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the
 TBUs
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, andersson@kernel.org,
 robdclark@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
 quic_sudaraja@quicinc.com, djakov@kernel.org
References: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
 <20240329210638.3647523-6-quic_c_gdjako@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240329210638.3647523-6-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/29/24 22:06, Georgi Djakov wrote:
> Add the device-tree nodes for the TBUs (translation buffer units) that
> are present on the sdm845 platforms. The TBUs can be used debug the
> kernel and provide additional information when a context faults occur.
> 
> Describe the all registers, clocks, interconnects and power-domain
> resources that are needed for each of the TBUs.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---

[...]

> +		mnoc_hf_0_tbu: tbu@150cd000 {
> +			compatible = "qcom,sdm845-tbu";
> +			reg = <0x0 0x150cd000 0x0 0x1000>;
> +			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			qcom,stream-id-range = <&apps_smmu 0x800 0x400>;
> +		};
> +
> +		mnoc_hf_1_tbu: tbu@150d1000 {
> +			compatible = "qcom,sdm845-tbu";
> +			reg = <0x0 0x150d1000 0x0 0x1000>;
> +			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			qcom,stream-id-range = <&apps_smmu 0xc00 0x400>;
> +		};
> +
> +		mnoc_sf_0_tbu: tbu@150d5000 {
> +			compatible = "qcom,sdm845-tbu";
> +			reg = <0x0 0x150d5000 0x0 0x1000>;
> +			interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mmss_noc SLAVE_MNOC_SF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
> +		};

These three are missing their GDSCs, the rest looks in line with msm-4.4

Konrad
