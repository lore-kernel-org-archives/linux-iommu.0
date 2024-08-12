Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29D178378
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469147; cv=none; b=Blrhfif5tSmPXO8BZS1gje3claqx+JoLaXDf/TQ+tDqVAx9jDbN0IO6C1ZI2o9ABQeUtDh+mV8m0xzJyWz0ynOGbX1E5D2a6okBjopR17V+4Whv75Tg6NOAchY02SHDA5sB/qHMR2pVubXCVMqy/aG1vYKGHbnTZmOJLCph60N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469147; c=relaxed/simple;
	bh=V9W1mHBG7nCjOakKrNvlHdCSu7XhfjXNoktXt/lNYZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ifsy2VywlIN/+TIRtPGckIM4xuuKFyaXc6xzveOCZvUiiLi2K/O+/In1Wqmk4BbF4grTqQgLa2h/Y1GwA/hoOGkLed8jVmTT3P8VdLXn63yxIgbRsJ1SPvGVhRtuyWRK1DbsfRMEz9srNr3pVvo7sFYfOVhuXOkCDxH9GbnGlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoqgRGDu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoqgRGDu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-200aa53d6d2so325875ad.0
        for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723469145; x=1724073945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmYajX4gMaVGigJxbQG+9M3259675dZnYWJeb/SxvFA=;
        b=QoqgRGDuHtYs63b8OdlOzt6GHYDFhTYJIVR8feZMZkFevVsr1trEmcmS2ZNcYrs+cN
         4IF6xUTq8ynZS+mYnNPV+V2Ouvpk6K77ZrkcvTyOSVKs3QN5liBIGHUeBrfkCms1mLiR
         /3DR+ZgmufBHvApw+VMsFi5enUoRJNd+cgW01ulqaFMBU3CkmVePJLGes6vc1RuFvZry
         D3W9nqop9W58K14FDt8Ff/VyyjIU0s6y1E4ozQ7ump3Ox3FAEE/OV8N7WF/wR+Ba9SFb
         8OoAvhr/ggt+UmpfICXNFgr6WqTkPvojYwyqhG8Pb9L6wvqLHpfwlRDd6ESxeRssW1Ud
         jI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469145; x=1724073945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmYajX4gMaVGigJxbQG+9M3259675dZnYWJeb/SxvFA=;
        b=Dv9zwu9x8cQ/E7kxkK+adPeuGNe7DER2GmsNIsUWfGd1gvRcE0akNgae9T61JRy/OV
         8cVsZIki1+6DYyFo1XrfRLTh2WYhqcclOEjU59xJLQ29EP1w2UMCQb8iQqLIjWRH6toG
         c/rgykpM5ksQ86EaiWdzvvoUXqfdTrSyBJcSTdJ6hNW2T5gWF0XEqQixOyVxVKmL5DDW
         SUilGHFJ/w9mo42qZFA9Be+JBRZ55TdKz/F79M0ox9P9GVDiVBSEKLtY+ErzowurERur
         7MPE6y+pjzw3h9u7Cm2rMF6LcGgIAMl7pVKYJV4SLhV6JWOvSozGGw20MAhLF8RytCPl
         4uyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm+3RYdKhTti3IHARXoja6vWJVyXHIFlAJ2YspD/5Xo16JETI7J6FIGfXSGX8nTd8RvZeQ82hloN0TDskDOMHcF9ggd6o=
X-Gm-Message-State: AOJu0Yz2HvzG2smb1i2Ptb+s7rSd3Qg4pHa6zJxKDp9aafDzlgUQ8sDe
	roonVu//k5tl5UmqyMlMpr8oHJITxeHBiTWi6CpJnN+V5hHT6DMTl21ednTGOQ==
X-Google-Smtp-Source: AGHT+IHb6qeSJStNs0pVR+CmYkttDl20c4Sd0X9v5RgYO5YZwdbSZX0vov7dB1RIgvFULpIown2sxA==
X-Received: by 2002:a17:902:db04:b0:1fb:3e93:79cf with SMTP id d9443c01a7336-200bd27550bmr4027905ad.13.1723469145000;
        Mon, 12 Aug 2024 06:25:45 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a89e22sm4085935b3a.170.2024.08.12.06.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:25:44 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:25:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, quic_c_gdjako@quicinc.com,
	dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: remove runtime pm enabling for
 TBU driver
Message-ID: <ZroNUGkKuC1L7Qfr@google.com>
References: <1722335443-30080-1-git-send-email-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722335443-30080-1-git-send-email-quic_zhenhuah@quicinc.com>

On Tue, Jul 30, 2024 at 06:30:43PM +0800, Zhenhua Huang wrote:
> TBU driver has no runtime pm support now, adding pm_runtime_enable()
> seems to be useless. Remove it.
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 36c6b36ad4ff..aff2fe1fda13 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -566,7 +566,6 @@ static struct acpi_platform_list qcom_acpi_platlist[] = {
>  
>  static int qcom_smmu_tbu_probe(struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
>  	int ret;
>  
>  	if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM_DEBUG)) {
> @@ -575,11 +574,6 @@ static int qcom_smmu_tbu_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	if (dev->pm_domain) {
> -		pm_runtime_set_active(dev);
> -		pm_runtime_enable(dev);

I assumed that this was required to avoid the TBU from being powered
down? If so, then I think we shall move it under the
previous if condition, i.e. CONFIG_ARM_SMMU_QCOM_DEBUG?

If not, we can remove it give that the TBU would be powered ON as needed

> -	}
> -
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 

Thanks,
Pranjal
