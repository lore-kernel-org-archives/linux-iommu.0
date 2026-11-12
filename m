Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490649;
	b=h2FlS4eOyoI8DUsUrE410gahQWjFYroMzbyCnWIEErXQUaggA4Rt2I3+pxHNiHtyCpF9
	 AfE5kAxeoXwu5KtMEYSklafbiXBP/NmXGQlNQE+nwL7d6nBk1Fih8iWGDpYhlJ7Exezjj
	 1/QL6gOtC35K8ePlabA7G/CxtqFY1JS+HlakIxN6+zPZxgonscWdH98Xv+yivlCh55cVr
	 qTaRsQ3MH1FddONW16kJOp7mAu74oWAVgEiit0qRD1Tu/noNkg5lmcZ2WPpLd1SRq2DMe
	 yQwwiOZgsY/eauWMMeeIkFPiCWuiVVrBT5G8mFqS2+RUUWXDO+Xuc2MGVQlYv8LMUow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Hq/MU/gK+BSgB5mQh8Y6JTJeHVaolVP6d47tb0fD0P8=;
	b=SXp2T7pn1O8wfpZiyWNErzl4JN6luWyjCkUUpu0diOCWX93g7TYSyxpbevL+CeQn34ng
	 bQcD5ng61i+uFoDDJCDZKXtD3ZaEkz48yWPAdPQ9v+Hsay5g8HNOF9ygHw6n/CCiV+LH9
	 2E5hpG5ftbMlo1tXEvcp+unSCjqELMf7R4Hfpn4UcBP9qMqIwxopZi+EIEnk7NAJJUG2e
	 yJTh6vAMXIZAMmWdM73TqCLcP3oZTCgXtgjlWXKn9HOv2+9OCHnJ23IgEbwn2MyZnKDFT
	 dDjbbW2aLIB8A4kGEmrTEjdYA0RtutFf9qnQhw3P6XR2+v5PL1NB8KUZTjrTLXbSCYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bDwWc6pc;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC154606A321
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 13:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC154606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bDwWc6pc
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4b76c15ae36so33515e9.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 05:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794490647; x=1795095447; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hq/MU/gK+BSgB5mQh8Y6JTJeHVaolVP6d47tb0fD0P8=;
        b=bDwWc6pcuUx+Z1jkC/RM0Xpnp9HxShNFkZ4/Owtk0DeR0F2a9XGGCNNyVxA2g9Bz9B
         BJe/i4x0ZCtwGkpxbGC91QlGWDW2tPo2wx8i5mSJn2q4/i1+asRP+cp4aLBQmy9ZMrM8
         L47G/Doi5b4qfT9FigB5UUTNpQUHmWEkNSkrGMYdRvo5J4GJIGJXnFzUTXbCyXhzZK3m
         Vc/fiJULSiqdnVUdT+/UIB+tqvLib8hSp4tHUxU84Jxt/dnkNi8nvB+iOoPrM04affCK
         vXT6nYw8ltC+M/yAtLP/J723KwkcxQCwFAYPcLxWrrRZC6c6DIJUTtCs2o1YCmh7N4Kc
         U/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490647; x=1795095447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hq/MU/gK+BSgB5mQh8Y6JTJeHVaolVP6d47tb0fD0P8=;
        b=v69gBEI2pXBR9h0oQXC9C8tUHq1dy/KkIgj7KfvYEExaORrJnVa7Jwx0F0J0wqVoeF
         MN099vbd/vkZkHy/hTKJKbqWzBDjTRBoEKK+oLCWxydTPnrGhCsASXw9RhNY1zhOf+Rp
         tx9P9SXjyyL6dNqgKxL6wOIDH/EvUztzVa2hS6vRKukAm6NBUrET9D1ALy0Wbfllvg/7
         XwPwiWNWLbQonINZRfSd89DcpHFeTTtKSlnaa2I7R6gcPlcyv+eXHnbmkYni+goAnmkM
         TVadtzeI7tdJObg+WcJAXTzd1h0/Exu/fqbJrcPyyM5+91v6dS6uO7mbyrnwwu2ELFJ0
         OB8g==
X-Forwarded-Encrypted: i=1; AL+hErG3rDKQkS3RGEnPpq2JAq3mo6O/+uYnJnrolQ1TE9K4GMTx2loLaAMCv4M5xSsBthqfB8Itzg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+RmWg5X9IFAV/VmpqpfFqSCMg9ZLLAVE/oipC5L1QHNDBu20hq
	ZnAKDrgNpw5bp4GkFrQhZPeN/Hdx0YpW3YxjloMT8GLrNS4IMnl58Unqn9J5bUKEBQ==
