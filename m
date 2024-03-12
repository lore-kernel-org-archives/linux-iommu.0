Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6313958E
	for <iommu@lists.linux.dev>; Tue, 12 Mar 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267293; cv=none; b=oBSMEX+Bm7K1VOAnzvOIodqoY8/Ow0AspwsZr1+oFgP4CC5e18LcwlaQEm1PZdpdK1xORb6tki5q9xTYF22r6v7rMimJ31WiFyrx3qBgyYUk4maKSzqXEInOidnuwx7E4PC0jq27V+SQp8hzEaNpd8sJRgGfU5VRc6B1WZT/4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267293; c=relaxed/simple;
	bh=NoHLxl5q4br2NmwuVbEbWC8Hgzx+ElYfgu5TSPvDZak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K83bYMinUo2e76JuXWkBdILr1+gBXUoYM+vgA+Lxw3uJgaa9IGNGKQNoI9k5wa5AEvOLfC0Z5eJX46y4/+6YrD1LGkjKYV42i8i+gYogfV8Cq6U1zP2tNBi6sr0oxVy4gaenhvGPP3m/ptJJyIwa9VwV907xAABm6zqOvtLAHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xj6sbpUV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xj6sbpUV"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512ed314881so5245800e87.2
        for <iommu@lists.linux.dev>; Tue, 12 Mar 2024 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710267289; x=1710872089; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndyrovNU7gmuZatlaLPeU/xwQKMeCdI2vpreLiAY164=;
        b=Xj6sbpUVK6EGiDui9ehfcOR0APWLuY0rdDC4MKD0HL8rQzv25Ug2eJp1LuVkYK34P4
         XGwLUOAXHN21fsHGVmjTkPa13x6BrO3jNy4MhhIZVZaQSdpnQYjZ0vqcss3/LhKWHIhV
         vVEqxP/yC6gAgDFane8r/7kW7OIYOt+mes4E2H/AyUrE846R6vrK9e21v2uu6Gwtjuu1
         av16vDGEmbiJfqwFCmKXJDn4uigUXnSDc+DCbTkh3/TX5kiNTWT8jXwJzhXmP6ir+etL
         QC/uBT+TU4M22spo2tNswij6VznXVN+r5dBzb0C55mRHS8CmPMK3wBT7BRO7zpIosu59
         wsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710267289; x=1710872089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndyrovNU7gmuZatlaLPeU/xwQKMeCdI2vpreLiAY164=;
        b=uDaQO7ShlUnFC7wuQAABQ8etMEd9eBaO2wBal3WN01aE1HaLjVIK0QJPAXhpRjzBJ8
         59bhHxAAgwX+QtL2+EbBnuPjbk93hUiZBUZMrk7NkqZn5iJII0gf9RyGnmDuzWCZ4/6n
         p0kbXTQs2Os9kPek74mtNDIiqMwOvrRbkDXjv0lF168uaBiSdhHIL8zhIf5iBo2l2lZ4
         sulhUwwNBh7bD3qZ6+QczXlnetIKS/LDrY42JiuL5o5J/qeCmThFgIsrk4iSL+fLjIDA
         aOSLBBKu+JUWmNrzeG64qkW3d2Bjur3qmU9TM7HG6mHMxWMQ1BG8AjE414ofk2sYJ1BZ
         Ip5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgymSVOwiU9N0Dpw9cfmRm5FIOwBcbluQvPDpruXxLyfIR5ySsDYiHDHNZSpXD5OPYdaWSq6gMYIytrzj5doC7PrsF0PY=
X-Gm-Message-State: AOJu0YybkGJs4cAa0Hd67lE3bdDp1zlhmnSYxb+hDDZCkNH5re5DY6YG
	3RxPhGpXcQUk2GjMfLrF66JE3kFDCjPHPqom0dHT5JSJWGcbX03+rcuw+i3On+k=
X-Google-Smtp-Source: AGHT+IEESLK6yRlor/BAs+mtT8DWCpjx4vz0GFvh9t3WEDBysSuHBbCc7YBtd8LxA3B7iMwul9UANg==
X-Received: by 2002:ac2:4901:0:b0:513:a140:fbf8 with SMTP id n1-20020ac24901000000b00513a140fbf8mr6285218lfi.30.1710267289328;
        Tue, 12 Mar 2024 11:14:49 -0700 (PDT)
Received: from [172.30.204.193] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b0051313a9bddasm1675985lfc.252.2024.03.12.11.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 11:14:48 -0700 (PDT)
Message-ID: <8e00b2e8-866e-490a-bb81-73a9cb9dc737@linaro.org>
Date: Tue, 12 Mar 2024 19:14:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] iommu/arm-smmu-qcom: Use a custom context fault
 handler for sdm845
Content-Language: en-US
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev
Cc: devicetree@vger.kernel.org, andersson@kernel.org, robdclark@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
 quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com,
 djakov@kernel.org
References: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
 <20240307190525.395291-5-quic_c_gdjako@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240307190525.395291-5-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/7/24 20:05, Georgi Djakov wrote:
> The sdm845 platform now supports TBUs, so let's get additional debug
> info from the TBUs when a context fault occurs. Implement a custom
> context fault handler that does both software + hardware page table
> walks and TLB Invalidate All.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---

[...]

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 5c7cfc51b57c..7a58b1b96bca 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -422,6 +422,10 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
>   	.reset = qcom_sdm845_smmu500_reset,
>   	.write_s2cr = qcom_smmu_write_s2cr,
>   	.tlb_sync = qcom_smmu_tlb_sync,
> +#ifdef CONFIG_ARM_SMMU_QCOM_TBU
> +	.context_fault = qcom_smmu_context_fault,
> +	.context_fault_needs_threaded_irq = true,
> +#endif

Is this enough for cases where CONFIG_ARM_SMMU_QCOM_TBU=y but the
dts changes aren't there? IIUC this will spam the error message in
qcom_find_tbu()

Konrad
