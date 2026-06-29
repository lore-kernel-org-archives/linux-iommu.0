Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1C4657F4
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751234; cv=none; b=dR2lueUEQvYKJCjRpB7HD/5xQIPcwdTkzm99LrJLrLc7Xc62MsBR7hgr2flhyKUamkhr0XOFJ7dNtRMWl5E6RfPGsSoWBZWm2h/10bZnhTv7UIxMcLzLTilzS+McXnukCYZHHg6E8/6ItHjaV/+THM5Xq9PKmiMOsKdtR9hKXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751234; c=relaxed/simple;
	bh=R43X/mwoYLibYf/258eRf+1TRx5cN7H4nWibbzSz+FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK1EITCjLadtMezOAIs3PHX8zW/QYw+JXxYkFWDEKx0+iGWGSVUScyRR3sNRd7ev0jRRDRqH+l9rt61J/Fd2ttdJD/K8LuTdb8kFo/KDR32ckHZDjkmTle4pUqZfmLioluMAXxcqRYWxtLCdbM6qhii97k+oNlIIslma1lG2I7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXnZ7CNi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXnZ7CNi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9df229032so54105ad.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782751228; x=1783356028; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5GdEv1gYkrutMa/9eRDoSEN3dnm0xb5aQFmw17wydw=;
        b=sXnZ7CNiaUYXtJn+Cmf+NUOCfVPG4DBENYyv+Kr7vTvV6OrErx4vmdw9knU/9ndNaY
         wfJRhfLvO9mvnhksQXcPI5u7WCxZ5LfIjY/q7SDuQgIx94dtvammHcSDNIJwirkUbRxo
         fOWM0KeWFzALcthvs0hmugQ1zYU86+yPxFC7tft4T8wF9QTvcRBI5suiiypSJgiDKBgB
         Nko5TWXvo8T2Qk6/SkaY+JikIKo+8F6Xsayn3qHd3TglfN1DzCSLuE8WyhsLnOZQFpD7
         GDnwRQRY0guCOjea+5se3ZezWrADu3plJESaEic3rAY9vaiIJJTr70yUhpIe2B9J+ijC
         G1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751228; x=1783356028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5GdEv1gYkrutMa/9eRDoSEN3dnm0xb5aQFmw17wydw=;
        b=ry8uXXKGDzKDgN6jjxFQDJmvXAzCkHKiT2uIhubQK0P8siw55KMxN4k91/ItDi9b1R
         WqMif2/GewA5tTQ20WeOxdiGUY324qMBB3KNrsT/TlXvbKODsfnaerrUs6lyvAOS+jel
         /Dl+nSwrS3Guv/hmO4ArTfLNnGTBOYp5Ol5zk6Dlvq8FKoZgt8CTXDwoYUZWfKH0n+S0
         Rl1kkdfq2AY8bZhud5SyoE7xBz8xwylKxa9p2yBOBZr4YQTnOtvkch03bStWZTXhX0AP
         YhYlYp7Q9JEYCVpXt+LWCSbnMUpb+c1UDKYZaNz7yFrnvCJsmEebekyyHHdduax3GoTw
         At4A==
X-Forwarded-Encrypted: i=1; AHgh+Rpq6u8RBmUDF6pbqsULTrP6+KaqW0iaMtbef9r2RxpXJYt6e1e/gh7KtvLuwTdCQHeyYh2h5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmiH16MzKDBtlD+sc85iKrFgcgfi7rToEW/2GGylfGBGx0q5hZ
	4wJJ6Dhr/P7B+cEQwGbMVEWj+8hKMO6yuTUGXCFrGRN08dngAzXDjI++sknB6EEzjQ==
X-Gm-Gg: AfdE7cmrIeQNTzgO1FwEJo2+gIWw5w/ez/tqwQfyp/y/SjGdJhGLrAsE7oJEQbGkAil
	r2n6mxhthph1v4LfNDF1HYknB4fbBjIztgU5zIEDuo9nu1uXnE+KMMb2C4CcKviVGsuUXqmniE9
	jhg19YLDg50sZOFkuSgg+W+RTYfUc9kBTlCCzJZqBMsRohYBxEAx8qAhy8UXSFlfCFkBQXC8nXx
	22TNn4eqOF9j+hneh5eeG1F/kWiQELFlIt1ou+HCz8JkgtpF7CNjQSvOfsK8n6EHHsAW/L/I1W2
	Lk5JvBiJf2ZMm4QD/iXCHGMDYqwKzeNUA/8rYynG5tL53cvKQKV2Iqnhrw01agnFkTQCo95zqhJ
	qerFp2faO8ZWsYIx+8f0+79MTw3PiJbCbo28bPXse3dmxmFzTDAxxXBnAp/7QyFQeWIx9IqesRH
	/d4QnVrgRK9BPcu8177Bra8TWbf5rlfAtl4DspCx70ts0v67o=
X-Received: by 2002:a17:903:1844:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2ca2cff7977mr338545ad.13.1782751227357;
        Mon, 29 Jun 2026 09:40:27 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a00029d3sm35570b3a.20.2026.06.29.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:40:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:40:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 7/7] iommu/arm-smmu-v3: Detect
 ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Message-ID: <akKf9S1TURJJq6em@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <8f43bbe920466359465f2083cfd09a15ee8e5ff1.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f43bbe920466359465f2083cfd09a15ee8e5ff1.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:24AM -0700, Nicolin Chen wrote:
> arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
> natural to decide whether the kdump kernel must adopt the crashed kernel's
> stream table.
> 
> Given that memremap is used to adopt the old stream table, set this option
> only on a coherent SMMU.
> 
> And make sure SMMU isn't in Service Failure Mode.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 851bcebfdb3d4..fb34c3ffee9fe 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5353,6 +5353,33 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
>  			  hw_features, fw_features);
>  }
>  
> +static void arm_smmu_device_hw_probe_kdump(struct arm_smmu_device *smmu)
> +{
> +	u32 gerror, gerrorn, active;
> +
> +	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
> +	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
> +		return;
> +
> +	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
> +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
> +		dev_warn(smmu->dev,
> +			 "kdump: non-coherent SMMU unsupported; reset to block all DMAs\n");
> +		return;
> +	}

We seem to be checking it here right at the beginning, let's remove the
redundant checks downstream?

> +
> +	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
> +	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
> +	active = gerror ^ gerrorn;
> +	if (active & GERROR_SFM_ERR) {
> +		dev_warn(smmu->dev,
> +			 "kdump: SMMU in Service Failure Mode, must reset\n");
> +		return;
> +	}
> +
> +	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
> +}
> +
>  static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  {
>  	u32 reg;
> @@ -5567,6 +5594,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  
>  	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
>  		 smmu->oas, smmu->features);
> +
> +	if (is_kdump_kernel())
> +		arm_smmu_device_hw_probe_kdump(smmu);
> +
>  	return 0;
>  }
  
Apart from that nit,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