X-Gm-Gg: AYBFou12CDaedbtxkc+IfNiIWqd1+9DjcYwtTyELKPqtt1bMX298J/VrXSHPK4RWvPy
	73Tbxwf8C/qUQkpgoEQati0d8kFW2tkhAMkqMrQX4SH5GlhrU47mKuo5Hy/dCJARwcOF/dyJEhj
	yfk0fPLtayxqFlJcRIszDLwwuR7RgzmLSwFsqxG+xYN/GAPqvnM6v1yWS3Ph30dOz5QCbKyp1WM
	WHA2LcKl7XkYAlB7/UNoER86Ez/LtNct+XyJEE4ritpWp+gZk918eS6rfNyaEDaBxIxj7eWqtvg
	Ku5Dy/oONg7d5fuzjVZw9vm4Y5xb8uUmClhS55ZphnaBLhceN3petcMc+DymhCaJqxEJ4ihSe6J
	OoPExJi1P12nswMie3a1QdcBU7SM7NvxeCMz+xK4errwWaYz6XSXy7O87Vrkhet+V7knhNvl/xL
	4rKqZl+GFw7ce0GEqsOO/4HgWLmSBxPmX95zTuGiMz7YuAF/x4ZRJUD/eZsjRYuq4zz018yUCcm
	Cr2A5qAqwluXhSHsX1v2MkWkuWwu3veWv5F9N7rlldhIeRxaTxp20dj+YA8bmPcMfl0xaAh1CH3
	eUsdAPLGatcvC1krEn+MaP9KettpU8XJ6i+y0pc/0zEG9gBK3rPGeQGqMpMwX0oVHdiWYWY=
X-Received: by 2002:a05:600c:a115:b0:4b6:c939:3bfe with SMTP id 5b1f17b1804b1-4bb4ff4ad18mr798825e9.8.1794490646742;
        Thu, 12 Nov 2026 05:37:26 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c30b1sm16911221f8f.46.2026.11.12.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:37:25 -0800 (PST)
Date: Thu, 12 Nov 2026 13:37:21 +0000
From: Mostafa Saleh <smostafa@google.com>
To: aiyengar1990@gmail.com
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Don't leak the CMDQV device on a bad
 #iommu-cells
Message-ID: <avXBEbkBJ1ZMZ00B@google.com>
References: <20261112-smmu-cmdqv-leak-v1-1-7ea8e34277ea@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112-smmu-cmdqv-leak-v1-1-7ea8e34277ea@gmail.com>

On Thu, Nov 12, 2026 at 08:20:19AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> arm_smmu_device_dt_probe() only logs a missing or invalid #iommu-cells
> and carries on with ret = -EINVAL. For "nvidia,tegra264-smmu" it then
> calls tegra_cmdqv_dt_probe(), which takes a reference on the CMDQV
> platform device in smmu->impl_dev, and returns the error. That reference
> is only dropped by tegra241_cmdqv_probe() via arm_smmu_impl_probe(),
> which is never reached, so every failed probe leaks it.
> 
> Return the error as soon as #iommu-cells is found to be wrong, before

This is one of the things I came across a while ago when I passed
the whole driver to Sashiko [1] and IMHO, it shouldn’t be worth it
to fix as the FW can do many other harmful stuff to the kernel
leading to panics or memory corruption and the binding for the driver
is quite clear.

Thanks,
Mostafa

[1] https://lore.kernel.org/all/20260924085616.300650-1-smostafa@google.com/

> anything takes a reference.
> 
> Fixes: ea69dc4e207b ("iommu/arm-smmu-v3: Add device-tree support for CMDQV driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-206486@kernel.org/
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> The Sashiko AI review found this leak while reviewing my series
> "iommu/arm-smmu-v3: Keep the clock of the RK3588 PCIe SMMU running"
> [1]. It is not related to that series, so it is sent on its own.
> 
> Only compile-tested (arm64 allmodconfig, W=1): I have no Tegra264
> hardware.
> 
> This patch was developed with Claude (Anthropic) as a coding assistant:
> it wrote the code and the commit message, and I reviewed it.
> 
> [1] https://lore.kernel.org/r/20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6d4520c47308..f685ed0c01b3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5661,14 +5661,15 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  {
>  	struct device *dev = &pdev->dev;
>  	u32 cells;
> -	int ret = -EINVAL;
>  
> -	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
> +	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells)) {
>  		dev_err(dev, "missing #iommu-cells property\n");
> -	else if (cells != 1)
> +		return -EINVAL;
> +	}
> +	if (cells != 1) {
>  		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
> -	else
> -		ret = 0;
> +		return -EINVAL;
> +	}
>  
>  	parse_driver_options(smmu);
>  
> @@ -5680,7 +5681,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  		static_branch_enable(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
> 
> ---
> base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
> change-id: 20261112-smmu-cmdqv-leak-003f273b5e59
> 
> Best regards,
> --  
> Arun Iyengar <aiyengar1990@gmail.com>
> 
> 
