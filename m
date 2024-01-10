Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D73FB36
	for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QC4MLtMk"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so4868251e87.3
        for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 03:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704884440; x=1705489240; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfeKeWELsUXSOsoX/4w9IRfss9fiLzU6vIaJLnkhKk8=;
        b=QC4MLtMkm49imAMnEQKP29Fu7l6vJlPNA6xm2VmgbwB0O+GL3MnJHqZ7Cl5wWWMoxv
         p52x5mIpv05OwWg6xBcizAlrzR3wTFV7F8/mosuMgWPkJQjpl0w9XMFN6fzpy7HAu5BG
         lbQYyN7JTiJyPIcP4LStCR2Xie98BxOmonlyeVr5f3wTCuJd1dSTyTVQbcX5ogjOyFHD
         1FmCKe23W7yo5ojIPKkdkSMyGhMtvxE14QBCpE64aLqsR+l2BuwPQKoxGdIN59E0yLLQ
         eE0e7qpRxJY0h3nPrx/pZ9eEdiCVGBXf2EM11+JoOY0bMIJPUzFzQWu2QacD8iCqngQs
         gW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704884440; x=1705489240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfeKeWELsUXSOsoX/4w9IRfss9fiLzU6vIaJLnkhKk8=;
        b=UGDmZwmoATafxLn0j0xYikgXdIgAJkou2kzDIJDn1vB2A1CJuy6xPBpI5XOTU7X8zC
         Cn42+ex/p3adGFLWw8RXqmDkrCmhndn3tggV72147PxrgBoASlvaOR3PeKxmT1LVpn3X
         DjPIBbBhwFh6LctRNVl77g6eUup/86PQZ9POKwHeZYAp8CTatDjPXT8fnrPTaQEQYVJs
         IjJVu79y1TYIR/EJpcOTqhr1FAglwTAnRsjtEd7ElfAT2awRVtsRalaYdhzXPWbltxYS
         bSP8bg54Qw4TK84NpLFVVJtMmy0a7reJr66JceOTbPtaIao+9ELRoi96IAAcDOBWZvqt
         CikQ==
X-Gm-Message-State: AOJu0Yzn++TLhwOw7ef9RyLAS8TWt4hu08fsxs6gVK8e3xEE2ad9C59t
	b0LRdg1nCNtaKbHisE8aZidli++qjg5xQA==
X-Google-Smtp-Source: AGHT+IHxHBhrhaM+rqV9BsRHT6XAftzD06A/BcYSyyty/0KA0tCunnAFj1XF5aWGoLi7Er3fmNTdWg==
X-Received: by 2002:a19:9117:0:b0:50e:7be9:52fb with SMTP id t23-20020a199117000000b0050e7be952fbmr326167lfd.82.1704884439955;
        Wed, 10 Jan 2024 03:00:39 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id eo30-20020a056512481e00b0050e7ed9585asm617280lfb.233.2024.01.10.03.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:00:39 -0800 (PST)
Message-ID: <36f9eac0-3086-4d18-9879-02738e99d262@linaro.org>
Date: Wed, 10 Jan 2024 12:00:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org,
 quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 qipl.kernel.upstream@quicinc.com
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-2-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240109114220.30243-2-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/24 12:42, Bibek Kumar Patro wrote:
> Default MMU-500 reset operation disables context caching in
> prefetch buffer. It is however expected for context banks using
> the ACTLR register to retain their prefetch value during reset
> and runtime suspend.
> 
> Replace default MMU-500 reset operation with Qualcomm specific reset
> operation which envelope the default reset operation and re-enables
> context caching in prefetch buffer for Qualcomm SoCs.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 ++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 549ae4dba3a6..000e207346af 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -14,6 +14,16 @@
> 
>   #define QCOM_DUMMY_VAL	-1
> 
> +/*
> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
> + * buffer). The remaining bits are implementation defined and vary across
> + * SoCs.
> + */
> +
> +#define CPRE			(1 << 1)
> +#define CMTLB			(1 << 0)
> +
>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>   {
>   	return container_of(smmu, struct qcom_smmu, smmu);
> @@ -376,11 +386,32 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>   	return match ? IOMMU_DOMAIN_IDENTITY : 0;
>   }
> 
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +	u32 val;
> +	int i;
> +
> +	ret = arm_mmu500_reset(smmu);
> +
> +	if (ret)
Weird empty line.. Please remove it in the next revision since you're
already going to send a new one..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
