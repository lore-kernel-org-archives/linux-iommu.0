Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45091AC45C
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878175; cv=none; b=HwA2sgPsOwY1HLVpFmHNKqT3umSHxPCmOSQnEiHOQBq9VC3x4odQW0xp5qKg+m5AKnDbNtagJnfJSqij+eh7sAabCAiWqEuKM3kJzplhqXIIsFnOsk0me0xoepFCyqdwB1X7o8rkvbDy6m7fgw8l9jlwN0ki/5ifntAZRRCcv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878175; c=relaxed/simple;
	bh=SI+regcL35D2pgjCxxik/DYpB87OSLp3n3YVroEysHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT/ZO4Xy5+M4w3ZpSigDp2hVTD+f4tq0JJR++AwgrmkjpXN2c2u9bQ24mCDb72rKmYY8SQkfkXUspb031OEDBZa2E88JmPqzLk8MDQ0vc/x7ta9fsGuMSAum6Jyh5NaEVZEtceaZ9PgbSz8Hs0dngMtbiYMBxQvGtsAk1d5JOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cL3uv/9+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cL3uv/9+"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53346132365so8606092e87.1
        for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724878172; x=1725482972; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7iL+wVZPXpJO8ClTV1l/2A644kBdScvCJ/IGN2rpT8=;
        b=cL3uv/9+a2OxQ431CklD3Jt0sv2q1gB9MfUVGA/IKBU0o5QwhBK0d46PNoy4wyYuLd
         aeRpyt1DqaMxWC4KMuu09/aUilsh1HFyOtg7v0o8Co/aaOAxJNtn32hSBZ62t+tgGjbW
         QbjkfdytAVE80Xp/AdmiJJw3BJFp+czE2Vn6gDKMo56oLk8E5XED7NH1OgZTmrUiDFxh
         JPcFs2hM13ASpAwXk/mmchr/wc9mqxmqA61wwQRx+yLeArh+oqL7viiOu10FxOnIFp6W
         4OM1Yoa6d4X2jgGbMawK/7T9rdfG7X6tqf7pDumDq5dxV6nVBs1eir+q16/FaTg4Pk2v
         oeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878172; x=1725482972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7iL+wVZPXpJO8ClTV1l/2A644kBdScvCJ/IGN2rpT8=;
        b=X3sP28hcpe4dgyW/4UscHL6MgIJWqfsh8kYia81oWiWf553n2VxmUjUPlPWGcT2Rjv
         tOfW8tS3GWqXw1FLtMuI+6Gh/G0Tk2MqffGGUAEnVswnbTTVjfu73qZdszMvcfAnNFdr
         ltuYisOjogxircGFyHIknbvegrYk0PqOCnOkTIDYGeZ4gIXZvmzuVoymxk92hPHahnT6
         xqjh2WborQTO+CwiWO/drQPPMexjUvhq8psnWfkxfJx7Un0qgTeNKUFVvotW57tzMXAm
         vUL91UkH5WR2qgUDOwVbFO74U9wEnd8ttoNLH7oHLPyJgO4HtxN7AH4dzi9Omq670LFb
         PswA==
X-Forwarded-Encrypted: i=1; AJvYcCUUEkoKcqjAFm7PHRS6YujCVwbjITMNcsYW5U1PrOZyY/QgYPqK3fckyPHPy0ZSjfnlZRDdjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzW/FM5PgJdgxxbM7zsIF4Vou/dRRH9I48JsKB8LfgW3khKcEh9
	McKx/Ojf55Cc89213KKL5t8FyeSH2W0ndjNhij07eUCc/Wzsdx9MoQLzGV9nT6Y=
X-Google-Smtp-Source: AGHT+IGFlooROX7KAAWEZ3u9MgehYtM/1Q4NV0a/4GC6vjfI00yn1fIiQPQwXUf0jAQZYDlL800GWg==
X-Received: by 2002:a05:6512:ac9:b0:533:4591:fbf1 with SMTP id 2adb3069b0e04-5353e567669mr289888e87.15.1724878171237;
        Wed, 28 Aug 2024 13:49:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea36413sm2299368e87.79.2024.08.28.13.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:49:30 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:49:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnaud Vrac <avrac@freebox.fr>, Pierre-Hugues Husson <phhusson@freebox.fr>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: hide last LPASS SMMU context
 bank from linux
Message-ID: <jxxstowusullmfvtee7xvabc7s3ifele5xlc6muem65dnvzxih@e2nm7ln5n2qv>
References: <20240819-smmu-v1-0-bce6e4738825@freebox.fr>
 <20240819-smmu-v1-1-bce6e4738825@freebox.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-smmu-v1-1-bce6e4738825@freebox.fr>

On Mon, Aug 19, 2024 at 02:59:35PM GMT, Marc Gonzalez wrote:
> On qcom msm8998, writing to the last context bank of lpass_q6_smmu
> (base address 0x05100000) produces a system freeze & reboot.
> 
> The hardware/hypervisor reports 13 context banks for the LPASS SMMU
> on msm8998, but only the first 12 are accessible...
> Override the number of context banks
> 
> [    2.546101] arm-smmu 5100000.iommu: probing hardware configuration...
> [    2.552439] arm-smmu 5100000.iommu: SMMUv2 with:
> [    2.558945] arm-smmu 5100000.iommu: 	stage 1 translation
> [    2.563627] arm-smmu 5100000.iommu: 	address translation ops
> [    2.568923] arm-smmu 5100000.iommu: 	non-coherent table walk
> [    2.574566] arm-smmu 5100000.iommu: 	(IDR0.CTTW overridden by FW configuration)
> [    2.580220] arm-smmu 5100000.iommu: 	stream matching with 12 register groups
> [    2.587263] arm-smmu 5100000.iommu: 	13 context banks (0 stage-2 only)
> [    2.614447] arm-smmu 5100000.iommu: 	Supported page sizes: 0x63315000
> [    2.621358] arm-smmu 5100000.iommu: 	Stage-1: 36-bit VA -> 36-bit IPA
> [    2.627772] arm-smmu 5100000.iommu: 	preserved 0 boot mappings
> 
> Specifically, the crashes occur here:
> 
> 	qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
> 	arm_smmu_cb_write(smmu, qsmmu->bypass_cbndx, ARM_SMMU_CB_SCTLR, 0);
> 
> and here:
> 
> 	arm_smmu_write_context_bank(smmu, i);
> 	arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);
> 
> It is likely that FW reserves the last context bank for its own use,
> thus a simple work-around is: DON'T USE IT in Linux.
> 
> If we decrease the number of context banks, last one will be "hidden".
> 
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 7e65189ca7b8c..d08c18edf5732 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -282,6 +282,11 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>  	u32 smr;
>  	int i;
>  
> +	if (of_device_is_compatible(smmu->dev->of_node, "qcom,msm8998-lpass-smmu")) {
> +		dev_warn(smmu->dev, "hide last ctx bank from linux");

dev_info() or dev_dbg(). dev_warn should be reserved to the case when
you need to warn the user that something went wrong. In this case it is
expected that the last bank is unusable.

> +		--smmu->num_context_banks;
> +	}
> +
>  	/*
>  	 * Some platforms support more than the Arm SMMU architected maximum of
>  	 * 128 stream matching groups. For unknown reasons, the additional
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
