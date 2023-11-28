Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78456B77
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJRwd2W6"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c9ba5753bcso703661fa.1
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 05:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177511; x=1701782311; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTf2yUtECbY/OYuChMFvXRgzzGsfDdzdXOehMmGhewk=;
        b=QJRwd2W6VRXrS4A/CBhp2YcbC3sU4ZAmPGeKVZFT1WgHZggwetwhSZeDaVxv4Aktuf
         WytqGCQI6LnNbrg07xeSz3IzVGKS7gA8V4HV3YpvZYe2XF2pHpPCUZ/jMNlV5tuoKFSh
         thaVVE/Bj7+ADN1gIzBCB3ZldzUW9elGxh6Ru0DOCFqwSp0JQzblj3sSCl9meTgs2GDJ
         TNbSVhh+IcLUajQqo+Pdj2tBCkwnF8DCDGb67pjcmD7zqC2+S5zEH9zlbI2pmpnyZJa/
         LJEdGSiCARQAsvrM2SxlgvnoD1EsdB+YRpT9jxgodejcPfhdTBsnxuo0qTESjlXlJL7V
         0WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177511; x=1701782311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTf2yUtECbY/OYuChMFvXRgzzGsfDdzdXOehMmGhewk=;
        b=rWFHX3zXBIb3Cn9S+b9gDGyR9e2vAwr44smWU9hKuA1ubWPzY8yz8JybfjJI46iHOP
         viq+bUdfKuk4yNIrBfi6ZvjCJ49rc8JoLd2bx5HGWYQMNeFjzTshcEexYrdoSYS7jxh3
         62DoWdOlVFfL5xscFRBbLIojTSY0Wg84+Y2VF5Z/3gh7DC9eFtNQYnNvHqc9GNSwXtaM
         pTLlP76XQ1x0FX06N3DkLWd/hjAhPhHkkjF649WEaQA3kbUKWz0WebS6oxt9aQgD7Hww
         4Orsp/zOy8p0W0ofHhs9Ss+KJfvxJUReQFzO9Cw/ZgGa5dUxaGOPtP6upRd2n0DBr8ME
         1DKQ==
X-Gm-Message-State: AOJu0YzNoE1AtQQfj/bT3hn62MjMWHbwIz+UR7R+oHVqVzo05q22b34r
	fnzYer5/O8nYQx11VGFEm2zbvA==
X-Google-Smtp-Source: AGHT+IGqrSCmGnNKknw600PvCwdJ4nyNLsm/yU9AqIvf2jLutSas7DdHhjfbocjXyLUEEP7CqlRP5A==
X-Received: by 2002:a05:651c:39d:b0:2c9:9983:6fba with SMTP id e29-20020a05651c039d00b002c999836fbamr5636031ljp.52.1701177511295;
        Tue, 28 Nov 2023 05:18:31 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b002b657f10b78sm1707226ljh.58.2023.11.28.05.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:18:30 -0800 (PST)
Message-ID: <83e4f84f-63bd-4f53-886e-5cff215fd802@linaro.org>
Date: Tue, 28 Nov 2023 15:18:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>,
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
 <20231125-topic-rb1_feat-v2-5-979b28f35e4a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-5-979b28f35e4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2023 17:28, Konrad Dybcio wrote:
> Add the QCM2290 DPU compatible to clients compatible list, as it also
> needs the workarounds.

Nit: MDSS, not DPU compatible

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 549ae4dba3a6..aea5e85b20ff 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -245,6 +245,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>   	{ .compatible = "qcom,adreno" },
>   	{ .compatible = "qcom,mdp4" },
>   	{ .compatible = "qcom,mdss" },
> +	{ .compatible = "qcom,qcm2290-mdss" },
>   	{ .compatible = "qcom,sc7180-mdss" },
>   	{ .compatible = "qcom,sc7180-mss-pil" },
>   	{ .compatible = "qcom,sc7280-mdss" },
> 

-- 
With best wishes
Dmitry

