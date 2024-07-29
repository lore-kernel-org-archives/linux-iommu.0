Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AA43152
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284095; cv=none; b=FDV+NHFNPMSZG9j7/VTuzcA5e2tXghHt8PGzI3wvvMLXXM8o/cfeyg6wqv1sXxA57a+Xj5rh2hodi8GEkKM0F9h6lfcAse6AGVp7gT/GmAH0vg0rcnRpRi3ah8hivBUJv0v/6WGwNLgvdG4UbDQ5z/YwmgZ1EDZuyCrIfNoWg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284095; c=relaxed/simple;
	bh=AKeyuLupkAmAZYcAw3WzV2K6qgDlQbwQXs+KeJQTye8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFxEuG+I8YR/RpLYPs8LdvegHOJbVwX9OWKCCUfJJNdjDPWJ+jN02eQng0fReV6pJUmtNMHbjtc9Dtr4xoD2/eNO/Gb0bs/j7vWr3ut75wv8skEhyguJBLh53elxh/Jnh4FFtaaFGXMr1Gww0dG+XPi6hZ8zSytkQcLbZ+gqWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xvXh6CTT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvXh6CTT"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so58334231fa.1
        for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722284092; x=1722888892; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MSxQLkATCZcwG+U7RrSWy+VSeH2u4p3Lmc5mvojSKw=;
        b=xvXh6CTT+cHT6aWkK6AKi6Pk6wwnMVaCZyOh/V3LvuxjUg1fTI8ScqWv9zj/taVOgX
         UufwgNb64Ml9kAw5if72rrqOkToQmPHz+OflsUA26STYXJ2rAXp+Q2rjcF2n+r9nvEmu
         BpjEVTbrW10O+YmtZ8bdYqUDJxT+LamCJ2ca2TW0GVqq96kCaKfFcdagEBgFqkrHYc7G
         NHD0PDBJ1THDOgyLgDX4S6QHd3xap8vcgTtezk0g/We5NJlofwdkVfctaUKkctQtBl3W
         vLryuA5BwJgTixZqQiHdWQyD525mcAWDurwWfES1yiNjPShVxfEVl9e5toI9MlsorbAH
         XtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722284092; x=1722888892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MSxQLkATCZcwG+U7RrSWy+VSeH2u4p3Lmc5mvojSKw=;
        b=YUr9wBYcpwq8npCdXvWVKzPsTWs5iQk6v65Ppkm6StGzXZ0nr0YJr5td/Ytprcu2FC
         qS3U943QYDKLlAkchBk/R7Mozn98hd1XYToma9Aw13ITt5kzcTFXVNHYl1yLaDZLHS+C
         HlsBP3MMKr27dzItQVvjHh682JRhZBHVaVFV4ogVELYOS+Q2ATzqzzeJzmw5lW3zvyAA
         ZBQCSej3pHsFyePRV2enpOfLumq+hT7fjZ53maEC6JoHmKEaAgFFRatlngMX1yCp34pr
         CZQuuuhquRQRMVaRPvSa5+5zGHEOq+YHCUIC9uB9ies7DKG/q3TfNL5oVElYgY9pUDCi
         fC9g==
X-Forwarded-Encrypted: i=1; AJvYcCVcnlZEq1NjcxAtX4jQumpfdbc37TKqcoWZRBeac+pyYuO0RlVKjo7rB98DiwWH//T8Gh7ohEbQY4nythkrq3m6COBAVUI=
X-Gm-Message-State: AOJu0YzWzFehyTfHzY/EKCp0aqKKcfTltIN40ls0MnDzMDsIgeaQB7Ot
	zdmIrNQ475T4zGWisCeFR8myOXTaHeNGIYaiX3yGwQbidU5SjUGrTMUDbPwbgaY=
X-Google-Smtp-Source: AGHT+IHwWi170IaSpuqzgKXSqdDpCqWdNwQokms2xCpWCNu7yyJPx2iZ4KDFBHzK0i6N4igPdmbOBw==
X-Received: by 2002:a2e:3a17:0:b0:2ef:22ef:a24a with SMTP id 38308e7fff4ca-2f12ee57c24mr67925111fa.31.1722284092292;
        Mon, 29 Jul 2024 13:14:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf0dc57sm14566801fa.10.2024.07.29.13.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:14:51 -0700 (PDT)
Date: Mon, 29 Jul 2024 23:14:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/
 16K pages
Message-ID: <osxynb352ubxgcb5tv3u7mskkon23nmm3gxkfiiiqss5zp67jf@fv5d6bob2rgp>
References: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org>

On Mon, Jul 29, 2024 at 10:37:48AM GMT, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> SDM845's Adreno SMMU is unique in that it actually advertizes support
> for 16K (and 32M) pages, which doesn't hold for newer SoCs.
> 
> This however, seems either broken in the hardware implementation, the
> hypervisor middleware that abstracts the SMMU, or there's a bug in the
> Linux kernel somewhere down the line that nobody managed to track down.
> 
> Booting SDM845 with 16K page sizes and drm/msm results in:
> 
> *** gpu fault: ttbr0=0000000000000000 iova=000100000000c000 dir=READ
> type=TRANSLATION source=CP (0,0,0,0)
> 
> right after loading the firmware. The GPU then starts spitting out
> illegal intstruction errors, as it's quite obvious that it got a
> bogus pointer.
> 
> Hide 16K support on SDM845's Adreno SMMU to work around this.
> 
> Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> There's a mismatch in sender/committer addresses but that's "fine":
> https://lore.kernel.org/linux-usb/2024072734-scenic-unwilling-71ea@gregkh/
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 36c6b36ad4ff..d25825c05817 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -338,6 +338,15 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> +static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smmu)
> +{
> +	/* SDM845 Adreno SMMU advertizes 16K pages support, but something is broken */
> +	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-v2"))
> +		smmu->features &= ~ARM_SMMU_FEAT_FMT_AARCH64_16K;

Shouldn't we hide that uncoditionally as it's likely that none of v2
Adreno SMMUs support 16k pages?

> +
> +	return 0;
> +}
> +
>  static void qcom_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
>  {
>  	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
> @@ -436,6 +445,7 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
>  
>  static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>  	.init_context = qcom_adreno_smmu_init_context,
> +	.cfg_probe = qcom_adreno_smmuv2_cfg_probe,
>  	.def_domain_type = qcom_smmu_def_domain_type,
>  	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>  	.write_sctlr = qcom_adreno_smmu_write_sctlr,
> 
> ---
> base-commit: 931a3b3bccc96e7708c82b30b2b5fa82dfd04890
> change-id: 20240726-topic-845_gpu_smmu-ab738f7a013c
> 
> Best regards,
> -- 
> Konrad Dybcio <konradybcio@kernel.org>
> 

-- 
With best wishes
Dmitry
