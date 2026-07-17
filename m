Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14416395D86
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319584; cv=none; b=njXGKwfvYMmZIR3Gmg78EyVr47ksEUOnToHdRrfOaU/7CaU92VYOZ6kanzknCSMi/Ofg4M25tNw3dI1vBvR5ay9CUAAA2M8falTT9oT5Zo+hdrrLzru+xaJs28+IjSylnZzTpZ6/VpmDCQB2nndLpcr39CHlpfStaYb9RC+nFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319584; c=relaxed/simple;
	bh=PbNViWUgj3WBUCT3/UpmOD/6P42BeZf6CSc/xOU4GB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diY0QgQACDJJkD5If7K8gsfpG58Lglw0VqgHddx/jrhd8xIsk3GDqCjNW2e2EVkMh8Sxy4Tfy6qmHNTQc/LL7mrmo95myILqiggeQaVXC93Ep5PoZaTvkUnjVNNWPJreQ+v64ralFVUoAL9Myo7sj95oRMWdj7Vl+88u7obaQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G0KtVIQR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G0KtVIQR"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f256eaedf8so90857996d6.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784319579; x=1784924379; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M2hbpzf52w+esSVkF8QFMW+oo8Oyq13jDlcvDql6gbs=;
        b=G0KtVIQRd2Hb1tU/XV+u9PE8R+XH25iT/KWvJZSFr75yDPA0CuNBI3jf1XMGViFzx4
         urQu6iVmSkux2wAPqKI/a/nDHTlGSWOatxNVnHwhqgwnc0gA4rO74SSEFDChnnqXJ1XA
         ZsdQzad5AplvmDIM7JyEbE3zfeRg4bap03CF63MA/OnZA9GIxk9kH4DcraKV6M4X8xGx
         N9FAtCsSCNQMFCu5gM4kaeh+jAmSx2aL/UJHYwYjYrpfnCjt1BR2OdP6zoDNuamBR/on
         c6KRVQ5JLYxFqL5SDTvT56BSroh2qdcwG0YvS+wUDZ/pw4zFy3FNvcNAh9MDWMJrKQ7u
         GWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784319579; x=1784924379;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2hbpzf52w+esSVkF8QFMW+oo8Oyq13jDlcvDql6gbs=;
        b=nnRB4kILpTGtTNnttLUz4bqeqgB6fjP2KXy+yHDz26Ii8KdYm5Fg4txc9gq+CINYXG
         cQLtXaocyKXHcmO1LbOXThAmhVJIQOOt8icXRKx5vLaNUrHvYzrrVGq5hX0aNzJcG2Sw
         pVaXLCrga6RywpYV01/T+qP60V0YN8JSZQafAa0sUCiR4l7fPFitt8UGoA70qUdt+HEo
         QqbEBhqTbDJZ0US2gQdYlwocpps0wDWRT5nSg263712pM1sRptyh+RwFN/lO4Nw4J+LJ
         Al/EpxkgARsy8TzJ15M+h+rS/LYVoUiHMxsaiF6zB0Fk0O3q0q0gKvv0itJUscI+aLT8
         fOQQ==
X-Forwarded-Encrypted: i=1; AHgh+RreJBxkvcc2P1Mmb3Jsu3dn8SgJsj96gputFa2YQB9aYYIMrvGU8bEwJRVXv/IN1jixMTYi+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxybrBnDhSVGi/7HKM7ohGxB+6vvPYNjgquYkgVl+HKJwz4OOl7
	LId8ERjP5qQOa3aFElMjrWXmInb5kB0nthDVLvMk7ATzRYIJL6K0TG2LlEKhTKKzBA0=
X-Gm-Gg: AfdE7clqdTUrE2H+j4K73M/ikZ5fyu6Pa0xF6+k38j1NC9CJ4hbmMc3GE2IYXPp+CVm
	tBT6UgZay910wgMvDdhkrDv8ZuCNfu0SzonfSsiW1uQ4nxL7qEtyQbNw8sbXARdk6U0rkLTqE3o
	cBXFPwDOzLSqkkbJcdnbz2IMU7ijzfGqaDG24IUWCexyIy4SedPUpTt68WTJ6A8yThTJDQeXGlO
	hYm/oSJcRlhEcURVPZ7NLOuEilkRnB1B1DFZi8rvgOLx9LqbFCig6beLYBMwxSoRVMktX0DKy82
	40FZaw1NYVw1smsd5XQ/wkhitZBEYTZAWTVe79Ao9+nWxNORbWayMZZbT48rZLGLh6Mxhai376I
	8QLw5e4ZKTQQGvQ9jXHw7gxOx23F36OEalcRSwAjYJVRit1Hr4g==
X-Received: by 2002:a05:620a:4588:b0:92e:e2a4:9d40 with SMTP id af79cd13be357-930b3f4547cmr452740585a.27.1784319578518;
        Fri, 17 Jul 2026 13:19:38 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542b300sm245589785a.26.2026.07.17.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkp20-000000052xd-3lLn;
	Fri, 17 Jul 2026 17:19:36 -0300
Date: Fri, 17 Jul 2026 17:19:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 3/3] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat
 workaround on Tegra264
Message-ID: <20260717201936.GD701389@ziepe.ca>
References: <20260714104202.1664187-1-amhetre@nvidia.com>
 <20260714104202.1664187-4-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714104202.1664187-4-amhetre@nvidia.com>

On Tue, Jul 14, 2026 at 10:42:02AM +0000, Ashish Mhetre wrote:

> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5357,8 +5357,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	if (of_dma_is_coherent(dev->of_node))
>  		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>  
> -	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
> +	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
>  		tegra_cmdqv_dt_probe(dev->of_node, smmu);
> +		static_branch_enable(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
> +	}

It is a bit of a big hammer to not have the per-instance FEAT but it
probably doesn't matter

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
