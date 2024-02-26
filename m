Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47986E5E4
	for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956760; cv=none; b=ibmhmV1zyPo85bn0ADd9Xq9y6anqbGQiIp+TC6OiTEf1HD2KsTFwu8I4QglxAR2fswTx5ZGVC4xDu9VEPDZAcSZsmMm1BZmoJf3Ba+SZ6CF1uCfTdMpar0zOdgd41vWcXYqS/CnrEPpRPGcuoQ9OaXihVC4lMEQB/1BKu9/cwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956760; c=relaxed/simple;
	bh=A/EwKKFTHq9+UV9wd+Ov3mtNuR3zx7HttqwVAOODPzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkPepnIim93hZYOSlB0+rViLTK+7EgiZgp6Gs61mPkdkhHxJrRbak/9FhbKQT3buYVW7aivCLkk3sjjK0dPnC+Gux/TEKhqmcWyO9gA/3HRVx4nX23LoYD6j+daVDlzZiEvN3maHbMduAzT6u422SRD1SoD83cylqv7BZnLxQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jm4sd/mb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jm4sd/mb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso959956f8f.0
        for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708956757; x=1709561557; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=opvKQ7pk9+ZOHfw7awaAV2ZGrvnpC0iaXUg4k8IUpnw=;
        b=Jm4sd/mb1qo1O5MK9fCPRPCfynTeHyqLOlPsoP5ms4TQQDL/OZmwPH0nk8Lb47AU26
         pIfFKoDwFDNhFrV0bdCxYrRDcWGFLA2VjPyYchHg5utct79Rsmn277sc5qro2wEVKF+L
         3eP1Tpyj6QlIQbcZAd2saZ9fmhP/5Zj4IaA+55/mfilq1oEWYk7vy3ojX/dhL/UGJT5B
         BYbRP52ty8SILVjOLVpBz1FyirawqtpBeQpBwO5ff3qH7KrUGv6TDdl/Lifry8ArKz8R
         XEQlZgAEs7yzyvUF5atwGW2wMEJAgTeYqiTgSNsbIRhpVlpCkNKNjuWHfx60Pbngd572
         RzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956757; x=1709561557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opvKQ7pk9+ZOHfw7awaAV2ZGrvnpC0iaXUg4k8IUpnw=;
        b=N9gHymApDpFSGJBbKPlNmtrv8asta7EBsmu/rsVRR1TyJ6eVBuYJ2UIaRkz36cE1hu
         unUnZ6i3nq7kjV2pPqTgA1GKQrYaPnlsJ4NbROkhdU4BOZwpdmIp5p3Mb6iuPBZqVieS
         ZOf/BE5FGRL5VCLfsftBqNJxhqV/n6DpwOQcf8bH2k+Oq+tkW5Qc4f/aGismuIMgRGaX
         3S0FIjLNrL3TPSdCY1bB7wRVjf6y7mSWzmozIZ+LupomAxWF+watl15he6X5wtyYr3er
         U7d3N/4rr00jvXGrQ3JeYKtSD2mPCUC1+7M7nnkcmozZbP8LQaiQR/MHiLK2Er1FdBWP
         cexw==
X-Forwarded-Encrypted: i=1; AJvYcCU4JuBoDjv6jYcem5xG2MS0Xlwn/VHoqwjRwkGY99HdaRZjmwSp+2TC8Lobf/HIaE53XtsC+R2611DUKfIrpJHQHi8tETw=
X-Gm-Message-State: AOJu0Yzq2hobjAVhTMnyYkLEPiT+d60Jy6CI4KO8GCY2wQeUzrh7P2BK
	EvJzbnsluyPM57aEDydS9hMadBgwumqewD/WgtEtI0FOzpDj4EDMbyazGLqSbHA=
X-Google-Smtp-Source: AGHT+IEXDyGxCMeMUIAcAEuPZ7NNSc7bU/cKvZtROLGEJzvNqVfVr4GRFQDgQFpthCMgqCFSmsPRPw==
X-Received: by 2002:a05:6000:120a:b0:33d:2567:995c with SMTP id e10-20020a056000120a00b0033d2567995cmr5185055wrx.1.1708956757142;
        Mon, 26 Feb 2024 06:12:37 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id k29-20020adfb35d000000b0033de2f2a88dsm1434832wrd.103.2024.02.26.06.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:12:36 -0800 (PST)
Date: Mon, 26 Feb 2024 14:12:13 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, dbrazdil@google.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 20/45] KVM: arm64: iommu: Add map() and unmap()
 operations
Message-ID: <20240226141213.GB1579460@myrica>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-21-jean-philippe@linaro.org>
 <Zc9OHq2NO3X7DsSO@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc9OHq2NO3X7DsSO@google.com>

On Fri, Feb 16, 2024 at 11:59:26AM +0000, Mostafa Saleh wrote:
> > +#define IOMMU_PROT_MASK (IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE |\
> > +			 IOMMU_NOEXEC | IOMMU_MMIO)
> Is there a reason IOMMU_PRIV is not allowed?

No I probably just forgot it

Thanks,
Jean

