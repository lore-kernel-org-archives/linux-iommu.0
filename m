Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB81F8F17
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587763; cv=none; b=kbZC/3qt+MDDnSGyEmMS0M/H2iPXFFLh7TBiWEgYVRuZL4pM2+Srs6ej0b5gAB5UpkPOZWw2ruaBSWLPJqep5ysky9RnZXrLQpuvMPFWn5RatapfvlYXEN8Flm7jKfGhKF+2b2Kgn2sYMjKWwspZTeZGVkkk+rd0PacK++UNZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587763; c=relaxed/simple;
	bh=T+LDaEiPLaW2+KPSAG2c9PKXYlFwR3gPf0XLpn/LmK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOn4oMrLCOrrC6IFm5b69LJyGllFA92sTZx41rL4+JhW4yYgj1vVZfcCP8vgCn9BDn8xlINK+6E4H9o3I5XXKoelkC8NyvTMyxGQkFA+g54guZt+yyWHk3DsFXd9mdCvyosOpmcR7YbVsEPKmLJfZf0MB70bFCSlaiH5vpWXC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XW0r3UNM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW0r3UNM"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a097aa3daso522862e87.1
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 04:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731587760; x=1732192560; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VolHPGwzyzWXHH7WDKvK/ITQahcEIxL1w6M06zCzGt8=;
        b=XW0r3UNM76WkcGtKbcBmH79EtxKmeX2C2+5fiJI7LJ0GP9wIO3hKoVBtRKGPcfR+bn
         ppIVdRXlQZCjQgECWXCR3WZv1LaaUZbG8DyEDGjY9lLOme3e4YdeVDrY/IuT3KbfgQMq
         tniRCaeuvLiMv783zDsa9FRE/FpOADnLCsmDM2NrXQ81BgRw3WOM1lP0FTnKy5AXyT5h
         jFwmxyPbSpYtkmEkkGaFTOlUzvxOQQ8ePH6Cs5LIoajmpYlZVeXxchQoUB65r+fWRLX3
         N/YSAI0YIC/2rEYH9Z+AYd82jySMuy3M7qXwYlDSGeAcgOqFM4Gzn7fBIR3Rywna2Jq9
         1Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731587760; x=1732192560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VolHPGwzyzWXHH7WDKvK/ITQahcEIxL1w6M06zCzGt8=;
        b=eo68MIEKJo3UMDQbdrNI5kk7rzrwURTiW5ZiVou1wn97SoOYZBBORNT6Pkn4I5TLOQ
         m33an2mVeFulf2Q2IxLnCRuCAiId1AFMiG3KrRDCvps5Tok/ASm8KvXjxpO8c/gB0fZF
         k8SmzNyhLySPa1zYFp1/nrsSbot65UTh/boLEzRN5TdPwVD6mzpu0xRO5dSb293iZ+a3
         04XYQ8E7lPTebTgBrsZxfXEybDXA1HQzn2OSxuTGwf5EXM2LbDQJbWx36lzsX4Yo4k5+
         gDr/e/4WxcagTKerwXsHLSH01eENiTnmjp2Jte/dgFMQZQYmyeOm7BGSlRdlessdF8z3
         tzBg==
X-Forwarded-Encrypted: i=1; AJvYcCXWGQP6v+v3Gj7qd+qazzTTweYnZ/4wqCIIsJrrqAWkD4rpWNUkeDxsGm7uwQKgE797G3qNNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxkzzetlsbn+mtKRbZNMFbVUhoREjmGjAHxBL1dJxDBNf0HaRrN
	XtsAKAlM0L/xnJaaqCB7AWPF1AAO9qxpkg4IOdlC+qvcb/Koo1XXUO+3pwFHUvE=
X-Google-Smtp-Source: AGHT+IGi7UOzSfwh72ihUwOGEexWy2JMnijNfqGBkqGRHqPGSrFGRfh6xQPHDoXZUsDQNmf4oTaytg==
X-Received: by 2002:ac2:4c23:0:b0:53d:a86e:4f19 with SMTP id 2adb3069b0e04-53da86e4f40mr648491e87.25.1731587760466;
        Thu, 14 Nov 2024 04:36:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6530f62sm170210e87.166.2024.11.14.04.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:35:59 -0800 (PST)
Date: Thu, 14 Nov 2024 14:35:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-qcom: add sdm670 adreno iommu
 compatible
Message-ID: <4lpz2sx3ikvdpb5dv7qdovpsfm724kc6ibjtbmmxaajtwemr5l@xtiaork4hy6e>
References: <20241114004713.42404-4-mailingradian@gmail.com>
 <20241114004713.42404-6-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114004713.42404-6-mailingradian@gmail.com>

On Wed, Nov 13, 2024 at 07:47:16PM -0500, Richard Acayan wrote:
> Add the compatible for the separate IOMMU on SDM670 for the Adreno GPU.
> 
> This IOMMU has the compatible strings:
> 
> 	"qcom,sdm670-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2"
> 
> While the SMMU 500 doesn't need an entry for this specific SoC, the
> SMMU v2 compatible should have its own entry, as the fallback entry in
> arm-smmu.c handles "qcom,smmu-v2" without per-process page table support
> unless there is an entry here. This entry can't be the
> "qcom,adreno-smmu" compatible because dedicated GPU IOMMUs can also be
> SMMU 500 with different handling.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 6372f3e25c4b..601fb878d0ef 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -567,6 +567,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
> +	{ .compatible = "qcom,sdm670-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
>  	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry
