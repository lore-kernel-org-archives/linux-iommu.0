Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DE3A0EAB
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405818; cv=none; b=q6HgBWCwO5zVYVz6rGtT9aZ1NQrQlKR3jKHkeJso+khJFInLIWUzGA3y1DjtLI++HKKTLWV8gvSt/8PrtGsQ1eUc64omQ/b+2Z3+erBBnl/iB+JjkQILo8aRz7m3IBT939wevzFNdyAy9YNA8Zh/T8AqJwDPGHxgk66C+ODeeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405818; c=relaxed/simple;
	bh=N+tLMRmoiFGfxXzeaTMOxasVpQhTrHRdnrw+/3/mH9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKxOa/P+E9+MxN7azi/L5O4Uu9VBpXbDGV/eKUc6jhH31/R/bScTIEx5umH6DeHbt6yg6yPTlPCYdtvZbSiz9irufG/ItVXuWnBnc6EIOBFWIfPrkwHGNePOjjUr27aT0fzqbAcBXNWELRJjQeyK9cJDNaDPcUVc+WaiE1/+VEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cK+5HQJG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cK+5HQJG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a35ae38bdfso73295ad.1
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 07:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768405816; x=1769010616; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCxOk+iywvSu8+CpqcXhukbgVIWbwqBDGWYpBD4H77A=;
        b=cK+5HQJGrNWHs19ARYLLSQ3C7OMql6UHNMJ/YYz+qZEWoWqfJiMTJJQTM8gLxFnX3i
         BAsxG/CPt+swG3WG2T6c8bbrGGp+MeMfKGqU3j3lW0TMI+joGHOKySso/71ShiQzKPnC
         QRcIIP1EvvXG1Wu6UdiI/PMrRc8imbVIEZoL2/iAytx3uwoWqVuyawuCRXes+MBs3apS
         oiLWYgYZZkQwJ7QGbIu9Y3pHGvnHxhPRWcbVD+wcfO6cyJ04O3sWrtEOHe1gQf9g8pAI
         VmMutM4dsaNkrVeCKr4CahzkC08wRuyKO7KM5duynSdJhzxDZTgKueDoVHwa8/gJEJX+
         zUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405816; x=1769010616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCxOk+iywvSu8+CpqcXhukbgVIWbwqBDGWYpBD4H77A=;
        b=Pz53RX4LG9GZz1bMNGSmkkR1n6/VE3HU/YJ0cuKipV5gPdDDQrg0ZAapHQGi54yFVo
         XNgRbiRETsoTkpAKTCCW9p1jsg67CD4nLnsl/a0/JnOHBju1xT8aCHOza9IO+6bSuGCv
         COdFBFxgKDG11ps8X7Qfx5JkFLq/FWdJbPdSDkzLl8nj4nvs47xJ8AeuhWl5hhZlsPY1
         frsE2wwXTYWgTtTxD2ebPyui8dQITMcPo1+3or2mavTMe+i4GcetJAIUKPYBYjSmMDRP
         r241G8VeMnj6WQ3IpGWPfgYvv+bOCrtmV7Vq1T+SaREZqoMN0ek+c4BsaaiwdFdUs2Mu
         nCwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCCys7YD+n0XowMSlxyQI/0ZLoowxgtVuUPDxtDEByS7LuvfqMYFbX4THWWxiTY4Dp8I5M2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBb/F+6iBoOCx/R2eBSNE7BFKkgvvSoF2aoc7J0FV1rLYZZnUq
	kgKA+Gi6IOkMkSM6A9Y83ZR76sPgoMlJgcFdeqsF8+AJ75H4o4c2mWFA+qBL0RjUDw==
X-Gm-Gg: AY/fxX6HiVGuK6QAzd6KvznJW4E9dKkZwom8hD6xR9BygwSp8b/Qr21VKLOkEKx1hF+
	XRHnjRpLH50gNGum88Q5cs0MmaoBSq7IC1KdLBI4egIKTM4nyYF/Z2IirLOv2m4e15ZN38Mo9Kv
	3j5ZZgkXvF2UJcCgSUWxvuvdRyZO/5Gf0Ei+6G9+4g2Vf0NOVhLVeQmd72gPw4M22PYbICeW/Br
	waf1P3cbZENtbDmT+7HnAItEifchgcbGNRZahQye7Xt2wyzFK3+hMLVuP6fVQze+VZ7gCG7lIjF
	vwIypL8NUJPJF1b0rEc73eeIkgbjICMdkGle/nqZO4+3rdVOx++kd7bT2m2mgDMmqQxWGvtztel
	nOIgqFMSen4EvmxVIa/QI/tw3q3tPEeTt90kB0n14EyMzfw5p8m+RDDZcv0F7VpoZMj4KsMJlG3
	CyukNDjl9P5h8NjoAIfpIKEdGpEMLJwGudUc63QqmfwAMFDB7M
X-Received: by 2002:a17:902:e549:b0:294:f745:fe7b with SMTP id d9443c01a7336-2a599a25a6bmr3059615ad.6.1768405815639;
        Wed, 14 Jan 2026 07:50:15 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109c78f20sm2370400a91.13.2026.01.14.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:50:15 -0800 (PST)
Date: Wed, 14 Jan 2026 15:50:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v6 2/4] iommu/arm-smmu-v3: Mark STE MEV safe when
 computing the update sequence
Message-ID: <aWe7MaEiGY_uOY4a@google.com>
References: <cover.1768248467.git.nicolinc@nvidia.com>
 <f560881df101d76de95c942cdbeab149eae3d581.1768248467.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f560881df101d76de95c942cdbeab149eae3d581.1768248467.git.nicolinc@nvidia.com>

On Mon, Jan 12, 2026 at 12:20:15PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
> the hypervisor. Since MEV is in STE word 1 this causes a breaking update
> sequence that is not required and impacts real workloads.
> 
> For the purposes of STE updates the value of MEV doesn't matter, if it is
> set/cleared early or late it just results in a change to the fault reports
> that must be supported by the kernel anyhow. The spec says:
> 
>  Note: Software must expect, and be able to deal with, coalesced fault
>  records even when MEV == 0.
> 
> So mark STE MEV safe when computing the update sequence, to avoid creating
> a breaking update.
> 
> Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 390446d259ab..ccd6357fa5a8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1086,6 +1086,16 @@ VISIBLE_IF_KUNIT
>  void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
>  				  __le64 *safe_bits)
>  {
> +	/*
> +	 * MEV does not meaningfully impact the operation of the HW, it only
> +	 * changes how many fault events are generated, thus we can relax it
> +	 * when computing the ordering. The spec notes the device can act like
> +	 * MEV=1 anyhow:
> +	 *
> +	 *  Note: Software must expect, and be able to deal with, coalesced
> +	 *  fault records even when MEV == 0.
> +	 */
> +	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
>  
> -- 
> 2.43.0
> 
