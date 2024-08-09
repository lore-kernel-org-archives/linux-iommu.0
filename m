Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559901D551
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234218; cv=none; b=AgCuKgtCNpgicb7VcxOc2CjnpFgMgmNCkvJiZ+J+PmvNhR9eE4oT93DmzQXq9KTvrVGrfktZT9+J+qmmf4F/xzZg48OAprury9Dm7phvwdxILocPov8Oe39aKI4xAd/3DK9NlD19bnoiLMux8sQ9ylxO6zLH2HTZ8lqHq0pEgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234218; c=relaxed/simple;
	bh=42W0tLghB4yvv48FXzrpn0uYSoZjE6pUUTBSeMH1Qqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrA+8Vvqqn894iRPt+Bjor50+u4vEozPe5hXSBUfCgadaW4zZHcG9PePGli6J+t2nytwOObTYCfx2T9zn+psoXGuXc/2w6HtMhE65Ix3X6ej8Os8VnxOQzjEvC0EK1nHfMsJHEsyKgkoMtJBoIPQ5vGmgspcMIEH3GBI2C7kwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJK+Au+1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJK+Au+1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-200aa53d6d2so45165ad.0
        for <iommu@lists.linux.dev>; Fri, 09 Aug 2024 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723234216; x=1723839016; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgqce5rXdRX+XwqcnFHtjrWp8PyPm6TN4Q0gJ9i4UiU=;
        b=sJK+Au+1znLGu2Oj0H+8FdvNdkz6Tg/j3/PPuBM3z1YJXbeOf8Ey3VSba7WmRPLa/z
         k3iGenut/eThl0/5XxP9y+ZQNs8BHm4D2LKQUvQN+wiE8GXErCt6sAfKNMxs9VYZXlR6
         L15p9igvyImIuglkgV+yWnBJGeDMpdQXXzthIbcD6OOlmBtksP+IWZjOCxPM1ox4bDeH
         sM1pOtwlRZFk/60uSjI/0sos/ebi5nBFMe5awjEZiNxE59I87l02gUCqIML8C031xDSN
         Mi6xcyq0xe9rglR03dAku5RY301o9hhmTL4nYVprkbL9JWVz47bKnska/XnF6CcMfFAb
         7vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723234216; x=1723839016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgqce5rXdRX+XwqcnFHtjrWp8PyPm6TN4Q0gJ9i4UiU=;
        b=Sx8LAy0SqmeAzZYhjqs4y7nYEInvTetlK5K5zvHs4Yf/a7aATMH6yiMHTI2nIJ24C2
         aNP15iwU9KgPcXasopiZRvUQqvvidDb49EMFT2m5eJQXHyAHkPmYP8VBwNIO5VoJ/FkT
         XYqW6s5WC/KACcewM8CRBAOyRzkWFSJnTrxGr5IocoEGN9DtGV6b/krk4Ps6bvwtMKyU
         oQk/TcCKyTvL+9OuKS7vo2jq1FwRh9MLm75NQOyHWfY+vWdrluBZIFaW0L29N31dIu9w
         iQXKg3aT0D+5oz3w/hM+yy9ZfB7+mUe8itOnNROVswaLwVvWNcnbdLC1txKT2/Xx/479
         bHvw==
X-Gm-Message-State: AOJu0YwhbuG1+Sfd7Mvtnp4ELO9IJESwNALxDryG2KFtlPPQNZ09uMJa
	hJ3zlsCA33X+RMlbgr0L8YtFsnhSegTCQjuVadS7WQj8nnOG9RJM4nTSTafusg==
X-Google-Smtp-Source: AGHT+IGCwF0wDx64AEbXcI1PmYNKlXMXiszjM75RvAm9xC3BTuLx9Ns1kMzSlCVJ3QIjU1KiQ9CWrA==
X-Received: by 2002:a17:902:c403:b0:1fc:7357:9076 with SMTP id d9443c01a7336-200bbb3b48fmr557185ad.6.1723234216116;
        Fri, 09 Aug 2024 13:10:16 -0700 (PDT)
Received: from google.com (255.248.124.34.bc.googleusercontent.com. [34.124.248.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab7c27sm134892b3a.205.2024.08.09.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:10:15 -0700 (PDT)
Date: Fri, 9 Aug 2024 20:10:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu: Un-demote unhandled-fault msg
Message-ID: <ZrZ3nm2U5ox3a25O@google.com>
References: <20240809172716.10275-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172716.10275-1-robdclark@gmail.com>

On Fri, Aug 09, 2024 at 10:27:14AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Previously this was dev_err_ratelimited() but it got changed to a
> ratelimited dev_dbg().  Change it back to dev_err().
> 
> Fixes: d525b0af0c3b ("iommu/arm-smmu: Pretty-print context fault related regs")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> We have crash telemetry watching for "Unhandled context fault", so we
> want to preserve this error msg.
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 723273440c21..8321962b3714 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -417,7 +417,7 @@ void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
>  void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
>  				       const struct arm_smmu_context_fault_info *cfi)
>  {
> -	dev_dbg(smmu->dev,
> +	dev_err(smmu->dev,
>  		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
>  		cfi->fsr, cfi->iova, cfi->fsynr, cfi->cbfrsynra, idx);
>  
> -- 
> 2.46.0
>
Yup, this should be changed back to dev_err.
Reviewed-by: Pranjal Shrivastava <praan@google.com>
